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

`v0.4.0` local stabilization, `v0.4.1` Advisor model diversity, `v0.4.2` CLI agent workspace trust plus OpenSpec C0-C4 lifecycle closure, and `v0.4.3` Leader state compaction are complete.

Goal: make the workflow easier to apply consistently.

- Add `examples/` with small, medium, commit-gate, push-gate, and handoff scenarios.
- Add example PM, Advisor, Worker, and Reviewer outputs.
- Add example owner-decision prompts written in plain language.
- Document when Small Task Mode is appropriate and when the stricter workflow is required.
- Document Leader direct execution boundaries before promoting them into `SKILL.md`.
- Add a short guide for restarting continuity after a context rollover or new conversation.
- Add an example for OpenSpec C0-C4 workstreams, including CLI workspace trust, PM/Advisor model separation, goal completion, and archive closure.
- Add a compact handoff example for current state cards, evidence indexes, and historical archive notes.

Exit criteria:

- A user can copy an example and adapt it to a real task.
- The examples demonstrate both normal flow and blocked/degraded flow.
- Commit and push examples clearly separate normal non-high-risk PM plus Advisor gates from explicit Owner approval gates for high-risk and default-exclusion actions.
- Validation docs confirm Small Task Mode, Leader direct execution, Reviewer independence, English-only docs, and reference-source automation boundaries.
- Advisor model-diversity rules are documented as a completed v0.4.1 follow-up without adding automation.
- CLI workspace-trust and OpenSpec C0-C4 lifecycle rules are documented as a v0.4.2 follow-up without adding automation.
- Leader state compaction rules are documented as a v0.4.3 follow-up without adding automation.

## Stage 3: Lightweight Validation Tooling

Goal: catch accidental documentation and packaging regressions before publication.

Status: future work. No local validation command, CI validation, packaging check, or automation is available yet.

- Add a simple local validation command or script.
- Check `SKILL.md` frontmatter shape.
- Check required major sections are present.
- Check internal links from README and docs.
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
- Document installation options for local Codex usage.
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

Decide the next version target after `v0.4.3`: likely candidates are lightweight local validation tooling, more copyable role-output templates, or packaging/install guidance. Keep automation out of scope until the manual workflow remains stable across more real tasks.
