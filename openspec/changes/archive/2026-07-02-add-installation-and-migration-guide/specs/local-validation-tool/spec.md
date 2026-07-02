## ADDED Requirements

### Requirement: Validation checks installation guidance markers
The local validation command SHALL check selected text markers for the installation and migration guide when present.

#### Scenario: Installation guide is missing required boundaries
- **WHEN** a contributor removes installation guidance, validation commands, global skill sync boundaries, or non-transferable authorization warnings
- **THEN** the local validation command fails with a targeted message
