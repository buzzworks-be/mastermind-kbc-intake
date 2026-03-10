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
}