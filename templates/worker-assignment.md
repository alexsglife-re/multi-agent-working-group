# Worker Assignment Template

Version: v0.4.5 recommended template.

```text
Role:
  Worker Agent

Task target:
  <one sentence acceptance target>

Allowed files or modules:
  - ...

Readable context:
  - ...

Forbidden scope:
  - ...

Implementation constraints:
  - Do not expand scope.
  - Do not self-approve.
  - Do not commit or push.
  - Do not edit files outside the allowed scope.

Required validation:
  - ...

Expected return:
  Status:
    completed | blocked | partial
  Changed files:
    - ...
  Summary:
    - ...
  Validation performed:
    - ...
  Findings:
    P0:
    P1:
    P2:
  Blockers:
    - none | ...
  Next action recommendation:
    - ...
```
