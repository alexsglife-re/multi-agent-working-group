## Why

Advisor independence is a core part of this skill, but the current text does not say how to handle model selection when multiple AI models are available. Recent usage showed that assigning Advisor to the same model as Leader or Worker can weaken the practical value of independent critique.

## What Changes

- Add a v0.4.1 rule-level upgrade that makes Advisor default to a different AI model than Leader, PM, Worker, or Reviewer unless the Owner explicitly requests same-model Advisor use.
- Require Leader to ask for and record the Advisor model/provider at workstream or session startup when no project or session record exists.
- Clarify precedence: explicit Owner instruction comes first, then different-model default, then recorded degradation when a different model is unavailable.
- Preserve all existing Advisor boundaries: minimum necessary context, no-peek independence, unverified-until-Leader-verifies, and existing failure rules.
- Update README, changelog, TODO, validation, and roadmap wording so v0.4.0 is treated as completed local stabilization and v0.4.1 is the current planned upgrade.

## Capabilities

### New Capabilities
- `advisor-model-diversity`: Defines Advisor model-selection defaults, same-model override recording, degradation recording, and validation expectations.

### Modified Capabilities

## Impact

- Affected documentation and rules: `SKILL.md`, `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/VALIDATION.md`, `docs/ROADMAP.md`.
- Affected planning artifacts: `openspec/changes/add-advisor-model-diversity/`.
- No runtime code, CLI automation, credentials, persistent config format, release, tag, deployment, or public publication is introduced by this change.
