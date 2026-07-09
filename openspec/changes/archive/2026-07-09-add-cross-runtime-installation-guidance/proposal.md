## Why

Claude Code can consume a `SKILL.md` folder with supporting files, which makes
this repository's bare `SKILL.md` plus `references/` layout useful beyond
Codex. The public docs should explain that path without implying that Claude
Code, OpenClaw, Hermes Agent, or other runtimes have fully validated adapters.

## What Changes

- Add cross-runtime installation guidance for Codex and Claude Code while
  keeping README concise.
- Document that Claude Code can install the bare skill folder at personal or
  project scope, but that this is installation guidance rather than fully
  validated runtime support.
- Keep OpenClaw and Hermes Agent as planned adapter guidance until real
  workflows validate their role, evidence, handoff, and git-gate behavior.
- Update adapter maturity labels and validation anchors to prevent support
  overclaims.
- Update version/status docs for the v0.4.16 target.
- Do not add installation automation, plugin packaging, CI, tag/release
  automation, GitHub metadata mutation, or runtime-specific support claims.

## Capabilities

### New Capabilities

- None.

### Modified Capabilities

- `platform-adapter-guidance`: Document cross-runtime installation guidance and
  adapter maturity labels for Codex, Claude Code, OpenClaw, and Hermes Agent.
- `local-validation-tool`: Add local validation anchors for v0.4.16
  cross-runtime installation guidance and runtime-support overclaim
  prevention.

## Impact

- Affected docs: `README.md`, `docs/INSTALLATION.md`,
  `docs/ADAPTERS.md`, `docs/RUNTIME_INSTALLATION.md`, `docs/ROADMAP.md`,
  `docs/TODO.md`, `docs/VALIDATION.md`, and `CHANGELOG.md`.
- Affected validation: `scripts/validate-local.sh`.
- Affected OpenSpec artifacts: this change plus accepted specs during archive.
- No runtime code, no package manager integration, no CI workflow, no local
  Claude Code installation, no GitHub metadata update, and no tag/release.
