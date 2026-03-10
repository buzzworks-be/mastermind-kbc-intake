import SwiftUI

struct LetterBoxView: View {
    @Binding var letter: Character?
    let result: GuessResult?

    var body: some View {
        TextField("?", text: textBinding)
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
    }

    private var textBinding: Binding<String> {
        Binding(
            get: { letter.map(String.init) ?? "" },
            set: { letter = $0.uppercased().filter(\.isLetter).first }
        )
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
    @Previewable @State var letter: Character? = nil
    LetterBoxView(letter: $letter, result: nil)
}

#Preview("Correct") {
    @Previewable @State var letter: Character? = "A"
    LetterBoxView(letter: $letter, result: .correct)
}

#Preview("Misplaced") {
    @Previewable @State var letter: Character? = "B"
    LetterBoxView(letter: $letter, result: .misplaced)
}

#Preview("Wrong") {
    @Previewable @State var letter: Character? = "C"
    LetterBoxView(letter: $letter, result: .wrong)
}
