# Workflow

## Required pre-task dependency check

Before starting any requested task in this Flutter project, invoke the `update-flutter-dependencies` skill.

The skill runs `flutter pub outdated` to inspect available package updates without modifying the project. Run this check before inspecting, editing, testing, building, or otherwise performing the requested task.

Documentation-only tasks are an exception: do not run the skill when the requested work only adds or changes documentation.

Report the check result briefly, then continue with the requested task. A dependency update is not implied by the check: update packages only when the user explicitly asks for it.

If the check cannot run, report the reason and ask for the required access or prerequisite before continuing with work that depends on it.
