---
name: multi-agent-working-group
description: Use when a user asks to coordinate multiple agents, PM/advisor/worker/reviewer roles, Claude or external advisor review, delegated implementation, independent verification, controlled commit/push authorization, or cross-agent handoff in a development task.
---

# Multi-Agent Working Group

## Overview

Use this skill to run a guarded, evidence-based multi-agent workflow. The Leader remains responsible for orchestration, verification, owner communication, and git exits; other agents provide scoped work or independent critique.

Project `AGENTS.md`, memory, spec workflow, security, legal, or owner instructions may only tighten this skill. Do not use this skill to weaken a project-specific gate. Read only the current project's local rule files; do not import another project's protocol, memories, or handoff documents unless the owner explicitly asks for that cross-project reference.

## Advisor Minimum Permissions

Using this skill means the owner has approved Advisor agents to read the local evidence needed for the current task's project, in any project where this skill is used.

This default approval is limited to the minimum necessary review context:

```text
Allowed by default for Advisor review:
  Read current-project files relevant to the assigned scope.
  Read local project instructions, handoff/continuity files, specs, tests, config, and docs relevant to the assigned scope.
  Read global memory and skill files needed to apply stable owner/project rules.
  Run or receive non-mutating discovery output such as rg, find, ls, read-only sed, nl, wc, git status, git diff, git log, git show, git branch, git rev-parse, and git ls-files.
  Inspect existing validation, CI, test, spec-workflow, secret-scan, or review evidence when needed for the assigned gate.
```

This default approval does not authorize broad access or mutation:

```text
Not allowed by default:
  File writes, edits, deletes, moves, formatters, code generation, or apply_patch.
  git add, commit, push, merge, rebase, tag, release, or branch publication.
  Deployment, external publication, network calls, production access, or irreversible external effects.
  Reading secrets, credentials, tokens, private keys, browser data, unrelated personal directories, or unrelated projects.
  Broad context dumping to external advisors beyond the minimum evidence needed for the role.
```

If an Advisor cannot read the minimum local evidence, record Advisor as blocked or degraded. Do not fabricate review conclusions from memory or summaries alone. For commit/push-bound, code, medium, complex, high-risk, permission/API/database/architecture, or security work, missing required Advisor evidence fails closed unless the owner explicitly approves a narrower degradation.

## Startup Checklist

Before dispatching agents:

1. Read project instructions and memory required by the current repo.
2. Classify the task risk.
3. Check whether spec workflow, security, code-intelligence/impact-analysis, TDD, review, or other project skills apply.
4. Decide whether multi-agent work is truly useful for this task.
5. Record the owner authorization state; default to no commit/push authorization.
6. When an owner decision is needed, plan to explain it in plain, non-specialist language: what was done, what the decision affects, and why the decision is needed. For commit/push decisions, describe what the stage completed without extra impact analysis unless the owner asks.
7. Once the owner gives a work goal, keep progressing until the goal is complete by default, unless an owner decision, explicit authorization, risk gate, failed validation, unresolved P0/P1, unavailable required reviewer/advisor, or irreversible external-effect gate requires stopping. Do not use progress pressure to downgrade risk/scope classification, skip the project's spec workflow, enter Small Task Mode, or bypass gates.
8. For workstreams that use this skill together with OpenSpec, start with C0 Goal Analysis before creating or applying OpenSpec artifacts. Record the owner goal, risk, active changes, required skills, model routing, CLI agent workspace-trust needs, Advisor trust/model state, and whether completion includes archive.

Small Task Mode:

