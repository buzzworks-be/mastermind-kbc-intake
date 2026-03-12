import Testing
@testable import Mastermind

struct MastermindViewModelTests {

    // MARK: - isCheckEnabled

    struct IsCheckEnabled {
        let vm = MastermindViewModel(gameLogicService: MockGameLogicService(
            secret: ["A", "B", "C", "D"],
            evaluateResult: []
        ))

        @Test func falseWhenNoLetters() {
            #expect(vm.isCheckEnabled == false)
        }

        @Test func falseWhenPartiallyFilled() {
            vm.slots[0].letter = "A"
            vm.slots[1].letter = "B"
            #expect(vm.isCheckEnabled == false)
        }

        @Test func trueWhenAllFilled() {
            vm.slots[0].letter = "A"
            vm.slots[1].letter = "B"
            vm.slots[2].letter = "C"
            vm.slots[3].letter = "D"
            #expect(vm.isCheckEnabled == true)
        }
    }

    // MARK: - checkGuess

    struct CheckGuess {
        let vm = MastermindViewModel(gameLogicService: MockGameLogicService(
            secret: ["A", "B", "C", "D"],
            evaluateResult: [.correct, .wrong, .misplaced, .wrong]
        ))

        @Test func assignsResultsToSlots() {
            vm.checkGuess()

            #expect(vm.slots[0].result == .correct)
            #expect(vm.slots[1].result == .wrong)
            #expect(vm.slots[2].result == .misplaced)
            #expect(vm.slots[3].result == .wrong)
        }

        @Test func presentsSuccessWhenCorrect() {
            let vm = MastermindViewModel(gameLogicService: MockGameLogicService(
                secret: ["A", "B", "C", "D"],
                evaluateResult: [.correct, .correct, .correct, .correct]
            ))
            vm.slots[0].letter = "A"
            vm.slots[1].letter = "B"
            vm.slots[2].letter = "C"
            vm.slots[3].letter = "D"

            vm.checkGuess()

            #expect(vm.isSuccessPresented == true)
            #expect(vm.isGameOverPresented == false)
        }
    }

    // MARK: - resetGame

    struct ResetGame {
        let vm = MastermindViewModel(gameLogicService: MockGameLogicService(
            secret: ["A", "B", "C", "D"],
            evaluateResult: [.correct, .correct, .correct, .correct]
        ))

        @Test func clearsSlots() {
            vm.slots[0].letter = "A"
            vm.slots[0].result = .correct

            vm.resetGame()

            #expect(vm.slots.allSatisfy { $0.letter == nil && $0.result == nil })
        }

        @Test func resetsTimer() {
            vm.resetGame()
            #expect(vm.timeRemaining == vm.totalDuration)
        }

        @Test func dismissesSheets() {
            vm.slots[0].letter = "A"
            vm.slots[1].letter = "B"
            vm.slots[2].letter = "C"
            vm.slots[3].letter = "D"
            vm.checkGuess()

            vm.resetGame()

            #expect(vm.isSuccessPresented == false)
            #expect(vm.isGameOverPresented == false)
        }
    }
}
