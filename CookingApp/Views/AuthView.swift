import SwiftUI
import AuthenticationServices

struct AuthView: View {
    @EnvironmentObject var auth: AuthManager
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 16) {
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 72))
                    .foregroundStyle(Color(hex: "E53935"))
                    .padding(.bottom, 8)

                Text("CookingApp")
                    .font(.system(size: 32, weight: .bold))
                    .tracking(-0.5)

                Text("Plan meals, share with your household,\nand cook together.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            VStack(spacing: 16) {
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        errorMessage = nil
                        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
                            auth.handleCredential(credential)
                        }
                    case .failure(let error):
                        // Surface the failure instead of swallowing it. A missing
                        // "Sign in with Apple" entitlement shows up here.
                        let nsError = error as NSError
                        if nsError.code == ASAuthorizationError.canceled.rawValue {
                            errorMessage = nil   // user tapped Cancel; not an error
                        } else {
                            errorMessage = nsError.localizedDescription
                        }
                    }
                }
                .signInWithAppleButtonStyle(.black)
                .frame(height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 14))

                if let errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }

                Text("Sign in uses your Apple ID. Your data is stored in iCloud.")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}
