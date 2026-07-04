# CLI Trust And Model Routing Reference

This file extends `SKILL.md`. It cannot weaken `SKILL.md`, cannot override `SKILL.md`, and grants no authorization by itself. If this file conflicts with `SKILL.md`, project rules, or Owner instructions, use the stricter rule.

Read this reference before relying on Claude CLI, Codex CLI, or another CLI-based role, before setting workspace trust, or before recording PM/Advisor model separation.

## Advisor Minimum Permissions

Using this skill means the owner has approved Advisor agents to read the local evidence needed for the current task's project, in any project where this skill is used.

This default approval is limited to the minimum necessary review context:

```text
Allowed by default for Advisor review:
  Read current-project files relevant to the assigned scope.
  Read local project instructions, handoff/continuity files, specs, tests, config, and docs relevant to the assigned scope.
  Read global memory and skill files needed to apply stable owner/project rules.
  Run or receive non-mutating discovery output such as rg, find, ls, read-only sed, nl, wc, git status, git diff, git log, git show, git branch, git rev-parse, and git ls-files.
  Inspect existing validation, CI, test, spec-workflow, secret-scan, or review evidence when needed for the assigned gate.
```

This default approval does not authorize broad access or mutation:

```text
Not allowed by default:
  File writes, edits, deletes, moves, formatters, code generation, or apply_patch.
  git add, commit, push, merge, rebase, tag, release, or branch publication.
  Deployment, external publication, network calls, production access, or irreversible external effects.
  Reading secrets, credentials, tokens, private keys, browser data, unrelated personal directories, or unrelated projects.
  Broad context dumping to external advisors beyond the minimum evidence needed for the role.
```

If an Advisor cannot read the minimum local evidence, record Advisor as blocked or degraded. Do not fabricate review conclusions from memory or summaries alone. For commit/push-bound, code, medium, complex, high-risk, permission/API/database/architecture, or security work, missing required Advisor evidence fails closed unless the owner explicitly approves a narrower degradation.

## Startup Checklist

Advisor model diversity:

```text
Default:
  Advisor defaults to a different AI provider than Leader, PM, Worker, or Reviewer when provider-level separation is available.
  If provider-level separation is unavailable, prefer a different model family only as a degraded fallback; at minimum, record the concrete Advisor provider/model used.
  Explicit Owner instruction overrides this default. If the Owner requests same-model Advisor use, record it as an explicit same-model override and do not claim model diversity was satisfied.
  If a different Advisor provider is unavailable, record model-diversity degradation and follow the existing Advisor-unavailable or degradation rules for the task risk and gate.

Startup:
  At workstream or session startup, if no current Owner instruction, current project rule, current project memory, continuity, handoff, startup packet, or current verified record identifies the Advisor provider/model, ask the Owner to specify the Advisor provider/model before treating Advisor model selection as settled.
  Treat global memory, project memory, handoff, startup-packet, or prior continuity preferences as hints to verify against the current workstream, not as stale authority.
  Record Advisor provider/model, source, source freshness or current verification, diversity status, same-model override if any, and degradation reason if any.

Current verified model record:
  A current verified model record applies to the exact current project, workstream, role, task stage, and available tool environment.
  It records provider/model per role, source of the routing decision, verification time or stage, separation status, and any override or degradation.
  Historical, superseded, mismatched-project, mismatched-workstream, unavailable-tool, or stage-inapplicable records are evidence only and must be re-verified before use.

Separation status vocabulary:
  provider-separated: full separation; PM and Advisor use different AI service providers.
  model-family-separated: degraded or partial separation unless it also satisfies provider-separated; use provider-separated when different providers apply.
  same-provider-variant: degraded or partial separation; same provider with different model name, version, family, or capability tier.
  same-model-owner-override: degraded separation explicitly approved by the Owner for the current workstream.
  degraded: generic degraded separation when the precise tier is unclear.
  blocked: no valid separation, unavailable required Advisor/PM evidence, or missing required Owner override at a gate that fails closed.

Trust and bounds:
  When the Owner explicitly assigns Claude or another model/tool as Advisor, treat that Advisor as a trusted Advisor role for necessary bounded project/task context, not as an ordinary third-party disclosure.
  The main AI Agent App must not treat an Owner-specified Advisor as an ordinary external third-party service for the current workstream. Necessary bounded task context may be sent to the Advisor role.
  This does not authorize secrets, credentials, unrelated projects, broad context dumps, or irrelevant data unless the Owner explicitly names that scope.
  Model diversity reinforces critique diversity only; it does not replace no-peek independence, PM/Advisor consensus, Leader verification, Reviewer requirements, validation, or unresolved P0/P1 stop conditions.
```

