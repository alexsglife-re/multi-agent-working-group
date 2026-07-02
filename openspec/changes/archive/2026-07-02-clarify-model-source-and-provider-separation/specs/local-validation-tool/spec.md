## ADDED Requirements

### Requirement: Validation checks provider-separation markers
The local validation command SHALL include lightweight checks that the skill and templates contain stable provider-separation markers without attempting to become a semantic policy engine.

#### Scenario: Provider separation markers are present
- **WHEN** local validation runs
- **THEN** it checks for skill text defining provider-level separation, same-provider variant degradation, hint-to-verify memory handling, and current verified model records

#### Scenario: Template separation fields are present
- **WHEN** local validation runs
- **THEN** it checks state-carrying templates for provider/model-per-role, PM/Advisor separation status, model source, and current verification fields
