# Context-Efficient Stage-Scoped Role Review

An OpenSpec C2 PM uses Stage Session ID `pm-c2-17`, backed by Runtime Session ID `codex-thread-17`, for implementation review `REV-C2-01` and commit-readiness review `REV-C2-02`. Each checkpoint has a new Attempt ID, target fingerprint, `fresh-decision: confirmed`, current validation and authorization states, and `isolated-current-first-pass`. The PM retains verified C2 context and its own reasoning, but neither the earlier `GO` nor validation or authorization carries forward.

The C2 Advisor similarly uses `advisor-c2-09`. Claude runtime identity is proven by exact `--resume claude-session-09`; `--continue` is never accepted as identity evidence. PM and Advisor do not receive one another's current first-pass conclusion until both first passes complete.

At C2-to-C3 transition, Leader records `restart reason: cross-stage`, `Lifecycle Decision Actor: leader`, `Lifecycle Decision Time: 2026-07-12T18:20:00-07:00`, and a verified restart packet. C3 receives new Stage Session IDs and inherits only `verified-restart-packet`, not C2 decisions or authorization.

During C3, Advisor context becomes materially unreliable. Leader records a same-stage transition with `restart reason: context-reliability`, actor and timezone-qualified time, quarantines any `running` or `result-unknown` old attempt until concurrent-execution risk is resolved, and starts `advisor-c3-12` from verified restart evidence. The new lifecycle records `continuity: restarted`; it cannot claim intact continuity.

If an unchanged target needs one missing file, the role may continue the same Review ID with a linked Attempt ID. A changed target always gets a new Review ID. If an attempt remains silent, its record stays `running`; short silence does not trigger cleanup or duplicate invocation.

The factual manifest and separate role packets remain evidence indexes. Both roles may inspect any task-relevant original evidence and return `GO`, `NO-GO`, or `BLOCKED-EVIDENCE` with P0/P1/P2, gaps, freshness, corrections, Owner-decision needs, next action, and complete reasoning.
