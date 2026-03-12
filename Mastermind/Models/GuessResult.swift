import SwiftUI

enum GuessResult: Equatable {
    case correct
    case misplaced
    case wrong

    var color: Color {
        switch self {
        case .correct:   return .green
        case .misplaced: return .orange
        case .wrong:     return .red
        }
    }

    nonisolated static func == (lhs: GuessResult, rhs: GuessResult) -> Bool {
        switch (lhs, rhs) {
        case (.correct, .correct), (.misplaced, .misplaced), (.wrong, .wrong): return true
        default: return false
        }
    }
}
