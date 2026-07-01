# PM Review Template

Version: v0.4.5 recommended template.

```text
Role:
  PM Agent

Review type:
  first-pass | scope review | pre-commit gate | post-commit review | pre-push gate | post-push review | closeout

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

Owner-decision needs:
  none | <plain-language decision needed>

Gate conclusion:
  <no unresolved P0/P1 and next gate can proceed | blocked because ...>
```
