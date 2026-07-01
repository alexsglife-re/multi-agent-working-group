# Role Boundaries

This document records the working boundary between Leader-owned coordination and delegated execution. It is a discussion artifact before promotion into `SKILL.md`.

## Current Roles

| Role | Primary responsibility | Must not do |
| --- | --- | --- |
| Owner | Set goals, approve exceptions, and authorize external or irreversible actions. | Delegate final authorization to agent agreement by implication. |
| Leader | Orchestrate, synthesize, verify evidence, communicate with Owner, and execute approved git exits. | Self-authorize commit/push, hide direct execution, or act as Reviewer for its own substantive work. |
| PM Agent | Clarify product goal, scope, acceptance criteria, risk, and next action. | Read Advisor's first pass before producing its own first-pass analysis. |
| Advisor Agent | Challenge assumptions, identify risks, preserve dissent, and define stop conditions. | Author files or run mutating commands unless explicitly reassigned to a non-advisor role. |
| Worker Agent | Complete one bounded execution slice and return evidence. | Expand scope, approve its own work, commit, or push. |
| Reviewer Agent | Review changed artifacts after execution and verify against acceptance criteria. | Review its own implementation. |

Role names describe responsibilities, not seniority. A person, model, or tool may hold different roles at different times only when the assignment is explicit and independence requirements still hold.

## Leader Direct Execution Principle

Leader may directly execute only when the work is orchestration, verification, synthesis, or an explicitly classified small low-risk task. Leader must not become a hidden Worker plus self-reviewing Reviewer.

Candidate rule:

```text
Leader Direct Execution Rule:

Leader may directly execute only when all are true:
1. The task is orchestration, verification, synthesis, or small low-risk work.
2. The scope is narrow and explicitly declared.
3. The work does not require independent Worker ownership.
4. Leader will not later act as Reviewer for the same substantive work.
5. Required gates remain intact:
   - Small Task Mode: no PM, no Worker, no Reviewer.
   - Small Task Mode with commit/push scope: Advisor review is still required at git gates.
   - Medium, complex, code, or high-risk work: use the stricter PM/Advisor/Worker/Reviewer workflow as required.
6. The final report labels what Leader executed directly and why it was allowed.

Otherwise, Leader must dispatch a Worker or stop for Owner decision.
```

## What Leader May Do Directly

Leader may directly perform these activities when they stay within the current task scope:

- Read project instructions, memory, docs, examples, diffs, and local evidence.
- Inspect git state, branch, log, diff, and changed files.
- Classify risk and decide which roles are required.
- Prepare the stage, gate, startup packet, and validation plan.
- Synthesize PM and Advisor outputs without treating agreement as proof.
- Run non-mutating discovery or validation commands.
- Write Owner-facing summaries, decision prompts, and next-step recommendations.
- Perform small low-risk documentation, checklist, copy, or example edits under Small Task Mode.
- Integrate Worker outputs and resolve low-risk P2 disagreements with recorded rationale.
- Execute commit or push only after the applicable git gates and explicit authorization or valid preauthorization pass.

## What Leader Must Not Do Directly

Leader must not directly perform these activities unless the workflow explicitly reclassifies the work and assigns the required roles:

- Implement medium, complex, code, permission, API, database, security, architecture, or high-risk work as a hidden Worker.
- Review its own substantive implementation as Reviewer.
- Replace independent PM first-pass analysis with Leader's own product judgment when PM is required.
- Replace independent Advisor critique with Leader's own critique when Advisor is required.
- Use after-the-fact PM/Advisor agreement to justify work that should have been delegated before execution.
- Expand scope, change requirements, or change architecture without the required PM/Advisor/Owner gate.
- Commit, push, publish, release, deploy, tag, force-push, change credentials, change authentication, change permissions, change schema, or perform destructive actions without the applicable explicit gate.
- Use Small Task Mode when risk classification is uncertain.
- Omit the fact that Leader executed directly.

## Small Task Mode Boundary

Small Task Mode is the narrow exception where Leader may complete work directly.

Allowed shape:

```text
Owner -> Leader direct execution -> local validation
```

When commit or push is in scope:

```text
Owner -> Leader direct execution -> local validation -> Advisor review -> git gate
```

Small Task Mode does not use PM, Worker, or Reviewer. Advisor is only required when a git gate or stricter project rule requires independent review. If the task becomes broader, riskier, code-like, or behavior-changing, exit Small Task Mode and use the stricter workflow.

## Practical Classification

| Classification | Leader direct execution? | Notes |
| --- | --- | --- |
| Green | Yes | Read-only analysis, summaries, narrow docs, examples, checklist updates, local validation. |
| Yellow | Draft or propose; use stricter review before relying on it | Workflow policy changes, multi-file docs that affect future behavior, rule wording that could alter gates. |
| Red | No | Code behavior, permissions, API/database/security/auth/schema, external publication, git remote effects, destructive or irreversible actions. |

When classification is uncertain, use the stricter workflow.

## Documentation Promotion Path

This file should remain a staging document until the project has enough examples. Promotion path:

1. Keep this as a reference note for discussion and review.
2. Update examples so they demonstrate the boundary in real scenarios.
3. Promote only the shortest, most stable rules into `SKILL.md`.
4. Keep detailed examples here or under `examples/` rather than overloading the skill body.
