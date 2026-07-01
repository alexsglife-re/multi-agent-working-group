# Example: Blocked Task

This example shows how an agent should stop and report when it hits a missing permission, failed validation, or owner gate. The goal is to make blocking behavior explicit and useful, not dramatic.

## Scenario

The owner asks:

```text
Update the project documentation and publish the result.
```

During the work, the agent discovers that "publish" could mean committing, pushing, creating a release, or updating a public package. The owner did not explicitly authorize any of those external effects.

## Classification

```text
Risk: medium until scope is clarified
Stage: execute -> blocked
Mode: direct documentation work allowed only for local edits
Spec workflow: not required for local docs
Commit authorization: not granted
Push authorization: not granted
Release authorization: not granted
```

## Capability Declaration

Before acting, the agent records what it can and cannot do:

```text
Can read local files: yes
Can write local docs: yes
Can run local validation: yes
Can commit: no current authorization
Can push: no current authorization
Can publish/release: no current authorization
Can access secrets: no
```

If a required capability is missing, the agent may continue only within the capability it has. It must stop before the missing capability is needed.

## Case 1: Missing Permission

The agent can edit docs locally, but the requested next action requires a git commit.

Blocked report:

```text
Status: blocked
Blocked by: missing commit authorization
Completed locally:
  - Updated documentation files.
  - Re-read changed sections.
  - Checked git status and local diff.

Not performed:
  - git add
  - git commit
  - git push
  - release/publication

Needed from owner:
  Explicit instruction to commit, or instruction to leave changes local.

Recommended next action:
  Review the local docs first. If they look right, authorize a commit as a separate step.
```

Rule:

```text
Do not convert a broad word like "publish", "ship", "save", or "finish" into git commit, git push, release, deployment, or external publication unless the current applicable gate covers that exact action. Normal non-high-risk git exits require the PM plus Advisor gate and evidence; high-risk or default-exclusion actions require explicit Owner approval.
```

## Case 2: Validation Failure

The agent edits docs and runs a local validation check. The check fails because a link points to a missing file.

Blocked report:

```text
Status: blocked
Blocked by: failed validation
Failed check:
  docs link check

Observed failure:
  docs/REFERENCE_NOTES.md links to examples/missing-file.md, but that file does not exist.

Completed:
  - Documentation draft written.
  - Validation run.

Not performed:
  - commit
  - push

Recommended next action:
  Fix or remove the broken link, then rerun validation before any git gate.
```

Rule:

```text
Failed required validation blocks stage advancement. Do not ask for commit or push authorization until the validation failure is fixed or explicitly accepted by the owner as a documented degradation.
```

## Case 3: Owner Gate

The local docs are complete and validation passes, but the next requested action is push to a remote branch.

Blocked report:

```text
Status: blocked
Blocked by: missing current push gate
Completed:
  - Documentation changes made.
  - Local validation passed.
  - Commit-ready scope reviewed.

Still required before push:
  - PM plus Advisor push-gate agreement when the normal non-high-risk standing rule applies, or explicit Owner approval when the action is a default exclusion or otherwise outside that normal gate.
  - Advisor review of the outgoing scope if required by the workflow.
  - Secret/credential scan over outgoing diff when applicable.
  - Clear target remote and branch.

Recommended next action:
  Decide whether the next step is a normal non-high-risk push gate or an Owner-only action, then gather the matching approval and evidence.
```

Rule:

```text
Agreement, validation success, or "looks good" is not push authorization by itself. Push still needs the current gate to pass: either the normal non-high-risk PM plus Advisor gate with required evidence, or explicit Owner approval for high-risk/default-exclusion actions.
```

## Blocked State Template

Use this template whenever the agent stops:

```text
Status:
  blocked

Current stage:
  discuss | plan | execute | verify | closeout

Blocked by:
  missing permission | failed validation | owner gate | unresolved P0/P1 | missing required evidence

Completed:
  - ...

Not performed:
  - ...

Evidence:
  - Files read:
  - Commands run:
  - Validation result:

Needed from owner or leader:
  - ...

Recommended next action:
  - ...
```

## What The Agent Must Not Do

```text
- Do not continue by assuming permission.
- Do not downgrade a failed required validation to a warning.
- Do not invent advisor, reviewer, CI, or owner approval.
- Do not push, release, deploy, or publish because the local work is complete.
- Do not broaden context sharing to another agent or external service to work around a gate.
```

## Recovery

When the blocker is resolved, the agent should restart from current evidence:

```text
1. Re-read the owner instruction that resolved the blocker.
2. Re-check branch, dirty state, and changed files.
3. Re-run or confirm required validation freshness.
4. Confirm whether any Advisor/Reviewer gate is still required.
5. Continue only inside the newly authorized scope.
```

Old blocked reports are evidence, not authority.