```text
If Leader explicitly records that the task is small low-risk, that neither the project's spec workflow nor the full multi-agent-working-group workflow is required, and that independent Worker ownership is not required, Leader may complete the work directly.
Small Task Mode uses no PM, no Worker, and no Reviewer.
This does not bypass project instructions, memory, code-intelligence or impact-analysis checks, validation, dirty-worktree protection, or owner authorization rules.
Small Task Mode is a narrow execution exception only; it does not authorize unilateral commit/push, weaken Git Exit Rules, or permit default exclusions.
Leader direct execution must stay narrow, explicit, and low-risk, and must be reported as Leader direct execution rather than hidden Worker execution.
Commit and push are separate checkpoints: before commit and before push, Advisor review is still required and the Git Exit Rules below apply.
Advisor may reject the Small Task Mode classification during commit/push review. Advisor review must follow the existing independence standard and must not rely on Leader self-assessment as a substitute for independent review.
If Advisor is unavailable, commit/push-bound Small Task Mode work fails closed unless owner explicitly approves a narrower degradation.
Medium or higher work must not be performed by Leader as hidden Worker execution. If scope becomes medium/complex/high-risk, spec-workflow-required, touches a default exclusion, needs independent Worker ownership, or receives unresolved P0/P1 Advisor objection, exit Small Task Mode and use the stricter required workflow.
Progress-to-completion pressure must not downgrade risk/scope classification, skip the project's spec workflow, enter Small Task Mode, or bypass any gate. When classification is uncertain, use the stricter workflow.
```

Default roles:

```text
Owner
  -> Leader
      -> PM Agent
      -> Advisor Agent
      -> Worker Agent(s), when implementing
      -> Reviewer Agent, when required
```

Default launch:

```text
Small/medium/complex task: PM + Advisor
Code implementation task: PM + Advisor + Reviewer
Security/permission/API/database/architecture/high-risk task: PM + Advisor + Reviewer
```

Advisor model diversity:

```text
Default:
  Advisor defaults to a different AI model than Leader, PM, Worker, or Reviewer when model selection is available.
  Prefer a different provider or model family when practical; at minimum, record the concrete Advisor model/provider used.
  Explicit Owner instruction overrides this default. If the Owner requests same-model Advisor use, record it as an explicit same-model override and do not claim model diversity was satisfied.
  If a different Advisor model is unavailable, record model-diversity degradation and follow the existing Advisor-unavailable or degradation rules for the task risk and gate.

Startup:
  At workstream or session startup, if no project, session, continuity, or handoff record identifies the Advisor model/provider, ask the Owner to specify the Advisor model/provider before treating Advisor model selection as settled.
  Record Advisor model/provider, diversity status, same-model override if any, and degradation reason if any.

Trust and bounds:
  When the Owner explicitly assigns Claude or another model/tool as Advisor, treat that Advisor as a trusted Advisor role for necessary bounded project/task context, not as an ordinary third-party disclosure.
  The main AI Agent App must not treat an Owner-specified Advisor as an ordinary external third-party service for the current workstream. Necessary bounded task context may be sent to the Advisor role.
  This does not authorize secrets, credentials, unrelated projects, broad context dumps, or irrelevant data unless the Owner explicitly names that scope.
  Model diversity reinforces critique diversity only; it does not replace no-peek independence, PM/Advisor consensus, Leader verification, Reviewer requirements, validation, or unresolved P0/P1 stop conditions.
```

PM/Advisor model separation:

```text
Default:
  PM and Advisor default to different AI models when model selection is available.
  Prefer different provider or model family separation when practical.
  The Leader must record PM model/provider, Advisor model/provider, separation status, and any override or degradation reason when the workstream uses both roles.

Same-model pairing:
  The Leader must not automatically degrade PM and Advisor to the same AI model.
  Same-model PM/Advisor pairing requires explicit Owner approval and must be recorded as a same-model PM/Advisor override.
  If PM/Advisor model separation is unavailable and the Owner has not approved same-model pairing, commit/push-bound, OpenSpec-backed, small, medium, complex, high-risk, code, permission/API/database/architecture, or security work fails closed.
  Do not claim PM/Advisor independence was strengthened by model diversity when same-model pairing was used.
```

CLI agent workspace trust:

