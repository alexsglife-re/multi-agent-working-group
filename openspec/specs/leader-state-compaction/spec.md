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
- **WHEN** a Leader updates a long-running or cross-conversation handoff during `Rollover Opportunity`, `ContextBudget Watch`, `Rollover Recommended`, `Rollover Strongly Recommended`, or `Rollover Required`
- **THEN** the current state card also records canonical context budget state, compression count value, compression count source, compression count confidence, last context-budget check, rollover reason, next safe rollover boundary, and rollover action without copying the full prior handoff narrative

#### Scenario: Leader uses dashboard fields as evidence input
- **WHEN** task status dashboard, pending messages, conflicts, overlaps, gate state, role continuity, or evidence index fields are used during rollover review
- **THEN** they remain evidence inputs to canonical state selection and MUST NOT become a parallel state machine or dashboard runtime

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
- **THEN** unresolved P0/P1, PM/Advisor/Reviewer continuity status, Worker state, validation run and not run, changed and do-not-touch files, historical gate state as evidence, non-inherited commit/push/CI/archive authorization state, pending messages, conflicts, and successor verification requirements remain explicit

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

### Requirement: Leader selects a progressive active-state profile
The skill SHALL classify the current active Leader record as `Compact`, `Standard`, or `hierarchical-required` from deterministic current-active-state inventory. Compact SHALL allow at most 2 active workstreams, 5 blockers, 8 live role lifecycles, 8 validation-freshness groups, 10 dependency/conflict edges, 5 overlap edges, 2 high-risk gates, and 2 authorization domains. Standard SHALL allow at most 5 active workstreams, 10 blockers, 15 live role lifecycles, 15 validation-freshness groups, 30 dependency/conflict edges, 20 overlap edges, 3 high-risk gates, and 3 authorization domains. Structural thresholds SHALL select the profile; overlapping line and byte bands MUST NOT select a profile.

#### Scenario: Ordinary small work selects Compact
- **WHEN** a new or freshly measured active state satisfies every Compact structural condition
- **THEN** the Leader records `Compact` and a fresh `Profile selection basis` stating that all Compact triggers were checked and none were exceeded without displaying a full count scorecard

#### Scenario: Takeover starts directly in Standard
- **WHEN** fresh takeover verification shows that a Compact trigger is exceeded and every Standard condition is satisfied
- **THEN** the Leader selects `Standard` directly, records the exceeded Compact triggers and full takeover counts, and MUST NOT first force the state through Compact

#### Scenario: Standard is insufficient
- **WHEN** a Standard structural trigger is exceeded or reliable single-file semantic projection cannot be maintained
- **THEN** the Leader records `hierarchical-required`, names the trigger, preserves all applicable current facts, and follows accepted qualitative rollover and handoff safety without claiming structurally bounded large-project state

#### Scenario: Single-file projection has an observable failure
- **WHEN** current state has conflicting canonical ownership, unresolved duplicate current projections, a missing or orphaned current pointer, or an active cross-workstream fact that cannot be represented once with stable references
- **THEN** the Leader treats reliable single-file projection as failed, records `hierarchical-required`, and records whether the evidence was structurally fixture-testable or required reviewed Leader judgment

### Requirement: Structural inventory uses deterministic counting units
The skill SHALL define active workstream, blocker, live role lifecycle, validation-freshness group, dependency/conflict edge, overlap edge, high-risk gate, and authorization domain as stable counting units. A dependency edge SHALL be one tuple of an ordered active-workstream pair and one normalized dependency reason. A conflict edge SHALL be one tuple of an unordered active-workstream pair and one normalized conflict reason. An overlap edge SHALL be one tuple of an unordered active-workstream pair and one normalized shared-file path or named shared control surface. Duplicate reports of the same tuple SHALL count once, while distinct normalized reasons, files, or control surfaces SHALL count separately. An authorization domain SHALL count only when its authority is currently requested, pending, granted, denied, revoked, or expired for the current action, current gate, or first next action, and SHALL be deduplicated by actor, normalized scope, normalized action, normalized target, status, and normalized expiry-or-revocation condition. A current denial SHALL remain active, fail closed, and count until its action, gate, or first next action is no longer current. Standing default exclusions that none of those actions request SHALL remain recorded as scope or stop conditions but SHALL NOT count as active authorization domains. Independently decidable domains MUST NOT be merged or omitted to force a lower profile.

#### Scenario: One fact affects multiple workstreams
- **WHEN** one canonical fact affects multiple active workstreams
- **THEN** the fact is counted once in its own dimension and each distinct normalized dependency, conflict, or overlap edge tuple is counted separately after duplicate tuples are removed

#### Scenario: One workstream pair has multiple relationship reasons
- **WHEN** the same active-workstream pair has multiple distinct normalized dependency or conflict reasons
- **THEN** each distinct reason counts as a separate edge and duplicate reports of the same reason do not increase the count

