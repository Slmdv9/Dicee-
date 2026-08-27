# 🎯 Architecture conventions

## 💡 Convention

Dicee+ is a small Flutter application using Material 3, built-in widget state,
and no external state-management, routing, or dependency-injection packages.
Keep boundaries aligned with the existing `lib/` layout:

```text
lib/
├── main.dart                   # Application entry point
├── app/dicee_app.dart          # MaterialApp and application-wide themes
├── pages/                      # Tab navigation and mode-specific state
└── widgets/animated_dice.dart # Reusable animated die presentation
```

Pages own local mode state; reusable presentation belongs in `widgets/`; assets
remain in `images/` and are declared in `pubspec.yaml`. Die values stay in the
one-based range 1 through 6 because image names map directly to those values.

## 🏆 Benefits

- Keeps the stack simple and understandable.
- Makes ownership and data flow predictable.
- Prevents duplicated page state and broken asset mappings.

## 👀 Examples

### ✅ Good: Keep mode state local

`OneDice` and `DicePage` own their values and call `setState` after a roll.
`AnimatedDice` receives a value and renders it without owning application state.

### ❌ Bad: Add an unnecessary state-management package

Do not introduce a global store for state used by a single dice page; it adds
complexity without sharing behavior.

## 🧐 Real world examples

- [`lib/app/dicee_app.dart`](../lib/app/dicee_app.dart) configures the root app.
- [`lib/pages/`](../lib/pages/) contains mode-specific state and composition.
- [`lib/widgets/animated_dice.dart`](../lib/widgets/animated_dice.dart) reuses die presentation.
- [`images/`](../images/) contains the light and dark die assets.

## 🔗 Related agreements

- [Constitution](constitution.md) defines stack simplicity and spec/code alignment.
- [Testing](testing.md) defines verification expectations for behavior changes.

Architecture documented by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
