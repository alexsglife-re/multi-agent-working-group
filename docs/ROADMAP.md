# Roadmap

This roadmap keeps development incremental. The goal is to make the protocol useful, reviewable, and safe before adding heavier automation.

## Stage 1: Project Foundation

Goal: make the repository understandable and safe to change.

Status: mostly complete. The foundation docs exist and were aligned during the local `v0.4.0` stabilization target; this status does not imply a release, tag, push, deployment, or public publication.

- Add README, roadmap, and validation checklist.
- Define the expected repository layout.
- Make the skill's purpose, non-goals, and safety boundaries easy to find.
- Keep all project documentation English-only by default.
- Avoid behavior-changing edits to `SKILL.md` unless they are reviewed against the validation checklist.

Exit criteria:

- A new reader can understand what the skill is for within a few minutes.
- A contributor can identify what to check before editing the skill.
- The repo has a clear next-step plan.

## Stage 2: Examples And Operating Patterns

`v0.4.0` local stabilization through `v0.4.17` Role Review Context Efficiency
are complete and publicly released.

`v0.4.18` Review Packet Retention And Cleanup is the current development target; it is not published.

Goal: make the workflow easier to apply consistently.

- Add `examples/` with small, medium, commit-gate, push-gate, and handoff scenarios.
- Add example PM, Advisor, Worker, and Reviewer outputs.
- Add copyable PM, Advisor, Worker, Reviewer, C0, blocked, handoff, and git-gate templates.
- Add example owner-decision prompts written in plain language.
- Document when Small Task Mode is appropriate and when the stricter workflow is required.
- Document Leader direct execution boundaries before promoting them into `SKILL.md`.
- Add a short guide for restarting continuity after a context rollover or new conversation.
- Add an example for OpenSpec C0-C4 workstreams, including CLI workspace trust, PM/Advisor model separation, goal completion, and archive closure.
- Add a compact handoff example for current state cards, evidence indexes, and historical archive notes.
- Add successor startup packet guidance for context-budget rollover without automatic conversation creation.
- Add CLI workspace trust setup protocol for Owner-recorded Claude CLI, Codex CLI, and similar CLI role assignments without dangerous permission bypass or broad directory trust.
- Add Leader Rollover Opportunity Protocol so Leaders prepare rollover at clean boundaries before context reliability degrades.
- Clarify provider-level PM/Advisor separation and current verified model-source records without hard-coding concrete models.
- Clarify PM/Advisor and substantive Worker lifecycle patience so short silence is not treated as failure.
- Add installation and migration guidance for local checkout use, global skill sync, machine migration, and project adoption.
- Add task-trait guidance for when future agents should select this skill automatically.
- Add a plain-language closeout summary requirement so completed work reports what changed, what was verified, what remains uncertain, and recommended next goals.
- Reposition the project as a platform-neutral protocol with Codex as the reference adapter and explicit adapter maturity labels.
- Split long skill details into progressive references without reducing `SKILL.md` hard-boundary summaries or gate strength.
- Add Leader Delegation And Cleanup Discipline so bounded Worker slices are
  dispatched before Leader context grows when practical, and role-agent cleanup
  is sequential without weakening delivery gates.
- Add scenario-based adoption guidance and adapter guide guardrails so readers
  can decide when to use the workflow without overloading `README.md` or
  `SKILL.md`.

Exit criteria:

- A user can copy an example and adapt it to a real task.
- The examples demonstrate both normal flow and blocked/degraded flow.
- Commit and push examples clearly separate normal non-high-risk PM plus Advisor gates from explicit Owner approval gates for high-risk and default-exclusion actions.
- Validation docs confirm Small Task Mode, Leader direct execution, Reviewer independence, English-only docs, and reference-source automation boundaries.
- Advisor model-diversity rules are documented as a completed v0.4.1 follow-up without adding automation.
- CLI workspace-trust and OpenSpec C0-C4 lifecycle rules are documented as a v0.4.2 follow-up without adding automation.
- Leader state compaction rules are documented as a v0.4.3 follow-up without adding automation.
- Lightweight local validation tooling is documented as a completed v0.4.4 follow-up without adding CI, release automation, or automatic repair.
- Copyable role templates are documented as a completed v0.4.5 follow-up without rewriting legacy handoff history.
- Leader Rollover Protocol is documented as a completed v0.4.6 follow-up without automatic thread creation or gate bypass.
- CLI workspace trust setup protocol is documented as a completed v0.4.7 follow-up without dangerous permission bypass, global trust, or external-effect authorization.
- Leader Rollover Opportunity Protocol is documented as a completed v0.4.8 follow-up without automatic thread creation, automatic agent spawning, inherited authorization, or dashboard runtime.
- Provider Separation, Agent Patience, And Migration Guidance is documented as a completed v0.4.9 follow-up without hard-coding concrete models, treating stale memory as authority, adding timer automation, or transferring authorization.
- Agent patience and lifecycle continuity rules are documented as part of v0.4.9 without adding automatic timers, polling, or session supervision.
- Installation and migration guidance is documented as part of v0.4.9 without adding packaging automation, release publication, or authorization transfer.
- Invocation, migration, and plain-language closeout guidance is documented as a completed v0.4.10 follow-up without adding automatic agent spawning, external Advisor calls, workspace trust, git exits, CI/archive automation, or next-goal execution.
- Completion summaries distinguish verified evidence from claims, include mandatory uncertainty/skipped-check reporting, and treat recommended next goals as advice only unless the Owner has already given explicit current-session authorization.
- Platform-neutral protocol positioning is documented as a v0.4.11 follow-up without claiming Claude, OpenClaw, Hermes Agent, or other runtimes are fully supported before validation.
- Progressive skill references are documented as a v0.4.12 follow-up without lowering skill capability, constraints, default exclusions, PM/Advisor independence, OpenSpec lifecycle, or git gates.
- Leader Delegation And Cleanup Discipline is documented as a v0.4.13 follow-up
  without adding automatic Worker spawning, automatic diff-size enforcement,
  parallel cleanup, release authorization, or cleanup-based gate bypass.
