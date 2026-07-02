# PM Review Template

Version: v0.4.8 recommended template.

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

Owner-decision needs:
  none | <plain-language decision needed>

Gate conclusion:
  <no unresolved P0/P1 and next gate can proceed | blocked because ...>
```