```text
Applies when Claude CLI, Codex CLI, or another CLI-based agent is assigned as PM, Advisor, Worker, Reviewer, or another role.

Preflight:
  Before relying on a CLI agent, confirm it can read the exact current project workspace under the intended role.
  A minimal read-only probe is enough when available, such as asking the CLI agent to identify the project path or inspect a non-sensitive project file.
  If the CLI reports an untrusted workspace, blocked project, or similar trust prompt, check whether an Owner-recorded CLI role assignment authorizes current-project trust setup before recording a blocker.

Owner-recorded role authorization:
  If a current Owner instruction, global memory, project rule, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence records that the Owner assigned Claude CLI, Codex CLI, or another CLI-based agent to a PM, Advisor, Worker, Reviewer, or other role for the current project and workstream, the Leader may treat current-project workspace trust setup as Owner-authorized for that assigned CLI role.
  The Leader must verify that the authorization source applies to the exact current project and workstream before relying on it.
  Stale, historical-only, superseded, or mismatched role records do not authorize workspace trust setup.
  The Leader should not ask the Owner again merely because the assignment was recorded in memory, project rules, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence instead of the current message.

Trust setup:
  For an Owner-recorded CLI role assignment in the current project, trusting the exact current project workspace is a normal setup step for that role.
  The Leader may perform or confirm workspace trust setup for the exact current project root without asking the Owner again when the Owner-recorded role authorization applies.
  The Leader must record the authorization source, assigned role, target project root, trust setup action, and probe result.
  Keep trust scoped to the current project workspace only.
  Do not trust parent directories, home directories, all repositories, unrelated directories, or unrelated projects unless the Owner explicitly approves that wider action.
  Do not use dangerous permission-bypass flags, broaden file access, expose secrets, read credentials, read browser data, change global tool policy, perform git actions, run CI, deploy, release, publish, or create external effects unless the Owner explicitly approves that separate action.
  After trust setup, rerun a minimal read-only probe before using the CLI agent's output as evidence.

Trust states:
  Use this compact state vocabulary when recording CLI workspace trust:
    not-needed
    preflight-needed
    owner-recorded-role-authorized
    trust-setup-attempted
    trusted-verified
    blocked
  Use `owner-confirmation-needed` only when the trust target is outside the current project root, the authorization source is stale or missing, the tool requires dangerous permission bypass, secret access, unrelated directory access, global policy changes, git actions, CI, deployment, release, publication, or another external effect.
  Record `trusted-verified` only after the post-setup read-only probe succeeds.

Failure:
  Do not mark the role unavailable, silently switch models, reuse stale Advisor output, or degrade PM/Advisor separation merely because workspace trust is blocked.
  Stop at the applicable gate and report what trust step is needed in plain language.
```

Agent lifecycle:

```text
Default: keep PM and Advisor open until the current complete stage goal finishes.
Spec-workflow lifecycle default: keep the same PM and Advisor from proposal/opening through archive when practical.
For spec-bound workstreams, "complete stage goal" usually means the whole spec lifecycle through C4/archive, not merely artifact drafting, validation, commit, push, or CI.
Close or restart agents at a stage boundary, long owner pause, context overload, role/risk change, or suspected drift.
When restarting, provide a compact evidence packet; do not treat the prior agent's memory as authority.
```

Continuity is not the same as repeated review. For a scoped multi-agent workstream, especially a spec-bound lifecycle, the Leader must maintain PM and Advisor continuity as explicit state:

```text
PM identity / role instance
Advisor identity / role instance
Advisor model/provider
Advisor model diversity status: different-model, same-model override, degraded, or unavailable
Reason for same-model override or degradation, if any
Lifecycle start point
Current stage or C-stage
Continuity memory or handoff file used, if any
Continuity status: intact, restarted, degraded, or unavailable
Reason for any restart, degradation, or unavailability
```

For spec-bound workstreams, treat PM/Advisor continuity as strict by default:

```text
Keep the same PM and Advisor from initial analysis/proposal through C4/archive completion.
Do not close or restart them merely because C1, C1.6, C2, C3, validation, commit, push, or CI completed.
A stage boundary alone is not enough reason to close them when the next stage belongs to the same spec-bound lifecycle.
Close only after C4/archive completion, an explicit owner-approved boundary, long pause, context overload, tool/usage boundary, role/risk change, or suspected drift.
```

A newly launched PM or Advisor after interruption is a restarted agent, not the same uninterrupted agent. The Leader must not present restarted or one-shot review as uninterrupted lifecycle continuity.

When continuity breaks:

```text
Record the break plainly.
Provide a compact evidence packet to the restarted agent.
Require the restarted PM/Advisor to perform continuity recovery review.
Label later consensus as restarted continuity or degraded continuity, not uninterrupted continuity.
```

For git-specific stages, keep the relevant Advisor available across the pre-commit review, commit execution, post-commit review, push authorization request, push execution, CI check, and post-push/CI review when the work stays within the same stage.

