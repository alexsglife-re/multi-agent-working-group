# Advisor Review Template

Version: v0.4.7 recommended template.

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
  <no unresolved P0/P1 and next gate can proceed | blocked because ...>
```
