import SwiftUI

struct MastermindView: View {
    @State private var viewModel = MastermindViewModel()

    var body: some View {
        @Bindable var vm = viewModel
        
        VStack(spacing: 40) {
            Text("Mastermind")
                .font(.largeTitle.bold())
            
            Text(String(viewModel.secret))
                .font(.largeTitle.bold())

            HStack(spacing: 12) {
                ForEach(0..<4, id: \.self) { index in
                    LetterBoxView(slot: $vm.slots[index])
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
