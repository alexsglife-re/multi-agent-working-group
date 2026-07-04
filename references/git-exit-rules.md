# Git Exit And Default Exclusion Reference

This file extends `SKILL.md`. It cannot weaken `SKILL.md`, cannot override `SKILL.md`, and grants no authorization by itself. If this file conflicts with `SKILL.md`, project rules, or Owner instructions, use the stricter rule.

Read this reference before commit, push, tag, release, publication, deployment, force-push, destructive actions, credential/secret/security/auth/permission changes, schema changes, or other default exclusions.

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
