# Unsafe Review Packet Cleanup Examples

Each case is rejected for the stated reason:

| Proposed action | Required result |
| --- | --- |
| Compact a packet whose invocation is `running`. | Reject: active invocation. Short silence is not failure. |
| Compact a packet whose invocation is `result-unknown`. | Reject: inspect process, output, and CLI status; do not clean or blindly retry. |
| Compact while P0 or P1 remains unresolved. | Reject: unresolved blocker. |
| Compact after `BLOCKED-EVIDENCE` or an evidence gap. | Reject until original evidence is inspected or the gap is resolved. |
| Compact pushed-task packets before status/CI evidence or post-push review. | Reject: incomplete final applicable gate. |
| Delete `templates/pm-review.md` because filled PM packets are lifecycle-bound. | Reject: the blank template is permanent protocol material. |
| Retain only `GO` and omit Review ID, target anchor, fingerprint, findings, validation, evidence pointers, retry lineage, or complete reasoning. | Reject: incomplete durable audit record. |
| Automatically delete all historical packets after 30 days. | Reject: time-based retrospective bulk deletion and no exact-scope Owner authorization. |

`failed-confirmed` and `superseded` renderings are not automatically eligible. Retry lineage and final disposition must first be durable, all other blockers must clear, and any destructive removal remains separately Owner-authorized.
