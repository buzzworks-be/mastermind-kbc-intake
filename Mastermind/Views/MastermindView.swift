import SwiftUI

struct MastermindView: View {
    @State private var viewModel = MastermindViewModel()

    var body: some View {
        @Bindable var vm = viewModel
        
        VStack(spacing: 40) {
            Text("Mastermind")
                .font(.largeTitle.bold())

            HStack(spacing: 12) {
                ForEach(0..<4, id: \.self) { index in
                    LetterBoxView(
                        letter: $vm.slots[index].letter,
                        result: viewModel.slots[index].result
                    )
                }
            }

            Button("Check") {
                viewModel.checkGuess()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(!viewModel.isCheckEnabled)
        }
        .padding()
    }
}

#Preview {
    MastermindView()
}
