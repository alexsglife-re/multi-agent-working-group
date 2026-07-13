# OpenSpec Review Packet Retention Example

This example compacts duplicate working material without deleting files.

## C1

Both independent proposal first passes, corrections, and the scope decision are complete. The Leader records Review IDs, findings, complete role reasoning at durable result locations, and reproducible proposal/spec pointers. Redundant rendered proposal packets become eligible for non-destructive compaction; C2 evidence stays accessible.

## C2

Implementation validation and required implementation review complete. Superseded implementation packets may be compacted, but current diffs, validation, findings, and evidence needed for commit and push remain active.

## C3

Pre-commit, actual-commit, pre-push, status/CI, and post-push packets remain active until their corresponding gates and follow-up reviews finish. C2 completion is not final cleanup.

## C4

Archive validation, applicable archive commit/push/status work, and post-action PM/Advisor review are complete. The blocker check passes and the minimum durable audit record is complete. Final non-destructive compaction is eligible. Destructive removal remains blocked unless the Owner separately authorizes exact targets.

Permanent blank templates, accepted specifications, archived OpenSpec artifacts, task-relevant original evidence, and durable audit evidence remain preserved.

This lifecycle controls which context remains active or is retransmitted. It does not cap stored files: eligible lifecycle-bound files remain stored until exact-scope Owner-authorized removal.
