## Why

Multi-Agent Working Group is now public and should be presented as a reusable
multi-agent workflow protocol, not as a Codex-only artifact. Codex remains the
reference packaged adapter, but the core protocol should be understandable for
Claude, OpenClaw, Hermes Agent, and other agent runtimes without overstating
verified support.

## What Changes

- Reposition the project documentation from "Codex skill" to "portable
  multi-agent workflow protocol with a Codex reference adapter."
- Add adapter guidance that explains how runtimes map Leader, PM, Advisor,
  Worker, Reviewer, trust, validation, and git gates.
- Document adapter maturity levels so unverified runtimes are described as
  planned or compatible guidance, not fully supported.
- Update installation and roadmap docs to separate the generic protocol from
  Codex-specific installation.
- Extend local validation to preserve the platform-neutral positioning markers.

## Capabilities

### New Capabilities

- `platform-adapter-guidance`: Requirements for documenting runtime adapters,
  maturity labels, and platform-neutral protocol positioning.

### Modified Capabilities

- `local-validation-tool`: Add lightweight checks for v0.4.11
  platform-neutral positioning and adapter guidance markers.

## Impact

- Documentation only: `README.md`, `docs/INSTALLATION.md`, `docs/ROADMAP.md`,
  `docs/VALIDATION.md`, `docs/TODO.md`, `CHANGELOG.md`, and new adapter docs.
- Local validation script marker updates in `scripts/validate-local.sh`.
- OpenSpec artifacts for the new capability and validation changes.
- No behavior-changing edits to the protocol gates in `SKILL.md` are planned.
