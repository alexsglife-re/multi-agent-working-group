## ADDED Requirements

### Requirement: State templates record provider separation
The template set SHALL include provider/model-per-role, model source, PM/Advisor separation status, and freshness/applicability verification fields in templates that carry workstream state.

#### Scenario: C0 template records model source
- **WHEN** a Leader fills the C0 goal analysis template for a workstream using PM and Advisor
- **THEN** the template includes fields for PM provider/model, Advisor provider/model, model source, PM/Advisor separation status, and current verification status

#### Scenario: Handoff templates record model source
- **WHEN** a Leader fills compact handoff or successor startup templates for a workstream with PM/Advisor state
- **THEN** the templates include provider/model-per-role, separation status, model source, freshness, and applicability verification fields

#### Scenario: Same provider variant is recorded
- **WHEN** PM and Advisor use different variants from the same provider
- **THEN** the templates provide a status that records the state as degraded or partial rather than full provider separation
