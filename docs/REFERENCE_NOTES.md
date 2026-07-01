# Reference Notes

This document records reusable ideas observed from local reference checkouts. It is not a decision to copy code or adopt a CLI implementation. The current project should prefer rules, templates, and examples before adding automation.

## Reference Sources

| Source | Local Path | Indexed Alias | Commit | Role |
| --- | --- | --- | --- | --- |
| `HKUDS/ClawTeam` | `references/external/HKUDS-ClawTeam` | `HKUDS-ClawTeam` | `0119833` | Upstream baseline for multi-agent team coordination. |
| `win4r/ClawTeam-OpenClaw` | `references/external/win4r-ClawTeam-OpenClaw` | `win4r-ClawTeam-OpenClaw` | `9a494c5` | Fork with OpenClaw, subprocess, Windows, reliability, and model-routing additions. |

Both reference repositories are ignored by this repository through `.gitignore`. GitNexus indexes are local evidence only and should not be published.

## What To Borrow

### Stage Model

ClawTeam uses a simple staged lifecycle:

```text
discuss -> plan -> execute -> verify -> ship
```

For this skill, the same idea should become a general rule:

```text
Every non-trivial workstream should declare its current stage:
discuss -> plan -> execute -> verify -> closeout

Stage advancement requires evidence. Missing evidence blocks the stage rather than becoming a vague warning.
```

This is useful because most AI agents can follow stage names even when they cannot run a specific CLI.

### Gate Model

ClawTeam's useful gate ideas are:

- Artifact gate: required documents, results, or evidence must exist.
- Completion gate: assigned work must be done or explicitly blocked.
- Human approval gate: external effects or high-risk actions require owner approval.

Candidate rule:

```text
Before advancing a stage, state which gates apply:
- Artifact gate
- Completion gate
- Owner approval gate
- Risk stop gate

If any required gate is missing, stay in the current stage and report the blocker.
```

### Role As Responsibility

The reference projects define roles by what each role should produce. The transferable pattern is to avoid treating role names as status labels.

Candidate role language:

```text
Planner: clarify goal, scope, acceptance criteria, and risks.
Advisor: challenge assumptions, identify stop conditions, and preserve dissent.
Executor: complete one bounded slice and return evidence.
Evaluator: verify result against acceptance criteria.
Leader: integrate evidence, decide whether gates pass, and communicate with the owner.
```

### Startup Packet

ClawTeam's prompt builder consistently includes identity, workspace, task, context, coordination, and loop instructions. This should become a portable startup packet template.

Candidate packet:

```text
Identity:
  Role, name, responsibility, leader/owner relationship.

Scope:
  Allowed files, allowed tasks, forbidden actions, risk ceiling.

Task:
  One clear objective and one acceptance target.

Context:
  Only the evidence this role needs.

Coordination:
  How to report done, blocked, questions, and evidence.

Loop:
  After finishing, check whether more assigned or matching work remains before declaring idle.

Stop Conditions:
  Owner decision, missing evidence, unresolved P0/P1, failed validation, or forbidden action.
```

### Worker Loop

The reference projects require workers to keep checking for remaining work instead of exiting after the first task. The rule version:

```text
Worker completion is not workstream completion.
After a worker finishes a task:
1. Report result and evidence.
2. Re-check assigned scope.
3. State whether more work remains.
4. Declare idle only after no matching work remains.
```

### Task State Vocabulary

ClawTeam's task model uses a small vocabulary that is useful without any tooling:

```text
pending
in_progress
completed
blocked
```

Candidate task record:

```text
Task:
  Owner:
  Status: pending | in_progress | completed | blocked
  Priority:
  Acceptance target:
  Blocked by:
  Evidence required on return:
```

### Role-Scoped Recovery

The reference recovery logic gives each role only the context it needs. This is a strong fit for cross-thread handoff and long conversations.

Candidate recovery rule:

```text
Recovery packets must be role-scoped:
- Worker: own task, own prior result, direct blockers.
- Reviewer/Evaluator: acceptance criteria, result/diff, known risk areas.
- PM/Planner: scope, decisions, open questions.
- Advisor: claims to challenge, assumptions, stop conditions.
- Leader: full gate state, authorization state, current branch/dirty state, validation evidence.
```

Old handoff material remains evidence, not authority.

### Agent Degradation

The OpenClaw fork uses a circuit-breaker-style health model. The rule-level version is:

```text
If an agent repeatedly fails:
- First failure: mark degraded and reduce trust.
- Repeated failure: stop assigning new work to that agent.
- Recovery: allow one limited task after restart/cooldown.
- Trust is restored only after fresh evidence passes review.
```

This is useful for all agent runtimes because it frames repeated failure as state, not vibes.

### Capability Declaration

The OpenClaw fork separates platform/runtime differences instead of assuming every agent can do everything.

Candidate rule:

```text
Before assigning work, declare the agent's available capabilities:
- Can read local files?
- Can write files?
- Can run shell commands?
- Can use git?
- Can access network?
- Can persist state?
- Can resume previous state?

Do not assign work that requires a missing capability unless the owner explicitly accepts a degraded path.
```

### Model Or Capability Selection Priority

The OpenClaw fork uses a priority chain for model selection. The rule-level equivalent is useful for any agent router:

```text
Agent/tool choice priority:
1. Owner explicit instruction.
2. Task risk and required capability.
3. Role need: planner/reviewer/advisor usually need stronger reasoning; executor needs focused fit.
4. Project default.
5. Environment availability.
6. Fallback with recorded degradation.
```

## What Not To Borrow Yet

Do not add these to the skill until the rule-level workflow is proven:

- Automatic agent spawning.
- tmux or subprocess backend management.
- Runtime message injection.
- Board UI or dashboard behavior.
- Full MCP tool surface.
- Automatic worktree management.
- Cost dashboard automation.

These are implementation features. The current project should first make the portable rules and examples clear.

## Candidate Additions To This Project

Recommended first additions, before editing `SKILL.md`:

1. Add example files for stage/gate usage.
2. Add startup packet templates.
3. Add role-scoped recovery examples.
4. Add task-state examples.
5. Add small-task and blocked-task examples.

Only after examples feel stable should the strongest rules be promoted into `SKILL.md`.
