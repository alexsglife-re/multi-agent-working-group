# Example: Medium Worker Task

This example shows when a task is too large for Leader direct execution and should be delegated to a Worker. It pairs with `examples/small-doc-task.md`: small low-risk work may be done directly by Leader, but medium work needs clearer role separation.

## Scenario

The owner asks:

```text
Add medium-task guidance to the docs so future agents know when Leader must delegate to Worker.
```

The request is still documentation-only, but it affects multiple documents and future workflow interpretation. It is not a tiny copy edit. Leader should not quietly write all guidance and then ask PM/Advisor to approve it after the fact.

## Classification

```text
Risk: medium
Stage: plan -> execute -> verify
Mode: multi-agent workflow
Spec workflow: not required, unless project rules say otherwise
PM: required
Advisor: required
Worker: required for the documentation slice
Reviewer: not required unless the task changes SKILL.md behavior, code, security, permissions, API, database, architecture, or another stricter project gate applies
Commit authorization: not granted
Push authorization: not granted
```

Why this is not Small Task Mode:

```text
- The work affects future workflow interpretation.
- The likely edit spans more than one section or document.
- The task needs PM/Advisor agreement on scope and wording.
- The writing itself should have a bounded Worker owner.
- Leader would otherwise become a hidden Worker and self-review its own guidance.
```

## Leader Responsibilities

Leader owns orchestration, not the main execution slice:

```text
Leader may:
  - Read current docs and examples.
  - Classify the task as medium.
  - Ask PM for scope, acceptance criteria, and risk notes.
  - Ask Advisor to challenge the classification and stop conditions.
  - Create a bounded Worker assignment.
  - Verify Worker output against PM/Advisor consensus and current evidence.
  - Run or inspect required validation.
  - Summarize what changed and what remains unauthorized.

Leader must not:
  - Draft the substantive medium-scope guidance as hidden Worker execution.
  - Treat PM/Advisor agreement as proof.
  - Review its own substantive implementation as Reviewer.
  - Commit or push without the applicable git gate.
```

## PM First Pass

PM should answer before reading Advisor's first-pass conclusions:

```text
Goal:
  Add a reusable example showing medium task delegation.

Acceptance criteria:
  - The example explains why the task is medium.
  - It shows PM, Advisor, Worker, and Leader responsibilities.
  - It states when Reviewer is not required and when stricter gates add Reviewer.
  - It separates local completion from commit/push authorization.

Risk:
  Medium, because guidance can affect future workflow interpretation.

Recommended next action:
  Dispatch one Worker to draft examples/medium-worker-task.md only.
```

## Advisor First Pass

Advisor should answer independently before reading PM's first-pass conclusions:

```text
Claims to challenge:
  - Is this truly medium rather than small?
  - Could Leader direct execution blur role boundaries?
  - Does the example accidentally require Reviewer for all medium docs work?

Stop conditions:
  - The example changes SKILL.md behavior directly.
  - The example weakens commit/push authorization.
  - The example says PM/Advisor agreement replaces Owner authorization.
  - The example requires Reviewer for small low-risk tasks.

Recommended next action:
  Proceed only with a bounded Worker documentation slice.
```

## Consensus Gate

Before dispatching Worker, Leader checks whether PM and Advisor agree on:

```text
Same goal: yes
Same scope: examples/medium-worker-task.md only
Risk conflict: none
Next action: dispatch Worker
Verification method: re-read file, compare against role boundaries, check git status/diff
Unresolved P0/P1: none
```

If PM and Advisor disagree on whether this is small or medium, Leader should use the stricter classification or stop for Owner decision.

## Worker Assignment

Leader sends Worker a bounded slice:

```text
Role:
  Worker Agent

Task:
  Draft examples/medium-worker-task.md.

Acceptance target:
  The file demonstrates why a medium documentation task must be delegated to Worker instead of directly executed by Leader.

Allowed files:
  examples/medium-worker-task.md

Readable context:
  - examples/small-doc-task.md
  - examples/blocked-task.md
  - docs/ROLE_BOUNDARIES.md
  - SKILL.md role, risk, and git-gate sections

Forbidden scope:
  - Do not edit SKILL.md.
  - Do not change README, roadmap, validation checklist, or other examples.
  - Do not commit or push.
  - Do not add new policy beyond the example's candidate guidance.

Required validation:
  - Re-read the created file.
  - Confirm no wording authorizes commit, push, release, deployment, or external publication.
  - Confirm the example does not require Reviewer for small tasks.

Return:
  - Changed file.
  - Summary of content.
  - Validation performed.
  - Any unresolved issues.
```

## Worker Return

The Worker reports:

```text
Status: completed
Changed file:
  examples/medium-worker-task.md

Summary:
  Added a medium documentation task example showing PM/Advisor consensus, bounded Worker assignment, Leader verification, and git gate separation.

Validation:
  - Re-read the file.
  - Confirmed no commit or push authorization is implied.
  - Confirmed Reviewer is not required for small low-risk tasks.

Unresolved issues:
  none
```

## Leader Verification

Leader verifies the Worker result:

```text
Evidence checked:
  - Worker changed only the assigned file.
  - Example remains documentation-only.
  - Medium task classification is explained.
  - Leader direct execution is not used for the substantive slice.
  - Reviewer is conditional, not universal.
  - Commit and push remain unauthorized.

Commands or checks:
  - git status --short
  - git diff -- examples/medium-worker-task.md
  - Re-read examples/medium-worker-task.md
```

If the Worker changed files outside scope, introduced policy conflicts, or implied git authorization, Leader must stop and repair through a new Worker slice or Owner decision.

## Completion Report

Leader's final report should be concise:

```text
Added examples/medium-worker-task.md.
Verified that the example keeps Leader as orchestrator, assigns the writing slice to Worker, keeps Reviewer conditional, and does not authorize commit or push.
No commit or push was performed.
```

## Commit Or Push Gate

Medium task completion does not authorize git publication.

Before commit:

```text
Advisor must review the commit-ready scope.
PM and Advisor must have no unresolved P0/P1 disagreement when the project's standing gate requires PM agreement.
Required validation must be fresh.
Required Reviewer approval must exist when the task type or project gate requires Reviewer.
If the commit is a normal non-high-risk commit and no default exclusion is present, commit may proceed under the normal PM plus Advisor gate without asking Owner again.
```

Before push:

```text
Advisor must review the actual commit and outgoing scope.
PM and Advisor must still have no unresolved P0/P1 disagreement when the standing push gate requires PM agreement.
Required validation must still be fresh.
Available secret/credential scanning over the outgoing diff must pass when applicable.
Target remote and branch must be clear.
Required Reviewer approval must still exist when applicable.
If the push is a normal non-high-risk push and no default exclusion is present, push may proceed under the normal PM plus Advisor gate without asking Owner again.
```

## If The Task Becomes High-Risk

Escalate to the stricter workflow if any of these happen:

```text
- The task changes SKILL.md behavior.
- The task changes code, permissions, security, authentication, API, database, schema, deployment, or release behavior.
- The task requires external publication.
- PM and Advisor disagree on risk or next action.
- Validation fails.
- A P0/P1 issue remains unresolved.
```

When that happens, stop the current medium example flow and use the required high-risk or project-specific workflow.
