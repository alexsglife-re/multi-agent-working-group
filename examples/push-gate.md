# Example: Push Gate

This example shows how a normal non-high-risk push may proceed after PM plus Advisor consensus, fresh validation, clear target, applicable secret or credential scanning, available status checks, and post-push PM plus Advisor review.

## Scenario

The local work already passed the commit gate and now exists as a real commit on the current branch. The Leader needs to decide whether that commit may be pushed to a named remote branch.

## Classification

```text
Risk: medium, non-high-risk
Stage: verify -> push gate
Mode: multi-agent workflow
PM: required and already participating
Advisor: required and already participating
Reviewer: required only if the task type or project gate requires it
Push authorization: possible under the normal gate
```

## Preconditions

Before push, the Leader confirms:

```text
- PM and Advisor continuity status is explicit.
- PM and Advisor have no unresolved P0/P1 disagreement.
- The outgoing scope is exactly the reviewed commit or commit set.
- Required validation is still fresh for the outgoing scope.
- Required Reviewer approval still exists when applicable.
- Target remote, branch, and ref are clear.
- Available secret or credential scanning over the outgoing diff passes when applicable.
- Any available status or CI prerequisite for the project is checked before or immediately after push, depending on the project rule.
- The push is normal and non-high-risk.
- No default exclusion is present.
```

## Evidence Packet

Leader records the outgoing evidence:

```text
Outgoing commit set:
  - <actual commit hash>

Target:
  Remote: origin
  Branch: main
  Ref: origin/main

Validation freshness:
  - Manual doc review rerun after final edits: yes

Secret/credential scan:
  - Outgoing diff reviewed for secrets/credentials: clear

Reviewer:
  Not required for this docs-only task.

PM continuity:
  Identity: PM-1
  Continuity status: intact

Advisor continuity:
  Identity: Advisor-1
  Continuity status: intact
```

## PM Review

PM independently confirms:

```text
Outgoing scope matches accepted work: yes
Push target is the expected target: yes
Fresh validation is still present: yes
Recommended next action: normal push may proceed
```

## Advisor Review

Advisor independently confirms:

```text
No unresolved P0/P1: yes
Target clarity is sufficient: yes
Applicable secret/credential scan passed: yes
Normal push to origin/main does not require a protected-branch bypass or exception: yes
No default exclusion or hidden external-effect expansion: yes
Recommended next action: normal push may proceed
```

## Consensus Gate

Leader records:

```text
Same goal: yes
Same outgoing scope: yes
Risk conflict: none
Validation fresh: yes
Reviewer required: no
Target clear: yes
Secret/credential scan clear: yes
Push type: normal non-high-risk
Target origin/main allowed by normal gate: yes
Default exclusion present: no
Decision: push may proceed under the normal PM plus Advisor gate
```

For this normal path, explicit Owner re-approval is not required.

## Push Execution

Leader performs the push and records the actual result:

```text
Push executed: yes
Remote accepted push: yes
Actual target matched planned target: yes
Unexpected ref or branch update: no
```

## Status Or CI Check

When project checks are available, Leader verifies the result after push:

```text
Status/CI available: yes | no
If yes:
  - Check the status link, branch protection result, or CI run tied to the pushed commit.
  - Record pass, fail, pending, or unavailable.
If no:
  - Record that no project status/CI evidence was available for this push gate.
```

## Post-Push PM Plus Advisor Review

PM and Advisor review the actual push result, plus status/CI evidence when available:

```text
PM result review:
  - Push landed on the intended target.
  - No follow-up repair is required from the planned scope.

Advisor result review:
  - No unexpected scope expansion occurred during push.
  - Status/CI evidence was checked when available.
  - No unresolved P0/P1 remains in the actual push result.
```

Only after that review may the push flow be reported complete.

## Owner Approval Still Required

The normal push gate does not cover:

```text
- Force-push or history rewrite
- Protected-branch bypass or exception actions
- Tag or release publication
- Deployment or public publication
- Schema migration
- Credential or secret changes
- Security, auth, or permission changes
- Destructive or irreversible external effects
- Any other high-risk or default-exclusion action
```

If any of those appear, stop and get explicit Owner approval.
