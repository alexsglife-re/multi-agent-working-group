## MODIFIED Requirements

### Requirement: Leader records context-budget state
The skill SHALL require long-running, spec-bound, or cross-conversation work to record exactly one canonical context-budget state when context pressure or rollover opportunity signals are visible.

#### Scenario: Leader refreshes current state under context pressure
- **WHEN** the Leader observes platform summaries, context compression, large outputs, repeated long returns, old-context lookups, ledger growth, a clean boundary before a heavier next step, or Owner concern about context length or compression
- **THEN** the current state card, compact handoff, ledger, or successor packet records one canonical context budget state, compression count value, compression count source, compression count confidence, last context-budget check, reason for current state, next safe rollover boundary, and rollover action

#### Scenario: Compression count is unknown
- **WHEN** the Leader cannot determine a reliable compression/summary count
- **THEN** the Leader records the compression count source as `unknown`, records confidence as `unknown`, and MUST NOT invent a count

#### Scenario: Visible summaries undercount actual compactions
- **WHEN** the Leader can see a platform summary count but the Owner reports a higher actual compression count
- **THEN** the Leader MUST record the visible count as `platform-visible`, record the Owner report as `owner-reported`, and MUST NOT claim the platform-visible count is the actual total compaction count

#### Scenario: Canonical state selection
- **WHEN** compression count, opportunity, dashboard, reliability, Owner concern, and gate-risk triggers point to different states
- **THEN** the Leader MUST record exactly one current ContextBudget state and MUST use the highest applicable state

### Requirement: Compression thresholds map to rollover states
The skill SHALL define non-overlapping context-budget states that combine compression count, state reliability, opportunity boundaries, and next-step risk into one canonical rollover action.

#### Scenario: Low observed compression count
- **WHEN** the Leader observes 0-1 platform-visible compressions or summaries and no higher-priority opportunity, watch, recommendation, or required trigger applies
- **THEN** the Leader treats the state as `Normal` or `Soft Warning`, refreshes the current state card when useful, and does not recommend rollover from count alone

#### Scenario: Early warning count
- **WHEN** the Leader observes exactly 2 platform-visible compressions or summaries and no higher-priority opportunity, watch, recommendation, or required trigger applies
- **THEN** the Leader treats the state as `Soft Warning`, records the count value/source/confidence, and does not recommend rollover from count alone

#### Scenario: Opportunity boundary before heavier next step
- **WHEN** the Leader reaches a clean boundary and the next step is a new or longer stage, new Worker dispatch, commit, push, CI, archive, or new OpenSpec change
- **THEN** the Leader treats the state as at least `Rollover Opportunity`, refreshes the current-state card and evidence index, and updates a lightweight successor packet skeleton when useful without requiring immediate rollover

#### Scenario: C-stage opportunity
- **WHEN** an OpenSpec C-stage has just completed and the next action starts a new or longer C-stage
- **THEN** the Leader treats the state as at least `Rollover Opportunity`

#### Scenario: Worker dispatch opportunity
- **WHEN** an implementation slice has completed and validation is fresh, and the next action is dispatching a new Worker
- **THEN** the Leader treats the state as at least `Rollover Opportunity`

#### Scenario: Gate opportunity
- **WHEN** the current-state card and evidence index have been refreshed and the next action is commit, push, CI, archive, or a new OpenSpec change
- **THEN** the Leader treats the state as at least `Rollover Opportunity`

#### Scenario: Owner-reported compression opportunity
- **WHEN** the Owner reports actual compression count is higher than the platform-visible count and the next step is a heavier stage or gate
- **THEN** the Leader treats the state as at least `Rollover Opportunity` and records the Owner report separately from platform-visible evidence

#### Scenario: Owner reports concrete count above opportunity
- **WHEN** the Owner reports a concrete compression or summary count that meets a higher context-budget threshold
- **THEN** the Leader treats that Owner-reported count as threshold evidence and uses the highest applicable canonical state

#### Scenario: Watch count
- **WHEN** the Leader observes 3-4 compressions or summaries and no higher-priority recommendation or required trigger applies
- **THEN** the Leader treats the state as `ContextBudget Watch`, records the context-budget fields, and organizes the evidence index without proactively recommending rollover from count alone

#### Scenario: Recommended rollover count
- **WHEN** the Leader observes 5-6 compressions or summaries and no higher-priority required trigger applies
- **THEN** the Leader treats the state as `Rollover Recommended` and recommends switching at the next safe boundary

#### Scenario: Strong recommendation count
- **WHEN** the Leader observes exactly 7 compressions or summaries and no higher-priority required trigger applies
- **THEN** the Leader treats the state as `Rollover Recommended` with a stronger action note, finishes only a near-complete small step when safe, and otherwise prepares a successor packet

#### Scenario: Strongly recommended rollover count
- **WHEN** the Leader observes 8 or more compressions or summaries and no higher-priority required trigger applies
- **THEN** the Leader treats the state as `Rollover Strongly Recommended` and prepares a successor packet unless a very small current step can finish immediately

### Requirement: Required rollover blocks unsafe next gates
The skill SHALL require sealed-ready behavior when context pressure combines with a risky next gate or when current-state verification is unreliable.

