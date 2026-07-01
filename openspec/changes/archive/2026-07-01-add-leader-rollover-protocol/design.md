# Design: Add Leader Rollover Protocol

## Approach

Add a documentation-only protocol that turns context pressure signals into explicit Leader actions. The protocol remains lightweight: it records context-budget evidence, prepares compact successor packets, and defines sealed-ready behavior, but it does not create or manage Codex threads automatically.

The core rule is:

- Leader may automatically identify rollover conditions.
- Leader may automatically refresh current state, evidence index, and successor packet.
- Leader must not silently create a new conversation, carry forward git authorization, or bypass current verification gates.

## Context-Budget Record

Long-running or spec-bound work should carry a small context-budget record in the current state card, compact handoff, ledger, or successor packet:

```text
Context budget state:
Observed compression/summary count:
Compression count confidence: known / inferred / unknown
Last context-budget check:
Reason for current state:
Next safe rollover boundary:
Rollover action:
```

This record makes the signal visible across platform summaries. If the count is unknown, the Leader records `unknown` rather than inventing a number.

## Thresholds

The thresholds make the existing "multiple" and "many" language operational while avoiding overly frequent interruptions:

- 0-1 observed compressions/summaries: `Normal` or `Soft Warning`; refresh current state card, no rollover suggestion.
- 2 observed compressions/summaries: `Soft Warning`; record the count, no rollover suggestion.
- 3-4 observed compressions/summaries: `ContextBudget Watch`; record context budget and organize evidence index, no proactive rollover suggestion.
- 5-6 observed compressions/summaries: `Rollover Recommended`; recommend switching at the next safe boundary.
- 7 observed compressions/summaries: strong `Rollover Recommended`; finish only a near-complete small step, otherwise prepare a successor packet.
- 8+ observed compressions/summaries: `Rollover Strongly Recommended`; prepare a successor packet unless a very small current step can finish immediately.
- 6+ observed compressions/summaries plus next Worker dispatch, commit, push, CI, archive, or high-risk gate: `Rollover Required`; enter sealed-ready and hand off before that gate.
- Unknown compression count plus unreliable current-state verification: `Rollover Required`; hand off using the successor protocol.

When triggers overlap, the highest applicable state wins.

## Rollover Actions

- `Soft Warning`: Refresh the current state card and avoid append-only narrative.
- `ContextBudget Watch`: Add or refresh the context-budget record and evidence index.
- `Rollover Recommended`: Avoid starting large new work; recommend switching at a safe boundary.
- `Rollover Strongly Recommended`: Prepare the successor packet and finish only a small immediately-completable step.
- `Rollover Required`: Enter sealed-ready; do not dispatch new Workers, accept new Worker results for the handed-off workstream, enter commit/push/CI/archive gates, or execute external-effect actions until takeover verification is restored.

## Safe And Unsafe Boundaries

Preferred rollover boundaries:

- OpenSpec C-stage boundary.
- Implementation slice complete and validation run.
- Commit/push/post-review flow fully complete.
- Before dispatching a new Worker.
- After the Leader has refreshed the current state card and evidence index.

Avoid rollover in the middle of:

- An unfinished patch.
- A running command or validation.
- A commit/push flow whose post-review or CI/status evidence is incomplete.
- An unresolved P0/P1, except as a blocked handoff.

If context has become unreliable before a high-risk or git/CI/archive gate, rollover is required and the successor must re-verify before continuing.

## Successor Packet

The successor packet should combine:

- Current state card.
- Rollover context-budget record.
- Lightweight handoff dashboard: tasks by pending/in-progress/completed/blocked, role continuity, pending messages, conflicts, and overlaps.
- Evidence index.
- Successor verification checklist.

This borrows rule-level ideas from the local reference projects: task states and explicit approval messages from ClawTeam, and compact board summary fields from OpenClaw. It does not copy code, add a dashboard runtime, or introduce automatic agent spawning.

## Legacy Documents

Existing v0.3-era or bloated handoffs remain historical evidence. The Leader creates a new current state card and successor packet, copies only facts that are still needed and currently verified, and references old material in the evidence index with freshness and verification status. Old evidence must not be rewritten or appended verbatim into the active handoff.

## Safety

This change is documentation-only. It must not weaken PM/Advisor, Reviewer, OpenSpec, validation, git, secret-scan, CI/status, or owner authorization gates. ContextBudget states and filled templates remain evidence, never authorization.
