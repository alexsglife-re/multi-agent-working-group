# Multi-Agent Working Group

Multi-Agent Working Group is a portable multi-agent workflow protocol for
guarded AI-agent development. It defines Leader, PM, Advisor, Worker, and
Reviewer roles, plus handoff, validation, commit, push, and release gates for
tasks where independent critique and controlled exits matter more than speed
alone.

This repository ships Codex as the reference packaged adapter. The protocol is
designed to be adapted to Claude, OpenClaw, Hermes Agent, and other agent
runtimes, but non-Codex runtimes are adapter guidance or compatible patterns
until their adapters are validated in real use.

The skill is intentionally conservative. It keeps the Leader responsible for orchestration and verification, treats agent output as evidence rather than authority, and separates local completion, normal git gates, and Owner-only exclusions.

> Current local version: `v0.4.13`. `v0.4.13` Leader Delegation And Cleanup Discipline is complete on top of the public `v0.4.12` Progressive Skill References release. Public release tags should point at reviewed commits; documentation version text alone is not a release, deployment, or external publication claim. For now, version tracking lives in `README.md`, `CHANGELOG.md`, and release tags when they are created, while `agents/openai.yaml` remains versionless interface metadata.

## What This Protocol Helps With

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
- Treating Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy,
  or context-heavy Leader direct execution beyond small connective edits as an
  exception, with more than 2 files or roughly 80 diff lines as a self-check
  trigger rather than an automatic failure.
- Dispatching bounded Worker slices before Leader context grows toward rollover
  pressure when Worker-first context control is practical.
- Closing multi-agent role agents sequentially instead of in parallel, while
  keeping gate-bearing roles open until their gate or cleanup-impact judgment is
  complete.
- Reporting cleanup failures as cleanup issues only when delivery evidence is
  already confirmed from evidence in hand and validation, PM/Advisor/Reviewer,
  git, CI/status, secret-safety, release, and authorization gates are unaffected.
- Running a lightweight local validation command before commit or push.
- Copying recommended role and gate templates for C0, PM, Advisor, Worker, Reviewer, blocked, handoff, successor startup, and git gate outputs.
- Recording enough evidence for a future agent or conversation to safely resume.
- Selecting this workflow when task traits show that multi-agent coordination, OpenSpec lifecycle, guarded git exits, handoff, rollover, or complex verification are needed.
- Closing completed work with a plain-language summary of what changed, what was verified, what remains uncertain, and recommended next goals.

## What This Protocol Does Not Do

- It does not authorize commits, pushes, releases, deployments, force-pushes, or destructive operations by itself.
- It does not weaken project-specific rules, security gates, spec workflows, or owner instructions.
- It does not make advisor output authoritative. The Leader must still verify claims against current evidence.
- It does not replace project tests, CI, secret scanning, or code review.
- It does not automatically create a successor conversation when rollover is recommended or required.
- It does not automatically spawn Workers, measure diff size, close agents, or
  repair cleanup failures.
- It does not require Owner approval for every normal non-high-risk commit or push when the applicable PM plus Advisor gate and required evidence pass.
- It does not make every named runtime fully supported. Runtime adapters must
  be validated before the project describes them as supported.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `SKILL.md` | Codex reference-adapter entry point, hard-boundary summary, and progressive-reference router. |
| `references/` | Progressive reference files that expand `SKILL.md` without weakening its constraints. |
| `agents/openai.yaml` | Agent-facing metadata used by the Codex adapter bundle. |
| `LICENSE` | MIT license for public reuse. |
| `CONTRIBUTING.md` | Issue, pull request, and validation guidance for contributors. |
| `SECURITY.md` | Sensitive-content and vulnerability-reporting guidance. |
| `CODE_OF_CONDUCT.md` | Basic community participation expectations. |
| `CHANGELOG.md` | Local version and stabilization notes. |
| `docs/ROADMAP.md` | Development priorities and staged project direction. |
| `docs/INSTALLATION.md` | Local installation, global skill sync, migration, and adoption guidance. |
| `docs/ADAPTERS.md` | Platform adapter status, maturity labels, and runtime mapping checklist. |
| `docs/ROLE_BOUNDARIES.md` | Working notes for Leader direct execution and role separation. |
| `docs/VALIDATION.md` | Checklist for reviewing changes before publication. |
| `examples/` | Copyable workflow examples, including blocked, git-gate, and OpenSpec C0-C4 scenarios. |
| `templates/` | Fill-in templates for common role outputs, handoffs, blocked reports, and git gates. |
| `openspec/` | OpenSpec changes, archived changes, and accepted specs. |
| `scripts/validate-local.sh` | Lightweight read-only local validation command for repo docs, OpenSpec, and installed skill sync. |

