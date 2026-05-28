import SwiftUI
import CloudKit

struct SettingsView: View {
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var sharing: SharingManager
    @State private var showSignOutAlert = false
    @State private var showShareSheet = false

    var body: some View {
        NavigationStack {
            List {
                accountSection
                if auth.isSignedIn {
                    householdSection
                }
                aboutSection
            }
            .navigationTitle("Settings")
        }
    }

    // MARK: - Account

    private var accountSection: some View {
        Section("Account") {
            if auth.isSignedIn {
                HStack(spacing: 12) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 36))
                        .foregroundStyle(.secondary)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(auth.displayName.isEmpty ? "Apple Account" : auth.displayName)
                            .font(.system(size: 15, weight: .semibold))
                        Text(auth.iCloudAvailable ? "iCloud connected" : "iCloud unavailable")
                            .font(.caption)
                            .foregroundStyle(auth.iCloudAvailable ? .green : .orange)
                    }
                }
                .padding(.vertical, 4)

                Button(role: .destructive) {
                    showSignOutAlert = true
                } label: {
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                }
                .alert("Sign Out?", isPresented: $showSignOutAlert) {
                    Button("Sign Out", role: .destructive) { auth.signOut() }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Your data stays in iCloud. Sign back in any time.")
                }
            }
        }
    }

    // MARK: - Household sharing

    private var householdSection: some View {
        Section {
            if sharing.isShared {
                VStack(alignment: .leading, spacing: 10) {
                    Label("Household shared", systemImage: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                        .font(.system(size: 14, weight: .semibold))

                    if !sharing.participants.isEmpty {
                        ForEach(sharing.participants, id: \.self) { name in
                            HStack(spacing: 8) {
                                Image(systemName: "person.fill")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(name)
                                    .font(.subheadline)
                            }
                        }
                    } else {
                        Text("No one has joined yet — share the link below.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 4)

                ShareHouseholdButton(sharing: sharing)

                Button(role: .destructive) {
                    sharing.leaveHousehold()
                } label: {
                    Label("Stop Sharing Household", systemImage: "xmark.circle")
                }
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    Label("Share with Household", systemImage: "person.2.fill")
                        .font(.system(size: 15, weight: .semibold))
                    Text("Invite your partner or family to share the same meal plan and grocery list in real time.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)

                ShareHouseholdButton(sharing: sharing)
            }
        } header: {
            Text("Household")
        } footer: {
            Text("Shared data: meal plan, grocery list, and custom recipes. Seed recipes are built into the app and are the same for everyone.")
        }
    }

    // MARK: - About

    private var aboutSection: some View {
        Section("App") {
            HStack {
                Text("Version")
                Spacer()
                Text("1.0")
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text("Storage")
                Spacer()
                Text("iCloud")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

// MARK: - Share button (UIKit bridge)

struct ShareHouseholdButton: View {
    @ObservedObject var sharing: SharingManager

    var body: some View {
        Button {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let root = scene.windows.first?.rootViewController else { return }
            Task {
                await sharing.presentShareSheet(from: root)
            }
        } label: {
            Label(
                sharing.isShared ? "Manage Sharing" : "Share Household",
                systemImage: sharing.isShared ? "person.badge.plus" : "square.and.arrow.up"
            )
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AuthManager())
        .environmentObject(SharingManager())
}
