# Context-Efficient Independent Role Review

The Leader creates one conclusion-free factual manifest anchored to commit `BASE` and the current diff `BASE..HEAD`. Separate PM and Advisor packets reuse those facts but intentionally withhold the other role's conclusion.

The Advisor finds the packet insufficient and reads the task-relevant original `SKILL.md` and validator sections. This does not broaden the approved project scope. The Advisor returns `BLOCKED-EVIDENCE` until a fresh validation result is supplied, then completes a narrow follow-up in the same short-lived session because the target did not change.

If the attempt remains silent, the invocation record stays `running`; short silence does not trigger cleanup or a duplicate call. If process and output checks cannot resolve it, the state becomes `result-unknown`. Only after confirmed failure does a new Attempt ID link to the parent and retry the same Review ID. PM and Advisor still return `GO`, `NO-GO`, or `BLOCKED-EVIDENCE` with P0/P1/P2, inspected evidence, gaps, freshness, corrections, Owner-decision needs, next action, and rationale.

These records are evidence, not authorization.
