## ADDED Requirements

### Requirement: Validation checks invocation and closeout markers
The local validation command SHALL include lightweight checks that the skill and docs preserve v0.4.10 invocation, migration, and closeout markers without becoming a semantic policy engine.

#### Scenario: Invocation markers are present
- **WHEN** local validation runs
- **THEN** it checks for skill text describing task-trait based skill invocation and boundaries against automatic subagent spawning, external Advisor calls, git exits, archive, CI, and next-goal execution

#### Scenario: Closeout markers are present
- **WHEN** local validation runs
- **THEN** it checks for final output or template text that requires a plain-language completion summary, verification evidence, remaining uncertainty or skipped checks, and recommended next goals

#### Scenario: Migration markers are present
- **WHEN** local validation runs
- **THEN** it checks installation guidance for adoption steps and non-transferable authorization, role continuity, validation freshness, workspace trust, secrets, and stale handoff authority
