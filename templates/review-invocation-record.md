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
Retention class:
  permanent protocol material | durable audit evidence | lifecycle-bound working material
Final applicable gate or OpenSpec checkpoint:
Cleanup blocker check:
  Invocation state resolved:
  P0/P1 resolved:
  BLOCKED-EVIDENCE and evidence gaps resolved:
  Required corrections and Owner decisions resolved:
  Required reviews and later applicable gates complete:
  Cleanup impact known:
Cleanup decision:
  retain active | non-destructive compaction eligible | destructive removal blocked | exact-scope Owner-authorized removal eligible
Cleanup scope:
Cleanup actor:
Cleanup decision time:
Retained-record location:
Exact target anchors and original-evidence pointers:
Decision and P0/P1/P2 findings:
Validation freshness and results:
Status or CI and secret-scan evidence, when applicable:
Complete reasoning, option comparison, recommendation, objections, and key error details:
  embedded here | durable result location
```

Do not blindly repeat the same Review ID and packet fingerprint while it is `running` or `result-unknown`.

The blank template is permanent protocol material. A filled instance is lifecycle-bound working material until the applicable gate and blocker checks complete. Non-destructive compaction does not mutate or delete files. Any destructive removal requires exact-scope Owner authorization.
