# Role Review Context Efficiency

This reference extends `SKILL.md`; it cannot weaken `SKILL.md` or create authorization.

## Quality Boundary

Context efficiency removes repeated transmission, not review capability. It must not change PM or Advisor provider/model routing, required review frequency, assigned scope, independent no-peek authority, access to task-relevant original evidence, gate coverage, lifecycle patience, or Leader verification. No hard token ceiling may force incomplete review or a false `GO`.

## Session And Packet Model

Use a fresh short-lived session for each distinct first-pass, scope, pre-commit, post-commit, pre-push, post-push, or closeout target. A narrow clarification or missing-file request for the unchanged target may remain in the same session. A changed commit, diff, gate, decision request, or materially changed packet requires a new Review ID or linked attempt.

Build one conclusion-free factual manifest and derive separate PM and Advisor packets. Never expose one role's first-pass conclusion to the other before both independent first passes finish. Each packet includes the Owner goal and authorization boundary, stable baseline and accepted anchor, current delta, changed files and behavior, fresh validation, known risks, unresolved questions, and evidence pointers.

The packet is an index and starting point, not a restriction or substitute for original evidence. The role may inspect any task-relevant original file and read-only evidence within the approved project scope. When the packet is insufficient, inspect or request original evidence and return `BLOCKED-EVIDENCE` if the gap remains.

## Invocation Identity

Record Review ID, Attempt ID, role, review type, target, stable baseline anchor, packet fingerprint, state, start/completion time, result location, retry decision, and parent Attempt ID when retried.

States are `prepared`, `running`, `completed`, `failed-confirmed`, `result-unknown`, and `superseded`. Do not blindly repeat the same Review ID and packet fingerprint while it is `running` or `result-unknown`. First inspect process, output, and CLI status evidence. Short silence is not failure or cleanup. A confirmed retry uses a new Attempt ID linked to its parent and preserves the same capability and scope.

## Required Role Response

Record:

- Decision: `GO`, `NO-GO`, or `BLOCKED-EVIDENCE`.
- P0, P1, and P2 findings.
- Evidence inspected and evidence gaps.
- Validation freshness.
- Required corrections and Owner-decision needs.
- Recommended next action and concise rationale.

Role output and packet records are evidence, not authorization.
