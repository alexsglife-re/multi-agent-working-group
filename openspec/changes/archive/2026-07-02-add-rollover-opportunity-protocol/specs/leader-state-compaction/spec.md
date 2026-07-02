## MODIFIED Requirements

### Requirement: Leader state uses layered compaction
The skill SHALL define active Leader handoff and continuity state as a layered record with a current state card, a claim-indexed evidence index, and historical archive notes.

#### Scenario: Leader refreshes active state
- **WHEN** a Leader updates a long-running or cross-conversation handoff
- **THEN** the current state card records the owner instruction, current goal, stage, archive requirement when applicable, gate state, unresolved disagreements and P0/P1, validation run and not run, validation freshness, next action, stop conditions, and commit/push authorization state without copying the full prior handoff narrative

#### Scenario: Leader refreshes active state during rollover
- **WHEN** a Leader updates a long-running or cross-conversation handoff during `Rollover Opportunity`, `ContextBudget Watch`, `Rollover Recommended`, `Rollover Strongly Recommended`, or `Rollover Required`
- **THEN** the current state card also records canonical context budget state, compression count value, compression count source, compression count confidence, last context-budget check, rollover reason, next safe rollover boundary, and rollover action without copying the full prior handoff narrative

#### Scenario: Leader uses dashboard fields as evidence input
- **WHEN** task status dashboard, pending messages, conflicts, overlaps, gate state, role continuity, or evidence index fields are used during rollover review
- **THEN** they remain evidence inputs to canonical state selection and MUST NOT become a parallel state machine or dashboard runtime

#### Scenario: Leader preserves evidence reachability
- **WHEN** important details are too large for active state
- **THEN** the Leader records a concise claim-indexed evidence reference with evidence type, location or command, freshness or currentness, and Leader verification status

### Requirement: Compaction preserves gates and findings
The skill SHALL prohibit compaction from removing required reasoning outputs, PM/Advisor findings, unresolved P0/P1, validation status, owner-decision needs, or git authorization state.

#### Scenario: Compacting before takeover
- **WHEN** a Leader prepares a successor startup packet or compact handoff
- **THEN** unresolved P0/P1, PM/Advisor continuity status, validation run and not run, changed and do-not-touch files, and commit/push authorization state remain explicit

#### Scenario: Compacting before successor takeover
- **WHEN** a Leader prepares a successor startup packet or compact handoff
- **THEN** unresolved P0/P1, PM/Advisor/Reviewer continuity status, Worker state, validation run and not run, changed and do-not-touch files, historical gate state as evidence, non-inherited commit/push/CI/archive authorization state, pending messages, conflicts, and successor verification requirements remain explicit
