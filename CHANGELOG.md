# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Completed local upgrade for v0.4.14: Adoption Scenarios And Adapter Guardrails

- Add `docs/ADOPTION.md` with scenario guidance for documentation tasks,
  release preparation, long-running project work, cross-conversation handoff,
  and ordinary small tasks.
- Restructure the README around Quick Start, Use Cases, Safety Boundaries, and
  deeper adoption links without turning the always-loaded `SKILL.md` into a
  long scenario guide.
- Clarify installation guidance so readers distinguish adopting the workflow
  protocol from installing the Codex reference adapter.
- Add adapter guide template and review checklist guidance while keeping
  Claude, OpenClaw, Hermes Agent, and other non-Codex runtimes labeled as
  planned guidance or compatible patterns until validated.
- Add release-preparation and long-running documentation workstream examples.
- Extend local validation anchors for adoption guidance and adapter guardrails
  without adding CI, release automation, link checking, or semantic runtime
  enforcement.

### Completed local upgrade for v0.4.13: Leader Delegation And Cleanup Discipline

- Add role-agent cleanup discipline: cleanup/close actions run sequentially,
  never in parallel, and gate-bearing roles stay open until their gate or
  cleanup-impact judgment is complete.
- Define cleanup/close narrowly as role-agent teardown or lifecycle hygiene,
  not validation, PM/Advisor/Reviewer, git, CI/status, secret-scan, release, or
  authorization failure.
- Allow cleanup failure to be reported as degraded cleanup evidence only when
  delivery evidence is already confirmed from evidence in hand and required
  gates are unaffected; escalate cleanup failure when it blocks evidence.
- Add Leader work-budget self-check guidance for Medium, Complex,
  OpenSpec-backed, multi-file, implementation-heavy, or context-heavy work.
- Add Worker-first context-control guidance so bounded Worker slices are
  dispatched before Leader context grows toward rollover pressure when
  practical.
- Update templates and local validation anchors for cleanup status, bounded
  Worker dispatch, and validation-anchor limits.

### Completed local upgrade for v0.4.12: Progressive Skill References

- Split long-form skill details into progressive `references/` files while
  keeping `SKILL.md` as the fail-closed router and hard-boundary summary.
- Preserve the existing `SKILL.md` validation anchor set and add dedicated
  anchors for PM/Advisor no-peek independence, Advisor evidence-not-authority,
  and handoff evidence-not-authorization.
- Add mandatory reference routing for git/default exclusions, OpenSpec, CLI
  trust, rollover/handoff, and role output domains.
- Add `references/TRACEABILITY.md` so reviewers can verify that hard boundaries
  remain in `SKILL.md` and detailed rules remain reachable.
- Extend local validation checks for references, routing, and representative
  no-constraint-reduction scenarios.

### Completed local upgrade for v0.4.11: Platform-Neutral Protocol Positioning

- Reposition Multi-Agent Working Group as a portable multi-agent workflow
  protocol with Codex as the reference packaged adapter.
- Add `docs/ADAPTERS.md` with adapter maturity labels and required runtime
  mapping fields.
- Document Claude, OpenClaw, and Hermes Agent as planned adapter guidance rather
  than fully supported integrations.
- Update installation guidance to separate generic protocol adoption from Codex
  reference-adapter installation.
- Extend local validation checks for platform-neutral positioning markers.

### Public release preparation for v0.4.10

- Add MIT licensing for public reuse.
- Add contributor, security, and code-of-conduct guidance.
- Document public release checks, sensitive-content scanning, and release tag order.
- Clarify that archived OpenSpec changes are design history and not required reading for ordinary users.
- Keep public rules model-agnostic and exclude local-only provider/model preferences from the reusable skill.

### Completed local upgrade for v0.4.10: Invocation, Migration, And Plain-Language Closeout Guidance

- Add task-trait guidance for when agents should select or explicitly consider `multi-agent-working-group`.
- Clarify that automatic skill invocation means workflow/checklist reasoning only and never creates external effects or transfers authority.
- Strengthen migration and adoption guidance without transferring authorization, role continuity, validation freshness, workspace trust, secrets, or stale handoff authority.
- Require completed work and safe stopping points to include a plain-language closeout: what changed, what was verified, what remains uncertain or was not checked, and recommended next goals.
- Clarify that next-goal recommendations are advice only unless the Owner has already given explicit current-session authorization.
- Update templates and local validation checks for v0.4.10 invocation, migration, and closeout markers.

### Completed local upgrade for v0.4.9: Provider Separation, Agent Patience, And Migration Guidance

- Clarify that Advisor diversity and PM/Advisor model separation default to provider-level separation, not same-provider model or version variants.
- Add separation status vocabulary: `provider-separated`, `model-family-separated`, `same-provider-variant`, `same-model-owner-override`, `degraded`, and `blocked`.
- Treat global memory, project memory, handoff, and startup-packet model preferences as hints to verify for the current workstream rather than stale authority.
- Update C0, compact handoff, and successor startup templates to carry provider/model per role, model source, current verification, and separation status.
- Clarify PM/Advisor and substantive Worker patience rules so short silence is not treated as failure without a concrete lifecycle reason.
- Add `docs/INSTALLATION.md` for local checkout use, global skill sync, machine migration, and project adoption boundaries.
- Extend local validation checks for provider-level separation and current verified model records.

