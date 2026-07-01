# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

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
