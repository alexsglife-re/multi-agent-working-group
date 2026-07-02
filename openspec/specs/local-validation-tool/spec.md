# local-validation-tool Specification

## Purpose
Define the repository's lightweight read-only local validation command for documentation, OpenSpec, version-marker, and installed skill sync checks.
## Requirements
### Requirement: Repository provides a local validation command
The project SHALL provide a repo-local validation command that can be run before commit or push to check the documentation-first skill package without network access.

#### Scenario: Contributor runs local validation
- **WHEN** a contributor runs the local validation command from the repository checkout
- **THEN** the command checks core documentation markers, `SKILL.md` frontmatter, OpenSpec health, accepted spec presence, and global skill sync when the global installed skill file exists

### Requirement: Local validation is read-only
The local validation command SHALL NOT mutate repository files, global skill files, Git state, OpenSpec state, or external services.

#### Scenario: Validation finds a problem
- **WHEN** a local validation check fails
- **THEN** the command reports the failing check and exits non-zero without attempting to repair files automatically

### Requirement: Local validation supports active-change and closeout modes
The local validation command SHALL support a default mode that can run during active OpenSpec work and a closeout mode that requires no active OpenSpec changes.

#### Scenario: Active OpenSpec change exists during implementation
- **WHEN** active OpenSpec changes exist and closeout mode was not requested
- **THEN** the command reports the active changes as informational and continues other checks

#### Scenario: Closeout mode is requested
- **WHEN** the command is run with closeout mode enabled and active OpenSpec changes exist
- **THEN** the command fails and reports that archive or cleanup is still required

### Requirement: Validation checks provider-separation markers
The local validation command SHALL include lightweight checks that the skill and templates contain stable provider-separation markers without attempting to become a semantic policy engine.

#### Scenario: Provider separation markers are present
- **WHEN** local validation runs
- **THEN** it checks for skill text defining provider-level separation, same-provider variant degradation, hint-to-verify memory handling, and current verified model records

#### Scenario: Template separation fields are present
- **WHEN** local validation runs
- **THEN** it checks state-carrying templates for provider/model-per-role, PM/Advisor separation status, model source, and current verification fields

### Requirement: Validation checks agent patience markers
The local validation command SHALL check selected text markers for the current local documentation version's agent patience and lifecycle rules.

#### Scenario: v0.4.9 patience markers are missing
- **WHEN** a contributor removes the agent patience rule or lifecycle fields from the skill or templates
- **THEN** the local validation command fails with a targeted message

### Requirement: Validation checks installation guidance markers
The local validation command SHALL check selected text markers for the installation and migration guide when present.

#### Scenario: Installation guide is missing required boundaries
- **WHEN** a contributor removes installation guidance, validation commands, global skill sync boundaries, or non-transferable authorization warnings
- **THEN** the local validation command fails with a targeted message
