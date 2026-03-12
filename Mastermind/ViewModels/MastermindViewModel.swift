import Observation
import Foundation

@Observable
final class MastermindViewModel {
    var slots: [GuessSlot] = Array(repeating: GuessSlot(), count: 4)
    var timeRemaining: Double = 60

    let secret: [Character]
    private let gameLogicService: GameLogicServiceProtocol
    private var timer: Timer?

    init(gameLogicService: GameLogicServiceProtocol = GameLogicService()) {
        self.gameLogicService = gameLogicService
        self.secret = gameLogicService.generateSecret(length: 4)
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
            }
        }
    }

    var isCheckEnabled: Bool {
        slots.allSatisfy { $0.letter != nil }
    }

    func checkGuess() {
        let results = gameLogicService.evaluate(
            guess: slots.compactMap { $0.letter },
            against: secret
        )
        for (index, result) in zip(slots.indices, results) {
            slots[index].result = result
        }
    }
}
