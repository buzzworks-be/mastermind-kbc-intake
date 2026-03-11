import SwiftUI

struct LetterBoxView: View {
    @Binding private var slot: GuessSlot
    @State private var text = ""

    init(slot: Binding<GuessSlot>) {
        self._slot = slot
    }
    
    var body: some View {
        TextField("?", text: $text)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.center)
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundStyle(textColor)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .animation(.easeInOut(duration: 0.3), value: slot.result)
            )
            .onChange(of: text) { _, newValue in
                let filtered = String(newValue.uppercased().filter(\.isLetter).prefix(1))
                text = filtered
                slot.letter = filtered.first
            }
    }

    private var backgroundColor: Color {
        return slot.result?.color ?? Color.secondary.opacity(0.15)
    }

    private var textColor: Color {
        slot.result == nil ? .primary : .white
    }
}

#Preview("Empty") {
    @Previewable @State var slot = GuessSlot()
    LetterBoxView(slot: $slot)
}

#Preview("Correct") {
    @Previewable @State var slot = GuessSlot(letter: "A", result: .correct)
    LetterBoxView(slot: $slot)
}

#Preview("Misplaced") {
    @Previewable @State var slot = GuessSlot(letter: "B", result: .misplaced)
    LetterBoxView(slot: $slot)
}

#Preview("Wrong") {
    @Previewable @State var slot = GuessSlot(letter: "C", result: .wrong)
    LetterBoxView(slot: $slot)
}
