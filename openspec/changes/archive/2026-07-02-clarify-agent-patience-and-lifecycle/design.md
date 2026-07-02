# Design: Agent Patience And Lifecycle

## Decisions

### Patience Is Role And Scope Dependent

Short silence is not failure for substantive role work. The Leader records a patience window rather than assuming an immediate timeout:

- PM/Advisor substantive review: longer wait by default.
- PM/Advisor OpenSpec, commit, push, CI/status, archive, or high-risk gate review: longer wait by default and do not close early without a concrete blocker.
- Complex or implementation-heavy Worker: longer wait by default when the assignment is bounded and validation-heavy.
- Small low-risk or quick read-only checks: shorter wait may be reasonable when explicitly scoped as quick.

The skill should avoid hard-coded universal durations. Projects or Owner instructions may set concrete wait windows.

### Evidence-Based Closure

The Leader may close, restart, or replace an agent only with a recorded reason:

- agent reports completion, blocked, or cannot proceed;
- tool/session exits, errors, or becomes unreachable;
- agreed patience window is exceeded without progress evidence;
- evidence becomes stale or role context drifts;
- context overload, rollover, or lifecycle boundary requires restart;
- Owner instructs closure or reassignment.

### Worker Applicability

Complex Workers need the same treatment as PM/Advisor when the assigned slice is substantive. The Worker assignment should say whether it is a quick slice or substantive slice and should record expected wait/recheck behavior.

### No Automation

This change documents lifecycle discipline only. It does not add timers, polling automation, runtime session management, or automatic agent cleanup.
