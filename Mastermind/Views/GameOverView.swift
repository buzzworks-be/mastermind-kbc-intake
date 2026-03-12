import SwiftUI

struct GameOverView: View {
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "timer")
                .font(.system(size: 60))
                .foregroundStyle(.red)

            Text("Game Over")
                .font(.largeTitle.bold())

            Text("Your time ran out. Click retry to try again.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button("Retry") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(32)
    }
}

#Preview {
    GameOverView(retryAction: {})
}
