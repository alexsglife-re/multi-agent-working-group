# Worker Assignment Template

Version: v0.4.10 recommended template.

```text
Role:
  Worker Agent

Task target:
  <one sentence acceptance target>

Work size:
  quick | substantive | complex | implementation-heavy | validation-heavy

Expected wait/recheck behavior:
  <how long or under what condition Leader should wait before progress check>

Lifecycle patience:
  Do not treat short silence as failure for substantive bounded work.
  Close/restart only for completion, blocked return, tool/session failure,
  exceeded patience window without progress evidence, stale evidence,
  role drift, context overload, rollover boundary, or Owner instruction.

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
  Lifecycle patience:
    Last contact or progress evidence:
    Patience window exceeded:
      yes | no | not applicable
    Closure/restart reason, if any:
  Findings:
    P0:
    P1:
    P2:
  Blockers:
    - none | ...
  Next action recommendation:
    - ...
```
