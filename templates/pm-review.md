# PM Review Template

Version: v0.4.13 recommended template.

```text
Role:
  PM Agent

Review type:
  first-pass | scope review | pre-commit gate | post-commit review | pre-push gate | post-push review | closeout

Context-efficient review identity:
  Review ID:
  Attempt ID:
  Parent Attempt ID:
  Packet fingerprint:
  Invocation state:
    prepared | running | completed | failed-confirmed | result-unknown | superseded
  Stable baseline anchor:
  Incremental evidence target:
  Conclusions intentionally withheld:
    Advisor conclusions | none

Goal:
  <owner goal and current stage>

Scope:
  In scope:
    - ...
  Out of scope:
    - ...

Acceptance criteria:
  - ...

Risk classification:
  Tier:
  Reason:
  Default exclusions touched:
    yes | no

Model routing, if relevant:
  Provider/model:
  Model source:
  Source freshness/current verification:

Lifecycle patience:
  Work size:
    quick | substantive | large gate review | unknown
  Expected wait/recheck behavior:
  Last contact or progress evidence:
  Patience state:
    active | waiting | progress-check-needed | exceeded | blocked | complete
  Closure/restart reason, if any:

CLI workspace trust, if relevant:
  Owner-recorded role authorization source:
  Source applies to current project/workstream:
    yes | no | not applicable
  Trust state:
    not-needed | preflight-needed | owner-recorded-role-authorized | trust-setup-attempted | trusted-verified | owner-confirmation-needed | blocked
  Target project root:
  Post-setup read-only probe:
    passed | failed | not run | not applicable
  Scope boundary concerns:
    none | ...

Recommended next action:
  <proceed, revise, block, ask owner, dispatch worker, archive, etc.>

Findings:
  P0:
    - none | ...
  P1:
    - none | ...
  P2:
    - none | ...

Validation expectation:
  Required before next gate:
    - ...
  Already verified:
    - ...

Evidence inspected:
  - ...
Evidence gaps:
  - none | ...
Validation freshness:
  fresh | stale | missing | mixed
Required corrections:
  - none | ...

Owner-decision needs:
  none | <plain-language decision needed>

Gate conclusion:
  GO | NO-GO | BLOCKED-EVIDENCE
Concise rationale:
  ...
```

This packet is an index and starting point, not a restriction or substitute for original evidence. Inspect any task-relevant original evidence within the approved scope when needed.

This reusable blank template is permanent protocol material. A filled PM packet is lifecycle-bound working material; its complete required reasoning and minimum durable audit record remain durable after any eligible non-destructive compaction.
