# 🎯 T9: coordinated two-dice roll animation

## 💡 Convention

`DicePage` now resolves both pending values after
`AnimatedDice.rollDuration`, the shared 800 ms duration already used by each
die presentation. Both `AnimatedDice` instances receive `isRolling: true` in
the same `setState`, so their independent controllers begin within the same
widget update.

Previously, the two-die page exposed its pending values after 50 ms, while the
shared die presentation was capable of an 800 ms rotation. It now preserves
`_pendingLeft` and `_pendingRight` through the whole visual transition, then
assigns both values and ends the local roll phase together. The existing
separate fields keep each result independent; no global state, package, or SDK
change is required.

## 🏆 Benefits

- Keeps both dice visibly spinning for the same 800 ms interval.
- Applies each stored result only after the coordinated animation finishes.
- Reuses the one-die timing contract without duplicating a duration literal.

## 👀 Examples

### ✅ Good: resolve both pending values after one shared duration

Set `_rollPhase` to `rolling` once, then assign `_pendingLeft` and
`_pendingRight` together after `AnimatedDice.rollDuration`.

### ❌ Bad: finish each die with a separate timer

Do not create independent delays for left and right values; a late timer can
make the pair appear out of sync or expose an intermediate result.

## 🧐 Real world examples

- [`DicePage`](../../lib/pages/dice_page.dart) owns both pending values.
- [`AnimatedDice`](../../lib/widgets/animated_dice.dart) owns each rotation.
- [`widget_test.dart`](../../test/widget_test.dart) checks both at 400 and 800 ms.
- `flutter analyze` and `flutter test` pass; hot reload succeeds on Android and
  macOS.

## 🔗 Related agreements

- [T9 specification](../../specs/001-dicee/spec.md) covers RF-2, RF-4, and RF-5.
- [Testing](../testing.md) requires deterministic assertions.
- [Architecture](../architecture.md) keeps mode state local.

Two independent results, one shared rhythm, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
