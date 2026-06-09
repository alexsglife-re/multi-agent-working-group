---
name: multi-agent-working-group
description: Use when a user asks to coordinate multiple agents, PM/advisor/worker/reviewer roles, Claude or external advisor review, delegated implementation, independent verification, controlled commit/push authorization, or cross-agent handoff in a development task.
---

# Multi-Agent Working Group

## Overview

Use this skill to run a guarded, evidence-based multi-agent workflow. The Leader remains responsible for orchestration, verification, owner communication, and git exits; other agents provide scoped work or independent critique.

Project `AGENTS.md`, memory, OpenSpec, security, legal, or owner instructions may only tighten this skill. Do not use this skill to weaken a project-specific gate. Read only the current project's local rule files; do not import another project's protocol, memories, or handoff documents unless the owner explicitly asks for that cross-project reference.

## Startup Checklist

Before dispatching agents:

1. Read project instructions and memory required by the current repo.
2. Classify the task risk.
3. Check whether OpenSpec, security, GitNexus, TDD, review, or other project skills apply.
4. Decide whether multi-agent work is truly useful for this task.
5. Record the owner authorization state; default to no commit/push authorization.

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

If the owner explicitly assigns roles differently, for example Claude Code CLI as PM/Worker and Codex as Advisor, honor that assignment while preserving all boundaries and gates.

## Risk and Severity

Use the higher tier when uncertain.

| Tier | Meaning |
| --- | --- |
| Small low-risk | Read-only work, narrow docs/copy/style/config, or isolated tests with no approved-behavior, permission, data, persistence, external-effect, or git-remote change. |
| Medium | Multi-file docs/tests, contained bug fixes, local tooling, or work needing multiple evidence sources without high-risk areas. |
| Complex | New user-visible workflow, architecture/module boundary, cross-layer work, public API, external integration, or OpenSpec-bound change. |
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
OpenSpec / spec state
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
```

Advisor additions:

```text
Claims to challenge
Known assumptions
Required counterexamples / objections
Stop-condition focus
Reminder: do not read PM conclusions before first pass
Reminder: output is unverified until Leader verifies it
```

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
No scope expansion, self-approval, commit, or push
```

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
3. Check spec/OpenSpec state when applicable.
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
Spec/OpenSpec state
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

Leader final outputs should include what was verified, what remains uncertain, whether any degradation occurred, and whether commit/push is unauthorized, one-time authorized, or covered by a controlled preauthorization window.
