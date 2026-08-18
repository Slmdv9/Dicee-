# Dicee+ Agent Guide

## Stack

- Flutter and Dart.
- Material 3 for theming and UI components.
- Native Flutter platform runners for Android, iOS, web, Linux, macOS, and Windows.
- `flutter_lints` for static analysis.

## Architecture

- `lib/main.dart` is the application entry point.
- `lib/app/` contains the root application widget and global theme configuration.
- `lib/pages/` contains the screen-level widgets for each dice mode.
- `lib/widgets/` contains reusable presentation widgets.
- Each dice page owns its local UI state and roll action; no state-management package is used.
- Image assets are stored in `images/` and declared in `pubspec.yaml`.

## Useful commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run
flutter build apk
flutter build ios
flutter build web
```

## Documentation

- Detailed conventions with examples live in `docs/`.
- **Do NOT read all docs upfront.**
- When working on a task, use this map to find and read only the docs relevant to your task:

```text
docs/
├── architecture.md      # Module boundaries, widget responsibilities, assets, and state
├── builds.md            # Dependency setup, local runs, tests, and platform builds
├── commit-conventions.md # Conventional Commit types, structure, and examples
└── documentation-conventions.md # Documentation language and writing conventions
```
