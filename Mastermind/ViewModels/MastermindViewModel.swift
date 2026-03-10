import Observation

@Observable
final class MastermindViewModel {
    var slots: [GuessSlot] = Array(repeating: GuessSlot(), count: 4)

    private var secret: [Character] = []
    private let gameLogicService: GameLogicServiceProtocol

    init(gameLogicService: GameLogicServiceProtocol = GameLogicService()) {
        self.gameLogicService = gameLogicService
        self.secret = gameLogicService.generateSecret(length: 4)
    }

    var isCheckEnabled: Bool {
        slots.allSatisfy { $0.letter != nil }
    }

    func checkGuess() {
        let guess = slots.compactMap { $0.letter }
        guard guess.count == secret.count else { return }
        let results = gameLogicService.evaluate(guess: guess, against: secret)
        for (index, result) in results.enumerated() {
            slots[index].result = result
        }
    }
}