If the owner explicitly assigns roles differently, for example Claude Code CLI as PM/Worker and Codex as Advisor, honor that assignment while preserving all boundaries and gates.

Goal completion:

```text
When the Owner asks the Leader to complete a goal, treat completion as all goal-related work through the normal closeout path:
  required validation,
  required PM/Advisor/Reviewer review,
  commit when covered by the applicable gate,
  push when covered by the applicable gate,
  status or CI check when available or required,
  post-commit and post-push PM/Advisor review,
  OpenSpec archive and archive validation when the goal is OpenSpec-backed.

Stop before full completion only for an Owner decision, explicit authorization need, failed validation, unresolved P0/P1, missing required role, workspace-trust blocker, high-risk/default-exclusion gate, tool failure that cannot be safely retried, or another concrete blocker.
Do not stop merely because implementation, validation, commit, push, or C3 closeout finished if C4/archive still belongs to the same goal.
```

OpenSpec lifecycle integration:

```text
Use this sequence whenever this skill and OpenSpec are both active for a workstream:

C0 Goal Analysis:
  Confirm owner goal, current task, active OpenSpec changes, risk tier, applicable skills, PM/Advisor model routing, PM/Advisor model separation, CLI agent workspace-trust needs, Advisor trusted-context boundary, git state, validation expectations, and completion target including archive.

C1 Proposal:
  Create or update proposal, design when needed, spec deltas, and tasks.
  PM and Advisor review scope before implementation.

C2 Implementation:
  Make the documentation or code changes, run required validation, and keep tasks current.

C3 Closeout:
  Complete required review, commit, push, status or CI checks, and post-push review when the applicable gates pass.

C4 Archive:
  Archive the OpenSpec change, validate the archived spec state, commit and push the archive when the applicable gates pass, and complete post-push review.

Do not skip C0, and do not treat C3 as final completion when C4 applies.
```

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

## Risk and Severity

Use the higher tier when uncertain.

| Tier | Meaning |
| --- | --- |
| Small low-risk | Read-only work, narrow docs/copy/style/config, or isolated tests with no approved-behavior, permission, data, persistence, external-effect, or git-remote change. |
| Medium | Multi-file docs/tests, contained bug fixes, local tooling, or work needing multiple evidence sources without high-risk areas. |
| Complex | New user-visible workflow, architecture/module boundary, cross-layer work, public API, external integration, or spec-bound change. |
| High-risk | Security, permission, auth, approval/sandbox, credentials, payment/account/wallet, schema/persistence, destructive/irreversible operation, external publication, release/tag/protected-branch bypass or exception, force-push/history rewrite, or unresolved P0/P1. |

Severity:

| Severity | Gate |
| --- | --- |
| P0 | Stop immediately: likely data loss, secret exposure, unauthorized commit/push/publication, security bypass, destructive external effect, or broken owner authorization boundary. |
| P1 | Resolve before affected gate: material ambiguity, verification gap, stale/failed validation, missing required Reviewer, unclear git target/scope, or medium/high-risk disagreement. |
| P2 | Record and continue when safe: clarity, polish, follow-up, or non-blocking improvement. |

## Role Boundaries

Leader:

- Own orchestration, synthesis, verification, and communication with owner.
- Verify agent outputs against canonical evidence.
- Never treat agreement as proof.
- Explain owner decisions in plain language, especially for non-specialist owners: what was done, what the decision affects, and why the decision is needed. For commit/push, summarize what the stage completed and keep authorization language explicit.
- Never self-authorize commit/push.

PM Agent:

- Own product framing, scope, acceptance criteria, risk classification, and next-action recommendation.
- Produce first-pass analysis independently from Advisor.

Advisor Agent:

- Own critique, risks, counterexamples, stop conditions, and second opinion.
- Produce first-pass analysis independently from PM.
- Treat output as unverified input until Leader verifies it.
- Do not author files or run mutating commands unless owner explicitly assigns a non-advisor role.

Worker Agent:

- Own exactly one slice with a one-sentence acceptance target and explicit file/module scope.
- Do not combine requirement interpretation, architecture judgment, implementation, and review in one assignment.
- Do not expand scope, self-approve, commit, or push.

