import Foundation
import Combine
import CloudKit
import CoreData
import UIKit

@MainActor
class SharingManager: NSObject, ObservableObject, UICloudSharingControllerDelegate {
    @Published var isShared = false
    @Published var isOwner = false
    @Published var participants: [String] = []

    private let persistence: PersistenceController
    private let containerIdentifier = "iCloud.com.kalyan.CookingApp"
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

    var cloudKitAvailable: Bool { cloudContainer != nil }

    private var cloudContainer: NSPersistentCloudKitContainer? {
        persistence.container as? NSPersistentCloudKitContainer
    }

    // MARK: - Prepare share (presented by the SwiftUI wrapper in SettingsView)

    /// Fetch-or-create the household share so it can be handed to a
    /// `UICloudSharingController`. Works with an empty grocery list because the
    /// share is anchored on the Household root, not a grocery item. Returns nil
    /// when CloudKit isn't available.
    func prepareShare() async -> (CKShare, CKContainer)? {
        guard let ckContainer = cloudContainer else { return nil }

        if let share = currentShare {
            return (share, CKContainer(identifier: containerIdentifier))
        }

        let context = persistence.context
        let household = persistence.currentHousehold(in: context)
        persistence.save()

        do {
            let (_, share, container) = try await ckContainer.share([household], to: nil)
            share[CKShare.SystemFieldKey.title] = (household.name ?? "Our Household") as CKRecordValue
            currentShare = share
            isShared = true
            isOwner = true
            updateParticipants(from: share)
            return (share, container)
        } catch {
            print("Prepare share error: \(error)")
            return nil
        }
    }

    // MARK: - Accept incoming share

    func acceptShare(url: URL) {
        guard let ckContainer = cloudContainer, let store = persistence.sharedStore else { return }
        CKContainer(identifier: containerIdentifier).fetchShareMetadata(with: url) { [weak self] metadata, error in
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

    /// Owner stops sharing (keeps data); participant leaves (removes their copy).
    func leaveHousehold() {
        guard let share = currentShare else { return }
        let container = CKContainer(identifier: containerIdentifier)
        let owner = isOwner
        Task {
            do {
                if owner {
                    try await container.privateCloudDatabase.deleteRecord(withID: share.recordID)
                } else {
                    try await container.sharedCloudDatabase.deleteRecord(withID: share.recordID)
                }
                currentShare = nil
                isShared = false
                isOwner = false
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
        guard let ckContainer = cloudContainer else { return }
        let stores = [persistence.privateStore, persistence.sharedStore].compactMap { $0 }
        for store in stores {
            if let shares = try? await ckContainer.fetchShares(in: store), let existing = shares.first {
                currentShare = existing
                isShared = true
                isOwner = (store == persistence.privateStore)
                updateParticipants(from: existing)
                return
            }
        }
    }

    private func updateParticipants(from share: CKShare) {
        let formatter = PersonNameComponentsFormatter()
        participants = share.participants
            .filter { $0.role != .owner }
            .compactMap { $0.userIdentity.nameComponents.map { formatter.string(from: $0) } }
    }
}
