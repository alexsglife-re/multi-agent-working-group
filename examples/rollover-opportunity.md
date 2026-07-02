# Rollover Opportunity Example

This example shows v0.4.8 early rollover preparation when visible platform
summaries undercount actual context compression, but the current evidence does
not yet prove a higher required threshold.

## Situation

```text
Stage:
  C2 implementation slice complete.

Validation:
  openspec validate --all: passed
  ./scripts/validate-local.sh: passed

Next step:
  Dispatch a new Worker for the next slice.

Compression evidence:
  Platform-visible summary count: 1
  Owner-reported actual compression count: higher than platform-visible;
  exact total unknown
```

## Context Budget Record

```text
Context budget state:
  Rollover Opportunity

Compression count value:
  unknown

Compression count source:
  owner-reported

Compression count confidence:
  medium; enough to prepare earlier, not enough to claim a threshold

Additional compression count evidence:
  platform-visible: 1, confidence low for actual total

Canonical state rule:
  exactly one state; highest applicable state wins

Reason:
  A validated implementation slice is complete, the Owner reports actual
  compression count is higher than platform-visible evidence without an exact
  total, and the next action is dispatching a new Worker.

Next safe rollover boundary:
  before dispatching the next Worker

Rollover action:
  refresh current-state card and evidence index; update a lightweight successor
  packet skeleton; do not require immediate handoff unless the Owner chooses it
  or a higher state applies.
```

## What Leader Must Not Say

```text
Incorrect:
  This conversation has only compressed once.

Correct:
  I can see one platform summary, but the Owner reports the actual compression
  count is higher than platform-visible evidence. I will record the
  platform-visible count separately from the Owner-reported evidence.
```

## Dashboard Use

```text
Task status dashboard:
  Pending:
    - next Worker slice
  In progress:
    - none
  Completed:
    - current implementation slice
  Blocked:
    - none

Dashboard use:
  evidence input to canonical state selection, not a separate state machine
```

## Authorization

```text
Historical gate evidence:
  prior validation passed

Current actionable authorization:
  no commit/push/CI/archive authorization is inherited by a successor packet

Same-workstream continuation:
  normal non-high-risk gates may continue only when PM and Advisor agree and
  all required Reviewer, validation, target, secret-scan, CI/status, and archive
  gates pass.
```

## Escalation Contrast

```text
If the Owner reports an actual count of 10+ and the next action is Worker
dispatch, commit, push, CI, archive, or another high-risk gate, the canonical
state is Rollover Required, not Rollover Opportunity.

Reason:
  Owner-reported count is threshold evidence. With a gated next step, the
  highest applicable state wins.
```
