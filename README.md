# Mastermind

A SwiftUI implementation of the classic Mastermind word-guessing game.

## Gameplay

Guess a secret 4-letter code (A–Z). After submitting your guess, each letter is coloured to give feedback:

| Colour | Meaning |
|--------|---------|
| 🟢 Green | Correct letter, correct position |
| 🟠 Orange | Correct letter, wrong position |
| 🔴 Red | Letter not in the secret |

## Architecture

After speaking with a KBC employee (Thomas Machiels), I learned that MVVM and SOLID are core to their engineering culture. I applied both throughout this project, and chose SwiftUI to align with KBC's ongoing migration to SwiftUI across their apps.

- **Model** — `GuessSlot` pairs a guessed letter with its result. `GuessResult` defines the three feedback states.
- **ViewModel** — `MastermindViewModel` owns the game state and exposes `checkGuess()` and `isCheckEnabled`. Built with the `@Observable` macro (iOS 17+).
- **Service** — `GameLogicService` handles secret generation and guess evaluation, injected via `GameLogicServiceProtocol` for testability.
- **View** — `MastermindView` and `LetterBoxView` are purely presentational with no business logic.
