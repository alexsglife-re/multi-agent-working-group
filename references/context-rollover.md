# Context Rollover And Handoff Reference

This file extends `SKILL.md`. It cannot weaken `SKILL.md`, cannot override `SKILL.md`, and grants no authorization by itself. If this file conflicts with `SKILL.md`, project rules, or Owner instructions, use the stricter rule.

Read this reference before context rollover, handoff, successor startup, continuity recovery, or relying on prior state.

## Leader Context Control

For long-running or spec-bound work, the Leader should treat context size as an explicit state to manage. Project rules may provide a named protocol such as `Leader Context Control V0.3`; when present, follow that stricter project protocol.

Leader state compaction:

```text
For long-running, spec-bound, or cross-conversation work, active Leader state should be layered:

Current state card:
  The single active takeover entry point. It records the compact current truth:
  owner instruction, current goal, scope and non-goals, stage or C-stage,
  archive requirement, gate state, PM/Advisor/Reviewer continuity, unresolved
  disagreements and P0/P1, validation run and not run, validation freshness,
  changed and do-not-touch files, next action, stop conditions, and commit/push
  authorization state.

Evidence index:
  Claim-indexed pointers to the evidence behind the current state. Each key
  claim should map to the evidence type, evidence location or command, freshness
  or current/stale status, and whether Leader has verified it. Evidence may
  include validation commands and results, diffs or file lists, commits,
  PM/Advisor/Reviewer outputs, Worker returns, decision records, old handoffs,
  and archived notes.

Historical archive notes:
  Completed stage detail, superseded handoff narrative, long logs, full command
  output, complete diffs, and old agent outputs that should remain reachable but
  should not stay in the active handoff body.
```

Active handoff or ledger updates should be refreshed around the current state card rather than maintained as append-only narrative. The current state card must not push required gate facts into "see evidence index"; the index explains why the current state is believed, but the state card remains the entry point for current action. When an old handoff is used, summarize the verified current truth and reference the old handoff as evidence instead of copying it forward verbatim.

Compaction must not remove unresolved P0/P1, owner-decision needs, PM/Advisor/Reviewer findings, validation freshness, changed and do-not-touch files, stop conditions, or git authorization state. It also must not convert old handoffs, archive notes, summaries, or evidence indexes into authority for commit, push, scope expansion, gate bypass, or external effects.

Generic ContextBudget states:

```text
Normal
Soft Warning
Rollover Opportunity
ContextBudget Watch
Rollover Recommended
Rollover Strongly Recommended
Rollover Required
```

Every context-budget check must record exactly one canonical ContextBudget state. When multiple triggers apply, use the highest applicable state. ContextBudget states are continuity and safety signals only. They never authorize deployment, release, external publication, secret or credential access, destructive commands, schema/security/authentication/permission changes, force-push, history rewrite, automatic successor thread creation, automatic agent spawning, role-session registry changes, delivery-queue changes, or product runtime behavior changes.

Within the same verified workstream, normal non-high-risk commit, push, CI/status, and archive progression may continue when PM and Advisor agree, no unresolved P0/P1 remains, required Reviewer approval has passed when applicable, validation is fresh, target scope is clear, and existing git, CI, archive, and secret-scan gates pass. Rollover or successor packets do not carry that authorization into a successor context without fresh verification.

Use context-budget triggers as evidence-control signals:

```text
Soft Warning:
  Long stage, long PM/Advisor/Worker return, large tool output,
  oversized current ledger snapshot, or repeated long returns.

ContextBudget Watch:
  3-4 observed compressions/summaries, repeated old-context lookup,
  accumulated long returns, or active ledger nearing its budget.

Rollover Opportunity:
  A clean boundary plus a heavier next step. Examples include an OpenSpec
  C-stage completing before a new or longer C-stage; a validated implementation
  slice before dispatching a new Worker; refreshed current-state card and
  evidence index before commit, push, CI, archive, or a new OpenSpec change;
  Owner-reported compression undercount plus a heavier next stage; or dashboard
  growth that remains reconcilable but should be summarized before continuing.

Rollover Recommended:
  5-6 observed compressions/summaries, 7 observed compressions/summaries with
  a stronger action note, multiple large stage steps, owner context-length
  concern, new Worker dispatch from long context, or ledger still too large
  after refresh.

Rollover Required:
  Leader cannot reliably verify current git/spec/validation/PM/Advisor/
  Reviewer/Worker/authorization state; state conflicts cannot be resolved
  from current evidence; high-risk gate is next and ledger is stale;
  state confusion appears; owner requests a new Leader; or owner says
  context length is affecting quality.
```

Compression or summary counts are weak signals. Platform-visible summaries are evidence of what the Leader can see, not proof of actual total compactions. The Leader must not claim an actual compression count from visible summaries alone. If the Owner reports a higher actual compression count, record it as Owner-reported evidence and lower confidence in platform-visible counts. If the Owner reports a concrete compression or summary count, treat that number as Owner-reported threshold evidence for canonical state selection; do not downgrade a numeric Owner-reported threshold to `Rollover Opportunity` when a higher threshold state applies. The hard trigger is loss of reliable current-state verification, unsafe continuation signs, owner instruction, or stale ledger before a high-risk gate.

Leader Rollover Protocol:

```text
For v0.4.6 and later, rollover handling means automatic detection and
automatic handoff preparation, not automatic successor conversation creation.
The Leader may identify rollover conditions, refresh current state, organize
the evidence index, and prepare a successor startup packet. The Leader must not
silently create or rely on a new conversation, carry forward git authorization,
or bypass current verification gates.
```

