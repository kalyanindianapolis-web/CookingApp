import SwiftUI
import CloudKit

struct SettingsView: View {
    @EnvironmentObject var auth: AuthManager
    @EnvironmentObject var sharing: SharingManager
    @EnvironmentObject var remoteLoader: RemoteRecipeLoader
    @State private var showSignOutAlert = false
    @State private var haURLInput: String = ""

    var body: some View {
        NavigationStack {
            List {
                accountSection
                if auth.isSignedIn {
                    householdSection
                }
                homeAssistantSection
                aboutSection
            }
            .navigationTitle("Settings")
            .onAppear { haURLInput = remoteLoader.haURL }
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
                    Label(sharing.isOwner ? "Stop Sharing Household" : "Leave Household",
                          systemImage: "xmark.circle")
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

    // MARK: - Home Assistant

    private var homeAssistantSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 6) {
                Text("JSON URL")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                TextField("http://homeassistant.local:8123/local/recipes.json", text: $haURLInput)
                    .font(.system(size: 13))
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.URL)
                    .onSubmit { remoteLoader.haURL = haURLInput }
            }
            .padding(.vertical, 4)

            HStack {
                Button {
                    remoteLoader.haURL = haURLInput
                    remoteLoader.fetchIfReachable()
                } label: {
                    Label("Fetch now", systemImage: "arrow.clockwise")
                }

                Spacer()

                if remoteLoader.isFetching {
                    ProgressView()
                } else if !remoteLoader.recipes.isEmpty {
                    Text("\(remoteLoader.recipes.count) recipes loaded")
                        .font(.caption)
                        .foregroundStyle(.green)
                } else {
                    Text("Not connected")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            if let date = remoteLoader.lastFetched {
                Text("Last synced: \(date.formatted(date: .omitted, time: .shortened))")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        } header: {
            Text("Home Assistant Recipes")
        } footer: {
            Text("Place a recipes.json file in your HA /config/www/ folder. The app fetches it silently when on your home network.")
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
    @State private var payload: SharePayload?
    @State private var isPreparing = false

    var body: some View {
        Button {
            isPreparing = true
            Task {
                if let (share, container) = await sharing.prepareShare() {
                    payload = SharePayload(share: share, container: container)
                }
                isPreparing = false
            }
        } label: {
            HStack {
                Label(
                    sharing.isShared ? "Manage Sharing" : "Share Household",
                    systemImage: sharing.isShared ? "person.badge.plus" : "square.and.arrow.up"
                )
                if isPreparing {
                    Spacer()
                    ProgressView()
                }
            }
        }
        .disabled(isPreparing)
        .sheet(item: $payload) { payload in
            CloudSharingView(share: payload.share, container: payload.container, delegate: sharing)
                .ignoresSafeArea()
        }
    }
}

/// Identifiable wrapper so a prepared share can drive a `.sheet(item:)`.
struct SharePayload: Identifiable {
    let id = UUID()
    let share: CKShare
    let container: CKContainer
}

/// Hosts `UICloudSharingController` for reliable presentation from SwiftUI —
/// avoids the fragile key-window lookup that made the button do nothing.
struct CloudSharingView: UIViewControllerRepresentable {
    let share: CKShare
    let container: CKContainer
    let delegate: UICloudSharingControllerDelegate

    func makeUIViewController(context: Context) -> UICloudSharingController {
        let controller = UICloudSharingController(share: share, container: container)
        controller.delegate = delegate
        controller.availablePermissions = [.allowReadWrite, .allowPrivate]
        return controller
    }

    func updateUIViewController(_ uiViewController: UICloudSharingController, context: Context) {}
}

#Preview {
    SettingsView()
        .environmentObject(AuthManager())
        .environmentObject(SharingManager())
}
