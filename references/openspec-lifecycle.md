# OpenSpec Lifecycle Reference

This file extends `SKILL.md`. It cannot weaken `SKILL.md`, cannot override `SKILL.md`, and grants no authorization by itself. If this file conflicts with `SKILL.md`, project rules, or Owner instructions, use the stricter rule.

Read this reference before OpenSpec proposal, implementation, validation, closeout, archive, or status reporting.

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

Packet lifecycle is separate from role-agent cleanup. C1 and C2 may permit only non-destructive compaction of redundant completed-stage working material after their reviews, corrections, decisions, and validation complete. C3 retains material required by git and status gates. C4 final cleanup eligibility waits for archive validation and every applicable archive commit, push, status, and post-action review. None of these checkpoints authorizes file deletion or weakens validation, PM/Advisor/Reviewer, git, CI/status, secret-scan, release, authorization, or original-evidence requirements.
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
