# Roadmap

This roadmap keeps development incremental. The goal is to make the skill useful, reviewable, and safe before adding heavier automation.

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

`v0.4.0` local stabilization, `v0.4.1` Advisor model diversity, `v0.4.2` CLI agent workspace trust plus OpenSpec C0-C4 lifecycle closure, `v0.4.3` Leader state compaction, `v0.4.4` lightweight local validation tooling, `v0.4.5` copyable role templates, `v0.4.6` Leader Rollover Protocol, `v0.4.7` CLI workspace trust setup protocol, `v0.4.8` Leader Rollover Opportunity Protocol, and `v0.4.9` Provider Separation, Agent Patience, And Migration Guidance are complete.

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

Status: future decision. Packaging, release tags, public publication, and CI remain out of scope until explicitly approved.

- Decide whether this remains a personal skill package or becomes a public reusable skill.
- Add license information if public reuse is intended.
- Add changelog once versioned releases begin.
- Decide whether installation guidance should become packaging automation or remain documentation-only.
- Decide whether CI should run markdown and skill validation checks.

Exit criteria:

- The intended audience and reuse model are explicit.
- Releases, if used, have a predictable checklist.
- Public-facing metadata is consistent with the repository purpose.

## Later Ideas

- Add templates for startup packets, handoff packets, and advisor review requests.
- Add a short troubleshooting guide for common workflow failures.
- Add more role-boundary examples for Leader direct execution, Worker delegation, and Reviewer independence.
- Add an ADR if the project adopts automated validation, CI, or a specific packaging strategy.
- Explore whether project-local memory templates would help long-running workstreams.

## Current Recommended Next Step

Decide the next version target after `v0.4.9`: likely candidates are agent patience/lifecycle timing, packaging/install guidance, or more lightweight validation hardening. Keep heavier automation out of scope until rollover opportunity protocol, trust setup protocol, templates, model-source verification, and the local command remain stable across more real tasks.
