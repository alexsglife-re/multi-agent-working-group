# leader-state-compaction Specification Delta

## MODIFIED Requirements

### Requirement: Leader state uses layered compaction

The skill SHALL define active Leader handoff and continuity state as a layered record with a current state card, a claim-indexed evidence index, and historical archive notes.

#### Scenario: Leader refreshes active state during rollover

- **WHEN** a Leader updates a long-running or cross-conversation handoff during `ContextBudget Watch`, `Rollover Recommended`, `Rollover Strongly Recommended`, or `Rollover Required`
- **THEN** the current state card also records context budget state, observed compression/summary count, count confidence, last context-budget check, rollover reason, next safe rollover boundary, and rollover action without copying the full prior handoff narrative

### Requirement: Compaction preserves gates and findings

The skill SHALL prohibit compaction from removing required reasoning outputs, PM/Advisor findings, unresolved P0/P1, validation status, owner-decision needs, or git authorization state.

#### Scenario: Compacting before successor takeover

- **WHEN** a Leader prepares a successor startup packet or compact handoff
- **THEN** unresolved P0/P1, PM/Advisor/Reviewer continuity status, Worker state, validation run and not run, changed and do-not-touch files, commit/push authorization state, pending messages, conflicts, and successor verification requirements remain explicit
