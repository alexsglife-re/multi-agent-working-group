# Review Packet Cleanup Checklist

Version: v0.4.18 development template.

```text
Task or OpenSpec change:
Review ID and Attempt ID set:
Candidate scope:
Retention class for every target:
Final applicable gate or OpenSpec checkpoint:
Gate completion evidence:

Blocker check:
  No prepared, running, or result-unknown invocation:
  No unresolved P0/P1 or BLOCKED-EVIDENCE:
  No evidence gap, correction, or Owner decision pending:
  Required reviews and later applicable gates complete:
  Cleanup impact is known:

Minimum durable audit record:
  Invocation identity and retry lineage:
  Exact target and stable-baseline anchors:
  Packet fingerprint and timing:
  Decision and P0/P1/P2 findings:
  Validation, status/CI, and secret-scan evidence as applicable:
  Reproducible original-evidence pointers:
  Complete role reasoning, options, recommendation, objections, and key errors:
  Cleanup decision, scope, actor, time, and retained-record location:

Decision:
  retain active | non-destructive compaction eligible | destructive removal blocked
Owner authorization for exact destructive scope:
  absent | present and recorded separately
```

Reject permanent protocol material, original task evidence, accepted specifications, archived OpenSpec artifacts, and incomplete durable audit records. This checklist never authorizes deletion. Do not mutate or remove files unless the Owner separately authorizes the exact destructive scope and all applicable gates pass.
