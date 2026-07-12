# Successor Startup Packet Template

Version: v0.4.13 recommended template.

Use this when a Leader recommends or requires rollover to a new conversation.
This packet is continuity evidence only. It is not automatic thread creation,
authorization, approval, validation success, or gate bypass.

Rule: successor startup packet != automatic thread creation.

## Current State Card

```text
Date/time:
  <date, time, timezone>

Current goal:
  <owner goal>

Owner instruction:
  <latest owner instruction that authorizes current local work>

Stage:
  discuss | C0 | C1 | C2 | C3 | C4 | commit gate | push gate | closeout | blocked

Scope:
  In scope:
    - ...
  Out of scope:
    - ...

Context budget:
  State:
    Normal | Soft Warning | Rollover Opportunity | ContextBudget Watch |
    Rollover Recommended | Rollover Strongly Recommended | Rollover Required
  Compression count value:
  Compression count source:
    platform-visible | owner-reported | inferred | unknown
  Compression count confidence:
    high | medium | low | unknown
  Additional compression count evidence:
    - <source/value/confidence; optional>
  Last context-budget check:
  Trigger category:
    threshold | rollover-opportunity | state-unreliable |
    owner-quality-concern | stale-ledger-before-gate | other
  Reason:
  Canonical state rule:
    exactly one state; highest applicable state wins
  Next safe rollover boundary:
  Rollover action:
  Opportunity action:
    current-state card and evidence index refreshed; complete packet only for
    Recommended+ or explicit Owner handoff request

Sealed-ready state:
  not entered | entered
  Frozen active current-state card:
    <path/title of the single active state card>
  Frozen scope:
    <what must not continue until takeover verification>
  Unconsumed Worker returns:
    none | ...

Gate state:
  Validation:
  PM/Advisor:
  Reviewer:
  Commit:
  Push:
  CI/status:
  Archive:

PM/Advisor/Reviewer continuity:
  PM:
  Advisor:
  Provider/model per role:
    PM:
    Advisor:
  Model source per role:
    PM:
    Advisor:
  Source freshness/current verification:
  Separation/diversity status:
    provider-separated | model-family-separated degraded |
    same-provider-variant degraded | same-model owner override degraded |
    degraded | blocked
  Override or degradation reason:
  Current verified model record:
  Lifecycle patience:
    Expected work size:
      quick | substantive | large gate review | unknown
    Expected wait/recheck behavior:
    Last contact or progress evidence:
    Patience state:
      active | waiting | progress-check-needed | exceeded | blocked | complete
    Closure/restart reason, if any:
  Reviewer:
  Continuity:
  Context-efficient review identity:
    Review ID:
    PM Attempt ID / packet fingerprint / state:
    Advisor Attempt ID / packet fingerprint / state:
    Stable baseline and incremental target:
    Result location:
    Retry decision / parent Attempt ID:
    If result-unknown, available evidence and unresolved gate:
      <successor must inspect evidence and must not blindly retry>

Worker lifecycle patience:
  Substantive Worker active:
    yes | no
  Worker identity/slice:
  Expected wait/recheck behavior:
  Last contact or progress evidence:
  Patience state:
    active | waiting | progress-check-needed | exceeded | blocked | complete
  Closure/restart reason, if any:

Unresolved P0/P1:
  none | ...

Git and OpenSpec:
  Branch:
  Commit:
  Dirty state:
  Active OpenSpec changes:
  Archive requirement:

Changed and do-not-touch files:
  Changed:
    - ...
  Do not touch:
    - ...

Validation:
  Run:
    - ...
  Not run:
    - ...
  Freshness:
    - ...

Authorization state:
  Current actionable authorization:
    default no | not entered | blocked | current verified gate passed
  Historical gate evidence:
    none | prior commit/push/CI/archive gate evidence; evidence only
  Successor inheritance:
    not inherited; successor must re-verify before acting

Next safe action:
  <one action only>

Plain-language closeout or handoff summary:
  What changed:
    <ordinary-language summary>
  What was verified:
    <commands, checks, review gates, or evidence actually run or observed>
  What remains uncertain or was not checked:
    <mandatory; write none and why if nothing remains>
  Recommended next goal:
    <advice only; successor must verify current Owner authorization before starting it>
  Role cleanup status:
    not needed | pending | attempted | skipped | degraded | failed
  Cleanup result by role:
    Worker:
    Reviewer:
    PM:
    Advisor:
  Delivery-evidence impact:
    none | affected | unknown
  If non-blocking cleanup failure:
    task, git, validation, CI/status, secret-safety, authorization, and
    required role evidence are confirmed from evidence in hand because:

Stop conditions:
  - ...
```

## Lightweight Handoff Dashboard

```text
Tasks:
  Pending:
    - ...
  In progress:
    - ...
  Completed:
    - ...
  Blocked:
    - ...

Pending messages:
  Owner:
    - ...
  PM:
    - ...
  Advisor:
    - ...
  Worker:
    - ...
  Reviewer:
    - ...

Conflicts and overlaps:
  Unresolved disagreements:
    - ...
  File or scope overlaps:
    - ...
  Authorization conflicts:
    - ...
  Dashboard use:
    evidence input to canonical state selection, not a separate state machine
```

## Evidence Index

```text
Claim:
  <claim>
Evidence type:
  <file, command, validation, agent output, old handoff, commit, CI/status>
Evidence location:
  <path, command, commit, or note title>
Freshness/status:
  current | stale until re-verified | historical only
Leader verification:
  verified | inferred | unverified
```

## Successor Verification Checklist

```text
Before continuing, the successor Leader must verify:
  - Project instructions, memory, and skill rules were read.
  - Current owner instruction still supports the next action.
  - git branch, commit, and dirty state are current.
  - OpenSpec active changes and C-stage are current.
  - Validation evidence is fresh for the current diff.
  - PM/Advisor/Reviewer continuity is intact, restarted, degraded, or unavailable.
  - Worker state and unconsumed returns are understood.
  - Unresolved P0/P1 and owner-decision needs are explicit.
  - Commit/push/CI/archive authorization state is not inherited from old handoff text.
  - Next action is safe after re-verification.
```

## Do Not Carry Forward

```text
Do not paste old handoffs, old validation logs, full diffs, complete agent
transcripts, or superseded plans into the active successor packet. Reference
them in the evidence index with freshness and verification status instead.
```
