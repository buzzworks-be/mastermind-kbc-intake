import SwiftUI

struct SuccessView: View {
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .foregroundStyle(.yellow)

            Text("Success!")
                .font(.largeTitle.bold())

            Text("You found the code. Click retry to try again.")
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
    SuccessView(retryAction: {})
}
