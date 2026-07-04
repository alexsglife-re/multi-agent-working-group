## Why

Long multi-agent work can still grow the Leader context when the Leader performs
substantive execution instead of dispatching bounded Workers. End-of-task agent
cleanup can also be confused with delivery correctness, especially if multiple
agents are closed in parallel or a cleanup error happens after the actual work is
complete.

This change tightens delegation and cleanup discipline without adding runtime
automation or weakening existing fail-closed gates.

## What Changes

- Add sequential agent cleanup rules: role-agent close/cleanup actions are
  sequential, never parallel, and each result is recorded before the next close.
- Define cleanup/close narrowly as agent teardown or lifecycle hygiene, not
  validation, PM/Advisor/Reviewer gates, git actions, CI/status, secret scanning,
  release gates, or authorization checks.
- Allow final closeout to proceed after cleanup failure only when delivery
  evidence and required gates are already confirmable and unaffected.
- Escalate cleanup failure to blocking severity when it prevents confirming task
  state, git state, validation, secret safety, authorization state, or required
  role evidence.
- Strengthen Leader delegation discipline for Medium, Complex, OpenSpec-backed,
  multi-file, or context-heavy work.
- Treat the `2 files / ~80 diff lines` Leader work budget as a self-check
  trigger that requires Worker dispatch or a recorded exception, not as an
  automatic correctness failure.
- Add Worker-first context-control guidance so bounded Worker slices are
  dispatched before context pressure becomes a rollover problem.
- Update templates and validation anchors so cleanup status and delegation
  boundaries remain visible in closeout.

## Capabilities

### New Capabilities

- `agent-cleanup-discipline`: sequential role-agent cleanup, non-blocking
  cleanup failure boundaries, and cleanup status reporting.

### Modified Capabilities

- `role-boundary-stabilization`: strengthen Leader direct-work limits and
  prevent hidden Worker execution from growing beyond small connective work.
- `leader-rollover-protocol`: connect Worker-first delegation to context control
  before rollover pressure becomes high.
- `copyable-role-templates`: add cleanup status fields and delegation/cleanup
  reminders to role and closeout templates.
- `local-validation-tool`: add anchor checks for cleanup discipline, Leader work
  budget guidance, Worker-first context control, and cleanup status templates.

## Impact

- Affects `SKILL.md`, `references/role-templates-and-output.md`,
  `references/context-rollover.md`, `references/TRACEABILITY.md`, templates,
  `docs/VALIDATION.md`, `scripts/validate-local.sh`, `CHANGELOG.md`,
  `README.md`, and `docs/TODO.md` during implementation.
- Does not add runtime automation, automatic agent spawning, automatic cleanup,
  automatic diff-size measurement, new model-routing rules, or new git/release
  authorization.
- Does not weaken PM/Advisor, Reviewer, validation, OpenSpec, git, release,
  secret-scan, CI/status, or Owner-only default-exclusion gates.
