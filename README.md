# Multi-Agent Working Group

Multi-Agent Working Group is a Codex skill for running guarded development workflows with explicit Leader, PM, Advisor, Worker, and Reviewer roles. It is designed for tasks where independent critique, scoped delegation, controlled git exits, or cross-conversation handoff matter more than speed alone.

The skill is intentionally conservative. It keeps the Leader responsible for orchestration and verification, treats agent output as evidence rather than authority, and separates local completion, normal git gates, and Owner-only exclusions.

> Current local version: `v0.4.9` in local documentation. `v0.4.0` local stabilization, `v0.4.1` Advisor model diversity, `v0.4.2` CLI agent workspace trust plus OpenSpec C0-C4 lifecycle closure, `v0.4.3` Leader state compaction, `v0.4.4` lightweight local validation tooling, `v0.4.5` copyable role templates, `v0.4.6` Leader Rollover Protocol, `v0.4.7` CLI workspace trust setup protocol, `v0.4.8` Leader Rollover Opportunity Protocol, and `v0.4.9` Provider Separation, Agent Patience, And Migration Guidance are complete. This is not a release, tag, deployment, or public publication claim. For now, version tracking lives in `README.md` and `CHANGELOG.md`, while `agents/openai.yaml` remains versionless interface metadata.

## What This Skill Helps With

- Coordinating PM, Advisor, Worker, and Reviewer roles during development.
- Keeping independent review separate from implementation.
- Defaulting Advisor to a different AI provider when provider-level separation is available, unless the Owner explicitly requests same-model Advisor use.
- Keeping PM and Advisor on different AI providers by default, while treating same-provider model or version variants as degraded or partial separation.
- Treating global memory, project memory, handoff, and startup-packet model preferences as hints to verify for the current workstream rather than stale authority.
- Giving PM, Advisor, and substantive Worker slices role-appropriate patience windows instead of treating short silence as task failure.
- Handling CLI agent workspace trust as a current-project preflight and Owner-recorded current-project setup protocol before relying on CLI-based PM, Advisor, Worker, or Reviewer output.
- Running OpenSpec-backed work through C0 goal analysis, C1 proposal, C2 implementation, C3 closeout, and C4 archive.
- Making commit and push gates explicit.
- Preserving continuity across long-running or spec-bound work.
- Keeping Leader handoff and continuity state compact with current state cards, evidence indexes, and historical archive notes.
- Detecting when Leader context should roll over and preparing successor startup packets without automatically creating new conversations.
- Identifying early `Rollover Opportunity` moments before context reliability degrades.
- Recording compression count value, source, and confidence without treating visible summaries as actual total compactions.
- Keeping Medium, Complex, High-risk, or substantive Worker-suitable work out of hidden Leader execution when bounded Worker dispatch is practical.
- Running a lightweight local validation command before commit or push.
- Copying recommended role and gate templates for C0, PM, Advisor, Worker, Reviewer, blocked, handoff, successor startup, and git gate outputs.
- Recording enough evidence for a future agent or conversation to safely resume.

## What This Skill Does Not Do

- It does not authorize commits, pushes, releases, deployments, force-pushes, or destructive operations by itself.
- It does not weaken project-specific rules, security gates, spec workflows, or owner instructions.
- It does not make advisor output authoritative. The Leader must still verify claims against current evidence.
- It does not replace project tests, CI, secret scanning, or code review.
- It does not automatically create a successor conversation when rollover is recommended or required.
- It does not require Owner approval for every normal non-high-risk commit or push when the applicable PM plus Advisor gate and required evidence pass.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `SKILL.md` | The Codex skill definition and operational protocol. |
| `agents/openai.yaml` | Agent-facing metadata used by the skill bundle. |
| `CHANGELOG.md` | Local version and stabilization notes. |
| `docs/ROADMAP.md` | Development priorities and staged project direction. |
| `docs/INSTALLATION.md` | Local installation, global skill sync, migration, and adoption guidance. |
| `docs/ROLE_BOUNDARIES.md` | Working notes for Leader direct execution and role separation. |
| `docs/VALIDATION.md` | Checklist for reviewing changes before publication. |
| `examples/` | Copyable workflow examples, including blocked, git-gate, and OpenSpec C0-C4 scenarios. |
| `templates/` | Fill-in templates for common role outputs, handoffs, blocked reports, and git gates. |
| `openspec/` | OpenSpec changes, archived changes, and accepted specs. |
| `scripts/validate-local.sh` | Lightweight read-only local validation command for repo docs, OpenSpec, and installed skill sync. |

## Using The Skill

Install or expose this repository as a Codex skill source, then invoke the skill when a task involves multi-agent coordination, independent advisor review, delegated implementation, guarded commit or push flow, or cross-conversation handoff.

Typical prompt:

```text
Use the multi-agent-working-group skill for this task.
```

For small read-only or low-risk documentation tasks, the Leader may complete the work directly when the skill's Small Task Mode conditions are met. Small Task Mode does not use PM, Worker, or Reviewer; commit and push gates still require the checks described in `SKILL.md`.

When Advisor provider/model has not been recorded for the current project, session, continuity file, handoff, startup packet, or current verified model record, the Leader asks the Owner to specify the Advisor provider/model at workstream startup. Different-provider Advisor use is the default when available; same-provider variants and same-model Advisor use must be explicit or degraded and recorded.