#### Scenario: Standing exclusions are not active authorization domains
- **WHEN** commit, push, release, publication, deployment, or another default exclusion is retained only as a stop condition and is not requested by the current action, current gate, or first next action
- **THEN** the Leader retains the exclusion but does not count it as an active authorization domain

#### Scenario: Current denial remains active and fail closed
- **WHEN** the Owner explicitly denies an authority boundary for the current action, current gate, or first next action
- **THEN** the Leader retains the denial, counts its distinct authorization tuple, and stops the denied action until it is no longer current or a fresh Owner decision changes the state

### Requirement: Profile selection basis is current and reviewable
Every profile selection or refresh SHALL record scope as current active state only, measurement source, measurement time, and freshness. Indexed historical records, durable audit evidence, durable role results, and raw output MUST NOT be counted as active profile inventory.

#### Scenario: Detailed counts are required
- **WHEN** selection occurs during takeover, a classification is disputed, a profile transition occurs, or a validation fixture is evaluated
- **THEN** the Leader records the deterministic count for every applicable structural dimension

#### Scenario: Historical evidence is indexed
- **WHEN** resolved history and durable audit evidence have stable evidence references
- **THEN** they remain available without inflating current active-state profile counts

### Requirement: Size never overrides the accepted retention floor
Every profile SHALL preserve the complete applicable accepted current-state, compact-handoff, role-lifecycle, cleanup, provider-separation, review-invocation, validation, authorization, and minimum-successor field set. Any illustrative field list MUST be non-exhaustive and MUST NOT authorize omission of accepted fields.

#### Scenario: Applicable control facts exceed a warning band
- **WHEN** required current facts make an active-state instance exceed its provisional line or byte warning
- **THEN** the Leader preserves the facts, emits a warning, and MUST NOT truncate them, block non-emergency work from size alone, infer approval, or create a degraded safety state from size alone

#### Scenario: A role finding has durable reasoning
- **WHEN** a current PM, Advisor, Reviewer, or Worker finding has full reasoning at a durable location
- **THEN** active state retains its current status, severity, and stable pointer without recopying resolved historical reasoning

### Requirement: Compact and Standard preserve the layered record
Compact and Standard SHALL each use one physical active-state instance that preserves a current-state projection, a claim-indexed evidence index, and historical archive-note capability. Durable evidence, raw output, and historical notes MAY remain external only when the active instance retains stable references.

#### Scenario: Compact omits inapplicable rendering
- **WHEN** an accepted field is not applicable to a Compact task
- **THEN** the rendered instance may omit the visibly empty section but MUST NOT interpret absence as approval or omit any triggered semantic requirement

#### Scenario: A derived projection exists
- **WHEN** a current fact is copied into a derived summary
- **THEN** the derived copy records canonical source identity and freshness, while facts without derived copies require no per-fact fingerprint metadata

### Requirement: Profile transitions are event-driven and conservative
The Leader SHALL refresh profile selection at event-driven freshness checkpoints and MUST NOT use timers or background mutation. Promotion SHALL occur when a higher trigger is freshly verified. Demotion SHALL require all applicable lower exit conditions at two consecutive freshness checkpoints and an explicit Leader decision. Standard-to-Compact exit conditions SHALL be at most 1 workstream, 4 blockers, 6 live role lifecycles, 6 validation-freshness groups, 8 dependency/conflict edges, 4 overlap edges, 1 high-risk gate, and 1 authorization domain. `hierarchical-required`-to-Standard exit conditions SHALL be at most 4 workstreams, 8 blockers, 12 live role lifecycles, 12 validation-freshness groups, 24 dependency/conflict edges, 16 overlap edges, 2 high-risk gates, and 2 authorization domains, with no observable single-file projection failure.

#### Scenario: Material scope change crosses a trigger
- **WHEN** takeover, material scope change, C-stage boundary, rollover refresh, profile transition, or a relevant gate makes the prior classification stale and a higher trigger is verified
- **THEN** the Leader promotes the profile and records the transition evidence

#### Scenario: State falls below exit bands once
- **WHEN** all lower exit conditions hold at only one freshness checkpoint
- **THEN** the Leader retains the current profile and MUST NOT demote automatically

### Requirement: Profile numbers remain provisional during the pilot
All structural ceilings, exit bands, target line bands, warning line thresholds, and UTF-8 byte thresholds SHALL be labeled provisional pilot baselines. Structural ceilings and exit bands SHALL be mandatory classification checks but MUST NOT block work, truncate facts, or create a degraded safety state by themselves. Line and byte measurements SHALL remain warning-only until a separate accepted calibration-exit change makes any size threshold enforceable.

#### Scenario: Line targets overlap
- **WHEN** an instance falls within overlapping Compact and Standard target line bands
- **THEN** structural active-state inventory selects the profile and line count only informs a warning

#### Scenario: Semantic control is invalid
- **WHEN** a required field is missing, a canonical source conflicts, a pointer is invalid, or another semantic or control requirement fails
- **THEN** the workflow fails closed independently of whether size thresholds are satisfied