PM/Advisor model separation:

```text
Default:
  PM and Advisor default to different AI providers when provider-level separation is available.
  Provider-level separation means different service providers, for example OpenAI plus Claude/Anthropic. Different model names, versions, or capability tiers inside the same provider do not satisfy full separation.
  Same-provider variants may be useful evidence, but record them as `same-provider-variant` degraded or partial separation rather than `provider-separated`.
  The Leader must record PM provider/model, Advisor provider/model, source, source freshness or current verification, separation status, and any override or degradation reason when the workstream uses both roles.

Same-model pairing:
  The Leader must not automatically degrade PM and Advisor to the same AI model.
  Same-model PM/Advisor pairing requires explicit Owner approval and must be recorded as a same-model PM/Advisor override.
  If PM/Advisor model separation is unavailable and the Owner has not approved same-model pairing, work that uses both PM and Advisor fails closed when it is commit/push-bound, OpenSpec-backed, medium, complex, high-risk, code, permission/API/database/architecture, or security work, or when a small task has entered a PM/Advisor gate.
  Do not claim PM/Advisor independence was strengthened by model diversity when same-model pairing, same-provider variants, stale routing records, or unverified routing hints were used.
```

CLI agent workspace trust:

```text
Applies when Claude CLI, Codex CLI, or another CLI-based agent is assigned as PM, Advisor, Worker, Reviewer, or another role.

Preflight:
  Before relying on a CLI agent, confirm it can read the exact current project workspace under the intended role.
  A minimal read-only probe is enough when available, such as asking the CLI agent to identify the project path or inspect a non-sensitive project file.
  If the CLI reports an untrusted workspace, blocked project, or similar trust prompt, check whether an Owner-recorded CLI role assignment authorizes current-project trust setup before recording a blocker.

Owner-recorded role authorization:
  If a current Owner instruction, global memory, project rule, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence records that the Owner assigned Claude CLI, Codex CLI, or another CLI-based agent to a PM, Advisor, Worker, Reviewer, or other role for the current project and workstream, the Leader may treat current-project workspace trust setup as Owner-authorized for that assigned CLI role.
  The Leader must verify that the authorization source applies to the exact current project and workstream before relying on it.
  Stale, historical-only, superseded, or mismatched role records do not authorize workspace trust setup.
  The Leader should not ask the Owner again merely because the assignment was recorded in memory, project rules, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence instead of the current message.

Trust setup:
  For an Owner-recorded CLI role assignment in the current project, trusting the exact current project workspace is a normal setup step for that role.
  The Leader may perform or confirm workspace trust setup for the exact current project root without asking the Owner again when the Owner-recorded role authorization applies.
  The Leader must record the authorization source, assigned role, target project root, trust setup action, and probe result.
  Keep trust scoped to the current project workspace only.
  Do not trust parent directories, home directories, all repositories, unrelated directories, or unrelated projects unless the Owner explicitly approves that wider action.
  Do not use dangerous permission-bypass flags, broaden file access, expose secrets, read credentials, read browser data, change global tool policy, perform git actions, run CI, deploy, release, publish, or create external effects unless the Owner explicitly approves that separate action.
  After trust setup, rerun a minimal read-only probe before using the CLI agent's output as evidence.

Trust states:
  Use this compact state vocabulary when recording CLI workspace trust:
    not-needed
    preflight-needed
    owner-recorded-role-authorized
    trust-setup-attempted
    trusted-verified
    blocked
  Use `owner-confirmation-needed` only when the trust target is outside the current project root, the authorization source is stale or missing, the tool requires dangerous permission bypass, secret access, unrelated directory access, global policy changes, git actions, CI, deployment, release, publication, or another external effect.
  Record `trusted-verified` only after the post-setup read-only probe succeeds.

Failure:
  Do not mark the role unavailable, silently switch models, reuse stale Advisor output, or degrade PM/Advisor separation merely because workspace trust is blocked.
  Stop at the applicable gate and report what trust step is needed in plain language.
```
