# Advisor Review Template

Version: v0.4.13 recommended template.

```text
Role:
  Advisor Agent

Review type:
  first-pass critique | scope challenge | pre-commit gate | post-commit review | pre-push gate | post-push review | closeout

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
    PM conclusions | none

Independence state:
  Reviewed before PM conclusions:
    yes | no | not applicable
  Provider/model:
  Model source:
  Source freshness/current verification:
  Model diversity/separation status:
    provider-separated | model-family-separated degraded |
    same-provider-variant degraded | same-model owner override degraded |
    degraded | blocked

Lifecycle patience:
  Work size:
    quick | substantive | large gate review | unknown
  Expected wait/recheck behavior:
  Last contact or progress evidence:
  Patience state:
    active | waiting | progress-check-needed | exceeded | blocked | complete
  Closure/restart reason, if any:

Claims challenged:
  - ...

Counterexamples considered:
  - ...

Risk check:
  Risk tier:
  Possible underestimated risks:
    - none | ...
  Default exclusions touched:
    yes | no

CLI workspace trust challenge, if relevant:
  Owner-recorded role authorization source inspected:
  Source applies to current project/workstream:
    yes | no | not applicable
  Trust state:
    not-needed | preflight-needed | owner-recorded-role-authorized | trust-setup-attempted | trusted-verified | owner-confirmation-needed | blocked
  Target project root is exact current project root:
    yes | no | not applicable
  Read-only probe passed before relying on CLI output:
    yes | no | not applicable
  Scope expansion concerns:
    none | parent/home/all-repo trust | dangerous permission bypass | secrets | global policy | git/CI/deploy/release/external effect | other

Findings:
  P0:
    - none | ...
  P1:
    - none | ...
  P2:
    - none | ...

Evidence inspected:
  Files:
    - ...
  Commands/results:
    - ...
  Agent outputs:
    - ...

Validation freshness:
  Fresh:
    - ...
  Stale or missing:
    - ...

Owner-decision needs:
  none | <plain-language decision needed>

Advisor conclusion:
  GO | NO-GO | BLOCKED-EVIDENCE
Evidence gaps:
  - none | ...
Required corrections:
  - none | ...
Recommended next action:
  ...
Concise rationale:
  ...
```

This packet is an index and starting point, not a restriction or substitute for original evidence. Inspect any task-relevant original evidence within the approved scope when needed.
