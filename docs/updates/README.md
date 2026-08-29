# 🎯 Code change learning updates

## 💡 Convention

Every change that modifies application code must include a focused Markdown
note under `docs/updates/`, named `YYYY-MM-DD-short-slug.md`. Write the note in
English and explain the change for learning, not only for release history:

Before implementation begins, the agent must explain the planned change to the
user in theoretical and practical terms. The explanation must precede code
changes and establish the intended before/after behavior.

After implementation and validation, the agent must repeat the educational
summary in the conversation before asking for commit confirmation. This chat
summary must describe the actual before/after behavior, the main concepts or
APIs introduced, and link to the detailed update note.

- Describe the goal and the theoretical concept behind the change.
- Explain the practical behavior before and after the change.
- Explain new or changed variables, classes, APIs, declarations, and language
  features, comparing them with the previous approach.
- Record dependency or Flutter/Dart version implications when relevant.
- Record the tests and validation used to verify the change.

Keep each update focused and approximately 50 lines. If it must be longer,
split it into linked subdocuments so readers can load only what they need.

## 🏆 Benefits

- Turns every code change into a reusable Flutter learning reference.
- Makes syntax, API, dependency, and language-version changes understandable.
- Preserves the reasoning behind implementation choices for future maintainers.
- Keeps the learning explanation visible to the user at the point of review.
- Supports progressive disclosure through focused, selectively readable notes.

## 👀 Examples

### ✅ Good: Explain a code change as theory and practice

A dated update explains the old and new declaration, why the new API is used,
its runtime effect, compatibility considerations, and the tests that verify it.

### ❌ Bad: Record only a one-line change summary

Do not write “updated animation” without explaining the relevant concepts,
before/after behavior, affected APIs, dependency implications, and validation.

## 🧐 Real world examples

- [`specs/001-dicee/`](../../specs/001-dicee/) contains the current design and
  implementation planning context for a learning-oriented change.
- [`workflow.md`](../workflow.md) requires an update note as part of code work.
- Future code changes should add dated notes beside this guide in `docs/updates/`.

## 🔗 Related agreements

- [Workflow](../workflow.md) defines when an update note is required.
- [Constitution](../constitution.md) requires spec, code, and tests to agree.
- [Documentation conventions](../documentation-conventions.md) defines focus,
  structure, language, and document size.

Learning made durable by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
