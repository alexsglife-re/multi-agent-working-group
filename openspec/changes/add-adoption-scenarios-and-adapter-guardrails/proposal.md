## Why

The README now presents the project clearly, but first-time readers still need
a shorter path from "what is this" to "when should I use it" and "how do I
adopt it safely." The next local upgrade should make adoption scenarios
concrete without making `README.md` or the always-loaded `SKILL.md` too long.

## What Changes

- Add scenario-based adoption guidance for documentation tasks, release
  preparation, long-running project work, cross-conversation handoff, and small
  ordinary tasks.
- Tighten README structure with a moderate Quick Start, Use Cases, Safety
  Boundaries, and pointers to deeper docs.
- Clarify installation guidance so readers distinguish adopting the protocol
  from installing the Codex reference adapter.
- Add adapter guide template and review checklist guidance without creating
  runtime-specific pages that look validated before real runtime testing.
- Add release-preparation and long-running documentation workstream examples.
- Update roadmap, changelog, TODO, validation docs, and local validation
  anchors for `v0.4.14`.
- Keep `SKILL.md` behavior unchanged unless a validation marker needs a version
  pointer; do not add automation, CI, release, tag, publishing, or runtime
  adapter support claims.

## Capabilities

### New Capabilities
- `adoption-guidance`: Defines reader-facing adoption scenarios, README
  usability requirements, examples, and safety boundaries for using the
  protocol.

### Modified Capabilities
- `platform-adapter-guidance`: Adds adapter guide template and checklist
  guardrails that prevent unvalidated runtime-specific guidance from being
  mistaken for supported adapters.
- `local-validation-tool`: Adds lightweight `v0.4.14` marker checks for
  adoption guidance and adapter guardrails without adding CI, link checking, or
  semantic runtime enforcement.

## Impact

- Documentation: `README.md`, `docs/ADOPTION.md`, `docs/INSTALLATION.md`,
  `docs/ADAPTERS.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`,
  `docs/TODO.md`, and `CHANGELOG.md`.
- Examples: add one or two adoption-focused workflow examples under
  `examples/`.
- Validation: update `scripts/validate-local.sh` version markers and selected
  text-anchor checks.
- OpenSpec: add one new accepted capability after archive and update two
  existing capability specs.
