# OpenSpec C0-C4 Task Example

This example shows a medium documentation-first change that uses both the Multi-Agent Working Group skill and OpenSpec.

## Owner Request

```text
Use multi-agent-working-group and OpenSpec to add a rule that CLI Advisors must be trusted for the current workspace before review. Complete the goal.
```

## C0 Goal Analysis

Leader records:

```text
Goal:
  Add a rule-level workspace-trust requirement for CLI Advisors.

Risk:
  Medium documentation/spec workflow. No runtime code, deployment, release, or destructive operation.

Active OpenSpec changes:
  None at start.

Applicable skills:
  multi-agent-working-group, openspec-propose, openspec-apply-change, openspec-archive-change.

PM/Advisor model routing:
  PM: Codex model.
  Advisor: Claude CLI.
  PM/Advisor model separation: different-model.
  Same-model override: none.

CLI workspace trust:
  Claude CLI is assigned as Advisor.
  Leader must confirm Claude CLI can read the exact current project workspace before relying on it.
  If Claude CLI reports an untrusted workspace, stop as workspace-trust-blocked and report the trust setup needed.

Advisor context:
  Owner specified Claude CLI as Advisor, so it is a trusted bounded collaboration role for this workstream.
  Send only necessary current-project evidence.
  Do not send secrets, credentials, unrelated projects, broad dumps, or irrelevant data.

Completion target:
  Proposal, design if needed, spec, tasks, implementation docs, validation, commit, push, status check, post-push review, OpenSpec archive, archive validation, archive commit, archive push, final post-push review.
```

## C1 Proposal

Leader creates:

```text
openspec/changes/add-cli-workspace-trust/proposal.md
openspec/changes/add-cli-workspace-trust/design.md
openspec/changes/add-cli-workspace-trust/specs/cli-workspace-trust/spec.md
openspec/changes/add-cli-workspace-trust/tasks.md
```

PM and Advisor review independently:

```text
PM:
  Scope is medium documentation/spec workflow.
  Recommendation: proceed with rule-level docs only.

Advisor:
  No P0/P1.
  Watch that workspace trust stays current-project only and does not imply secret access.

Leader:
  PM plus Advisor agree. Continue to C2.
```

## C2 Implementation

Leader updates `SKILL.md`, validation docs, roadmap, and examples.

Worker use is optional for medium documentation. If a Worker is used, the Worker receives one narrow file slice and cannot approve its own work.

Validation:

```text
openspec validate --changes
openspec validate --all
git diff --check
```

If validation fails, Leader fixes the issue or stops with the failed command and the affected file/check.

## C3 Closeout

Before commit:

```text
PM plus Advisor review the diff.
No unresolved P0/P1.
Required validation is fresh.
Commit target is clear.
```

Before push:

```text
PM plus Advisor review the actual commit.
Outgoing diff is scanned for secrets when available.
Remote and branch are clear.
No protected-branch bypass, force-push, release, deployment, or destructive action is involved.
```

After push:

```text
Leader checks available status or CI.
PM plus Advisor review the push result.
```

C3 is not final because the Owner asked to complete an OpenSpec-backed goal and C4 archive still applies.

## C4 Archive

Leader archives the change:

```text
openspec archive add-cli-workspace-trust --yes
openspec validate --all
openspec list --json
```

Then Leader repeats the normal commit and push gate for archive files.

Final state:

```text
Active OpenSpec changes: none.
Archived spec validation: passed.
PM plus Advisor post-push review: no unresolved P0/P1.
Goal: complete.
```

## Blocked Examples

Workspace trust blocked:

```text
Status: workspace-trust-blocked
Plain-language report:
  Claude CLI is assigned as Advisor, but it cannot read this project until this workspace is trusted. I cannot rely on it or silently switch PM and Advisor onto the same model. Recommended next step: trust only this project workspace for Claude CLI, then rerun a read-only probe.
```

Same-model PM/Advisor blocked:

```text
Status: blocked-pending-owner
Plain-language report:
  PM and Advisor would both use the same AI model. That weakens the independent second opinion you asked for. My recommendation is to use Claude CLI as Advisor and Codex as PM. If you still want same-model PM and Advisor for this task, please approve that specific downgrade.
```
