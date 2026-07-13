# C0 Goal Analysis Template

Version: v0.4.13 recommended template.

```text
Owner goal:
  <what the owner asked to complete>

Current task:
  <the immediate task in this workstream>

Risk tier:
  small low-risk | medium | complex | high-risk

Risk notes:
  <why this tier was chosen; name default exclusions if absent or present>

Active OpenSpec changes:
  <none | change names and state>

Applicable skills:
  <multi-agent-working-group, OpenSpec skills, security, etc.>

PM routing:
  Provider/model:
  Model source:
  Source freshness/current verification:
  Continuity:
  C-stage: C0-bootstrap
  Stage Session ID:
  Runtime/provider kind:
  Runtime Session ID / source / resume evidence:

Advisor routing:
  Provider/model:
  Model source:
  Source freshness/current verification:
  Model diversity:
  Trusted-context boundary:
  C-stage: C0-bootstrap
  Stage Session ID:
  Runtime/provider kind:
  Runtime Session ID / source / resume evidence:

PM/Advisor separation:
  provider-separated | model-family-separated degraded |
  same-provider-variant degraded | same-model owner override degraded |
  degraded | blocked
  Reason:
  Current verified model record:

PM/Advisor lifecycle patience:
  Expected work size:
    quick | substantive | large gate review | unknown
  Expected wait/recheck behavior:
  Last contact or launch time:
  Progress evidence:
  Patience state:
    active | waiting | progress-check-needed | exceeded | blocked | complete
  Closure/restart rule:
    close or restart before C1; do not carry C0 decisions or authorization; do not close for short silence
  C0 transition record:
    Prior Stage Session ID:
    Successor Stage Session ID:
    Restart reason: cross-stage | <other canonical reason>
    Lifecycle Decision Actor: leader | owner
    Lifecycle Decision Time: <ISO-8601 with timezone>
    Verified successor packet:

Context-efficient review plan:
  Inherited context: none
  Fresh decision: confirmed | blocked
  No-peek state: isolated-current-first-pass | consensus-open | contaminated
  Validation freshness: fresh-current-target | stale | not-applicable
  Authorization state: not-granted | owner-explicit-current-scope | normal-git-gate-current | blocked
  Review ID:
  Stable baseline anchor:
  Incremental evidence target:
  PM Attempt ID / packet fingerprint / state:
  Advisor Attempt ID / packet fingerprint / state:
  Result-unknown handling:
    inspect process/output/CLI evidence; do not blindly retry

CLI workspace trust:
  Needed:
  Status:
  Owner-recorded role authorization source:
  Source applicability:
  Assigned CLI role:
  Target project root:
  Trust setup action:
  Post-setup read-only probe:
  Evidence:

Git state:
  Branch:
  HEAD:
  Remote/base:
  Dirty state:

Validation expectations:
  Required:
  Optional:
  Not applicable:

Completion target:
  Includes C4 archive:
  Includes commit:
  Includes push:
  Includes CI/status check:

Legacy or bloated document handling:
  Old sources used:
  Facts copied forward:
  Facts left as historical evidence:

Stop conditions:
  <failed validation, unresolved P0/P1, missing Advisor evidence, owner decision, high-risk gate, etc.>
```
