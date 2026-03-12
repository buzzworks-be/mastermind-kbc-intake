import Observation
import Foundation

@Observable
final class MastermindViewModel {
    private let duration: Double = 60
    private let gameLogicService: GameLogicServiceProtocol
    private var timer: Timer?

    private(set) var timeRemaining: Double
    private(set) var secret: [Character]
    
    var isGameOverPresented = false
    var isSuccessPresented = false
    var slots: [GuessSlot] = Array(repeating: GuessSlot(), count: 4)

    var totalDuration: Double { duration }

    init(gameLogicService: GameLogicServiceProtocol = GameLogicService()) {
        self.gameLogicService = gameLogicService
        self.timeRemaining = duration
        self.secret = gameLogicService.generateSecret(length: 4)
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tickTimer()
        }
    }

    var isCheckEnabled: Bool {
        slots.allSatisfy { $0.letter != nil }
    }

    func checkGuess() {
        let currentGuess = slots.compactMap { $0.letter }
        let results = gameLogicService.evaluate(
            guess: currentGuess,
            against: secret
        )
        for (index, result) in zip(slots.indices, results) {
            slots[index].result = result
        }

        if currentGuess == secret {
            presentSuccess()
        }
    }

    func resetGame() {
        timer?.invalidate()
        slots = Array(repeating: GuessSlot(), count: 4)
        secret = gameLogicService.generateSecret(length: 4)
        timeRemaining = duration
        isGameOverPresented = false
        isSuccessPresented = false
        startTimer()
    }

    private func tickTimer() {
        timeRemaining = max(timeRemaining - 1, 0)
        if timeRemaining == 0 {
            presentGameOver()
        }
    }

    private func presentGameOver() {
        guard !isGameOverPresented else { return }
        timer?.invalidate()
        timer = nil
        isGameOverPresented = true
    }

    private func presentSuccess() {
        guard !isSuccessPresented else { return }
        timer?.invalidate()
        timer = nil
        isSuccessPresented = true
    }
}
