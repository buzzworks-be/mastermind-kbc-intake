import SwiftUI

struct MastermindView: View {
    @State private var viewModel = MastermindViewModel()

    var body: some View {
        @Bindable var vm = viewModel
        
        VStack(spacing: 20) {
            Text("Mastermind")
                .font(.largeTitle.bold())

            Text(String(viewModel.secret))
                .font(.largeTitle.bold())

            HStack(spacing: 12) {
                ForEach(vm.slots.indices, id: \.self) { index in
                    LetterBoxView(slot: $vm.slots[index])
                }
            }

            TimerView(timeRemaining: viewModel.timeRemaining, total: viewModel.totalDuration)

            Button("Check") {
                viewModel.checkGuess()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(!viewModel.isCheckEnabled)
        }
        .padding()
        .onAppear {
            viewModel.startTimer()
        }
        .sheet(isPresented: $vm.isSuccessPresented) {
            SuccessView {
                viewModel.resetGame()
            }
        }
        .sheet(isPresented: $vm.isGameOverPresented) {
            GameOverView {
                viewModel.resetGame()
            }
        }
    }
}

#Preview {
    MastermindView()
}