#### Scenario: Compression count precedes a gate
- **WHEN** the Leader observes 6 or more compressions or summaries and the next action is Worker dispatch, commit, push, CI, archive, or a high-risk gate
- **THEN** the Leader treats the state as `Rollover Required`, enters sealed-ready behavior, and hands off before that gate

#### Scenario: Count is unknown and state is unreliable
- **WHEN** compression count is unknown and the Leader cannot reliably verify current git, spec, validation, PM, Advisor, Reviewer, Worker, or authorization state
- **THEN** the Leader treats the state as `Rollover Required` and hands off using the successor protocol

#### Scenario: Dashboard conflicts with evidence
- **WHEN** dashboard, pending message, conflict, overlap, role continuity, gate, git, spec, validation, PM, Advisor, Reviewer, Worker, or authorization evidence cannot be reconciled
- **THEN** the Leader treats the state as `Rollover Required` if the conflict affects Worker dispatch, commit, push, CI, archive, high-risk gates, or owner authorization

#### Scenario: Rollover required
- **WHEN** `Rollover Required` applies
- **THEN** the Leader MUST NOT dispatch new Workers, accept new Worker results for the handed-off workstream, enter commit/push/CI/archive gates, or execute external-effect actions until reliable takeover verification is restored

### Requirement: Successor packet preserves takeover evidence
The skill SHALL require successor packets to include current state, context-budget evidence, a lightweight handoff dashboard, an evidence index, and successor verification.

#### Scenario: Leader prepares successor packet
- **WHEN** rollover opportunity, recommendation, strong recommendation, or required rollover applies
- **THEN** the Leader records date/time, current goal, stage or C-stage, canonical context budget state, compression count value, compression count source, compression count confidence, rollover reason, next safe boundary, and evidence references

#### Scenario: Leader prepares complete successor packet
- **WHEN** rollover recommendation, strong recommendation, or required rollover applies, or the Owner explicitly requests handoff
- **THEN** the successor packet records date/time, current goal, stage or C-stage, canonical context budget state, compression count value, compression count source, compression count confidence, rollover reason, next safe boundary, scope and non-goals, completed and incomplete work, PM/Advisor/Reviewer continuity, unresolved P0/P1, OpenSpec state and archive requirement, git state, changed and do-not-touch files, validation run and not run, commit/push authorization state, task status dashboard, pending messages, conflicts, overlaps, evidence index, and successor verification checklist

#### Scenario: Successor takes over
- **WHEN** a new Leader resumes from a successor packet
- **THEN** the new Leader MUST re-read applicable project instructions, memory, skill rules, handoff material, git/spec/current evidence, and MUST verify owner instruction, git state, OpenSpec state, validation freshness, PM/Advisor/Reviewer continuity, Worker state, unresolved P0/P1, and authorization state before continuing

#### Scenario: Historical gate state is recorded
- **WHEN** a successor packet records historical commit, push, CI, or archive gate state
- **THEN** the recorded gate state remains evidence only and MUST NOT authorize successor execution without fresh verification and applicable gates

### Requirement: Rollover does not create authority or automation
The skill SHALL keep rollover states and successor packets as evidence-control mechanisms only while preserving same-workstream gate-based automation.

#### Scenario: Rollover packet exists
- **WHEN** a rollover state or successor packet exists
- **THEN** it does not authorize deployment, release, external publication, secret or credential access, destructive actions, high-risk changes, automatic successor thread creation, automatic agent spawning, PM/Advisor bypass, Reviewer bypass, validation bypass, owner-decision bypass, or authorization inheritance

#### Scenario: Same-workstream gates pass
- **WHEN** the current verified workstream remains in the same Leader context, PM and Advisor agree, no unresolved P0/P1 remains, required Reviewer approval has passed when applicable, validation is fresh, target scope is clear, and applicable secret-scan, CI/status, commit, push, or archive gates pass
- **THEN** normal non-high-risk commit, push, CI/status, and archive progression MAY continue without repeated Owner confirmation

#### Scenario: Legacy handoff exists
- **WHEN** an old v0.3-era or bloated handoff, ledger, or role output is used during rollover
- **THEN** the Leader preserves it as historical evidence, copies only current verified facts into the active state, references old material through the evidence index, and MUST NOT append the old material verbatim into the active handoff

## ADDED Requirements

### Requirement: Leader avoids hidden Worker execution
The skill SHALL require the Leader to avoid doing Worker-suitable work directly when the work is Medium, Complex, High-risk, implementation-heavy, or substantively benefits from independent ownership.

#### Scenario: Work can be assigned as a bounded Worker slice
- **WHEN** a task is Medium, Complex, High-risk, implementation-heavy, or clearly Worker-suitable
- **THEN** the Leader SHOULD dispatch a bounded Worker slice instead of performing hidden Worker execution, unless the task is small low-risk, orchestration, synthesis, verification, owner communication, narrow documentation synchronization, a tiny connective edit, dispatch overhead clearly exceeds the work, or a tool, gate, or Owner instruction makes Worker dispatch unsuitable

#### Scenario: Worker dispatch follows context pressure
- **WHEN** the next action is dispatching a new Worker and context is long, degraded, or at `Rollover Opportunity` or higher
- **THEN** the Leader MUST consider refreshing the current-state card and successor packet before dispatching the Worker
