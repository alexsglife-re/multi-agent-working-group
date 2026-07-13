## Context

The current protocol starts a fresh PM or Advisor session at every distinct checkpoint. That is a strong isolation boundary, but within one OpenSpec C-stage it repeatedly discards verified context, increases evidence reloading, and weakens a role's ability to follow stage-local risk evolution. The replacement must preserve independent first passes, fresh gate decisions, original-evidence access, and all existing validation and authorization boundaries.

## Goals / Non-Goals

**Goals:**

- Retain one PM lifecycle and one Advisor lifecycle by default throughout each OpenSpec C-stage.
- Preserve checkpoint-level decision freshness and no-peek independence inside a persistent stage lifecycle.
- Make stage identity, runtime identity, inherited context, decision freshness, no-peek state, and restart reasons auditable through canonical values.
- Restart safely at C-stage boundaries and whenever continuity becomes unreliable.
- Migrate current rules and deterministic validation without changing the version number.

**Non-Goals:**

- Reusing an old `GO`, validation result, or authorization at a later checkpoint.
- Allowing one role to see the other role's current first-pass conclusion.
- Reducing provider/model capability, review frequency, evidence access, validation, or gate coverage.
- Keeping a role alive indefinitely across C-stages or after a restart trigger.
- Treating C0 bootstrap reviews as a lifecycle that continues into C1.
- Changing the fresh short-lived checkpoint model for non-OpenSpec work.
- Changing packet retention, destructive-cleanup authorization, tag, release, publication, or deployment rules.

## Decisions

### 1. Make the OpenSpec C-stage the default role-agent lifecycle boundary

Each role receives a Stage Session ID tied to exactly one of C1, C2, C3, or C4. The same PM or Advisor may continue through multiple checkpoints in that C-stage and retain verified context plus its own earlier reasoning. At the next C-stage, the Leader starts a new role lifecycle by default using verified baseline and continuity artifacts. C0 is bootstrap rather than a persistent C-stage: any C0 PM/Advisor session is short-lived and closes or restarts before C1, with no C0 decision or authority continuity.

This is preferred over checkpoint-scoped sessions because it preserves useful stage-local understanding. It is preferred over workstream-long sessions because cross-stage restart provides a predictable compaction and independence boundary.

### 2. Prove continuity from the underlying runtime session

Stage Session ID is a workflow identity backed by the exact Runtime Session ID, evidence source, and resume evidence when the runtime supports persistence. Claude continuation uses exact `--resume <session-id>` only; ambiguous `--continue` cannot prove identity. `--no-session-persistence`, process restart without exact resume, or a runtime without persistence produces `restarted`, `degraded`, or `unavailable` continuity and a new Stage Session ID, never `intact-runtime-proven`.

This prevents a documentation identifier from falsely claiming that two different model conversations are one persistent role lifecycle.

### 3. Separate lifecycle continuity from decision freshness

Every checkpoint is a new decision transaction even when the role-agent persists. It receives a new Review ID and Attempt ID, an exact current target fingerprint, and explicit `fresh-decision`, validation-freshness, authorization, and no-peek fields. Previous decisions remain evidence only.

The inherited-context flag records whether verified same-stage context was retained. It never means the prior decision or authority was inherited.

### 4. Preserve no-peek isolation inside persistent stage sessions

A role may retain its own prior reasoning and verified facts. It must not receive the other role's current first-pass conclusion until both current independent first passes finish. Later consensus evidence may be retained, but the next checkpoint again begins with current no-peek state declared and enforced.

### 5. Require restart on reliability or routing boundaries

The Leader restarts the affected role when context reliability is lost or under material pressure, independence is contaminated, provider/model/tool routing changes, workspace trust is lost, invocation state cannot be resolved safely, recovery fails, or the Owner instructs restart. A restart records its reason and receives verified continuity evidence; it does not inherit authority.

When a running or `result-unknown` invocation remains ambiguous after inspection, the Leader quarantines it and resolves concurrent-execution risk before a successor review may satisfy the same gate. Restart is not permission for a blind duplicate.

