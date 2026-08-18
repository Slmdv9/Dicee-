# Commit conventions

This project follows the [Conventional Commits](https://www.conventionalcommits.org/) format.

## Format

```text
type(scope): short imperative description
```

The scope is optional and identifies the affected area, such as `app`, `pages`, `widgets`, `android`, or `deps`. Use a concise, lowercase imperative description without a trailing period.

All commit messages must be written in English.

Use `!` after the type or scope when a commit introduces a breaking change. Add a `BREAKING CHANGE:` footer when the change needs an explanation.

```text
feat(app)!: remove the legacy theme configuration

BREAKING CHANGE: the previous theme extension is no longer available.
```

## Allowed types

The project uses the following complete set of commit types:

| Type | Use for |
| --- | --- |
| `feat` | A new user-visible feature. |
| `fix` | A bug fix. |
| `docs` | Documentation-only changes. |
| `style` | Formatting or stylistic changes that do not change behavior. |
| `refactor` | Code restructuring that preserves behavior. |
| `perf` | A change that improves performance. |
| `test` | Adding or updating tests. |
| `build` | Build system, tooling, package, or external dependency changes. |
| `ci` | Continuous-integration configuration or scripts. |
| `chore` | Maintenance work that does not fit another type. |
| `revert` | Reverting an earlier commit. |

## Examples

```text
feat(pages): add a roll history panel
fix(widgets): preserve the dice animation on theme changes
docs: document the Flutter build commands
style: format the dice page source
refactor(app): extract the theme configuration
perf(widgets): cache dice image providers
test(pages): cover switching between dice modes
build(deps): upgrade flutter_lints to version 6
ci: run Flutter analysis in pull requests
chore: update the Android Gradle wrapper
revert: revert "feat(pages): add a roll history panel"
```
