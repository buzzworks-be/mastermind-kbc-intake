@testable import Mastermind

struct MockGameLogicService: GameLogicServiceProtocol {
    let secret: [Character]
    let evaluateResult: [GuessResult]

    func generateSecret(length: Int) -> [Character] { secret }
    func evaluate(guess: [Character], against secret: [Character]) -> [GuessResult] { evaluateResult }
}
