# Successor Startup Packet Template

Version: v0.4.6 recommended template.

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
  Observed compression/summary count:
  Count confidence:
    known | inferred | unknown
  Last context-budget check:
  Trigger category:
    threshold | state-unreliable | owner-quality-concern | stale-ledger-before-gate | other
  Reason:
  Next safe rollover boundary:
  Rollover action:

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
  Reviewer:
  Continuity:

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

Commit/push authorization state:
  default no | not entered | blocked | one-time owner exception | gate passed

Next safe action:
  <one action only>

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