Leader delegation discipline:

```text
For Medium, Complex, High-risk, implementation-heavy, or substantively
Worker-suitable work, the Leader should dispatch bounded Worker slices instead
of performing hidden Worker execution when practical.

Leader direct work remains appropriate for small low-risk tasks, orchestration,
synthesis, verification, owner communication, narrow documentation
synchronization, tiny connective edits, cases where dispatch overhead clearly
exceeds the work, or when a tool, gate, or Owner instruction makes Worker
dispatch unsuitable.

If the next action is dispatching a new Worker and context is long, degraded,
or at `Rollover Opportunity` or higher, refresh the current-state card and
successor packet skeleton before dispatch when practical.
```

Reviewer Agent:

- Own post-change review and verification.
- Must not review its own implementation.
- High-risk work may use pre-flight review, but pre-flight review does not replace post-change review.

## Startup Packet

Every agent prompt must include only the relevant minimum context:

```text
Project
Role
Current goal
Scope / non-goals
Current owner instruction
Owner authorization state, default no commit/push
Spec-workflow state
OpenSpec C-stage and C0 analysis summary, if applicable
Git branch / commit / dirty state, if relevant
Risk tier and risk notes
PM model/provider and PM/Advisor model separation status, if relevant
Advisor model/provider and model diversity status, if relevant
CLI agent workspace-trust status, if relevant
Goal completion target, including whether archive is required
Applicable skills or checklist requirement
Evidence provided and evidence hierarchy
Readable context
Writable scope, if any
Forbidden scope
Required validation
Expected output format
Stop conditions
Reminder: handoffs, compressed summaries, old consensus, and other agent outputs are hints until Leader verifies them
```

PM additions:

```text
Product goal
Acceptance criteria
Open decisions
Consensus requirements
Owner escalation conditions
Reminder: do not read Advisor conclusions before first pass
Expected output must preserve complete reasoning, option comparison, recommendation, objections, P0/P1/P2 findings, owner-decision needs, and key error details when present
```

Advisor additions:

```text
Claims to challenge
Known assumptions
Required counterexamples / objections
Stop-condition focus
Reminder: do not read PM conclusions before first pass
Reminder: output is unverified until Leader verifies it
Expected output must preserve complete reasoning, option comparison, recommendation, objections, P0/P1/P2 findings, owner-decision needs, and key error details when present
```

PM/Advisor continuity memory:

For long-running or spec-bound work, the Leader should maintain concise PM/Advisor continuity memory when the project has a suitable writable location.

Recommended layers:

```text
Project baseline memory:
  Stable project-level baseline for PM/Advisor startup.
  Records stable rules, current project baseline, standing owner rules, git/CI/spec-workflow conventions, forbidden local noise, and recurring risks.

Workstream continuity file:
  Per-workstream file for an active long-running or spec-bound change.
  Records PM/Advisor identities, lifecycle start, current stage or C-stage, consensus, P0/P1/P2 findings, gate decisions, validation evidence, interruptions, restart packets, and next action.
```

These files are continuity aids, not authority. Reading a continuity file does not make a restarted agent the same uninterrupted agent. Old consensus, handoffs, and continuity files remain evidence for Leader verification, not authorization for commit, push, scope expansion, or bypassing current gates.

When a continuity file or handoff grows large, refresh it into the three-layer compaction structure above. Keep the active state card short and current, move completed or superseded detail to a historical archive note when a safe local storage location exists, and leave evidence references that a successor can re-verify.

Worker additions:

```text
One-sentence task target
Allowed files / modules
Forbidden files / modules
Allowed commands
Implementation context
Impact-analysis result when touching business symbols, if the project requires it
Acceptance target
Required evidence on return
Return must preserve complete result, done/not-done status, changed files, validation, findings, blockers, next action, and key error details
Key error details include command/tool, exit code or exception type, key stdout/stderr, failing file/test/check/step, and retry safety when available
No scope expansion, self-approval, commit, or push
```

Bulky raw material should be summarized and referenced instead of pasted into the Leader conversation when safe local evidence storage exists:

```text
Long logs
Full command output
Full diffs
Large source excerpts
Repeated check output
Long external excerpts
Superseded handoff text
Completed stage narrative
Full agent outputs that are no longer active blockers
```

