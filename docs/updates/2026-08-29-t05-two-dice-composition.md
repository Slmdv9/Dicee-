# 🎯 T5: adaptive two-dice composition

## 💡 Convention

The two-dice screen must preserve a shared action while making both results
independent and readable. This change mirrors T4's responsive composition but
adds a bounded row of two result columns inside one shared card.

`LayoutBuilder` derives each die's size from the available width, horizontal
padding, card padding, and the inter-die gap. `Expanded` gives both result
columns equal space, while `Semantics` exposes `Left result` and `Right result`
explicitly. The previous fixed row of two default-size dice is replaced by a
constraint-aware composition that can scroll vertically when needed.

## 🏆 Benefits

- Keeps both dice visually related but independently understandable.
- Prevents fixed widths from causing overlap in compact layouts.
- Reuses the existing `AnimatedDice` boundary and local page state.

## 👀 Examples

### ✅ Good: calculate shared space before sizing both dice

The available width is reduced by outer padding, card padding, and the gap before
the two equal columns receive their die size. Each column then presents one die
and one labeled result above the shared `Roll two dice` action.

### ❌ Bad: place two fixed-size dice without constraints

A fixed row can overflow or overlap when the viewport narrows, and unlabeled
faces make it harder to tell which result belongs to which die.

## 🧐 Real world examples

- [`lib/pages/dice_page.dart`](../../lib/pages/dice_page.dart) contains the responsive composition.
- [`test/widget_test.dart`](../../test/widget_test.dart) verifies both results and compact space.
- [`specs/001-dicee/visual-states.md`](../../specs/001-dicee/visual-states.md) defines the visual states.

## 🔗 Related agreements

- [T5 specification](../../specs/001-dicee/spec.md) defines RF-1, RF-4, and RF-7.
- [T4 update](2026-08-29-t04-one-die-composition.md) establishes the one-die layout pattern.
- [Testing](../testing.md) requires stable behavior-focused tests.

Two results, one clear composition, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
