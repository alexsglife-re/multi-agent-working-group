# Worker Return Template

Version: v0.4.9 recommended template.

```text
Role:
  Worker Agent

Status:
  completed | partial | blocked

Lifecycle patience:
  Work size:
    quick | substantive | complex | implementation-heavy | validation-heavy
  Last contact or progress evidence:
  Patience window exceeded:
    yes | no | not applicable
  Closure/restart reason, if any:

Assigned target:
  <original one-sentence target>

Changed files:
  - ...

Summary:
  - ...

Validation performed:
  - Command/check:
    Result:
    Freshness:

Findings:
  P0:
    - none | ...
  P1:
    - none | ...
  P2:
    - none | ...

Scope compliance:
  Stayed within allowed files:
    yes | no
  Scope changes:
    none | ...

Blocked or incomplete work:
  none | ...

Evidence for Leader:
  - ...

Recommended next action:
  <Leader verify, repair, ask owner, rerun validation, etc.>
```
