# Change: Add Local Validation Tool

## Why

The current validation workflow is intentionally manual, but repeated checks for README version state, `SKILL.md` frontmatter, OpenSpec health, and global skill sync are easy to miss or repeat inconsistently. A small read-only script can reduce accidental drift without introducing CI, release automation, packaging automation, or agent orchestration.

## What Changes

- Add a repo-local validation script.
- Check basic `SKILL.md` frontmatter and required documentation/version markers.
- Run OpenSpec list and full validation when the CLI is available.
- Compare the repo `SKILL.md` with the user's global installed skill when that file exists.
- Document the command in README, validation, roadmap, TODO, and changelog.

## Non-Goals

- No CI workflow.
- No release, tag, deployment, or public publication.
- No automatic commit, push, archive, or agent spawning.
- No broad secret scanning, package publishing, or network access.
- No replacement for PM, Advisor, Reviewer, or Leader verification gates.
