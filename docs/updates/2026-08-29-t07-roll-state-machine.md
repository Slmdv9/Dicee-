# 🎯 T7: local roll state machine

## 💡 Convention

Each dice page now models a roll with the private `_RollPhase` enum:
`available`, `rolling`, and `result`. The page remains the state owner; the
reusable `AnimatedDice` receives only the current value and `isRolling`.

The previous implementation generated and assigned random values directly in
one `setState` call. The new implementation first stores each generated value
in a pending field, enters `rolling`, then applies that pending value after the
short transition. This separates intent from presentation and ensures one
random value per die per roll. The temporary `Future.delayed` is deliberately
short; T8 will replace it with the specified 800 ms animation timing.

## 🏆 Benefits

- Makes available, occupied, and stable states observable and testable.
- Keeps one-die and two-dice state independent and local to their pages.
- Prevents a second tap from generating another value while rolling.

## 👀 Examples

### ✅ Good: generate once, then resolve the pending value

`_pendingLeft` and `_pendingRight` are assigned before the state changes to
`rolling`; completion reads those fields instead of generating again.

### ❌ Bad: call `Random()` during every animation frame

That would make the final result unstable and couple tests to uncontrolled
randomness.

## 🔗 Related agreements

- [T7 specification](../../specs/001-dicee/spec.md) covers RF-2, RF-3, RF-4, and RF-5.
- [Architecture](../architecture.md) keeps state local to each page.
- [Testing](../testing.md) requires deterministic state assertions.

State before spectacle, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
