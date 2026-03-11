import Observation

@Observable
final class MastermindViewModel {
    var slots: [GuessSlot] = Array(repeating: GuessSlot(), count: 4)

    let secret: [Character]
    private let gameLogicService: GameLogicServiceProtocol

    init(gameLogicService: GameLogicServiceProtocol = GameLogicService()) {
        self.gameLogicService = gameLogicService
        self.secret = gameLogicService.generateSecret(length: 4)
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
