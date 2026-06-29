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

Small Task Mode:

```text
If Leader determines that the task is small low-risk and that neither the project's spec workflow nor the full multi-agent-working-group workflow is required, Leader may complete the work directly.
This does not bypass project instructions, memory, code-intelligence or impact-analysis checks, validation, dirty-worktree protection, or owner authorization rules.
Small Task Mode is a narrow execution exception only; it does not authorize unilateral commit/push, weaken Git Exit Rules, or permit default exclusions.
Commit and push are separate checkpoints: before commit and before push, Advisor review is still required and the Git Exit Rules below apply.
Advisor may reject the Small Task Mode classification during commit/push review. Advisor review must follow the existing independence standard and must not rely on Leader self-assessment as a substitute for independent review.
If Advisor is unavailable, commit/push-bound Small Task Mode work fails closed unless owner explicitly approves a narrower degradation.
If scope becomes medium/complex/high-risk, spec-workflow-required, touches a default exclusion, or receives unresolved P0/P1 Advisor objection, exit Small Task Mode and use the stricter required workflow.
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

## Leader Context Control

For long-running or spec-bound work, the Leader should treat context size as an explicit state to manage. Project rules may provide a named protocol such as `Leader Context Control V0.3`; when present, follow that stricter project protocol.

Generic ContextBudget states:

```text
Normal
Soft Warning
ContextBudget Watch
Rollover Recommended
Rollover Required
```

When multiple triggers apply, use the highest applicable state. ContextBudget states are continuity and safety signals only. They never authorize commit, push, CI, deployment, release, external publication, secret or credential access, destructive commands, schema/security/authentication/permission changes, force-push, history rewrite, automatic successor thread creation, role-session registry changes, delivery-queue changes, or product runtime behavior changes.

Use context-budget triggers as evidence-control signals:

```text
Soft Warning:
  Long stage, long PM/Advisor/Worker return, large tool output,
  oversized current ledger snapshot, or repeated long returns.

ContextBudget Watch:
  Multiple compressions/summaries, repeated old-context lookup,
  accumulated long returns, or active ledger nearing its budget.

Rollover Recommended:
  Many compressions/summaries, multiple large stage steps,
  owner context-length concern, new Worker dispatch from long context,
  or ledger still too large after refresh.

Rollover Required:
  Leader cannot reliably verify current git/spec/validation/PM/Advisor/
  Reviewer/Worker/authorization state; state conflicts cannot be resolved
  from current evidence; high-risk gate is next and ledger is stale;
  state confusion appears; owner requests a new Leader; or owner says
  context length is affecting quality.
```

Compression or summary counts are soft hints. The hard trigger is loss of reliable current-state verification, unsafe continuation signs, owner instruction, or stale ledger before a high-risk gate.

When `Rollover Required` applies, the current Leader should enter `sealed-ready` behavior for the affected workstream: update ledger or handoff state, list takeover verification requirements, generate a successor startup packet, and report the safe next step. The Leader should not dispatch new Workers, accept new Worker results for the handed-off workstream, enter commit/push/CI/archive gates, or execute external-effect actions until reliable takeover verification is restored. This is a development-workflow self-restriction only; it does not create or modify product runtime role sessions, delivery queues, or handoff readiness.

## Risk and Severity

Use the higher tier when uncertain.

| Tier | Meaning |
| --- | --- |
| Small low-risk | Read-only work, narrow docs/copy/style/config, or isolated tests with no approved-behavior, permission, data, persistence, external-effect, or git-remote change. |
| Medium | Multi-file docs/tests, contained bug fixes, local tooling, or work needing multiple evidence sources without high-risk areas. |
| Complex | New user-visible workflow, architecture/module boundary, cross-layer work, public API, external integration, or spec-bound change. |
| High-risk | Security, permission, auth, approval/sandbox, credentials, payment/account/wallet, schema/persistence, destructive/irreversible operation, external publication, release/tag/protected branch, force-push/history rewrite, or unresolved P0/P1. |

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
Git branch / commit / dirty state, if relevant
Risk tier and risk notes
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

Agreement is not authorization.

```text
Default:
  One-time commit authorization covers only the current explicit commit action.
  One-time push authorization covers only the current explicit push action.

Small Task Mode:
  Applies only when Leader has recorded that the task is small low-risk, the project's spec workflow is not required, and the full multi-agent workflow is not required.
  Leader may complete the task directly without PM or Worker dispatch.
  Does not create commit or push authorization by itself. Because Small Task Mode has no PM participation, it cannot use any standing multi-agent commit/push gate that requires PM agreement; commit or push authorization must come from current explicit owner authorization or a valid controlled preauthorization window.
  Any controlled preauthorization window must still satisfy all required window conditions and exclusions.
  Before commit, Advisor must independently review the commit-ready scope, including the Small Task Mode classification, and have no unresolved P0/P1 objection. Advisor must not rely on Leader self-assessment as a substitute for independent review.
  After commit, Advisor must review the actual commit result before any push gate can pass.
  Before push, Advisor must review the outgoing scope, including the Small Task Mode classification; required validation must be fresh; available secret/credential scanning over the outgoing diff must pass; and the target remote/branch/ref must be clear.
  After push, Leader must check required CI/status and have Advisor review the push/CI result before reporting final push outcome.
  Small Task Mode never authorizes default exclusions unless the owner explicitly names the exception.
  If Advisor is unavailable, commit/push-bound Small Task Mode work fails closed unless owner explicitly approves a narrower degradation.
  The evidence record must include why the task qualified as Small Task Mode, Advisor review status for each git checkpoint, validation evidence, secret-scan status before push when applicable, and any non-required gate that was not run with the reason. Required gates may not be skipped merely by recording a reason.

Before commit:
  Advisor must review the commit-ready scope unless a stricter project rule requires PM + Advisor or Reviewer too.
  Leader must tell the owner in plain language that Advisor has reviewed, found no required changes, and commit can proceed.
  This statement is not authorization by itself; the owner must still explicitly authorize commit unless a valid controlled preauthorization window covers it.

After commit:
  Advisor must review the actual commit result before Leader asks for push authorization.
  Leader must report whether Advisor found required changes or cleared the commit for push consideration.

Push:
  Push requires explicit owner authorization unless a valid controlled preauthorization window covers the current push action.
  After push, Leader must check CI/status required by the project. CI scope/full-run decisions follow project rules and may be triggered by Leader under those rules.
  Advisor must review the push result and CI/status evidence before Leader reports final push outcome to the owner.

Controlled preauthorization window:
  Valid only when explicitly granted in the current Leader conversation.
  Must define scope, expiry or turn/stage boundary, target remote/branch/ref, risk ceiling, required validation, and excluded operations.
  If owner explicitly says PM/Advisor agreement may commit/push in the same Leader conversation, treat that as a controlled preauthorization window only when the required window fields are complete.
  PM and Advisor must agree.
  Required Reviewer must pass.
  No unresolved P0/P1 may remain.
  Required validation must pass and remain fresh.
  Before push, run available secret/credential scanning over staged or outgoing diff; suspected secrets block push and escalate to owner.
  Handoff never carries preauthorization forward.
```

Default exclusions unless owner explicitly names the exception:

```text
Push to main/protected branch
Force-push or history rewrite
Tag/release publication
Credential/security/permission/authentication changes
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
PM/Advisor consensus, if any
Unresolved disagreements
Spec-workflow state
Git branch / commit / dirty state
Changed and do-not-touch files
Validation run and not run
Risk level
Next recommended action
Stop conditions
Commit/push authorization state, default no
```

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
