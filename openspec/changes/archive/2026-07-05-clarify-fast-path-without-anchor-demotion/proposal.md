## Why

The v0.4.14 review found that `SKILL.md` can be easier to use if it explains the intended reading order for small tasks, but the follow-up PM and Advisor reviews also found that compressing the always-loaded file can accidentally remove hard-boundary rules. This change clarifies the fast path as a reading-order optimization only and adds no-anchor-loss guardrails before any future skill-load reduction work.

## What Changes

- Add an explicit Fast Path / Slow Path reading-order rule to `SKILL.md`.
- State that Fast Path never skips mandatory reference reads once an action enters a routed domain.
- Preserve the current `SKILL.md` hard-boundary anchor set; no anchor is demoted from `SKILL.md` to a reference in this change.
- Add validation and traceability checks for no-anchor-loss and no silent anchor demotion.
- Explicitly separate Fast Path reading order from Small Task Mode role rules.
- Document v0.4.15 as a guardrail-focused upgrade rather than a line-count reduction.

## Capabilities

### New Capabilities

- None.

### Modified Capabilities

- `progressive-skill-references`: clarify that fast-path use is only a reading-order optimization and cannot reduce action-triggered reference routing or always-loaded hard-boundary anchors.
- `local-validation-tool`: add validation markers for v0.4.15 fast-path boundaries and no-anchor-loss protection.

## Impact

- Affected files: `SKILL.md`, `references/TRACEABILITY.md`, `docs/VALIDATION.md`, `scripts/validate-local.sh`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, and OpenSpec artifacts/spec deltas.
- `README.md` changes are limited to current-version/status text required by local validation.
- `docs/INSTALLATION.md` is not expected to change because this change does not alter installation, adoption, migration, or global sync guidance.
- No runtime automation, agent spawning, CI, release automation, package publishing, GitHub metadata mutation, or external publication is included.
- No behavior-changing gate reduction is included; default exclusions, PM/Advisor review, OpenSpec lifecycle, cleanup discipline, and git gates remain unchanged.
