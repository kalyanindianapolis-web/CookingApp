import Foundation
import Combine
import CloudKit
import AuthenticationServices

@MainActor
class AuthManager: NSObject, ObservableObject {
    @Published var isSignedIn = false
    @Published var displayName = ""
    @Published var iCloudAvailable = false

    private let userIDKey = "siwa_userID"
    private let displayNameKey = "siwa_displayName"

    override init() {
        super.init()
        displayName = UserDefaults.standard.string(forKey: displayNameKey) ?? ""
        checkSignInState()
        checkiCloudStatus()
    }

    func checkSignInState() {
        guard let userID = UserDefaults.standard.string(forKey: userIDKey) else {
            isSignedIn = false
            return
        }
        let provider = ASAuthorizationAppleIDProvider()
        provider.getCredentialState(forUserID: userID) { [weak self] state, _ in
            Task { @MainActor in
                self?.isSignedIn = (state == .authorized)
            }
        }
    }

    private func checkiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] status, _ in
            Task { @MainActor in
                self?.iCloudAvailable = (status == .available)
            }
        }
    }

    func handleCredential(_ credential: ASAuthorizationAppleIDCredential) {
        UserDefaults.standard.set(credential.user, forKey: userIDKey)
        if let fullName = credential.fullName {
            let name = [fullName.givenName, fullName.familyName]
                .compactMap { $0 }.joined(separator: " ")
            if !name.isEmpty {
                displayName = name
                UserDefaults.standard.set(name, forKey: displayNameKey)
            }
        }
        isSignedIn = true
    }

    func signOut() {
        UserDefaults.standard.removeObject(forKey: userIDKey)
        isSignedIn = false
    }
}
