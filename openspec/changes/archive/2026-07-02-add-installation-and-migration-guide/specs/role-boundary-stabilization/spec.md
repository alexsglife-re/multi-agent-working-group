## ADDED Requirements

### Requirement: Installation and migration guidance preserves authorization boundaries
The project SHALL document how to install, sync, and migrate the skill without implying transfer of workstream authorization, git authorization, validation freshness, role continuity, or external-effect permission.

#### Scenario: Skill is migrated to another machine or project
- **WHEN** a reader follows the installation or migration guide
- **THEN** the guide states that files and stable rules may be copied, but commit/push/CI/archive authorization, PM/Advisor agreement, Worker results, and stale handoff facts must be re-verified for the new machine, project, or workstream
