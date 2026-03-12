# Mastermind

A SwiftUI implementation of the classic Mastermind word-guessing game.

## Gameplay

Guess a secret 4-letter code (A–Z) before the 60-second timer runs out. After submitting your guess, each letter is coloured to give feedback:

| Colour | Meaning |
|--------|---------|
| 🟢 Green | Correct letter, correct position |
| 🟠 Orange | Correct letter, wrong position |
| 🔴 Red | Letter not in the secret |

A progress bar shows time remaining. When it drops to 10 seconds or below, it turns red as a warning. The game ends in one of two ways:

- **Success** — you guessed the correct sequence; a success sheet is presented.
- **Game Over** — the timer reaches zero; a game over sheet is presented.

Both sheets offer a button to start a new game.

## Architecture

After speaking with a KBC employee (Thomas Machiels), I learned that MVVM and SOLID are core to their engineering culture. I applied both throughout this project, and chose SwiftUI to align with KBC's ongoing migration to SwiftUI across their apps.

- **Model** — `GuessSlot` pairs a guessed letter with its result. `GuessResult` defines the three feedback states.
- **ViewModel** — `MastermindViewModel` owns the game state and exposes `checkGuess()` and `isCheckEnabled`. Built with the `@Observable` macro (iOS 17+).
- **Service** — `GameLogicService` handles secret generation and guess evaluation, injected via `GameLogicServiceProtocol` for testability.
- **View** — `MastermindView`, `TimerView`, `SuccessView`, and `GameOverView` are purely presentational with no business logic. `TimerView` takes plain `Double` values and has no dependency on the ViewModel.
