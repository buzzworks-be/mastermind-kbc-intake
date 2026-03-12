import SwiftUI

struct TimerView: View {
    let timeRemaining: Double
    let total: Double

    private var isLow: Bool { timeRemaining <= 10 }

    var body: some View {
        VStack(spacing: 8) {
            ProgressView(value: timeRemaining, total: total)
                .frame(width: 240)
                .tint(isLow ? .red : .blue)
            Text("\(Int(timeRemaining))s remaining")
                .font(.headline.monospacedDigit())
                .foregroundStyle(isLow ? Color.red : Color.primary)
        }
    }
}
