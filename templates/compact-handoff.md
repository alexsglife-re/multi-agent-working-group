# Compact Handoff Template

Version: v0.4.5 recommended template.

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

Commit/push authorization state:
  <not entered | commit gate passed | push gate passed | blocked>

Stop conditions:
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

## Historical Archive Note

```text
Archive note:
  <what old material says>

Current verification:
  <what was re-checked now>

Reason archived:
  <why it should not remain in active handoff>
```
