## ADDED Requirements

### Requirement: OpenSpec reviews use runtime-proven C-stage role lifecycles and fresh checkpoint decisions
For OpenSpec-backed work, the workflow SHALL default each PM and Advisor to one runtime-proven role-agent lifecycle within exactly one C-stage (C1, C2, C3, or C4) and SHALL start a new lifecycle by default at every cross-C-stage boundary. Every distinct checkpoint within a C-stage SHALL remain a fresh decision transaction with a new Review ID, Attempt ID, exact target fingerprint, fresh-decision state, validation-freshness state, authorization state, and no-peek state. Same-C-stage continuity MAY retain verified context and the role's own prior reasoning, but MUST NOT inherit an earlier `GO`, validation freshness, git or archive authorization, or the other role's current first-pass conclusion.

#### Scenario: Review target changes within one C-stage
- **WHEN** the commit, diff, gate, decision request, or materially visible packet changes while a role remains in the same C-stage
- **THEN** the role MAY continue under the same runtime-proven Stage Session ID
- **AND** the Leader starts a new Review ID and Attempt ID with current target fingerprint and fresh decision, validation, authorization, and no-peek states

#### Scenario: OpenSpec C-stage changes
- **WHEN** work moves from one OpenSpec C-stage to another
- **THEN** the Leader starts new PM and Advisor lifecycles by default with new Stage Session IDs
- **AND** supplies verified baseline and continuity evidence without inheriting a prior decision or authorization
- **AND** records lifecycle decision actor and ISO-8601 lifecycle decision time with timezone for the cross-stage close/restart

#### Scenario: C0 bootstrap precedes C1
- **WHEN** PM or Advisor participates in C0 goal analysis before C1
- **THEN** the C0 role session is short-lived under `C0-bootstrap` and closes or restarts before C1
- **AND** no C0 decision, validation freshness, authorization, or Stage Session ID continues into C1
- **AND** the C0 close records lifecycle decision actor and ISO-8601 lifecycle decision time with timezone

#### Scenario: Same review needs a narrow follow-up
- **WHEN** a role requests one missing original file or a narrow clarification for the unchanged target
- **THEN** the Leader MAY continue the same Stage Session ID and Review ID under existing same-target clarification and linked-attempt rules

### Requirement: Non-OpenSpec distinct checkpoints use short-lived sessions
For work that does not use OpenSpec, the workflow SHALL use a fresh short-lived PM or Advisor session for each distinct first-pass, scope, pre-commit, post-commit, pre-push, post-push, publication, or closeout target. A narrow clarification or missing-file request for the unchanged target MAY remain in the same session. A changed target, gate, decision request, or materially changed packet MUST start a fresh session and MUST preserve required provider/model routing without silent substitution.

#### Scenario: Non-OpenSpec review target changes
- **WHEN** a non-OpenSpec commit, diff, gate, decision request, or materially visible packet changes
- **THEN** the Leader starts a fresh short-lived role session with a new Review ID and the required provider/model routing
- **AND** reserves linked attempts for unchanged-target clarification or confirmed retry lineage

#### Scenario: Non-OpenSpec target needs narrow clarification
- **WHEN** a role requests one missing original file or a narrow clarification for an unchanged non-OpenSpec target
- **THEN** the Leader MAY continue the same short-lived session under the existing Review ID and attempt rules

#### Scenario: Required provider is unavailable
- **WHEN** a fresh non-OpenSpec session cannot use the required provider/model
- **THEN** the workflow follows the existing blocked or Owner-approved degradation rule and MUST NOT silently substitute another provider

