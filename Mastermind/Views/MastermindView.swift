import SwiftUI

struct MastermindView: View {
    @State private var viewModel = MastermindViewModel()

    var body: some View {
        VStack(spacing: 40) {
            Text("Mastermind")
                .font(.largeTitle.bold())

            HStack(spacing: 12) {
                ForEach(0..<4, id: \.self) { index in
                    LetterBoxView(
                        letter: .constant("A"),
                        result: .correct
                    )
                }
            }

            Button("Check") {
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding()
    }
}

#Preview {
    MastermindView()
}
