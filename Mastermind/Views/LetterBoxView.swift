import SwiftUI

struct LetterBoxView: View {
    @Binding var letter: String
    let result: GuessResult?

    var body: some View {
        TextField("?", text: $letter)
            .textFieldStyle(.plain)
            .multilineTextAlignment(.center)
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundStyle(textColor)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .animation(.easeInOut(duration: 0.3), value: result)
            )
            .onChange(of: letter) { _, newValue in
                letter = String(newValue.filter(\.isLetter).prefix(1)).uppercased()
            }
    }

    private var backgroundColor: Color {
        guard let result else { return Color.secondary.opacity(0.15) }
        return result.color
    }

    private var textColor: Color {
        result == nil ? .primary : .white
    }
}

#Preview("Empty") {
    @Previewable @State var letter = ""
    LetterBoxView(letter: $letter, result: nil)
}

#Preview("Correct") {
    @Previewable @State var letter = "A"
    LetterBoxView(letter: $letter, result: .correct)
}

#Preview("Misplaced") {
    @Previewable @State var letter = "B"
    LetterBoxView(letter: $letter, result: .misplaced)
}

#Preview("Wrong") {
    @Previewable @State var letter = "C"
    LetterBoxView(letter: $letter, result: .wrong)
}