### Requirement: Stage continuity is proven by exact runtime session evidence
A Stage Session ID SHALL represent one role lifecycle in one C-stage and MUST be grounded in the exact underlying Runtime Session ID, runtime identity source, and exact resume evidence when the runtime supports persistence. `intact-runtime-proven` continuity MUST NOT be recorded for `--no-session-persistence`, process restart without exact resume evidence, unavailable persistence, or contradictory runtime evidence. Such a successor MUST receive a new Stage Session ID and record `restarted`, `degraded`, or `unavailable` continuity. Every recorded degraded or unavailable lifecycle transition MUST include a transition record with lifecycle decision actor `leader|owner` identifying the decision maker and an ISO-8601 lifecycle decision time with timezone.

#### Scenario: Claude resumes exact session
- **WHEN** Claude CLI continues a same-C-stage Advisor lifecycle
- **THEN** it uses exact `--resume <session-id>` evidence matching the recorded Runtime Session ID
- **AND** MUST NOT use ambiguous `--continue` as proof of continuity

#### Scenario: Session persistence is disabled
- **WHEN** a role invocation uses `--no-session-persistence`
- **THEN** a later process MUST NOT claim the same intact Stage Session ID
- **AND** records a new Stage Session ID with restarted, degraded, or unavailable continuity

#### Scenario: Runtime identity is unavailable
- **WHEN** the runtime cannot expose or resume an exact session identity
- **THEN** runtime evidence is `unavailable` and the workflow MUST NOT claim `intact-runtime-proven`
- **AND** the unavailable transition records lifecycle decision actor and timezone-qualified lifecycle decision time

### Requirement: Stage-scoped role lifecycles restart on canonical reliability boundaries
This requirement SHALL be the canonical restart-trigger definition. The workflow SHALL restart the affected PM or Advisor lifecycle for context reliability loss or material pressure, role independence contamination, provider/model/tool routing change, workspace trust loss, invocation state ambiguity that remains after inspection, failed recovery, or Owner instruction. Restart MUST include a transition record with canonical reason, lifecycle decision actor `leader|owner`, ISO-8601 lifecycle decision time with timezone, and verified restart packet without inheriting decisions, validation freshness, or authorization. Actor SHALL identify the decision maker; `owner-instruction` remains only a reason and MUST NOT replace actor. A successor MUST NOT satisfy the same gate until concurrent-execution risk from an ambiguous predecessor is resolved.

#### Scenario: Context reliability is lost
- **WHEN** accumulated context cannot be relied on or material pressure threatens complete review
- **THEN** the Leader starts a new lifecycle with a verified restart packet without reducing review scope or evidence access

#### Scenario: Role independence is contaminated
- **WHEN** a role receives the other role's current first-pass conclusion before completing its own
- **THEN** the affected lifecycle restarts and its contaminated output cannot satisfy independent review

#### Scenario: Provider model or tool changes
- **WHEN** required provider, model, or material tool environment changes during a C-stage
- **THEN** the workflow starts a new lifecycle and records the canonical routing-change reason

#### Scenario: Owner requires restart
- **WHEN** the Owner instructs restart
- **THEN** the Leader restarts the lifecycle with reason `owner-instruction`

## MODIFIED Requirements

### Requirement: PM and Advisor packets preserve no-peek independence
The workflow SHALL keep PM and Advisor current first-pass conclusions isolated while allowing both packets to derive from the same conclusion-free factual manifest. A persistent same-C-stage role MAY retain its own verified context and prior reasoning, but MUST NOT receive the other role's current-checkpoint first-pass conclusion before both current independent first passes complete.

#### Scenario: Advisor first pass is prepared
- **WHEN** the PM has already recorded a first-pass conclusion for the current checkpoint
- **THEN** the Advisor packet excludes that PM conclusion and records it as intentionally withheld until the Advisor current first pass is complete

#### Scenario: Same-stage role retains earlier consensus
- **WHEN** a role retained earlier same-C-stage consensus evidence
- **THEN** the next checkpoint declares a new no-peek state and withholds the other role's current first-pass conclusion
- **AND** retained evidence does not authorize or predetermine the new decision

