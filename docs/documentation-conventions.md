# 🎯 Documentation conventions

## 💡 Convention

Write all project documentation in clear, concise English. Every convention
belongs in a focused Markdown file under `docs/` and follows this order:
`Convention`, `Benefits`, `Examples`, `Real world examples`, and `Related
agreements`. Update the `AGENTS.md` documentation map when adding, removing, or
renaming a guide. Use established language and terminology before inventing new
ones.

Keep each document to approximately 50 lines. If a guide must exceed that
limit, split it into focused subdocuments and link them from the parent. This
keeps progressive disclosure practical: readers and agents need to load only
the material relevant to their task.

## 🏆 Benefits

- Lets agents and developers find one convention without loading every guide.
- Keeps documents self-contained and independently reviewable.
- Makes the documentation map reliable and discoverable.
- Keeps long guidance navigable through focused, selectively readable documents.

## 👀 Examples

### ✅ Good: Keep a convention focused and structured

Use a dedicated file such as [`testing.md`](testing.md) with the required
sections, practical good and bad examples, and links to related agreements.

### ❌ Bad: Hide multiple conventions in one unstructured guide

Do not bury architecture, testing, and database rules in a single monolithic
file; readers cannot identify the governing convention quickly.

## 🧐 Real world examples

- [`docs/testing.md`](testing.md) documents test levels and stable assertions.
- [`docs/architecture.md`](architecture.md) documents module boundaries.
- [`AGENTS.md`](../AGENTS.md) indexes every project guide.

## 🔗 Related agreements

- [Constitution](constitution.md) requires adapting to existing documentation.
- [Workflow](workflow.md) defines when documentation work is verified.

Documentation made discoverable by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
