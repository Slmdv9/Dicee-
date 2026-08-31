# 🎯 T8: one-die 800 ms roll animation

## 💡 Convention

`AnimatedDice` is now stateful and owns an `AnimationController` with the
shared `rollDuration` constant of 800 ms. When `isRolling` becomes true, a
`RotationTransition` advances from zero to one complete turn. The controller
resets after completion without a visible reverse motion because zero and one
turn have the same final orientation.

Previously, `OneDicePage` resolved its pending result after 50 ms and
`AnimatedDice` only changed its occupied surface. It now waits for
`AnimatedDice.rollDuration`, so the existing pending value is displayed after
the complete visual transition. The page still owns the phase and random value;
the widget only owns presentation timing. No packages or SDK constraints change.

## 🏆 Benefits

- Makes a one-die roll visibly last 800 ms.
- Keeps the generated result stable before and after the animation.
- Reuses one duration constant for state completion and visual motion.

## 👀 Examples

### ✅ Good: advance a controller once per roll

Start the controller with `forward(from: 0)` when `isRolling` changes to true,
then use the stored pending value after `rollDuration`.

### ❌ Bad: reset the rotation target through an implicit reverse animation

Do not animate from one turn back to zero after a roll; it creates a second,
backward movement after the result should be stable.

## 🧐 Real world examples

- [`AnimatedDice`](../../lib/widgets/animated_dice.dart) owns the controller.
- [`OneDicePage`](../../lib/pages/one_dice.dart) resolves its pending value.
- [`widget_test.dart`](../../test/widget_test.dart) advances the fake clock.

## 🔗 Related agreements

- [T8 specification](../../specs/001-dicee/spec.md) covers RF-2 and RF-5.
- [Testing](../testing.md) requires stable assertions.
- [Architecture](../architecture.md) keeps page state local.

Motion with a stable result, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