- `v0.4.14` Adoption Scenarios And Adapter Guardrails is documented without
  adding runtime-specific support claims, automatic publication, GitHub metadata
  mutation, CI, release automation, or heavier `SKILL.md` load.
- `v0.4.15` Fast Path And Anchor Guardrails is documented without demoting
  current `SKILL.md` anchors, changing Small Task Mode, reducing role gates,
  skipping mandatory references, or adding automation.
- `v0.4.16` Cross-Runtime Installation And Adapter Guardrails is documented
  without claiming Claude Code, OpenClaw, Hermes Agent, or other runtimes are
  fully supported before validation, without adding automatic installation,
  plugin packaging, CI, GitHub metadata mutation, tag/release automation, or
  `SKILL.md` behavior changes.
- `v0.4.17` Role Review Context Efficiency is documented with stable-baseline
  plus incremental review packets, fresh short-lived sessions, no-peek input
  separation, original-evidence access, and safe linked retry handling without
  reducing PM/Advisor capability, review frequency, or existing gates.
- `v0.4.18` Review Packet Retention And Cleanup defines permanent, durable-audit,
  and lifecycle-bound retention classes; OpenSpec and small-task checkpoints;
  fail-closed blockers; and non-destructive compaction without automatic or
  implicitly authorized deletion. It controls active and retransmitted context,
  not total stored files; stored packets may grow until authorized removal.

## Stage 3: Lightweight Validation Tooling

Goal: catch accidental documentation and packaging regressions before publication.

Status: partially complete. A lightweight local validation command exists for docs, OpenSpec, version markers, and installed skill sync. CI validation, packaging checks, release automation, and automatic repair are not available.

- Add a simple local validation command or script.
- Check `SKILL.md` frontmatter shape.
- Check required current version markers.
- Check accepted OpenSpec specs and `openspec validate --all`.
- Check installed global skill sync when the global skill file exists.
- Consider internal link checks for README and docs.
- Consider a lightweight spelling or markdown consistency check if it stays low-friction.

Exit criteria:

- Contributors can run one local command before commit.
- The command does not require network access.
- Validation failures point to specific files and checks.

## Stage 4: Packaging And Release Hygiene

Goal: make the skill easier to reuse outside the local checkout.

Status: in progress. MIT licensing, public contribution guidance, security
guidance, public release, platform-neutral positioning, progressive references,
and Leader cleanup/delegation discipline are accepted for public reuse. CI,
packaging automation, and runtime-specific adapter packaging remain separate
decisions.

- Publish as a public reusable skill while keeping the core protocol model-agnostic.
- Present the project as a portable protocol, not only a Codex skill.
- Keep Codex as the reference adapter while adding adapter guidance for Claude,
  OpenClaw, Hermes Agent, and other runtimes.
- Add license information for public reuse.
- Add contribution, security, and conduct guidance.
- Add changelog once versioned releases begin.
- Decide whether installation guidance should become packaging automation or remain documentation-only.
- Decide whether CI should run markdown and skill validation checks.
- Create release tags only after the corresponding release-preparation commit is reviewed.

Exit criteria:

- The intended audience and reuse model are explicit.
- Releases have a predictable checklist.
- Public-facing metadata is consistent with the repository purpose.
- Adapter docs distinguish validated support from planned guidance or compatible patterns.

## Later Ideas

- Add templates for startup packets, handoff packets, and advisor review requests.
- Add a short troubleshooting guide for common workflow failures.
- Add more role-boundary examples for Leader direct execution, Worker delegation, and Reviewer independence.
- Add an ADR if the project adopts automated validation, CI, or a specific packaging strategy.
- Explore whether project-local memory templates would help long-running workstreams.

## Current Recommended Next Step

`v0.4.17` Role Review Context Efficiency is the current public version, released
on July 12, 2026. It adds context-efficient role review without reducing
PM/Advisor capability, review scope, independent no-peek review, or access to
task-relevant original evidence. Future tags, GitHub Releases, deployments, and
publications remain Owner-only actions and require explicit authorization.

The current development target is `v0.4.18` Review Packet Retention And Cleanup. It does not claim publication, measured token savings, proven quality improvement, or runtime enforcement.
