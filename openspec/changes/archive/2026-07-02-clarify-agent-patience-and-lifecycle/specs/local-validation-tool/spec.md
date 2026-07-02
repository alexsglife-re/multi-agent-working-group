## ADDED Requirements

### Requirement: Validation checks agent patience markers
The local validation command SHALL check selected text markers for the current local documentation version's agent patience and lifecycle rules.

#### Scenario: v0.4.9 patience markers are missing
- **WHEN** a contributor removes the agent patience rule or lifecycle fields from the skill or templates
- **THEN** the local validation command fails with a targeted message
