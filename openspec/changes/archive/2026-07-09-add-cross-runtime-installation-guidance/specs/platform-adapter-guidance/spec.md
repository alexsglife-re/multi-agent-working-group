## ADDED Requirements

### Requirement: Runtime installation guidance distinguishes installability from validated support
The documentation SHALL provide cross-runtime installation guidance for runtimes
whose skill-folder layout can consume the repository's `SKILL.md` and
supporting files, while preserving adapter maturity labels and validation
requirements.

#### Scenario: Reader installs the Codex reference adapter
- **WHEN** a reader follows runtime installation guidance for Codex
- **THEN** the documentation gives global and project-level Codex skill paths
- **AND** identifies Codex as the reference adapter

#### Scenario: Reader installs for Claude Code
- **WHEN** a reader follows runtime installation guidance for Claude Code
- **THEN** the documentation gives personal and project-level Claude Code skill
  paths using a `SKILL.md` folder with `references/`
- **AND** keeps Claude Code under `adapter guide planned` with install guidance
  available and validation pending rather than fully validated adapter support

### Requirement: Runtime installation docs preserve non-transferable state
Runtime installation guidance SHALL state that copying the skill folder
transfers only workflow instructions and supporting references, not authority
or live workstream state.

#### Scenario: User copies the skill to another runtime
- **WHEN** a user installs the skill folder into Codex, Claude Code, or another
  runtime
- **THEN** the documentation states that commit, push, tag, release, deployment,
  publication, workspace trust, validation freshness, role continuity, and
  secret access do not transfer

### Requirement: Non-Codex runtime status remains evidence-based
Adapter documentation SHALL keep runtime support labels aligned with actual
validation evidence.

#### Scenario: Claude Code has install guidance but no full workflow validation
- **WHEN** adapter documentation lists Claude Code
- **THEN** it labels Claude Code as `adapter guide planned`
- **AND** may note that install guidance is available and validation is pending
- **AND** does not describe Claude Code as fully supported

#### Scenario: OpenClaw or Hermes Agent is named
- **WHEN** adapter documentation lists OpenClaw or Hermes Agent
- **THEN** it labels the runtime as adapter guide planned unless real validation
  evidence is added