This evidence limiting must not remove PM/Advisor reasoning, Worker results, findings, recommendations, objections, or key error details.

Reviewer additions:

```text
Artifact or diff to review
Review standard
Severity scale
Known risk areas
No implementation unless reassigned as a separate Worker slice
```

## Consensus Gate

PM and Advisor must independently agree on:

```text
Same goal
Same scope
No major risk-level conflict
Same next action
Same verification method
No unresolved P0/P1 disagreement
```

Low-risk disagreements may be Leader-resolved with recorded rationale. Medium/high-risk disagreements stop for owner confirmation. Any unresolved disagreement before commit/push blocks commit/push prompting or execution.

## Leader Verification Minimum

Before dispatch, acceptance, repair, commit, or push:

1. Restate the current owner instruction and whether it authorizes the next action.
2. Check git branch/base/dirty state and changed files when relevant.
3. Check spec-workflow state when applicable.
4. Check that PM/Advisor outputs were independent or record approved degradation.
5. Check required Reviewer status.
6. Check required validation output and freshness for the current diff.
7. Label key claims as verified, inferred, assumed, or unverified advisor input.
8. Stop at any unresolved P0/P1.

Local validation:

```text
For this repository, v0.4.4 adds `./scripts/validate-local.sh` as the lightweight local
validation command for README/SKILL/OpenSpec/version-marker/installed-skill
checks. Use it when local repository validation is relevant to commit, push,
or OpenSpec closeout.

During active OpenSpec work, the default command may report active changes as
informational. After archive, use `./scripts/validate-local.sh
--require-no-active-changes` when validating closeout.

The command is read-only evidence only. It does not authorize commit, push,
archive, release, deployment, external publication, secret-scan bypass,
Reviewer bypass, PM/Advisor bypass, or any high-risk/default-exclusion action.
```

Copyable templates:

```text
For this repository, v0.4.5 adds copyable templates under `templates/` for
C0 analysis, PM review, Advisor review, Worker assignment, Worker return,
Reviewer report, blocked reports, compact handoffs, and git gates.
v0.4.6 adds Leader Rollover Protocol fields plus
`templates/successor-startup-packet.md` for rollover handoff.
v0.4.7 adds CLI workspace trust setup fields for Owner-recorded role
authorization source, target project root, trust state, and post-setup
read-only probe evidence.
v0.4.8 adds Rollover Opportunity, compression count value/source/confidence,
canonical single-state selection, and Leader delegation discipline.

Use templates as fill-in structure and evidence capture only. A filled template
does not authorize commit, push, archive, release, deployment, external
publication, secret access, PM/Advisor bypass, Reviewer bypass, validation
bypass, CI/status bypass, or high-risk/default-exclusion actions.

When old v0.3-era or otherwise bloated handoff documents already exist, preserve
them as historical evidence. Create a new current state card from
`templates/compact-handoff.md`, copy only facts that are still needed and
currently verified, and reference the old material through the evidence index.
Do not append old handoffs verbatim below the new active handoff, and do not
rewrite old evidence in place merely to match the new template.
```

If owner escalation is required and owner does not respond, enter `blocked-pending-owner`. Do not silently degrade.

## Failure Rules

```text
Advisor unavailable:
  Record absence; do not fabricate advice.
  Small low-risk tasks may degrade with recorded rationale.
  Medium, complex, high-risk, code, permission/API/database/architecture, and commit/push-bound work fail closed unless owner explicitly approves degradation.

PM timeout:
  Retry once; if still failed, ask owner whether to degrade.

Worker failure:
  Review the error before expanding scope.

Reviewer failure:
  Do not enter commit/push state.
```

## Git Exit Rules

PM + Advisor consensus authorizes only normal non-high-risk git exits that satisfy the gates below. It does not authorize default exclusions or any other high-risk action.

