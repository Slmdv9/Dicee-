# 🎯 T4: adaptive one-die composition

## 💡 Convention

The one-die screen should express a clear content hierarchy while adapting to
the available space. This change keeps the existing local state and roll action
but replaces the previous centered, fixed-spacing column with a responsive
composition.

`LayoutBuilder` exposes the parent constraints so the view can derive
`isCompact`, `horizontalPadding`, and `diceSize`. `SafeArea` protects content
from platform insets, while `SingleChildScrollView` and `ConstrainedBox` allow
the composition to remain usable when vertical space is limited. `Card` makes
the die the visual focus, and `Semantics` gives the current result an explicit
accessible description.

## 🏆 Benefits

- Makes the result the primary content instead of an unlabeled image.
- Prevents fixed spacing from causing clipping in compact layouts.
- Keeps the implementation within Flutter's existing layout primitives.

## 👀 Examples

### ✅ Good: derive layout from constraints

The previous fixed `Column` with a 160-pixel die and a 40-pixel gap is now a
constraint-aware layout with compact and regular spacing decisions. The result
is visible as `Result: N`, while the existing `Roll one die` action remains the
single primary interaction.

### ❌ Bad: rely on fixed dimensions only

A centered column with fixed gaps and no scroll or safe-area handling can clip
the action or overlap content when the available height changes.

## 🧐 Real world examples

- [`lib/pages/one_dice.dart`](../../lib/pages/one_dice.dart) contains the adaptive composition.
- [`test/widget_test.dart`](../../test/widget_test.dart) verifies result visibility and compact layout.
- [`specs/001-dicee/visual-states.md`](../../specs/001-dicee/visual-states.md) defines the visual states.

## 🔗 Related agreements

- [T4 specification](../../specs/001-dicee/spec.md) defines RF-1 and RF-7.
- [Architecture](../architecture.md) keeps mode state in its page.
- [Testing](../testing.md) requires stable, behavior-focused tests.

Adaptive composition explained by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
