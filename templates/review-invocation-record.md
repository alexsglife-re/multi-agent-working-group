# Review Invocation Record Template

Version: v0.4.13 recommended template.

```text
Review ID:
Attempt ID:
Parent Attempt ID:
Role:
Review type:
Target commit or diff:
Stable baseline anchor:
Packet fingerprint:
State:
  prepared | running | completed | failed-confirmed | result-unknown | superseded
Started at:
Completed at:
Result location:
Available process/output/CLI evidence:
Retry decision and reason:
```

Do not blindly repeat the same Review ID and packet fingerprint while it is `running` or `result-unknown`.
