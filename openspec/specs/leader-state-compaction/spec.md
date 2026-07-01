# leader-state-compaction Specification

## Purpose
Define how Leader handoff and continuity state stays compact, current, and verifiable during long-running, spec-bound, or cross-conversation work.

## Requirements
### Requirement: Leader state uses layered compaction
The skill SHALL define active Leader handoff and continuity state as a layered record with a current state card, a claim-indexed evidence index, and historical archive notes.

#### Scenario: Leader refreshes active state
- **WHEN** a Leader updates a long-running or cross-conversation handoff
- **THEN** the current state card records the owner instruction, current goal, stage, archive requirement when applicable, gate state, unresolved disagreements and P0/P1, validation run and not run, validation freshness, next action, stop conditions, and commit/push authorization state without copying the full prior handoff narrative

#### Scenario: Leader refreshes active state during rollover
- **WHEN** a Leader updates a long-running or cross-conversation handoff during `ContextBudget Watch`, `Rollover Recommended`, `Rollover Strongly Recommended`, or `Rollover Required`
- **THEN** the current state card also records context budget state, observed compression/summary count, count confidence, last context-budget check, rollover reason, next safe rollover boundary, and rollover action without copying the full prior handoff narrative

#### Scenario: Leader preserves evidence reachability
- **WHEN** important details are too large for active state
- **THEN** the Leader records a concise claim-indexed evidence reference with evidence type, location or command, freshness or currentness, and Leader verification status

### Requirement: Active handoff is refreshed rather than append-only
The skill SHALL require active Leader handoff or ledger updates to replace stale repeated narrative with current verifiable state when context bloat is visible.

#### Scenario: Prior handoff text exists
- **WHEN** a previous handoff is used during recovery
- **THEN** the new active handoff summarizes verified current truth and references the old handoff as evidence instead of appending the old handoff verbatim

### Requirement: Compaction preserves gates and findings
The skill SHALL prohibit compaction from removing required reasoning outputs, PM/Advisor findings, unresolved P0/P1, validation status, owner-decision needs, or git authorization state.

#### Scenario: Compacting before takeover
- **WHEN** a Leader prepares a successor startup packet or compact handoff
- **THEN** unresolved P0/P1, PM/Advisor continuity status, validation run and not run, changed and do-not-touch files, and commit/push authorization state remain explicit

#### Scenario: Compacting before successor takeover
- **WHEN** a Leader prepares a successor startup packet or compact handoff
- **THEN** unresolved P0/P1, PM/Advisor/Reviewer continuity status, Worker state, validation run and not run, changed and do-not-touch files, commit/push authorization state, pending messages, conflicts, and successor verification requirements remain explicit

### Requirement: Bulky evidence is indexed before archival
The skill SHALL direct Leaders to summarize and index bulky evidence before moving it out of active state when safe local evidence storage exists.

#### Scenario: Long command output or diff exists
- **WHEN** a command output, diff, agent return, or log is too large for active handoff
- **THEN** the active handoff includes the claim, result, freshness or currentness, verification status, and evidence reference rather than the full raw material

### Requirement: Validation checks handoff bloat controls
The project SHALL include validation guidance for compact handoff structure, evidence references, archive notes, and append-only handoff avoidance.

#### Scenario: Documentation is reviewed
- **WHEN** future documentation or examples describe Leader handoff, ledger, rollover, or continuity recovery
- **THEN** reviewers check that active state is compact, evidence remains verifiable, old history is archived or referenced, and no gate is bypassed by compaction
