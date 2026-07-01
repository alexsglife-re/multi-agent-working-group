## ADDED Requirements

### Requirement: PM and Advisor models remain separated by default
The skill SHALL require PM and Advisor to use different AI models by default when both roles are active and model selection is available.

#### Scenario: PM and Advisor would use the same model
- **WHEN** a workstream requires both PM and Advisor and the available routing would place both roles on the same AI model
- **THEN** the Leader MUST stop, record the model-separation issue, and obtain explicit Owner approval before proceeding with same-model PM/Advisor pairing

#### Scenario: Owner approves same-model PM and Advisor
- **WHEN** the Owner explicitly approves same-model PM/Advisor pairing for the current workstream
- **THEN** the Leader MUST record the same-model PM/Advisor override and MUST NOT claim PM/Advisor model separation was satisfied