When a CLI-based agent such as Claude CLI or Codex CLI is assigned to a role, the Leader confirms the exact current project workspace is trusted before relying on that agent. If the Owner-recorded role assignment exists in the current conversation, global memory, project rules, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence, the Leader may complete trust setup for the exact current project root without asking again. Trust setup still requires source applicability verification, current-project scoping, and a minimal read-only probe before relying on the CLI output. If workspace trust is blocked, the Leader reports the blocker instead of silently switching roles or downgrading model separation.

When this skill is used with OpenSpec, each workstream starts with C0 goal/task analysis before C1 proposal work, and completion includes C4 archive when archive applies to the goal.

PM and Advisor reviews can take time when they receive large evidence packets, OpenSpec stage context, or commit/push/archive gate material. The Leader should record expected wait/recheck behavior and should not close or replace a quiet PM or Advisor without a concrete lifecycle reason such as completion, blocked state, tool failure, exceeded patience window without progress evidence, stale evidence, role drift, context overload, rollover boundary, or Owner instruction. The same rule applies to complex, implementation-heavy, or validation-heavy Worker slices.

For long-running or spec-bound work, active Leader handoff state should be refreshed into a compact current state card. Longer logs, old handoffs, full diffs, and completed-stage narrative should be summarized and referenced through an evidence index or historical archive note when safe local evidence storage exists.

When context pressure is visible, the Leader Rollover Protocol records one canonical context-budget state plus compression count value, source, confidence, rollover reason, next safe rollover boundary, and rollover action. `Rollover Opportunity` means the Leader has a clean boundary plus a heavier next step and should refresh current state and evidence before continuing; it does not require immediate handoff. `Rollover Required` means the Leader enters sealed-ready behavior and prepares a successor startup packet before Worker dispatch, commit, push, CI, archive, or high-risk gates. Rollover states do not mean Codex silently creates a new conversation or inherits authorization.

For installation, global skill sync, and migration between machines or projects, see `docs/INSTALLATION.md`. Migration copies files and stable rules only; it does not transfer commit/push authorization, PM/Advisor agreement, Worker results, validation freshness, role continuity, CI/archive permission, secrets, or stale handoff authority.

## Copyable Templates

Use the templates in `templates/` when a workstream needs a consistent fill-in shape for C0 analysis, PM review, Advisor review, Worker assignment, Worker return, Reviewer report, blocked report, compact handoff, successor startup packet, or commit/push gate evidence.

The v0.4.9 templates are structure only. A filled template is evidence, not authorization. It does not replace PM, Advisor, Reviewer, validation, secret scanning, OpenSpec archive, CI/status, commit gates, or push gates.

When older v0.3 or earlier handoff documents have already grown large, preserve them as historical evidence. Create a new `templates/compact-handoff.md` current state card, copy only verified current facts into it, and reference the old document through the evidence index instead of appending or rewriting the old text.

## Local Validation

Run the local validation command before normal commit or push gates:

```sh
./scripts/validate-local.sh
```

After an OpenSpec-backed change is archived, use closeout mode:

```sh
./scripts/validate-local.sh --require-no-active-changes
```

The command is read-only and does not use the network. It checks `SKILL.md` frontmatter, current version markers, accepted OpenSpec specs, `openspec validate --all`, active-change state, and the installed global skill copy when present. It is only a convenience check; it does not replace PM, Advisor, Reviewer, secret scanning, OpenSpec archive, or git gate requirements.

## Development Principles

- Keep the skill readable before making it comprehensive.
- Prefer explicit gates over implicit trust.
- Make risk levels and stop conditions clear in plain language.
- Add examples before adding more rules when examples would reduce ambiguity.
- Treat continuity files, handoffs, and previous agent output as evidence, not authority.
- Refresh long active handoffs around current verifiable state instead of appending old handoff text indefinitely.
- Keep local validation lightweight and read-only until heavier automation is explicitly accepted.
- Keep Leader direct execution narrow and visible; use `docs/ROLE_BOUNDARIES.md` before promoting new role rules into `SKILL.md`.

## Validation

Before changing `SKILL.md`, review `docs/VALIDATION.md`. At minimum, confirm that:

- The frontmatter remains valid.
- Role boundaries remain clear.
- Advisor permissions stay bounded.
- Commit and push authorization rules are not weakened accidentally.
- New instructions do not conflict with existing project or owner rules.

## Current Status

This repository is in a documentation-first stabilization stage. Stage 1 foundation docs are mostly complete. The `v0.4.0` local stabilization pass for role boundaries, examples, validation alignment, and release metadata is complete; `v0.4.1` Advisor model diversity is complete; `v0.4.2` CLI agent workspace trust and OpenSpec C0-C4 lifecycle closure is complete; `v0.4.3` Leader state compaction is complete; `v0.4.4` lightweight local validation tooling is complete; `v0.4.5` copyable role templates are complete; `v0.4.6` Leader Rollover Protocol is complete; `v0.4.7` CLI workspace trust setup protocol is complete; `v0.4.8` Leader Rollover Opportunity Protocol is complete; `v0.4.9` Provider Separation, Agent Patience, And Migration Guidance is complete.

`v0.4.9` is a completed local documentation version, not a release, tag, deployment, or public publication. Normal non-high-risk commits and pushes follow the PM plus Advisor gate in `SKILL.md` with required evidence; high-risk and default-exclusion actions still require explicit Owner approval.