Context-budget record:

```text
For long-running, spec-bound, or cross-conversation work, record this compact
state in the current state card, compact handoff, ledger, or successor packet
when context pressure is visible:

Context budget state:
Compression count value:
Compression count source: platform-visible | owner-reported | inferred | unknown
Compression count confidence: high | medium | low | unknown
Additional compression count evidence:
Last context-budget check:
Reason for current state:
Next safe rollover boundary:
Rollover action:
```

If the compression or summary count is unknown, record `unknown` instead of inventing a number. Unknown count plus unreliable current-state verification is `Rollover Required`.

Observed compression/summary thresholds:

```text
0-1 observed compressions/summaries:
  State: Normal or Soft Warning.
  Action: refresh current state card when useful; do not recommend rollover
  from count alone.

2 observed compressions/summaries:
  State: Soft Warning.
  Action: record observed count; do not recommend rollover from count alone.

Clean boundary plus heavier next step:
  State: at least Rollover Opportunity.
  Action: refresh current-state card and evidence index; update a lightweight
  successor packet skeleton when useful; report the next safe rollover
  boundary. Do not treat this as an immediate recommendation by itself.

3-4 observed compressions/summaries:
  State: ContextBudget Watch.
  Action: record context budget and organize the evidence index; do not
  proactively recommend rollover from count alone.

5-6 observed compressions/summaries:
  State: Rollover Recommended.
  Action: recommend switching at the next safe boundary.

7 observed compressions/summaries:
  State: Rollover Recommended.
  Action: treat as a strong recommendation; finish only a near-complete small
  step when safe; otherwise prepare a successor packet.

8 or more observed compressions/summaries:
  State: Rollover Strongly Recommended.
  Action: prepare a successor packet unless a very small current step can
  finish immediately.

6 or more observed compressions/summaries plus a next action of Worker
dispatch, commit, push, CI, archive, or a high-risk gate:
  State: Rollover Required.
  Action: enter sealed-ready and hand off before that gate.

Unknown count plus inability to reliably verify current git/spec/validation/
PM/Advisor/Reviewer/Worker/authorization state:
  State: Rollover Required.
  Action: hand off using the successor protocol.
```

When thresholds and other triggers overlap, use the highest applicable state.

Safe rollover boundaries:

```text
Preferred:
  OpenSpec C-stage boundary.
  Implementation slice complete and validation run.
  Commit/push/post-review flow fully complete.
  Before dispatching a new Worker.
  After current state card and evidence index are refreshed.

Avoid:
  Mid-patch.
  While a command or validation is still running.
  Between commit/push execution and required post-review or CI/status evidence.
  With unresolved P0/P1 unless the rollover is a blocked handoff.
```

When `Rollover Required` applies, the current Leader should enter `sealed-ready` behavior for the affected workstream: update ledger or handoff state, keep one active current-state card, list takeover verification requirements, generate a successor startup packet, and report the safe next step. If a newer successor packet replaces an older one, the older packet becomes historical evidence. The Leader should not dispatch new Workers, accept new Worker results for the handed-off workstream, enter commit/push/CI/archive gates, or execute external-effect actions until reliable takeover verification is restored. This is a development-workflow self-restriction only; it does not create or modify product runtime role sessions, delivery queues, handoff readiness, or successor conversations.

When `Rollover Recommended`, `Rollover Strongly Recommended`, or `Rollover Required` applies, prepare a complete successor packet unless a very small current step can safely finish first. `Rollover Opportunity` by itself requires a current-state and evidence refresh; it only requires a complete successor packet when the Owner requests handoff or another higher state also applies.

## Handoff

Cross-conversation handoff is continuity evidence, not authority.

Minimum handoff packet:

```text
Date/time
Current goal
Scope and non-goals
Completed and incomplete work
Context budget state
Compression count value
Compression count source
Compression count confidence
Additional compression count evidence, if any
Rollover reason and action, if any
Next safe rollover boundary, if any
PM/Advisor consensus, if any
Unresolved disagreements
Spec-workflow state
OpenSpec C-stage and archive requirement, if applicable
Git branch / commit / dirty state
PM model/provider and PM/Advisor model separation status
Advisor model/provider and model diversity status
CLI agent workspace-trust status
Changed and do-not-touch files
Validation run and not run
Risk level
Task status dashboard, if relevant
Pending messages, conflicts, and overlaps, if relevant
Next recommended action
Stop conditions
Commit/push authorization state, default no
```

For long-running or spec-bound work, the handoff packet should be the current state card, not an append-only transcript. If more detail is needed, add an evidence index with claim-to-evidence mappings, paths, commands, commits, freshness status, verification status, or archive-note references. Old handoffs may be listed as evidence, but their text should not be repeatedly copied into the active packet unless a narrow excerpt is required to explain an unresolved blocker.

Successor startup packets should also include a takeover checklist. A successor Leader must verify current owner instruction, git state, OpenSpec state, validation freshness, PM/Advisor/Reviewer continuity, Worker state, unresolved P0/P1, and authorization state before continuing. Task-status dashboards, pending messages, conflicts, and overlaps are compact takeover aids only; they do not create authority.

New conversations must re-read project instructions, memory, handoff material, git/spec/current evidence, and restart PM + Advisor continuity review when available.
