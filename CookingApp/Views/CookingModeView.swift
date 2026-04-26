import SwiftUI
import Combine

struct CookingModeView: View {
    let recipe: Recipe
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var groceryStore: GroceryStore

    @State private var currentStepIndex = 0
    @State private var timerSecondsLeft = 0
    @State private var timerRunning = false
    @State private var timerCancellable: AnyCancellable?

    private var currentStep: Step { recipe.steps[currentStepIndex] }
    private var progress: Double { Double(currentStepIndex + 1) / Double(recipe.steps.count) }

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
        .onAppear { loadTimer() }
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
            Text(recipe.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(.white.opacity(0.7))
                .lineLimit(1)
            Spacer()
            Text("\(currentStepIndex + 1) / \(recipe.steps.count)")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
                .frame(width: 36, alignment: .trailing)
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
                VStack(spacing: 12) {
                    Text(timeString(timerSecondsLeft))
                        .font(.system(size: 48, weight: .thin, design: .monospaced))
                        .foregroundStyle(.white)

                    Button {
                        timerRunning ? pauseTimer() : startTimer()
                    } label: {
                        Image(systemName: timerRunning ? "pause.fill" : "play.fill")
                            .font(.system(size: 20))
                            .foregroundStyle(.black)
                            .frame(width: 52, height: 52)
                            .background(.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 16)
            }
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 12) {
            if currentStepIndex > 0 {
                Button {
                    go(to: currentStepIndex - 1)
                } label: {
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
                Button {
                    go(to: currentStepIndex + 1)
                } label: {
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

    private func go(to index: Int) {
        stopTimer()
        currentStepIndex = index
        loadTimer()
    }

    private func loadTimer() {
        timerSecondsLeft = currentStep.timerSeconds ?? 0
        timerRunning = false
    }

    private func startTimer() {
        timerRunning = true
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timerSecondsLeft > 0 {
                    timerSecondsLeft -= 1
                } else {
                    stopTimer()
                }
            }
    }

    private func pauseTimer() {
        timerRunning = false
        timerCancellable?.cancel()
    }

    private func stopTimer() {
        timerRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
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
