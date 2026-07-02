## MODIFIED Requirements

### Requirement: Advisor model preference is requested when unspecified
The skill SHALL require Leader to ask the Owner for Advisor provider/model preference at workstream or session startup when no current Owner instruction, current project rule, current project memory, continuity record, handoff, startup packet, or current verified record identifies the Advisor provider/model. Installation and migration guidance SHALL describe the model-source mechanism without hard-coding concrete model names.

#### Scenario: Skill is installed on a new machine
- **WHEN** the skill is installed or migrated and no current verified model record exists for the new workstream
- **THEN** the Leader asks the Owner or verifies an applicable current model-source record instead of assuming a concrete model from the skill text
