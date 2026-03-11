struct GameLogicService: GameLogicServiceProtocol {
    private static let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    func generateSecret(length: Int) -> [Character] {
        (0..<length).map { _ in Self.alphabet.randomElement()! }
    }

    func evaluate(guess: [Character], against secret: [Character]) -> [GuessResult] {
        zip(guess, secret).map { guessChar, secretChar in
            if guessChar == secretChar    { return .correct }
            if secret.contains(guessChar) { return .misplaced }
            return .wrong
        }
    }
}
