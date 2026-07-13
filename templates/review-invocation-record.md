# Review Invocation Record Template

Version: v0.4.13 recommended template.

```text
Stage Session ID:
C-stage:
  C0-bootstrap | C1 | C2 | C3 | C4 | non-openspec
Runtime Session ID:
Runtime/provider kind:
  Claude | other
Runtime identity evidence source:
Runtime resume evidence:
  exact --resume <session-id> | exact runtime mechanism | unavailable | contradictory
Runtime evidence state:
  exact-supported | unavailable | contradictory
Provider/model/tool environment:
Workspace-trust state:
Inherited context:
  none | verified-same-stage | verified-restart-packet
Continuity:
  intact-runtime-proven | restarted | degraded | unavailable
Restart reason:
  cross-stage | context-reliability | context-pressure | independence-contamination | provider-change | model-change | tool-change | trust-loss | state-ambiguity | failed-recovery | owner-instruction | not-applicable
Review ID:
Attempt ID:
Parent Attempt ID:
Role:
Review type:
Target commit or diff:
Stable baseline anchor:
Packet fingerprint:
Target fingerprint:
Fresh decision:
  confirmed | blocked
No-peek state:
  isolated-current-first-pass | consensus-open | contaminated
Validation freshness:
  fresh-current-target | stale | not-applicable
Authorization state:
  not-granted | owner-explicit-current-scope | normal-git-gate-current | blocked
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

For a lifecycle transition only, append:

```text
Prior Stage Session ID:
Successor Stage Session ID:
Lifecycle Decision Actor:
  leader | owner
Lifecycle Decision Time:
  <ISO-8601 with timezone>
Verified successor packet:
Last progress evidence and patience-window state:
```

Transition fields are required for normal cross-stage close/restart, early close/restart, C0 close, and degraded or unavailable transitions. Omit them from routine same-stage records.

Do not blindly repeat the same Review ID and packet fingerprint while it is `running` or `result-unknown`.

The blank template is permanent protocol material. A filled instance is lifecycle-bound working material until the applicable gate and blocker checks complete. Non-destructive compaction does not mutate or delete files. Any destructive removal requires exact-scope Owner authorization.
