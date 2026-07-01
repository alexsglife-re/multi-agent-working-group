# Multi-Agent Working Group

Multi-Agent Working Group is a Codex skill for running guarded development workflows with explicit Leader, PM, Advisor, Worker, and Reviewer roles. It is designed for tasks where independent critique, scoped delegation, controlled git exits, or cross-conversation handoff matter more than speed alone.

The skill is intentionally conservative. It keeps the Leader responsible for orchestration and verification, treats agent output as evidence rather than authority, and separates local completion, normal git gates, and Owner-only exclusions.

> Current local version: `v0.4.3` in local documentation. `v0.4.0` local stabilization, `v0.4.1` Advisor model diversity, `v0.4.2` CLI agent workspace trust plus OpenSpec C0-C4 lifecycle closure, and `v0.4.3` Leader state compaction are complete. This is not a release, tag, deployment, or public publication claim. For now, version tracking lives in `README.md` and `CHANGELOG.md`, while `agents/openai.yaml` remains versionless interface metadata.

## What This Skill Helps With

- Coordinating PM, Advisor, Worker, and Reviewer roles during development.
- Keeping independent review separate from implementation.
- Defaulting Advisor to a different AI model when model selection is available, unless the Owner explicitly requests same-model Advisor use.
- Keeping PM and Advisor on different AI models by default, without silent same-model degradation.
- Handling CLI agent workspace trust as a current-project preflight before relying on CLI-based PM, Advisor, Worker, or Reviewer output.
- Running OpenSpec-backed work through C0 goal analysis, C1 proposal, C2 implementation, C3 closeout, and C4 archive.
- Making commit and push gates explicit.
- Preserving continuity across long-running or spec-bound work.
- Keeping Leader handoff and continuity state compact with current state cards, evidence indexes, and historical archive notes.
- Recording enough evidence for a future agent or conversation to safely resume.

## What This Skill Does Not Do

- It does not authorize commits, pushes, releases, deployments, force-pushes, or destructive operations by itself.
- It does not weaken project-specific rules, security gates, spec workflows, or owner instructions.
- It does not make advisor output authoritative. The Leader must still verify claims against current evidence.
- It does not replace project tests, CI, secret scanning, or code review.
- It does not require Owner approval for every normal non-high-risk commit or push when the applicable PM plus Advisor gate and required evidence pass.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `SKILL.md` | The Codex skill definition and operational protocol. |
| `agents/openai.yaml` | Agent-facing metadata used by the skill bundle. |
| `CHANGELOG.md` | Local version and stabilization notes. |
| `docs/ROADMAP.md` | Development priorities and staged project direction. |
| `docs/ROLE_BOUNDARIES.md` | Working notes for Leader direct execution and role separation. |
| `docs/VALIDATION.md` | Checklist for reviewing changes before publication. |
| `examples/` | Copyable workflow examples, including blocked, git-gate, and OpenSpec C0-C4 scenarios. |
| `openspec/` | OpenSpec changes, archived changes, and accepted specs. |

## Using The Skill

Install or expose this repository as a Codex skill source, then invoke the skill when a task involves multi-agent coordination, independent advisor review, delegated implementation, guarded commit or push flow, or cross-conversation handoff.

Typical prompt:

```text
Use the multi-agent-working-group skill for this task.
```

For small read-only or low-risk documentation tasks, the Leader may complete the work directly when the skill's Small Task Mode conditions are met. Small Task Mode does not use PM, Worker, or Reviewer; commit and push gates still require the checks described in `SKILL.md`.

When Advisor model/provider has not been recorded for the current project, session, continuity file, or handoff, the Leader asks the Owner to specify the Advisor model/provider at workstream startup. A different Advisor model is the default when available; same-model Advisor use must be explicit and recorded.

When a CLI-based agent such as Claude CLI or Codex CLI is assigned to a role, the Leader confirms the exact current project workspace is trusted before relying on that agent. If workspace trust is blocked, the Leader reports the blocker instead of silently switching roles or downgrading model separation.

When this skill is used with OpenSpec, each workstream starts with C0 goal/task analysis before C1 proposal work, and completion includes C4 archive when archive applies to the goal.

For long-running or spec-bound work, active Leader handoff state should be refreshed into a compact current state card. Longer logs, old handoffs, full diffs, and completed-stage narrative should be summarized and referenced through an evidence index or historical archive note when safe local evidence storage exists.

## Development Principles

- Keep the skill readable before making it comprehensive.
- Prefer explicit gates over implicit trust.
- Make risk levels and stop conditions clear in plain language.
- Add examples before adding more rules when examples would reduce ambiguity.
- Treat continuity files, handoffs, and previous agent output as evidence, not authority.
- Refresh long active handoffs around current verifiable state instead of appending old handoff text indefinitely.
- Avoid adding automation until the manual workflow has been tested on real tasks.
- Keep Leader direct execution narrow and visible; use `docs/ROLE_BOUNDARIES.md` before promoting new role rules into `SKILL.md`.

## Validation

Before changing `SKILL.md`, review `docs/VALIDATION.md`. At minimum, confirm that:

- The frontmatter remains valid.
- Role boundaries remain clear.
- Advisor permissions stay bounded.
- Commit and push authorization rules are not weakened accidentally.
- New instructions do not conflict with existing project or owner rules.

## Current Status

This repository is in a documentation-first stabilization stage. Stage 1 foundation docs are mostly complete. The `v0.4.0` local stabilization pass for role boundaries, examples, validation alignment, and release metadata is complete; `v0.4.1` Advisor model diversity is complete; `v0.4.2` CLI agent workspace trust and OpenSpec C0-C4 lifecycle closure is complete; `v0.4.3` Leader state compaction is complete.

`v0.4.3` is a completed local documentation version, not a release, tag, deployment, or public publication. Normal non-high-risk commits and pushes follow the PM plus Advisor gate in `SKILL.md` with required evidence; high-risk and default-exclusion actions still require explicit Owner approval.
