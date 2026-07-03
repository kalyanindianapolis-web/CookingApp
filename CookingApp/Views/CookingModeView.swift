import SwiftUI
import Combine
import AudioToolbox

struct CookingModeView: View {
    let recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var groceryStore: GroceryStore

    @State private var currentStepIndex = 0

    // Per-step timer state — keyed by step.id — so timers keep running when you
    // move between steps and several can run at once.
    @State private var endDates: [UUID: Date] = [:]        // running timers → target end
    @State private var pausedRemaining: [UUID: Int] = [:]   // paused timers → seconds left
    @State private var finished: Set<UUID> = []             // completed timers
    @State private var now = Date()
    @State private var ticker: AnyCancellable?

    // Unique per cooking session so notifications don't collide across recipes.
    private let sessionID = UUID().uuidString

    private var currentStep: Step { recipe.steps[currentStepIndex] }
    private var progress: Double { Double(currentStepIndex + 1) / Double(recipe.steps.count) }
    private var runningCount: Int { endDates.count }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                progressBar
                ScrollView {
                    stepContent
                        .padding(.vertical, 24)
                }
                .frame(maxHeight: .infinity)
                timerSection
                navigationButtons
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .preferredColorScheme(.dark)
        .onAppear {
            CookTimerNotifier.requestAuthorization()
            UIApplication.shared.isIdleTimerDisabled = true   // keep screen awake while cooking
            startTicker()
        }
        .onDisappear {
            ticker?.cancel()
            ticker = nil
            // Cancel any still-pending step notifications for this session.
            for id in endDates.keys { CookTimerNotifier.cancel(id: notifID(id)) }
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active { tick() }   // re-sync against wall-clock time
        }
    }

    // MARK: - Subviews

    private var topBar: some View {
        HStack {
            Button { dismiss() } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.7))
                    .frame(width: 36, height: 36)
                    .background(.white.opacity(0.12))
                    .clipShape(Circle())
            }
            Spacer()
            if runningCount > 0 {
                Label("\(runningCount) running", systemImage: "timer")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.horizontal, 10).padding(.vertical, 5)
                    .background(.white.opacity(0.12))
                    .clipShape(Capsule())
            } else {
                Text(recipe.name)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .lineLimit(1)
            }
            Spacer()
            Text("\(currentStepIndex + 1) / \(recipe.steps.count)")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
                .frame(width: 60, alignment: .trailing)
        }
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white.opacity(0.15))
                    .frame(height: 4)
                RoundedRectangle(cornerRadius: 2)
                    .fill(.white)
                    .frame(width: geo.size.width * progress, height: 4)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 4)
        .padding(.bottom, 8)
    }

    private var stepContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Step \(currentStep.order)")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.white.opacity(0.4))
                .tracking(1)

            Text(currentStep.instruction)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)

            if let tip = currentStep.tip {
                HStack(alignment: .top, spacing: 8) {
                    Text("💡")
                    Text(tip)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                }
                .padding(12)
                .background(.white.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var timerSection: some View {
        Group {
            if currentStep.timerSeconds != nil {
                let isDone = finished.contains(currentStep.id)
                VStack(spacing: 12) {
                    Text(timeString(displaySeconds(currentStep)))
                        .font(.system(size: 48, weight: .thin, design: .monospaced))
                        .foregroundStyle(isDone ? .green : .white)
                        .animation(.easeInOut(duration: 0.3), value: isDone)

                    if isDone {
                        Text("Timer done!")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.green)
                            .transition(.opacity)
                    } else {
                        Button {
                            toggleTimer(currentStep)
                        } label: {
                            Image(systemName: isRunning(currentStep) ? "pause.fill" : "play.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.black)
                                .frame(width: 52, height: 52)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom, 16)
                .animation(.easeInOut(duration: 0.3), value: isDone)
            }
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 12) {
            if currentStepIndex > 0 {
                Button { currentStepIndex -= 1 } label: {
                    Text("← Back")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }

            if currentStepIndex < recipe.steps.count - 1 {
                Button { currentStepIndex += 1 } label: {
                    Text("Next →")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            } else {
                Button {
                    groceryStore.clearChecked()
                    dismiss()
                } label: {
                    Text("Finish ✓")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding(14)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
        }
    }

    // MARK: - Timer logic

    private func notifID(_ stepID: UUID) -> String { "cook-\(sessionID)-\(stepID.uuidString)" }

    private func isRunning(_ step: Step) -> Bool { endDates[step.id] != nil }

    /// Seconds to show for a step: live countdown if running, 0 if done,
    /// else the paused remainder or the step's full duration.
    private func displaySeconds(_ step: Step) -> Int {
        if let end = endDates[step.id] { return max(0, Int(ceil(end.timeIntervalSince(now)))) }
        if finished.contains(step.id) { return 0 }
        return pausedRemaining[step.id] ?? (step.timerSeconds ?? 0)
    }

    private func toggleTimer(_ step: Step) {
        isRunning(step) ? pause(step) : start(step)
    }

    private func start(_ step: Step) {
        let seconds = pausedRemaining[step.id] ?? (step.timerSeconds ?? 0)
        guard seconds > 0 else { return }
        finished.remove(step.id)
        pausedRemaining[step.id] = nil
        endDates[step.id] = Date().addingTimeInterval(TimeInterval(seconds))
        // Local notification so it fires even if the app is backgrounded.
        CookTimerNotifier.schedule(id: notifID(step.id), after: seconds, recipeName: recipe.name)
        startTicker()
    }

    private func pause(_ step: Step) {
        if let end = endDates[step.id] {
            pausedRemaining[step.id] = max(0, Int(ceil(end.timeIntervalSinceNow)))
        }
        endDates[step.id] = nil
        CookTimerNotifier.cancel(id: notifID(step.id))
    }

    private func startTicker() {
        guard ticker == nil else { return }
        ticker = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in tick() }
    }

    /// Advances the clock and completes any timers whose end time has passed.
    private func tick() {
        now = Date()
        let done = endDates.filter { $0.value <= now }.map(\.key)
        guard !done.isEmpty else { return }
        for id in done {
            endDates[id] = nil
            finished.insert(id)
            CookTimerNotifier.cancel(id: notifID(id))
        }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        AudioServicesPlaySystemSound(1005)
    }

    private func timeString(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

#Preview {
    CookingModeView(recipe: SeedRecipes.dalTadka)
}
