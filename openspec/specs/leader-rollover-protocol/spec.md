# leader-rollover-protocol Specification

## Purpose
Define how a Leader detects context rollover conditions, records context-budget evidence, prepares successor handoff packets, and restricts unsafe continuation when rollover is required.

## Requirements
### Requirement: Leader records context-budget state
The skill SHALL require long-running, spec-bound, or cross-conversation work to record context-budget state when context pressure is visible.

#### Scenario: Leader refreshes current state under context pressure
- **WHEN** the Leader observes platform summaries, context compression, large outputs, repeated long returns, old-context lookups, or ledger growth
- **THEN** the current state card, compact handoff, ledger, or successor packet records context budget state, observed compression/summary count, count confidence, last context-budget check, reason for current state, next safe rollover boundary, and rollover action

#### Scenario: Compression count is unknown
- **WHEN** the Leader cannot determine a reliable compression/summary count
- **THEN** the Leader records the count confidence as `unknown` and MUST NOT invent a count

### Requirement: Compression thresholds map to rollover states
The skill SHALL define non-overlapping observed compression/summary thresholds that map context pressure to rollover action.

#### Scenario: Low observed compression count
- **WHEN** the Leader observes 0-1 compressions or summaries
- **THEN** the Leader treats the state as `Normal` or `Soft Warning`, refreshes the current state card when useful, and does not recommend rollover from count alone

#### Scenario: Early warning count
- **WHEN** the Leader observes exactly 2 compressions or summaries
- **THEN** the Leader treats the state as `Soft Warning`, records the count, and does not recommend rollover from count alone

#### Scenario: Watch count
- **WHEN** the Leader observes 3-4 compressions or summaries
- **THEN** the Leader treats the state as `ContextBudget Watch`, records the context-budget fields, and organizes the evidence index without proactively recommending rollover from count alone

#### Scenario: Recommended rollover count
- **WHEN** the Leader observes 5-6 compressions or summaries
- **THEN** the Leader treats the state as `Rollover Recommended` and recommends switching at the next safe boundary

#### Scenario: Strong recommendation count
- **WHEN** the Leader observes exactly 7 compressions or summaries
- **THEN** the Leader treats the state as a strong `Rollover Recommended`, finishes only a near-complete small step when safe, and otherwise prepares a successor packet

#### Scenario: Strongly recommended rollover count
- **WHEN** the Leader observes 8 or more compressions or summaries
- **THEN** the Leader treats the state as `Rollover Strongly Recommended` and prepares a successor packet unless a very small current step can finish immediately

### Requirement: Required rollover blocks unsafe next gates
The skill SHALL require sealed-ready behavior when context pressure combines with a risky next gate or when current-state verification is unreliable.

#### Scenario: Compression count precedes a gate
- **WHEN** the Leader observes 6 or more compressions or summaries and the next action is Worker dispatch, commit, push, CI, archive, or a high-risk gate
- **THEN** the Leader treats the state as `Rollover Required`, enters sealed-ready behavior, and hands off before that gate

#### Scenario: Count is unknown and state is unreliable
- **WHEN** compression count is unknown and the Leader cannot reliably verify current git, spec, validation, PM, Advisor, Reviewer, Worker, or authorization state
- **THEN** the Leader treats the state as `Rollover Required` and hands off using the successor protocol

#### Scenario: Rollover required
- **WHEN** `Rollover Required` applies
- **THEN** the Leader MUST NOT dispatch new Workers, accept new Worker results for the handed-off workstream, enter commit/push/CI/archive gates, or execute external-effect actions until reliable takeover verification is restored

### Requirement: Successor packet preserves takeover evidence
The skill SHALL require successor packets to include current state, context-budget evidence, a lightweight handoff dashboard, an evidence index, and successor verification.

#### Scenario: Leader prepares successor packet
- **WHEN** rollover is recommended, strongly recommended, or required
- **THEN** the successor packet records date/time, current goal, stage or C-stage, context budget state, observed compression/summary count, count confidence, rollover reason, next safe boundary, scope and non-goals, completed and incomplete work, PM/Advisor/Reviewer continuity, unresolved P0/P1, OpenSpec state and archive requirement, git state, changed and do-not-touch files, validation run and not run, commit/push authorization state, task status dashboard, pending messages, conflicts, overlaps, evidence index, and successor verification checklist

#### Scenario: Successor takes over
- **WHEN** a new Leader resumes from a successor packet
- **THEN** the new Leader MUST re-read applicable project instructions, memory, skill rules, handoff material, git/spec/current evidence, and MUST verify owner instruction, git state, OpenSpec state, validation freshness, PM/Advisor/Reviewer continuity, Worker state, unresolved P0/P1, and authorization state before continuing

### Requirement: Rollover does not create authority or automation
The skill SHALL keep rollover states and successor packets as evidence-control mechanisms only.

#### Scenario: Rollover packet exists
- **WHEN** a rollover state or successor packet exists
- **THEN** it does not authorize commit, push, CI, archive, deployment, release, external publication, secret or credential access, destructive actions, high-risk changes, automatic successor thread creation, PM/Advisor bypass, Reviewer bypass, validation bypass, or owner-decision bypass

#### Scenario: Legacy handoff exists
- **WHEN** an old v0.3-era or bloated handoff, ledger, or role output is used during rollover
- **THEN** the Leader preserves it as historical evidence, copies only current verified facts into the active state, references old material through the evidence index, and MUST NOT append the old material verbatim into the active handoff
