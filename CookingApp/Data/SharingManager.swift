import Foundation
import Combine
import CloudKit
import CoreData
import UIKit

@MainActor
class SharingManager: NSObject, ObservableObject, UICloudSharingControllerDelegate {
    @Published var isShared = false
    @Published var participants: [String] = []

    private let persistence: PersistenceController
    private var currentShare: CKShare?

    init(persistence: PersistenceController = .shared) {
        self.persistence = persistence
        super.init()
        // Only query CloudKit when the entitlement is present; calling these APIs
        // without the entitlement throws a fatal NSException.
        if PersistenceController.cloudKitEnabled {
            Task { await fetchExistingShare() }
        }
    }

    // MARK: - Share sheet

    func presentShareSheet(from viewController: UIViewController) async {
        guard let ckContainer = persistence.container as? NSPersistentCloudKitContainer else {
            let alert = UIAlertController(
                title: "iCloud Not Configured",
                message: "Enable iCloud + CloudKit in Xcode Signing & Capabilities to share your household.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
            return
        }

        let context = persistence.context
        let request = NSFetchRequest<NSManagedObject>(entityName: "GroceryItemEntity")
        request.fetchLimit = 1

        guard let anchor = (try? context.fetch(request))?.first else {
            let alert = UIAlertController(
                title: "Add a grocery item first",
                message: "Add at least one item to your grocery list before sharing.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
            return
        }

        do {
            let (_, share, cloudContainer) = try await ckContainer.share([anchor], to: nil)
            share[CKShare.SystemFieldKey.title] = "Our Meal Plan"

            let controller = UICloudSharingController(share: share, container: cloudContainer)
            controller.delegate = self
            viewController.present(controller, animated: true)

            currentShare = share
            isShared = true
            updateParticipants(from: share)
        } catch {
            print("Share error: \(error)")
        }
    }

    // MARK: - Accept incoming share

    func acceptShare(url: URL) {
        guard let ckContainer = persistence.container as? NSPersistentCloudKitContainer,
              let store = persistence.container.persistentStoreCoordinator.persistentStores.first else { return }
        Task {
            CKContainer.default().fetchShareMetadata(with: url) { [weak self] metadata, error in
                guard let self, let metadata, error == nil else { return }
                Task {
                    do {
                        try await ckContainer.acceptShareInvitations(from: [metadata], into: store)
                        await self.fetchExistingShare()
                    } catch {
                        print("Accept share error: \(error)")
                    }
                }
            }
        }
    }

    func leaveHousehold() {
        guard let share = currentShare else { return }
        Task {
            do {
                try await CKContainer.default().privateCloudDatabase.deleteRecord(withID: share.recordID)
                currentShare = nil
                isShared = false
                participants = []
            } catch {
                print("Leave household error: \(error)")
            }
        }
    }

    // MARK: - UICloudSharingControllerDelegate

    func cloudSharingController(_ csc: UICloudSharingController, failedToSaveShareWithError error: Error) {
        print("CloudKit share save failed: \(error)")
    }

    func itemTitle(for csc: UICloudSharingController) -> String? { "Our Household Meal Plan" }

    // MARK: - Helpers

    private func fetchExistingShare() async {
        guard let ckContainer = persistence.container as? NSPersistentCloudKitContainer,
              let store = persistence.container.persistentStoreCoordinator.persistentStores.first else { return }
        do {
            let shares = try await ckContainer.fetchShares(in: store)
            if let existing = shares.first {
                currentShare = existing
                isShared = true
                updateParticipants(from: existing)
            }
        } catch {
            // No existing share — fine
        }
    }

    private func updateParticipants(from share: CKShare) {
        let formatter = PersonNameComponentsFormatter()
        participants = share.participants
            .filter { $0.role != .owner }
            .compactMap { $0.userIdentity.nameComponents.map { formatter.string(from: $0) } }
    }
}
