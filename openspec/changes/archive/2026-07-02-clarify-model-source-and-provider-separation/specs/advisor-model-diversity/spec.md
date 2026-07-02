## MODIFIED Requirements

### Requirement: Advisor defaults to a different model
The skill SHALL state that Advisor defaults to a different provider from Leader, PM, Worker, or Reviewer when provider-level separation is available, unless the Owner explicitly requests same-provider or same-model Advisor use. The skill SHALL treat provider-level separation as full model diversity and SHALL treat same-provider variants as degraded or partial separation rather than full separation.

#### Scenario: Different provider available
- **WHEN** Leader starts a multi-agent workstream and a different Advisor provider is available
- **THEN** Leader assigns or requests an Advisor provider that is different from the other active agent model roles and records `provider-separated`

#### Scenario: Same provider variant available
- **WHEN** Leader can only route Advisor to a different model variant from the same provider as PM or Leader
- **THEN** Leader records the separation as `same-provider-variant` and as degraded or partial separation, not as full provider separation

#### Scenario: Owner requests same provider or same model
- **WHEN** the Owner explicitly requests Advisor to use the same provider or same model as another agent role
- **THEN** Leader records the explicit override and does not claim full provider separation was satisfied

### Requirement: Advisor model preference is requested when unspecified
The skill SHALL require Leader to ask the Owner for Advisor model/provider preference at workstream or session startup when no current verified project, session, continuity, or handoff record identifies the Advisor provider/model.

#### Scenario: No current verified Advisor model record exists
- **WHEN** Leader starts a local workstream and cannot find a current verified Advisor provider/model record for the project or session
- **THEN** Leader asks the Owner to specify the Advisor provider/model before treating the Advisor model selection as settled

#### Scenario: Advisor model record exists
- **WHEN** a project, session, continuity, or handoff record identifies the Advisor provider/model
- **THEN** Leader may use that record as startup evidence only after verifying it matches the current Owner instruction, current project and task, and available tooling

### Requirement: Model diversity has explicit precedence and degradation
The skill SHALL define model-routing source precedence as current Owner instruction, then current verified workstream/startup/handoff record, then accepted skill default provider-separation behavior, then explicit recorded degradation or Owner decision when unresolved. Global and project memory MAY surface prior preferences, but they SHALL be treated as hints to verify, not authority that settles routing by itself.

#### Scenario: Memory contains prior model preference
- **WHEN** global or project memory contains a prior PM or Advisor provider/model preference
- **THEN** Leader treats it as evidence to verify against the current Owner instruction, current project and task, and available tooling before relying on it

#### Scenario: Different provider unavailable
- **WHEN** a different Advisor provider is unavailable in the current environment
- **THEN** Leader records model-diversity degradation and follows the existing Advisor-unavailable or degradation rules for the task risk and git gate

### Requirement: PM and Advisor models remain separated by default
The skill SHALL require PM and Advisor to use different providers by default when both roles are active and provider-level separation is available. Same-provider model variants SHALL NOT satisfy full PM/Advisor separation.

#### Scenario: PM and Advisor would use same provider variants
- **WHEN** a workstream requires both PM and Advisor and the available routing would place both roles on different model variants from the same provider
- **THEN** the Leader MUST record `same-provider-variant` as degraded or partial separation and MUST NOT claim full PM/Advisor separation was satisfied

#### Scenario: PM and Advisor would use the same model
- **WHEN** a workstream requires both PM and Advisor and the available routing would place both roles on the same AI model
- **THEN** the Leader MUST stop, record the model-separation issue, and obtain explicit Owner approval before proceeding with same-model PM/Advisor pairing

#### Scenario: Owner approves same-model PM and Advisor
- **WHEN** the Owner explicitly approves same-model PM/Advisor pairing for the current workstream
- **THEN** the Leader MUST record the same-model PM/Advisor override as degraded with Owner override and MUST NOT claim PM/Advisor model separation was satisfied

## ADDED Requirements

### Requirement: Separation status is recorded in current state
The skill SHALL require state-carrying startup, handoff, and successor records to include provider/model-per-role, PM/Advisor separation status, model source, and freshness/applicability verification when PM and Advisor are active.

#### Scenario: C0 records PM and Advisor routing
- **WHEN** Leader performs C0 analysis for a workstream using both PM and Advisor
- **THEN** the C0 record includes PM provider/model, Advisor provider/model, PM/Advisor separation status, model source, and whether the source is current and verified

#### Scenario: Successor verifies model routing
- **WHEN** a successor Leader takes over a workstream with PM/Advisor state
- **THEN** the successor startup packet requires verification of provider/model-per-role, separation status, model source, and current applicability before relying on prior routing
