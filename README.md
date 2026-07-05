<h1 align="center">Multi-Agent Working Group</h1>

<p align="center">
  <img src="assets/social-preview.jpg" alt="Multi-Agent Working Group - Safer multi-agent workflows for AI coding" width="100%">
</p>

<p align="center">
  <strong>Controlled multi-agent work for tasks where review, evidence, and safe exits matter more than speed.</strong>
</p>

<p align="center">
  <a href="#quick-start"><img src="https://img.shields.io/badge/Quick_Start-2_min-blue?style=for-the-badge" alt="Quick Start"></a>
  <a href="docs/ADAPTERS.md"><img src="https://img.shields.io/badge/Adapters-Codex_reference-black?style=for-the-badge" alt="Codex reference adapter"></a>
  <a href="docs/VALIDATION.md"><img src="https://img.shields.io/badge/Validation-local_checks-green?style=for-the-badge" alt="Local validation"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="MIT License"></a>
</p>

AI agents are fast, but fast work can blur who reviewed what, which evidence was
checked, and whether a commit, push, release, or handoff was actually
authorized.

Multi-Agent Working Group is a portable workflow protocol for AI-assisted work.
It gives careful tasks clear roles, independent review, durable evidence, and
explicit gates for validation, handoff, git, and release decisions.

Use it when you want agents to help with serious work without silently approving
their own output, losing context across conversations, or turning "looks done"
into "safe to ship."

This repository ships Codex as the reference packaged adapter. The protocol is
designed to be adapted to Claude, OpenClaw, Hermes Agent, and other agent
runtimes, but non-Codex runtimes are adapter guidance or compatible patterns
until their adapters are validated in real use.

| Without a working protocol | With Multi-Agent Working Group |
| --- | --- |
| Reviews, handoffs, and git exits depend on memory and chat history. | Leader, PM, Advisor, Worker, and Reviewer roles produce explicit evidence. |
| Agent output can look authoritative before it is checked. | Agent output is treated as evidence until the Leader verifies it. |
| Commit, push, release, and cleanup boundaries can blur together. | Local completion, normal git gates, and Owner-only exclusions stay separate. |

The skill is intentionally conservative. It keeps the Leader responsible for
orchestration and verification, treats agent output as evidence rather than
authority, and separates local completion, normal git gates, and Owner-only
exclusions.

> Current local version: `v0.4.15`. `v0.4.15` Fast Path And Anchor Guardrails is in progress on top of the public `v0.4.14` Adoption Scenarios And Adapter Guardrails release. Public release tags should point at reviewed commits; documentation version text alone is not a release, deployment, or external publication claim. For now, version tracking lives in `README.md`, `CHANGELOG.md`, and release tags when they are created, while `agents/openai.yaml` remains versionless interface metadata.

## Quick Start

Use the protocol when a task benefits from independent critique, delegated work,
controlled commit or release gates, cross-conversation continuity, or a clear
record of what was checked before moving forward.

Codex reference-adapter minimal install:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git
mkdir -p ~/.codex/skills/multi-agent-working-group
mkdir -p ~/.codex/skills/multi-agent-working-group/references
cp multi-agent-working-group/SKILL.md ~/.codex/skills/multi-agent-working-group/SKILL.md
cp -R multi-agent-working-group/references/. ~/.codex/skills/multi-agent-working-group/references/
```

Typical prompt:

```text
Use the multi-agent-working-group skill for this task.
```

For full checkout use, migration, validation, and scenario guidance, see
`docs/INSTALLATION.md` and `docs/ADOPTION.md`.

## Use Cases

Use Multi-Agent Working Group when you want to:

- coordinate PM, Advisor, Worker, and Reviewer roles during development;
- review whether an open-source repository is ready for promotion;
- improve the README first screen and quickstart path;
- draft release notes, Show HN posts, Reddit variants, LinkedIn posts, or X
  threads without publishing them automatically;
- create a staged launch or release-preparation plan;
- check whether public copy overstates runtime support, automation, safety, or
  maturity;
- run OpenSpec-backed work through C0 goal analysis, C1 proposal, C2
  implementation, C3 closeout, and C4 archive;
- preserve compact handoff evidence across long-running or spec-bound work;
- keep normal commit and push gates separate from Owner-only release,
  deployment, publication, force-push, destructive, secret, auth, and permission
  actions.

For scenario-specific adoption guidance, see `docs/ADOPTION.md`.

## Safety Boundaries

This protocol gives agents a workflow and evidence structure. It does not, by
itself:

- authorize commits, pushes, releases, tags, deployments, force-pushes,
  destructive operations, or external publication;
- edit GitHub metadata such as repository description, topics, homepage URL, or
  social preview;
- make Advisor, PM, Worker, Reviewer, handoff, memory, or template output
  authoritative before Leader verification;
- replace project tests, CI, secret scanning, code review, or OpenSpec archive;
- read secrets, credentials, Keychain data, browser data, or unrelated projects;
- automatically create successor conversations, spawn Workers, measure diff
  size, close role agents, repair cleanup failures, or install external tools;
- make every named runtime fully supported. Runtime adapters must be validated
  before the project describes them as supported.

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

## Adoption Docs

Start with these docs when you need more than the quick path above:

- `docs/ADOPTION.md`: scenario guide for documentation, release preparation,
  long-running work, handoff, and ordinary small tasks.
- `docs/INSTALLATION.md`: local checkout use, Codex reference-adapter install,
  global skill sync, and migration boundaries.
- `docs/ADAPTERS.md`: adapter maturity labels, mapping checklist, and future
  runtime guide template.
- `docs/VALIDATION.md`: validation checklist for docs, OpenSpec, release
  readiness, and local checks.

For small read-only or low-risk documentation tasks, the Leader may complete the
work directly when every Small Task Mode condition in `SKILL.md` is met. Commit,
push, archive, tag, release, deployment, publication, and other gated actions
still use the stricter rules.

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

This repository is in a documentation-first stabilization stage. Stage 1 foundation docs are mostly complete. The `v0.4.0` through `v0.4.14` stabilization and public-release preparation work is complete. `v0.4.15` clarifies Fast Path reading order and anchor guardrails while preserving `SKILL.md` as the fail-closed hard-boundary summary and mandatory router.

`v0.4.15` is the current documented version. A future public release should be
created only after the release-preparation diff is reviewed, validation passes,
and an explicitly authorized tag points at the reviewed commit. Normal non-high-risk
commits and pushes follow the PM plus Advisor gate in `SKILL.md` with required
evidence; high-risk and default-exclusion actions still require explicit Owner
approval.
