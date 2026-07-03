# C0 Goal Analysis Template

Version: v0.4.10 recommended template.

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

Advisor routing:
  Provider/model:
  Model source:
  Source freshness/current verification:
  Model diversity:
  Trusted-context boundary:

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
    do not close for short silence; require concrete lifecycle reason

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
