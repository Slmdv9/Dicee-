# Architecture

## Overview

Dicee+ is a small Flutter application that lets users roll one or two dice. It uses Flutter's built-in widget state and does not rely on external state-management, routing, or dependency-injection packages.

## Module boundaries

```text
lib/
├── main.dart                 # Application entry point
├── app/
│   └── dicee_app.dart         # MaterialApp and application-wide themes
├── pages/
│   ├── home_page.dart         # Tab navigation and page composition
│   ├── one_dice.dart          # One-die mode and its local state
│   └── dice_page.dart         # Two-dice mode and its local state
└── widgets/
    └── animated_dice.dart     # Reusable animated die presentation
```

## Responsibilities and data flow

`main.dart` starts `DiceeApp`. `DiceeApp` configures Material 3 light and dark themes, then displays `HomePage`.

`HomePage` owns the tab layout and presents the one-die and two-dice modes. Each mode is a `StatefulWidget` because it owns the current die value or values. Its roll action generates values from 1 through 6 and calls `setState` to rebuild the page.

`AnimatedDice` is a stateless reusable widget. It receives a die value and optional size, selects the light or dark image from the active theme, and animates changes with `AnimatedSwitcher`.

## Assets

All dice images live in `images/` and are registered through the `assets` section of `pubspec.yaml`. Keep the light and dark variants aligned with the naming convention used by `AnimatedDice`:

```text
images/dice1.png
images/dice1_light.png
```

When adding an asset, update `pubspec.yaml` if it is outside the existing `images/` directory.

## Implementation guidance

- Keep application-wide configuration in `lib/app/`.
- Keep mode-specific state inside its corresponding page unless more than one page needs it.
- Extract widgets used by multiple pages to `lib/widgets/`.
- Preserve the one-based die-value range because image file names map directly to values 1 through 6.
