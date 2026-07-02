# Blocked Report Template

Version: v0.4.7 recommended template.

```text
Status:
  blocked

Current stage:
  discuss | C0 | C1 | C2 | C3 | C4 | commit gate | push gate | closeout

Blocked by:
  missing permission | failed validation | unresolved P0/P1 | missing Advisor evidence | missing Reviewer evidence | owner gate | workspace-trust-blocked | owner-confirmation-needed | tool failure | other

CLI workspace trust blocker, if relevant:
  Owner-recorded role authorization source:
  Source applicability:
  Assigned CLI role:
  Target project root:
  Trust state:
    not-needed | preflight-needed | owner-recorded-role-authorized | trust-setup-attempted | trusted-verified | owner-confirmation-needed | blocked
  Post-setup read-only probe:
  Why current authorization is insufficient:
    none | stale source | mismatched project/workstream | outside project root | dangerous permission bypass | secret access | global policy change | git/CI/deploy/release/external effect | other

Plain-language explanation:
  <what happened and why continuing would be unsafe or misleading>

Completed:
  - ...

Not performed:
  - ...

Evidence:
  Files:
    - ...
  Commands/results:
    - ...
  Agent outputs:
    - ...

Needed from owner or leader:
  - ...

Recommended next action:
  - ...

What must not happen:
  - Do not assume permission.
  - Do not treat stale evidence as current.
  - Do not bypass PM/Advisor/Reviewer, validation, secret-scan, CI/status, or git gates.
```
