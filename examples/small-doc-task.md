# Example: Small Documentation Task

This example shows how a small, low-risk documentation task can use the multi-agent-working-group skill without turning into a full multi-agent workflow.

## Scenario

The owner asks:

```text
Add a short README section explaining what this repository is for.
```

The task is documentation-only, local, and does not change behavior, permissions, security, external integrations, git history, or release state.

## Classification

```text
Risk: small low-risk
Stage: execute
Mode: Small Task Mode
Spec workflow: not required
PM/Worker dispatch: not required
Reviewer: not required
Commit authorization: not granted
Push authorization: not granted
```

## Leader Checks Before Editing

```text
Owner instruction:
  Add a short README section.

Scope:
  Allowed: README documentation.
  Forbidden: SKILL.md behavior changes, Worker delegation by stealth, Reviewer self-review, git commit, git push, release, external publication.

Current evidence:
  - Current branch checked.
  - Dirty state checked.
  - Existing README read.

Why Small Task Mode applies:
  - Documentation-only.
  - Narrow file scope.
  - No PM, Worker, or Reviewer is required.
  - No product behavior change.
  - No permission, security, schema, deployment, or external effect.
```

## Minimal Startup Packet

For direct Leader execution, the Leader can still use the startup packet shape internally:

```text
Identity:
  Leader performing a small documentation edit.

Task:
  Add a concise README section that explains repository purpose.

Scope:
  README only.

Context:
  Existing README and project file list.

Coordination:
  Report changed file and validation performed.

Stop Conditions:
  If the edit requires changing skill behavior, adding policy, committing, pushing, or publishing, stop and ask.
```

## Execution

The Leader edits the README and then verifies:

```text
Validation:
  - Re-read changed section.
  - Check git status.
  - Check git diff for only intended file.
  - Confirm no secret, credential, local private path, or behavior-changing instruction was added.
  - Confirm the task did not become hidden Worker execution or require Reviewer independence.
```

## Completion Report

The final response should be short and evidence-based:

```text
Updated README with a short project-purpose section.
Verified the diff only touched README.md.
No commit or push was performed.
```

## Commit Or Push Gate

Small Task Mode does not authorize git publication.
It also does not add Reviewer. Advisor review is the independent git-gate check for small tasks.

Before commit:

```text
Advisor must review the commit-ready scope unless the owner explicitly approves a narrower degradation.
Leader must report that Advisor found no required changes.
Because Small Task Mode has no PM, this example does not use the normal PM plus Advisor commit gate by itself.
If commit later becomes in scope, use the stricter current project rule that applies to Small Task Mode.
```

Before push:

```text
Advisor must review the actual commit and outgoing scope.
Required validation must still be fresh.
Available secret/credential scanning over the outgoing diff must pass when applicable.
Because Small Task Mode has no PM, this example does not use the normal PM plus Advisor push gate by itself.
If push later becomes in scope, use the stricter current project rule that applies to Small Task Mode.
```

## If The Task Stops Being Small

Exit Small Task Mode if any of these happen:

```text
- The edit changes SKILL.md behavior.
- The edit introduces new commit/push policy.
- The edit touches security, permissions, credentials, schema, deployment, or external publication.
- The owner asks for a broader workflow or release.
- Validation fails.
- Advisor raises an unresolved P0/P1 before a git gate.
```

Then use the stricter workflow.