### Completed local upgrade for v0.4.8

- Add `Rollover Opportunity` as an early preparation state before context reliability degrades.
- Require exactly one canonical ContextBudget state per check, with the highest applicable state winning.
- Replace compression count confidence-only recording with compression count value, source, and confidence.
- Prohibit treating platform-visible summaries as actual total compaction counts unless independently verified or Owner-reported.
- Clarify that dashboards, conflicts, overlaps, gate state, and role continuity are evidence inputs, not a separate state machine or runtime dashboard.
- Preserve same-workstream PM plus Advisor gate automation for normal non-high-risk commit, push, CI/status, and archive progression while keeping successor authorization non-inheritable.
- Add Leader delegation discipline for Medium, Complex, High-risk, or substantive Worker-suitable work.

### Completed local upgrade for v0.4.7

- Add CLI workspace trust setup protocol for Owner-recorded Claude CLI, Codex CLI, and similar CLI role assignments.
- Treat applicable Owner-recorded role assignment from current instruction, memory, project rules, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence as authorization for exact current-project trust setup.
- Add trust setup state vocabulary: `not-needed`, `preflight-needed`, `owner-recorded-role-authorized`, `trust-setup-attempted`, `trusted-verified`, and `blocked`.
- Require source applicability verification and a post-setup minimal read-only probe before relying on CLI role output.
- Preserve boundaries against dangerous permission bypass, broad directory trust, secrets, global policy expansion, git actions, CI, deployment, release, publication, or external effects.
- Update templates and local validation to check v0.4.7 trust setup markers.

### Completed local upgrade for v0.4.6

- Add Leader Rollover Protocol for explicit context-budget records, observed compression/summary thresholds, and rollover-safe actions.
- Add `Rollover Strongly Recommended` and sealed-ready guidance before Worker dispatch, commit, push, CI, archive, and high-risk gates.
- Add `templates/successor-startup-packet.md` and update compact handoff templates with context-budget, dashboard, pending-message, conflict, and successor verification fields.
- Document that v0.4.6 automatically detects rollover conditions and prepares handoff evidence, but does not automatically create successor conversations or carry forward authorization.
- Update local validation to check v0.4.6 markers, rollover protocol text, the successor packet template, and the accepted rollover spec.

### Completed local upgrade for v0.4.5

- Add `templates/` with copyable C0, PM, Advisor, Worker, Reviewer, blocked, handoff, and git-gate templates.
- Document that v0.4.5 templates are structure only and do not replace validation, review, OpenSpec archive, secret scanning, CI/status, commit gates, or push gates.
- Add legacy and bloated document handling: preserve old v0.3-era handoffs as historical evidence, extract only verified current facts into the new compact handoff, and reference old material through the evidence index.
- Update local validation to check v0.4.5 markers, required templates, and the copyable-role-templates spec.

### Completed local upgrade for v0.4.4

- Add `scripts/validate-local.sh` as a lightweight read-only local validation command.
- Check `SKILL.md` frontmatter, current version markers, accepted OpenSpec specs, OpenSpec validation, active-change state, and installed global skill sync.
- Add closeout mode for requiring no active OpenSpec changes after archive.
- Document that the local command does not replace PM, Advisor, Reviewer, secret scanning, OpenSpec archive, or git gates.

### Completed local upgrade for v0.4.3

- Add Leader state compaction rules using a current state card, evidence index, and historical archive notes.
- Require long active handoffs and ledgers to be refreshed around current verifiable state instead of becoming append-only transcripts.
- Add a compact handoff example that preserves gates, validation freshness, PM/Advisor continuity, unresolved findings, and evidence references.
- Add validation checks for handoff bloat controls while keeping reference-source influence rule-level only.

### Completed local upgrade for v0.4.2

- Add CLI agent workspace-trust preflight rules for Claude CLI, Codex CLI, and similar role agents.
- Clarify that an Owner-specified Advisor is a trusted bounded collaboration role for the current workstream, not an ordinary third-party service.
- Require PM and Advisor to use different AI models by default, without silent same-model degradation unless the Owner explicitly approves it.
- Add OpenSpec C0 goal/task analysis before C1 proposal work and require C4 archive when archive belongs to the goal.

### Completed local upgrade for v0.4.1

- Add Advisor model-diversity defaults so Advisor uses a different AI model by default when model selection is available.
- Require Leader to ask for and record Advisor model/provider when no project, session, continuity, or handoff record exists.
- Preserve bounded trusted-Advisor context, independent Leader verification, and existing PM/Advisor/Reviewer gates.

### Completed local stabilization for v0.4.0

- Stabilize role-boundary guidance around Leader direct execution, Small Task Mode, Worker delegation, Reviewer independence, and blocked-state reporting.
- Add operating examples for guarded commit flow, guarded push flow, and continuity recovery where prior handoffs remain evidence rather than authority.
- Align validation and release-readiness documentation with the v0.4.0 documentation-first stabilization target.
- Add visible version metadata in project docs so `README.md`, `docs/TODO.md`, and the changelog point to the same current target.
- Keep `agents/openai.yaml` versionless for now because it describes agent interface metadata, not the release source of truth.