```text
Default:
  Do not commit or push unless the applicable gate below passes.
  A one-time owner-named commit or push exception covers only that explicit action.
  PM + Advisor consensus covers only normal non-high-risk git exits and never covers default exclusions.

Small Task Mode:
  Applies only when Leader has recorded that the task is small low-risk, the project's spec workflow is not required, and the full multi-agent workflow is not required.
  Small Task Mode uses no PM, no Worker, and no Reviewer.
  Leader direct execution must be narrow, explicit, low-risk, and reported as Leader direct execution rather than hidden Worker execution.
  Does not create commit or push authorization by itself.
  Before commit, Advisor must independently review the commit-ready scope, including the Small Task Mode classification, and have no unresolved P0/P1 objection. Advisor must not rely on Leader self-assessment as a substitute for independent review.
  After commit, Advisor must review the actual commit result before any push gate can pass.
  Before push, Advisor must review the outgoing scope, including the Small Task Mode classification; required validation must be fresh; available secret/credential scanning over the outgoing diff must pass; and the target remote/branch/ref must be clear.
  After push, Leader must check required CI/status and have Advisor review the push/CI result before reporting final push outcome.
  Small Task Mode never authorizes default exclusions unless the owner explicitly names the exception.
  If Advisor is unavailable, commit/push-bound Small Task Mode work fails closed unless owner explicitly approves a narrower degradation.
  The evidence record must include why the task qualified as Small Task Mode, Advisor review status for each git checkpoint, validation evidence, secret-scan status before push when applicable, and any non-required gate that was not run with the reason. Required gates may not be skipped merely by recording a reason.

Before commit:
  Normal non-high-risk commit may proceed after PM + Advisor consensus, no unresolved P0/P1, required Reviewer approval when applicable, fresh validation, and a clear commit-ready target/scope.
  Small Task Mode does not satisfy the PM requirement and therefore cannot use this normal multi-agent commit gate unless the owner explicitly authorizes a valid exception path.
  Leader should report in plain language that the commit gate passed and why.

After commit:
  PM + Advisor must review the actual commit result before the flow is complete.
  Advisor must review the actual commit result before Leader enters any push gate.
  Leader must report whether Advisor found required changes or cleared the commit for push consideration.

Push:
  Normal non-high-risk push may proceed after PM + Advisor consensus, no unresolved P0/P1, required Reviewer approval when applicable, fresh validation, a clear target remote/branch/ref, and applicable secret/credential scanning over the outgoing diff.
  Normal push to main is covered by this gate when it satisfies these requirements and does not require a protected-branch bypass or exception.
  Small Task Mode does not satisfy the PM requirement and therefore cannot use this normal multi-agent push gate unless the owner explicitly authorizes a valid exception path.
  After push, Leader must check CI/status required by the project. CI scope/full-run decisions follow project rules and may be triggered by Leader under those rules.
  PM + Advisor must review the actual push result before the flow is complete.
  Advisor must review the push result and CI/status evidence before Leader reports final push outcome to the owner.

Controlled preauthorization window:
  Valid only when explicitly granted in the current Leader conversation.
  Must define scope, expiry or turn/stage boundary, target remote/branch/ref, risk ceiling, required validation, and excluded operations.
  PM and Advisor must agree.
  Required Reviewer must pass.
  No unresolved P0/P1 may remain.
  Required validation must pass and remain fresh.
  Before push, run available secret/credential scanning over staged or outgoing diff; suspected secrets block push and escalate to owner.
  Handoff never carries preauthorization forward.
```

Default exclusions unless owner explicitly names the exception:

```text
Protected-branch bypass or exception action
Force-push or history rewrite
Tag/release publication
Deployment or public publication
Credential/secret/security/permission/authentication changes
Schema migration
Destructive operation
Irreversible external effect
```

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

## Output Requirements

Every agent output must include:

```text
Applicable skill(s)
Why each skill applies
Checks performed
If no skill was used, why not
Findings by P0/P1/P2 when reviewing
Evidence used
Recommended next action
```

For PM/Advisor outputs in a continuous lifecycle, also include:

```text
Continuity status: intact, restarted, degraded, or unavailable
Continuity memory or baseline read
Prior consensus or unresolved findings carried forward
Whether this output continues the same lifecycle or is a restarted review
```

Leader final outputs should include what was verified, what remains uncertain, whether any degradation occurred, and whether commit/push is unauthorized, one-time authorized, or covered by a controlled preauthorization window. When asking the owner to decide, use plain language and include what was done, what the decision affects, and why the decision is needed; for commit/push decisions, summarize what the stage completed without extra impact explanation unless requested.
