# Blocked Report Template

Version: v0.4.5 recommended template.

```text
Status:
  blocked

Current stage:
  discuss | C0 | C1 | C2 | C3 | C4 | commit gate | push gate | closeout

Blocked by:
  missing permission | failed validation | unresolved P0/P1 | missing Advisor evidence | missing Reviewer evidence | owner gate | workspace-trust-blocked | tool failure | other

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
