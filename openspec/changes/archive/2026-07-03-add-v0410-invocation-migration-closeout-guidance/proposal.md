## Why

Actual use showed that future agents need clearer guidance for three practical moments:

1. when to automatically select the `multi-agent-working-group` workflow for a task;
2. how to install or migrate the skill without accidentally transferring stale authority; and
3. how to close a finished work round with a plain-language summary and a useful next-goal recommendation.

Without this guidance, "use the skill automatically" can be misread as silently spawning agents, calling external advisors, trusting stale handoffs, or inheriting commit/push authorization. The upgrade should make the entry and exit points easier for non-specialist Owners to understand while preserving the v0.4.9 safety rules.

## What Changes

- Add a skill-invocation decision rule that tells agents when to use or consider `multi-agent-working-group`.
- Clarify that "consider/call the skill" means selecting the workflow and checklist, not automatically spawning agents, calling external tools, or granting authorization.
- Strengthen installation and migration guidance with a practical adoption checklist for another machine or project.
- Add a plain-language closeout requirement: completed work should report what changed, what was verified, what remains uncertain, and recommended next goals.
- Add templates and validation markers so future edits preserve the invocation, migration, and closeout guidance.

## Capabilities

### New Capabilities

### Modified Capabilities
- `role-boundary-stabilization`: Add skill invocation triggers, plain-language closeout expectations, and boundaries against automatic agent spawning or authorization.
- `copyable-role-templates`: Add closeout summary and next-goal recommendation fields to state-carrying templates.
- `local-validation-tool`: Add lightweight validation checks for v0.4.10 invocation, migration, and closeout markers.

## Impact

- Affects `SKILL.md`, README/changelog/version markers, installation and validation docs, selected templates, accepted OpenSpec specs, and local validation checks.
- Does not add runtime automation, automatic agent spawning, external advisor calls, CI automation, package publishing, release tags, secret migration, or new commit/push authorization.
