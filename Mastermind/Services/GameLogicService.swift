struct GameLogicService: GameLogicServiceProtocol {
    private static let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    func generateSecret(length: Int) -> [Character] {
        (0..<length).map { _ in Self.alphabet.randomElement()! }
    }

    func evaluate(guess: [Character], against secret: [Character]) -> [GuessResult] {
        return [.correct]
    }
}
