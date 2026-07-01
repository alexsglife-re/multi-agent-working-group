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
