# 🎯 T6: enriched reusable die presentation

## 💡 Convention

`AnimatedDice` remains a stateless presentation boundary: pages continue to
own roll state, while the widget receives the value and a visual `isRolling`
flag. The widget now wraps the existing themed asset in an
`AnimatedContainer` whose Material 3 surface, rounded shape, border, and shadow
communicate depth and the occupied state.

In theory, a boolean is appropriate when the view has two mutually exclusive
visual modes. In practice, `isRolling: true` selects the primary-color border
and stronger elevation; the default `false` keeps the neutral result surface.
The previous implementation animated only the asset swap with
`AnimatedSwitcher`; the new implementation preserves that behavior and adds a
separate, bounded surface transition without introducing a dependency.

## 🏆 Benefits

- Keeps the six-value light/dark asset mapping unchanged.
- Gives both pages the same depth and occupied-state language.
- Leaves animation timing and roll ownership for the later state tasks.

## 👀 Examples

### ✅ Good: pass presentation state from the owning page

`AnimatedDice(value: value, isRolling: isRolling)` lets a page decide when a
roll is active while the reusable widget only renders that decision.

### ❌ Bad: generate values or own timers inside `AnimatedDice`

That would mix page state with presentation and make deterministic tests harder.

## 🔗 Related agreements

- [T6 plan](../../specs/001-dicee/plan.md) covers RF-1, RF-2, RF-5, and RF-7.
- [Architecture](../architecture.md) keeps state in pages and assets in `images/`.
- [Testing](../testing.md) requires stable widget assertions.

Depth around the result, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
