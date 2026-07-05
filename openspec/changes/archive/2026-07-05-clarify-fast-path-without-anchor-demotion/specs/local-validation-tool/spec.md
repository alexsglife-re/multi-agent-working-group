## ADDED Requirements

### Requirement: Validation checks Fast Path boundaries
The local validation command SHALL check that Fast Path wording remains a reading-order optimization and does not weaken mandatory reference routing.

#### Scenario: Fast Path wording is present
- **WHEN** local validation runs
- **THEN** it checks that `SKILL.md` states Fast Path never skips a mandatory reference once a routed domain is touched

#### Scenario: Slow Path routed domains are present
- **WHEN** local validation runs
- **THEN** it checks that `SKILL.md` lists routed domains including git exits, OpenSpec, CLI trust or model routing, role dispatch or output, rollover or handoff, release, secrets, auth, security, permission, schema, destructive, and irreversible actions

### Requirement: Validation documents SKILL.md anchor demotion guardrails
The local validation command SHALL check v0.4.15 guardrail markers showing that current `SKILL.md` anchors remain anchored and that anchor demotion is not a validation-maintenance shortcut.

#### Scenario: No-anchor-loss markers are present
- **WHEN** local validation runs
- **THEN** it checks documentation stating that current `SKILL.md` hard-boundary anchors remain in `SKILL.md`
- **AND** it checks that anchor demotion is an explicit reviewed boundary change rather than a validation-maintenance shortcut
