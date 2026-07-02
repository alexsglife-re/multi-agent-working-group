## Why

The current model-diversity language can be misread as allowing adjacent models from the same provider, such as two OpenAI GPT variants, to satisfy PM/Advisor separation. Actual use showed that this is not strong enough for independent critique, especially when the Advisor is expected to use a different provider such as Claude CLI.

## What Changes

- Define full PM/Advisor separation as provider-level separation when available.
- Treat same-provider variants as degraded or partial separation, not full separation.
- Clarify that remembered model preferences are hints to verify, not authority that settles routing by itself.
- Require current verified model/provider records to include freshness and applicability.
- Add provider/model-per-role and separation-status fields to state-carrying templates.
- Keep the skill model-agnostic and avoid hard-coding any concrete provider model into `SKILL.md`.

## Capabilities

### New Capabilities

### Modified Capabilities
- `advisor-model-diversity`: Clarify provider-level separation, same-provider degradation, model-source verification, and current verified model/provider record requirements.
- `copyable-role-templates`: Require state templates to record provider/model-per-role and PM/Advisor separation status.
- `local-validation-tool`: Add lightweight validation checks for provider-separation markers and template fields.

## Impact

- Affects `SKILL.md`, README/changelog/version markers, role templates, accepted OpenSpec specs, and local validation checks.
- Does not add automation, external integrations, secrets handling, or concrete model hard-coding.
