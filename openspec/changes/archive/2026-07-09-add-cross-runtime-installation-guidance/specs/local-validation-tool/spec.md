## ADDED Requirements

### Requirement: Validation checks cross-runtime installation anchors
The local validation command SHALL check that v0.4.16 runtime installation
guidance remains present without turning runtime guidance into installation
automation.

#### Scenario: Runtime installation markers are present
- **WHEN** local validation runs
- **THEN** it checks that README or installation docs link to runtime
  installation guidance
- **AND** it checks that Claude Code personal and project skill paths are
  documented

#### Scenario: Runtime installation boundary is present
- **WHEN** local validation runs
- **THEN** it checks that runtime installation docs state the repository is a
  bare skill folder rather than a plugin package
- **AND** it checks that copying the skill does not transfer authorization,
  workspace trust, validation freshness, role continuity, or secret access

### Requirement: Validation checks runtime support labels
The local validation command SHALL check that runtime adapter docs do not
overclaim Claude Code, OpenClaw, or Hermes Agent support.

#### Scenario: Runtime support labels are reviewed
- **WHEN** local validation runs
- **THEN** it checks that Claude Code remains under `adapter guide planned` with
  install guidance available and validation pending
- **AND** it checks that OpenClaw and Hermes Agent remain planned adapter
  guidance unless validation evidence is added
- **AND** it checks wording that fully supported runtime claims require
  validation evidence

#### Scenario: Runtime install commands do not become adapter guide skeletons
- **WHEN** local validation runs
- **THEN** it allows runtime installation commands only when they are separated
  from validated adapter guides
- **AND** it checks that docs still block runtime-specific guide skeletons that
  look like validated support before validation evidence exists
