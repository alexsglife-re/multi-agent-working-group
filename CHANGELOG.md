# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

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
