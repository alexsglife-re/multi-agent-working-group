# Change: Add Leader Rollover Protocol

## Why

The skill already warns about context pressure, long handoffs, and rollover states, but v0.3-era usage showed that soft wording such as "multiple" or "many" compressions can fail to trigger in real work. Leaders need an explicit, lightweight rollover protocol that records context-budget evidence, maps signals to actions, and prepares successor handoff packets without silently creating new conversations.

## What Changes

- Add a `leader-rollover-protocol` capability for context-budget fields, compression/summary thresholds, rollover-safe actions, sealed-ready behavior, and successor verification.
- Clarify that v0.4.6 automatically detects rollover conditions and prepares handoff evidence, but does not automatically create a successor conversation.
- Add a successor startup packet template for cross-conversation takeover.
- Update compact handoff guidance to include context-budget state, task/status dashboard fields, pending messages, conflicts, and successor verification.
- Preserve existing rules that old v0.3 or bloated handoffs are historical evidence only and must not be pasted forward as active state.
- Update README, changelog, roadmap, TODO, validation docs, `SKILL.md`, and local validation checks for `v0.4.6`.

## Capabilities

### New Capabilities

- `leader-rollover-protocol`: Defines how Leaders record context-budget state, use compression/summary thresholds, move from signal to action, prepare successor handoff packets, and restrict work during required rollover.

### Modified Capabilities

- `leader-state-compaction`: Requires compact handoff state to include context-budget and successor handoff evidence when rollover is recommended or required.
- `copyable-role-templates`: Adds a successor startup packet template and rollover-specific fields to handoff templates.

## Impact

- Affected files: `SKILL.md`, `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `templates/`, `examples/`, `scripts/validate-local.sh`, and OpenSpec artifacts.
- No product runtime changes, dependencies, automatic thread creation, dashboard runtime, deployment, release, tag, secret access, schema migration, or destructive operation.
