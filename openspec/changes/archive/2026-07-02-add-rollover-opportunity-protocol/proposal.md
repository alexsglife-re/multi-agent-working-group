## Why

Real v0.4.7 use showed that platform-visible summaries can undercount actual
context compressions: a Leader may see one summary while the Owner knows that
many compressions occurred. The rollover protocol needs an earlier, verifiable
opportunity state that does not rely on compression counts as the primary
signal and still preserves existing PM/Advisor, validation, git, archive, and
successor authorization gates.

## What Changes

- Add `Rollover Opportunity` as an early context-budget state before
  `ContextBudget Watch`.
- Require each context-budget check to record exactly one canonical state; when
  multiple triggers apply, the highest applicable state wins.
- Replace compression count confidence-only recording with explicit count
  value, source, and confidence fields.
- Define compression count as a weak signal: visible summaries MUST NOT be
  reported as the actual total compaction count unless independently verified
  or Owner-reported.
- Define `Rollover Opportunity` with verifiable combination scenarios such as a
  clean C-stage boundary plus a heavier next stage, validated slice plus Worker
  dispatch, or refreshed current-state evidence plus commit/push/CI/archive.
- Clarify that task dashboards, pending messages, conflicts, overlaps, gate
  state, and role continuity are evidence inputs to canonical state selection,
  not separate state machines or dashboard runtime features.
- Clarify that successor packets may record historical gate state as evidence
  but never carry commit/push/CI/archive authorization into a successor context
  without fresh verification.
- Add Leader delegation discipline: Medium, Complex, High-risk, or
  substantive Worker-suitable implementation work should be dispatched as
  bounded Worker slices rather than performed by the Leader as hidden Worker
  execution.
- Preserve the existing rule that within the same verified workstream, normal
  non-high-risk commit, push, CI/status, and archive progression may continue
  when PM and Advisor agree and all applicable gates pass.
- Add validation and example coverage for the Owner-reported compression-count
  undercount case and early opportunity handoff preparation.

## Capabilities

### New Capabilities

- None.

### Modified Capabilities

- `leader-rollover-protocol`: Adds `Rollover Opportunity`, canonical
  single-state selection, compression count value/source/confidence, and
  earlier opportunity scenarios while preserving required rollover and
  successor safety boundaries.
- `leader-state-compaction`: Updates compact handoff and successor packet
  fields to record compression count value/source/confidence and to treat
  dashboards as state-selection evidence, not as a parallel state machine.
- `copyable-role-templates`: Updates rollover-related templates and adds an
  example for opportunity-based handoff preparation.

## Impact

- Affected files: `SKILL.md`, `README.md`, `CHANGELOG.md`, `docs/TODO.md`,
  `docs/ROADMAP.md`, `docs/VALIDATION.md`, `templates/compact-handoff.md`,
  `templates/successor-startup-packet.md`, `examples/`,
  `scripts/validate-local.sh`, and OpenSpec specs/artifacts.
- No product runtime changes, dependencies, dashboard runtime, automatic
  successor thread creation, automatic agent spawning, release/tag/deployment,
  secret access, destructive operation, or git authorization bypass.
