import Testing
@testable import Mastermind

struct GameLogicServiceTests {
    let service = GameLogicService()

    // MARK: - generateSecret

    @Test func generateSecretReturnsCorrectLength() {
        let secret = service.generateSecret(length: 4)
        #expect(secret.count == 4)
    }

    @Test func generateSecretOnlyContainsLetters() {
        let secret = service.generateSecret(length: 4)
        #expect(secret.allSatisfy { $0.isLetter })
    }

    @Test func generateSecretOnlyContainsUppercase() {
        let secret = service.generateSecret(length: 4)
        #expect(secret.allSatisfy { $0.isUppercase })
    }

    // MARK: - evaluate

    @Test func evaluateAllCorrect() {
        let result = service.evaluate(guess: ["A", "B", "C", "D"], against: ["A", "B", "C", "D"])
        #expect(result == [.correct, .correct, .correct, .correct])
    }

    @Test func evaluateAllWrong() {
        let result = service.evaluate(guess: ["E", "F", "G", "H"], against: ["A", "B", "C", "D"])
        #expect(result == [.wrong, .wrong, .wrong, .wrong])
    }

    @Test func evaluateAllMisplaced() {
        let result = service.evaluate(guess: ["B", "A", "D", "C"], against: ["A", "B", "C", "D"])
        #expect(result == [.misplaced, .misplaced, .misplaced, .misplaced])
    }
}
