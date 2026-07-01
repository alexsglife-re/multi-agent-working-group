# Compact Handoff Template

Version: v0.4.6 recommended template.

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
    Normal | Soft Warning | ContextBudget Watch | Rollover Recommended |
    Rollover Strongly Recommended | Rollover Required
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

Scope:
  In scope:
    - ...
  Out of scope:
    - ...

PM/Advisor continuity:
  PM:
  Advisor:
  Separation/diversity:
  Continuity:

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

Commit/push authorization state:
  <not entered | commit gate passed | push gate passed | blocked>

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
