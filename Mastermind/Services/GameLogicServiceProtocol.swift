protocol GameLogicServiceProtocol {
    func generateSecret(length: Int) -> [Character]
    func evaluate(guess: [Character], against secret: [Character]) -> [GuessResult]
}
