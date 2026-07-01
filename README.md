# Multi-Agent Working Group

Multi-Agent Working Group is a Codex skill for running guarded development workflows with explicit Leader, PM, Advisor, Worker, and Reviewer roles. It is designed for tasks where independent critique, scoped delegation, controlled git exits, or cross-conversation handoff matter more than speed alone.

The skill is intentionally conservative. It keeps the Leader responsible for orchestration and verification, treats agent output as evidence rather than authority, and separates local completion, normal git gates, and Owner-only exclusions.

> Current stabilization target: `v0.4.0` in local documentation. This is a planned documentation-first milestone, not a release, tag, push, deployment, or public publication claim. For now, version tracking lives in `README.md` and `CHANGELOG.md`, while `agents/openai.yaml` remains versionless interface metadata.

## What This Skill Helps With

- Coordinating PM, Advisor, Worker, and Reviewer roles during development.
- Keeping independent review separate from implementation.
- Making commit and push gates explicit.
- Preserving continuity across long-running or spec-bound work.
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
| `docs/ROADMAP.md` | Development priorities and staged project direction. |
| `docs/ROLE_BOUNDARIES.md` | Working notes for Leader direct execution and role separation. |
| `docs/VALIDATION.md` | Checklist for reviewing changes before publication. |

## Using The Skill

Install or expose this repository as a Codex skill source, then invoke the skill when a task involves multi-agent coordination, independent advisor review, delegated implementation, guarded commit or push flow, or cross-conversation handoff.

Typical prompt:

```text
Use the multi-agent-working-group skill for this task.
```

For small read-only or low-risk documentation tasks, the Leader may complete the work directly when the skill's Small Task Mode conditions are met. Small Task Mode does not use PM, Worker, or Reviewer; commit and push gates still require the checks described in `SKILL.md`.

## Development Principles

- Keep the skill readable before making it comprehensive.
- Prefer explicit gates over implicit trust.
- Make risk levels and stop conditions clear in plain language.
- Add examples before adding more rules when examples would reduce ambiguity.
- Treat continuity files, handoffs, and previous agent output as evidence, not authority.
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

This repository is in a documentation-first stabilization stage. Stage 1 foundation docs are mostly complete, and Stage 2 is the current `v0.4.0` focus: role-boundary clarification, operating examples, validation alignment, and release metadata.

`v0.4.0` remains a current/planned local stabilization target, not a release, tag, push, deployment, or public publication. Normal non-high-risk commits and pushes follow the PM plus Advisor gate in `SKILL.md` with required evidence; high-risk and default-exclusion actions still require explicit Owner approval.
