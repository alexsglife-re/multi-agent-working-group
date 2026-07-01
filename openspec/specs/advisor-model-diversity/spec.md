# advisor-model-diversity Specification

## Purpose
Define the v0.4.1 Advisor model-diversity requirements for default model selection, explicit same-model overrides, recorded degradation, bounded trusted Advisor context, and continued Leader verification.

## Requirements
### Requirement: Advisor defaults to a different model
The skill SHALL state that Advisor defaults to a different AI model than Leader, PM, Worker, or Reviewer when model selection is available, unless the Owner explicitly requests same-model Advisor use.

#### Scenario: Different model available
- **WHEN** Leader starts a multi-agent workstream and a different Advisor model is available
- **THEN** Leader assigns or requests an Advisor model that is different from the other active agent model roles

#### Scenario: Owner requests same model
- **WHEN** the Owner explicitly requests Advisor to use the same model as another agent role
- **THEN** Leader records the same-model override and does not claim model diversity was satisfied

### Requirement: Advisor model preference is requested when unspecified
The skill SHALL require Leader to ask the Owner for Advisor model/provider preference at workstream or session startup when no project, session, continuity, or handoff record identifies the Advisor model/provider.

#### Scenario: No Advisor model record exists
- **WHEN** Leader starts a local workstream and cannot find an Advisor model/provider record for the project or session
- **THEN** Leader asks the Owner to specify the Advisor model/provider before treating the Advisor model selection as settled

#### Scenario: Advisor model record exists
- **WHEN** a project, session, continuity, or handoff record identifies the Advisor model/provider
- **THEN** Leader may use that record as startup evidence while still verifying it matches the current Owner instruction and available tooling

### Requirement: Model diversity has explicit precedence and degradation
The skill SHALL define precedence as explicit Owner instruction, then different-model Advisor default, then recorded degradation when a different Advisor model is unavailable.

#### Scenario: Different model unavailable
- **WHEN** a different Advisor model is unavailable in the current environment
- **THEN** Leader records model-diversity degradation and follows the existing Advisor-unavailable or degradation rules for the task risk and git gate

### Requirement: Trusted Advisor context remains bounded
The skill SHALL treat Owner-assigned Advisor models/tools as trusted Advisor roles for necessary bounded project/task context while preserving minimum-necessary context, secret restrictions, and independent Leader verification.

#### Scenario: Advisor is explicitly assigned
- **WHEN** the Owner explicitly assigns Claude or another model/tool as Advisor
- **THEN** Leader may send necessary bounded context for the Advisor role without treating the Advisor as an ordinary third-party disclosure, but does not send secrets or irrelevant broad context unless explicitly authorized

### Requirement: Model diversity does not replace independence or verification
The skill SHALL state that different-model Advisor review reinforces critique diversity but does not replace PM/Advisor independence, no-peek first-pass rules, Leader verification, Reviewer requirements, validation, or unresolved P0/P1 stop conditions.

#### Scenario: Different-model Advisor agrees
- **WHEN** a different-model Advisor agrees with PM or Leader
- **THEN** Leader still verifies the claim against current evidence before acting or reporting completion
