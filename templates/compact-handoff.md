# Compact Handoff Template

Version: v0.4.9 recommended template.

## Current State Card

```text
Date/time:
  <date, time, timezone>

Current goal:
  <owner goal>

Owner instruction:
  <latest owner instruction that authorizes current local work>

Stage:
  discuss | C0 | C1 | C2 | C3 | C4 | commit gate | push gate | closeout

Archive requirement:
  required | not required | unknown

Gate state:
  <validation, PM/Advisor, Reviewer, commit, push, CI/status>

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
    refresh current-state card and evidence index; lightweight successor
    packet skeleton only unless Recommended+ or Owner requests handoff

Sealed-ready state:
  not entered | entered
  Frozen active current-state card:
    <path/title of the single active state card>
  Frozen scope:
    <what must not continue until takeover verification>
  Unconsumed Worker returns:
    none | ...

Scope:
  In scope:
    - ...
  Out of scope:
    - ...

PM/Advisor continuity:
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
  Continuity:

Worker lifecycle patience:
  Substantive Worker active:
    yes | no
  Worker identity/slice:
  Expected wait/recheck behavior:
  Last contact or progress evidence:
  Patience state:
    active | waiting | progress-check-needed | exceeded | blocked | complete
  Closure/restart reason, if any:

Reviewer continuity:
  not required | required | complete | blocked

Unresolved P0/P1:
  none | ...

Validation:
  Run:
    - ...
  Not run:
    - ...
  Freshness:
    - ...

Changed and do-not-touch files:
  Changed:
    - ...
  Do not touch:
    - ...

Legacy or bloated source handling:
  Old sources frozen:
    - ...
  Verified facts copied forward:
    - ...
  Stale facts left in evidence index:
    - ...

Next action:
  <single next safe action>

Task status dashboard:
  Pending:
    - ...
  In progress:
    - ...
  Completed:
    - ...
  Blocked:
    - ...

Pending messages, conflicts, and overlaps:
  Pending messages:
    - ...
  Conflicts:
    - ...
  Overlaps:
    - ...
  Dashboard use:
    evidence input to canonical state selection, not a separate state machine

Commit/push authorization state:
  Current actionable authorization:
    <default no | not entered | blocked | current verified gate passed>
  Historical gate evidence:
    <none | prior commit/push/CI/archive gate evidence; not inherited>
  Successor inheritance:
    not inherited; successor must re-verify before acting

Stop conditions:
  - ...
```

## Successor Verification Checklist

```text
Before continuing, successor Leader must verify:
  - Project instructions, memory, and skill rules.
  - Current owner instruction.
  - git branch, commit, and dirty state.
  - OpenSpec active changes and C-stage.
  - Validation freshness.
  - PM/Advisor/Reviewer continuity.
  - Worker state and unconsumed returns.
  - Unresolved P0/P1 and owner-decision needs.
  - Commit/push/CI/archive authorization state.
  - Next safe action.
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

## Historical Archive Note

```text
Archive note:
  <what old material says>

Current verification:
  <what was re-checked now>

Reason archived:
  <why it should not remain in active handoff>
```