### 6. Preserve non-OpenSpec short sessions and narrow clarification semantics

Non-OpenSpec work continues to use a fresh short-lived PM or Advisor session for every distinct checkpoint. An unchanged-target missing-file request or narrow clarification may continue under the same session and Review ID according to existing attempt rules. Silent provider substitution remains prohibited.

A missing-file request or narrow clarification for the unchanged target may continue under the same Review ID according to existing attempt rules. A retry uses a linked Attempt ID. A changed target or decision request requires a new Review ID even inside the same Stage Session ID.

### 7. Use canonical lifecycle states

Templates and validators use closed values: C-stage `C0-bootstrap|C1|C2|C3|C4|non-openspec`; inherited context `none|verified-same-stage|verified-restart-packet`; fresh decision `confirmed|blocked`; no-peek `isolated-current-first-pass|consensus-open|contaminated`; validation freshness `fresh-current-target|stale|not-applicable`; authorization `not-granted|owner-explicit-current-scope|normal-git-gate-current|blocked`; continuity `intact-runtime-proven|restarted|degraded|unavailable`; runtime evidence `exact-supported|unavailable|contradictory`; restart reason `cross-stage|context-reliability|context-pressure|independence-contamination|provider-change|model-change|tool-change|trust-loss|state-ambiguity|failed-recovery|owner-instruction|not-applicable`; and lifecycle decision actor `leader|owner`. Actor identifies the decision maker. Lifecycle decision time is required in ISO-8601 with timezone. `owner-instruction` remains only a restart reason and does not replace actor.

The actor and decision time exist only in a lifecycle transition record and are required for normal cross-stage close/restart, early close/restart, C0 close, and every degraded or unavailable transition for which a lifecycle decision is recorded. Routine same-C-stage invocation records omit these transition-only fields rather than supplying a synthetic or `not-applicable` actor.

### 8. Validate lifecycle semantics deterministically

Local validation will check positive examples for same-stage continuity and negative examples for cross-stage reuse, stale decision inheritance, no-peek contamination, missing lifecycle identity, and ignored restart triggers. Documentation anchors and templates will use the same canonical fields.

## Risks / Trade-offs

- **Anchoring on an earlier same-stage decision** -> Require a fresh Review ID, target fingerprint, and explicit non-inheritance of decision, validation, and authorization at every checkpoint.
- **No-peek contamination accumulates in a persistent session** -> Declare current no-peek state for every checkpoint and restart on contamination.
- **Long stages create context pressure** -> Make context reliability loss or material pressure a mandatory restart trigger with a verified restart packet.
- **Provider or tool changes make continuity misleading** -> Restart and record the routing change rather than calling it uninterrupted continuity.
- **Workflow identity could falsely imply model-session persistence** -> Require exact runtime identity and resume evidence, otherwise record restarted/degraded/unavailable and issue a new Stage Session ID.
- **Ambiguous old process overlaps a successor** -> Quarantine the old attempt and resolve concurrent execution before the successor can satisfy the gate.
- **Lifecycle transitions could lack accountability** -> Require the actual decision maker and timezone-qualified decision time in every applicable transition record while omitting these fields from routine same-stage invocations.
- **More lifecycle fields increase bookkeeping** -> Use canonical values in shared templates and deterministic validator fixtures so omissions fail visibly.

## Migration Plan

1. Replace fresh-per-checkpoint normative text in the two affected accepted capabilities through MODIFIED delta requirements.
2. Update workflow references and templates to use runtime-backed Stage Session ID plus canonical checkpoint transaction fields.
3. Add positive and negative deterministic validator cases, including false continuity, missing runtime identity, ambiguous `--continue`, and blind restart.
4. Update examples and validation documentation while keeping all version markers unchanged.
5. Validate the active change strictly before implementation and retain the old behavior as rollback evidence in git history; rollback is a normal revert, not a history rewrite.

## Open Questions

None. The Owner has selected stage-scoped continuity with checkpoint-scoped fresh decisions.
