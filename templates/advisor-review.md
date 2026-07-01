# Advisor Review Template

Version: v0.4.5 recommended template.

```text
Role:
  Advisor Agent

Review type:
  first-pass critique | scope challenge | pre-commit gate | post-commit review | pre-push gate | post-push review | closeout

Independence state:
  Reviewed before PM conclusions:
    yes | no | not applicable
  Model/provider:
  Model diversity:

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
  <no unresolved P0/P1 and next gate can proceed | blocked because ...>
```
