## Context

`multi-agent-working-group` already tells the Leader to avoid hidden Worker
execution, manage context rollover, and report evidence-based closeout. In real
use, two gaps remain:

- End-of-task role cleanup can happen in a confusing order or be attempted in
  parallel, which makes cleanup failures hard to interpret.
- The Leader can still perform too much substantive work before dispatching a
  bounded Worker, growing the main context and weakening role separation.

The change is protocol-only. It tightens documentation, templates, and local
validation anchors. It does not add runtime enforcement or automatic agent
management.

## Goals / Non-Goals

**Goals:**

- Define sequential role-agent cleanup and prevent parallel close operations.
- Clarify that cleanup failure is non-blocking only when delivery evidence and
  required gates are already confirmable.
- Make cleanup failure blocking when it prevents verification of task, git,
  validation, secret-safety, authorization, or required role evidence.
- Add a Leader direct-work self-check trigger so Medium, Complex,
  OpenSpec-backed, multi-file, or context-heavy work is delegated earlier.
- Add Worker-first context-control guidance and template fields that keep
  Worker prompts narrow and Worker returns compact.
- Add validation anchors for the new discipline.

**Non-Goals:**

- No automatic cleanup, automatic agent spawning, or automatic close ordering.
- No automatic diff-size measurement.
- No new commit, push, tag, release, deployment, or publication authorization.
- No weakening of PM/Advisor, Reviewer, validation, secret-scan, CI/status, or
  Owner-only default-exclusion gates.
- No change to model-routing or provider-separation rules.

## Decisions

1. Treat cleanup discipline as a new capability.

   Cleanup/close behavior is not currently covered as its own skill capability.
   Creating `agent-cleanup-discipline` keeps the new fail-open carve-out narrow:
   cleanup means role-agent teardown or lifecycle hygiene only, never delivery
   correctness.

2. Keep the Leader work budget as a self-check trigger, not a hard correctness
   gate.

   A numeric threshold such as more than 2 files or roughly 80 diff lines is
   useful as an early stop signal, but local validation cannot measure or
   enforce it and the threshold will have legitimate exceptions. The hard rule
   is that Leader must dispatch a Worker or record a concrete exception when
   direct work grows beyond small connective edits.

3. Require gate-bearing roles to remain open until their gate is complete.

   Sequential cleanup normally closes Worker, Reviewer, PM, then Advisor, but
   that order cannot close a role still needed to evaluate a gate or cleanup
   impact. The role-needed-for-gate exception is a hard boundary.

4. Validate anchor presence, not runtime compliance.

   `scripts/validate-local.sh` remains a lightweight read-only check. It should
   verify that the protocol text, templates, and docs keep the new rules visible
   and consistent. It must not claim that a past task actually followed those
   rules.

## Risks / Trade-offs

- [Risk] Cleanup failure could be misused as a broad excuse to ignore real gate
  failures. -> Mitigation: define cleanup narrowly and list the gates it never
  covers.
- [Risk] Numeric Leader budget thresholds could block harmless mechanical edits.
  -> Mitigation: make the threshold a self-check trigger that allows a recorded
  exception.
- [Risk] Sequential cleanup adds small overhead at task close. -> Mitigation:
  scope it to role-agent cleanup in multi-agent tasks; Small Task Mode has no
  PM, Worker, or Reviewer cleanup.
- [Risk] Worker-first guidance could cause excessive delegation for tiny tasks.
  -> Mitigation: apply it to Medium, Complex, OpenSpec-backed, multi-file, or
  context-heavy work, not narrow low-risk edits.
