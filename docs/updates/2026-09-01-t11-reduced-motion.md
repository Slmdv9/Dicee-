# 🎯 T11: reduced-motion roll transition

## 💡 Convention

`MediaQuery.disableAnimationsOf(context)` now selects the roll presentation
for both dice modes. `AnimatedDice` adds `reduceMotion` and the shared
`reducedMotionDuration` of 150 ms. A normal roll still rotates one complete
turn for 800 ms; a reduced-motion roll rotates only 0.05 turns (18 degrees)
for 150 ms.

Previously, every roll used the full 800 ms rotation even when the platform
requested reduced motion. Each page now selects the matching completion delay,
so the pending result and disabled action recover when the attenuated
transition finishes. The same `AnimationController` is reused with a shorter
duration and a smaller `Tween<double>` end value. No package or SDK change is
required.

## 🏆 Benefits

- Respects the platform accessibility preference in both dice modes.
- Preserves visual feedback without a full spin.
- Keeps animation timing, result timing, and action recovery aligned.

## 👀 Examples

### ✅ Good: use the media-query preference for both timing and rotation

Select `reducedMotionDuration` in the page and pass `reduceMotion` to the
reusable die so the displayed and logical transitions end together.

### ❌ Bad: remove motion but keep an 800 ms disabled action

Do not skip the rotation while retaining the full delay; it leaves users
waiting without feedback and makes the control state inconsistent.

## 🧐 Real world examples

- [`AnimatedDice`](../../lib/widgets/animated_dice.dart) varies rotation size.
- [`OneDicePage`](../../lib/pages/one_dice.dart) selects result timing.
- [`DicePage`](../../lib/pages/dice_page.dart) applies the preference to both dice.
- [`widget_test.dart`](../../test/widget_test.dart) injects reduced motion in both modes.
- `flutter analyze` and `flutter test` validate the change; hot reload was
  attempted but both active run sessions had ended.

## 🔗 Related agreements

- [T11 specification](../../specs/001-dicee/spec.md) covers RF-2 and RF-6.
- [Testing](../testing.md) requires stable timing assertions.
- [Architecture](../architecture.md) keeps page state local.

Less movement, same result, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