The `openspec/changes/archive/` directory is design history. It is useful when
you want to understand why a rule exists, but ordinary users do not need to read
the archived changes before installing or using the skill.

## License

This project is released under the MIT License. See `LICENSE`.

## Using The Protocol

Use the protocol when a task involves multi-agent coordination, independent
advisor review, delegated implementation, guarded commit or push flow, or
cross-conversation handoff. With Codex, install or expose this repository as a
Codex skill source. With other runtimes, map the protocol through an adapter as
described in `docs/ADAPTERS.md`.

Codex reference-adapter minimal install:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git
mkdir -p ~/.codex/skills/multi-agent-working-group
mkdir -p ~/.codex/skills/multi-agent-working-group/references
cp multi-agent-working-group/SKILL.md ~/.codex/skills/multi-agent-working-group/SKILL.md
cp -R multi-agent-working-group/references/. ~/.codex/skills/multi-agent-working-group/references/
```

For full checkout use, examples, validation, and migration notes, see
`docs/INSTALLATION.md`. For runtime mapping guidance, see `docs/ADAPTERS.md`.

Typical prompt:

```text
Use the multi-agent-working-group skill for this task.
```

For small read-only or low-risk documentation tasks, the Leader may complete the work directly when the skill's Small Task Mode conditions are met. Small Task Mode does not use PM, Worker, or Reviewer; commit and push gates still require the checks described in `SKILL.md`.

Future agents should automatically select or explicitly consider this skill when a task includes PM, Advisor, Worker, or Reviewer coordination; external Advisor review; OpenSpec proposal, implementation, closeout, or archive work; medium or higher risk; delegated implementation; guarded commit, push, CI/status, or archive gates; context rollover; handoff; or complex verification.

This automatic selection is only workflow/checklist reasoning. It never creates external effects or transfers authority. For example, it does not silently spawn agents, call an external Advisor, trust a workspace, commit, push, run CI, archive, deploy, release, publish, read secrets, bypass Owner-only gates, or start a recommended next goal.

When Advisor provider/model has not been recorded for the current project, session, continuity file, handoff, startup packet, or current verified model record, the Leader asks the Owner to specify the Advisor provider/model at workstream startup. Different-provider Advisor use is the default when available; same-provider variants and same-model Advisor use must be explicit or degraded and recorded.

When a CLI-based agent such as Claude CLI or Codex CLI is assigned to a role, the Leader confirms the exact current project workspace is trusted before relying on that agent. If the Owner-recorded role assignment exists in the current conversation, global memory, project rules, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence, the Leader may complete trust setup for the exact current project root without asking again. Trust setup still requires source applicability verification, current-project scoping, and a minimal read-only probe before relying on the CLI output. If workspace trust is blocked, the Leader reports the blocker instead of silently switching roles or downgrading model separation.

Codex support is the reference adapter. Other agent runtimes can implement the
same protocol using their own prompt, tool, plugin, or workflow format, but
runtime-specific docs must label unvalidated adapters as planned guidance or
compatible patterns rather than fully supported integrations.

When this skill is used with OpenSpec, each workstream starts with C0 goal/task analysis before C1 proposal work, and completion includes C4 archive when archive applies to the goal.

PM and Advisor reviews can take time when they receive large evidence packets, OpenSpec stage context, or commit/push/archive gate material. The Leader should record expected wait/recheck behavior and should not close or replace a quiet PM or Advisor without a concrete lifecycle reason such as completion, blocked state, tool failure, exceeded patience window without progress evidence, stale evidence, role drift, context overload, rollover boundary, or Owner instruction. The same rule applies to complex, implementation-heavy, or validation-heavy Worker slices.

For long-running or spec-bound work, active Leader handoff state should be refreshed into a compact current state card. Longer logs, old handoffs, full diffs, and completed-stage narrative should be summarized and referenced through an evidence index or historical archive note when safe local evidence storage exists.

For Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or
context-heavy work, the Leader uses Worker-first context control when practical:
dispatch a bounded Worker slice before the Leader context grows toward rollover
pressure. More than 2 files or roughly 80 diff lines is a self-check trigger,
not an automatic correctness failure; the Leader either dispatches a bounded
Worker or records why direct Leader execution is safer.

When context pressure is visible, the Leader Rollover Protocol records one canonical context-budget state plus compression count value, source, confidence, rollover reason, next safe rollover boundary, and rollover action. `Rollover Opportunity` means the Leader has a clean boundary plus a heavier next step and should refresh current state and evidence before continuing; it does not require immediate handoff. `Rollover Required` means the Leader enters sealed-ready behavior and prepares a successor startup packet before Worker dispatch, commit, push, CI, archive, or high-risk gates. Rollover states do not mean Codex silently creates a new conversation or inherits authorization.

At the end of multi-agent work, role-agent cleanup or close actions run
sequentially, never in parallel. Cleanup/close means role-agent teardown or
lifecycle hygiene only; validation, PM/Advisor/Reviewer review, git, CI/status,
secret-safety, release, and authorization failures cannot be relabeled as
non-blocking cleanup. Cleanup failures become blocking when they prevent
confirming task state, git state, validation state, CI/status state, secret
safety, authorization state, or required role evidence.

For installation, global skill sync, and migration between machines or projects, see `docs/INSTALLATION.md`. Migration copies files and stable rules only; it does not transfer commit/push authorization, PM/Advisor agreement, Worker results, validation freshness, role continuity, CI/archive permission, secrets, or stale handoff authority.

## Copyable Templates

Use the templates in `templates/` when a workstream needs a consistent fill-in shape for C0 analysis, PM review, Advisor review, Worker assignment, Worker return, Reviewer report, blocked report, compact handoff, successor startup packet, or commit/push gate evidence.

The v0.4.13 templates are structure only. A filled template is evidence, not authorization. It does not replace PM, Advisor, Reviewer, validation, secret scanning, OpenSpec archive, CI/status, commit gates, push gates, release approval, cleanup-impact judgment, or Owner-only default-exclusion approval. Completion summaries and next-goal recommendations are reporting aids only; they do not authorize starting new work unless the Owner has already given explicit current-session authorization.

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

The command is read-only and does not use the network. It checks `SKILL.md` frontmatter, current version markers, accepted OpenSpec specs, `openspec validate --all`, active-change state, template and reference anchors, and the installed global skill plus required references when present. It is only a convenience check; it does not replace PM, Advisor, Reviewer, secret scanning, OpenSpec archive, git gate requirements, or runtime compliance with cleanup/delegation behavior.

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
- Public-facing docs do not include private machine paths, credentials, or
  personal model-routing defaults.
- Platform-facing docs do not claim full runtime support before an adapter is
  validated.

Before a public release, also run:

```sh
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
rg -n "(token|api[_-]?key|secret|password|private key|/Users/|gmail|Keychain|GITHUB_PAT)" .
```

The content scan is broad by design. Safety-instruction matches are expected;
real secrets, credentials, private project details, and local machine-specific
paths must be removed before publication.

## Current Status

This repository is in a documentation-first stabilization stage. Stage 1 foundation docs are mostly complete. The `v0.4.0` through `v0.4.13` stabilization and public-release preparation work is complete. `v0.4.13` tightens Leader delegation and role-agent cleanup discipline while preserving `SKILL.md` as the fail-closed hard-boundary summary and mandatory router.

`v0.4.13` is the current documented version. A public release should be created
only after the release-preparation diff is reviewed, validation passes, and a
tag such as `v0.4.13` points at the reviewed commit. Normal non-high-risk
commits and pushes follow the PM plus Advisor gate in `SKILL.md` with required
evidence; high-risk and default-exclusion actions still require explicit Owner
approval.