#### Scenario: Shared evidence manifest is reused
- **WHEN** the Leader derives PM and Advisor packets from one manifest
- **THEN** the manifest contains verified facts and evidence pointers but no current role conclusion that breaks no-peek review

### Requirement: Review invocations have reproducible identity and state
Every context-efficient role invocation SHALL record Stage Session ID; Runtime Session ID or unavailable marker; runtime identity source and resume evidence; C-stage; inherited-context, fresh-decision, no-peek, validation-freshness, authorization, continuity, runtime-evidence, and restart-reason values; Review ID; Attempt ID; role; review type; target and exact target fingerprint; stable baseline anchor; packet fingerprint; invocation state; timing; result location; retry decision; and parent Attempt ID when retried. Canonical values SHALL be: C-stage `C0-bootstrap|C1|C2|C3|C4|non-openspec`; inherited context `none|verified-same-stage|verified-restart-packet`; fresh decision `confirmed|blocked`; no-peek `isolated-current-first-pass|consensus-open|contaminated`; validation freshness `fresh-current-target|stale|not-applicable`; authorization `not-granted|owner-explicit-current-scope|normal-git-gate-current|blocked`; continuity `intact-runtime-proven|restarted|degraded|unavailable`; runtime evidence `exact-supported|unavailable|contradictory`; and restart reason `cross-stage|context-reliability|context-pressure|independence-contamination|provider-change|model-change|tool-change|trust-loss|state-ambiguity|failed-recovery|owner-instruction|not-applicable`. Only an applicable lifecycle transition record SHALL add lifecycle decision actor `leader|owner` and ISO-8601 lifecycle decision time with timezone; routine same-C-stage invocation records omit those transition-only fields.

#### Scenario: First invocation starts in a C-stage
- **WHEN** a role begins its first review in an OpenSpec C-stage
- **THEN** its record identifies new Stage and Runtime Session evidence and moves from `prepared` to `running` under one Review ID and Attempt ID

#### Scenario: Same C-stage starts another checkpoint
- **WHEN** the same runtime-proven role-agent begins another checkpoint in its current C-stage
- **THEN** Stage Session ID remains unchanged while new checkpoint identity and fresh states are recorded
- **AND** transition-only lifecycle decision actor and time are omitted because no lifecycle transition occurred

#### Scenario: Transition record lacks decision actor
- **WHEN** a C0 close, cross-stage close or restart, early close or restart, or recorded degraded or unavailable transition omits lifecycle decision actor
- **THEN** deterministic validation rejects the transition record

#### Scenario: Transition record lacks timezone-qualified decision time
- **WHEN** an applicable lifecycle transition record omits decision time or records time without an ISO-8601 timezone
- **THEN** deterministic validation rejects the transition record

#### Scenario: Same packet has ambiguous state
- **WHEN** the same Review ID and packet fingerprint is `running` or `result-unknown`
- **THEN** the Leader inspects process, output, and CLI status evidence and MUST NOT blindly invoke the packet again

#### Scenario: Ambiguity remains after inspection
- **WHEN** an attempt remains ambiguous after available inspection
- **THEN** the Leader quarantines it and resolves concurrent-execution risk before a successor may satisfy the same gate

#### Scenario: Failure is confirmed and retry is needed
- **WHEN** evidence confirms failure or safely resolves ambiguity as retryable
- **THEN** retry uses a new linked Attempt ID without changing required capability or review scope

## REMOVED Requirements

### Requirement: Distinct review checkpoints use short-lived sessions
**Reason**: For OpenSpec work, checkpoint-scoped restart discards useful verified context and is replaced by runtime-proven C-stage continuity plus fresh checkpoint decisions. Non-OpenSpec work retains fresh short-lived checkpoint sessions.

**Migration**: Use one runtime-proven PM and Advisor lifecycle per C1-C4 stage, short-lived C0 bootstrap, fresh Review/Attempt identity per checkpoint, and fresh short-lived sessions per distinct non-OpenSpec checkpoint.
