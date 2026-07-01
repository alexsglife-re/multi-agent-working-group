# Example: Commit Gate

This example shows how a normal non-high-risk commit may proceed after PM plus Advisor consensus, fresh validation, and required Reviewer approval when applicable. It also shows what still requires explicit Owner approval.

## Scenario

The owner asked earlier for a bounded documentation change that was classified as medium, assigned to a Worker, and completed locally.

The Leader now wants to decide whether the current local diff may become a normal git commit.

## Classification

```text
Risk: medium, non-high-risk
Stage: verify -> commit gate
Mode: multi-agent workflow
PM: required and already participating
Advisor: required and already participating
Reviewer: required only if the task type or project gate requires it
Commit authorization: possible under the normal gate
Push authorization: not decided here
```

## Preconditions

Before the commit gate, the Leader confirms:

```text
- The scope is still the same bounded task PM and Advisor reviewed.
- PM and Advisor continuity status is explicit.
- PM and Advisor have no unresolved P0/P1 disagreement.
- Required validation is fresh for the current diff.
- Required Reviewer approval exists if the task type requires Reviewer.
- The commit is a normal non-high-risk commit.
- No default exclusion is present.
```

## Evidence Packet

Leader summarizes the commit-ready evidence:

```text
Files changed:
  - examples/commit-gate.md
  - examples/push-gate.md
  - docs/TODO.md

Validation:
  - Re-read changed files.
  - Checked wording against role-boundary rules.
  - Checked git diff for scope.

PM continuity:
  Identity: PM-1
  Continuity status: intact

Advisor continuity:
  Identity: Advisor-1
  Continuity status: intact

Reviewer:
  Not required for this docs-only task.
```

## PM Review

PM independently confirms:

```text
Goal still matches the original task: yes
Scope stayed bounded: yes
Acceptance target met: yes
Fresh validation present: yes
Required Reviewer status: not required
Recommended next action: normal commit may proceed
```

## Advisor Review

Advisor independently confirms:

```text
No unresolved P0/P1: yes
No hidden scope expansion: yes
No high-risk/default-exclusion action: yes
No wording that weakens Owner-only exclusions: yes
Recommended next action: normal commit may proceed
```

## Consensus Gate

Leader records the git-gate decision:

```text
Same goal: yes
Same scope: yes
Risk conflict: none
Validation fresh: yes
Reviewer required: no
Commit type: normal non-high-risk
Default exclusion present: no
Decision: commit may proceed under the normal PM plus Advisor gate
```

For this normal path, explicit Owner re-approval is not required.

## Commit Execution

Leader performs the commit and records the actual result:

```text
Commit executed: yes
Commit hash: <actual hash>
Commit scope matches reviewed diff: yes
Unexpected files included: no
```

## Post-Commit PM Plus Advisor Review

After the commit exists, PM and Advisor review the actual result rather than the plan alone:

```text
PM result review:
  - Commit matches accepted scope.
  - No follow-up repair required before push consideration.

Advisor result review:
  - Actual commit does not introduce unauthorized scope.
  - No P0/P1 objection remains.
```

Only after that post-commit review may the workflow move to a push gate.

## Owner Approval Still Required

The normal commit gate does not cover:

```text
- Force-push or history rewrite
- Protected-branch exception actions
- Tag or release creation
- Deployment or public publication
- Schema migration
- Credential or secret changes
- Security, auth, or permission changes
- Destructive or irreversible external effects
- Any other high-risk or default-exclusion action
```

If any of those appear, stop and get explicit Owner approval.
