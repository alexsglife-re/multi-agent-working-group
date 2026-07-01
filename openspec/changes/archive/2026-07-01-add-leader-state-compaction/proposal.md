## Why

Real use showed that Leader handoff documents can become append-only narratives. That makes takeover slower and increases the risk that a new Leader trusts stale history instead of verifying current state.

## What Changes

- Add Leader state compaction rules based on a three-layer structure: current state card, evidence index, and historical archive notes.
- Require active handoff or ledger documents to be refreshed instead of repeatedly appending old handoff text.
- Require bulky raw evidence to be summarized and referenced when safe local evidence storage exists.
- Add templates and validation guidance for compact handoffs, evidence indexes, and archived history notes.
- Preserve the existing rule that handoffs, summaries, and continuity files are evidence, not authority.

## Capabilities

### New Capabilities

- `leader-state-compaction`: Rules for keeping Leader handoff and continuity documents compact, current, verifiable, and layered.

### Modified Capabilities

- None.

## Impact

- Affected documentation: `SKILL.md`, `docs/VALIDATION.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `README.md`, `CHANGELOG.md`, and new or updated examples.
- Affected specs: new `openspec/specs/leader-state-compaction/spec.md` after archive.
- No runtime code, external dependency, deployment, release, credential, schema, or destructive operation is included.
