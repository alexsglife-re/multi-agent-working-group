# copyable-role-templates Specification Delta

## MODIFIED Requirements

### Requirement: Repository provides copyable role templates

The project SHALL provide copyable templates for common multi-agent workstream outputs, including C0 analysis, PM review, Advisor review, Worker assignment, Worker return, Reviewer report, blocked report, compact handoff, successor startup packet, and git gate evidence.

#### Scenario: Leader prepares rollover handoff

- **WHEN** a Leader needs to prepare a successor after context pressure, rollover recommendation, or required rollover
- **THEN** the repository provides a successor startup packet template that captures current state, context-budget evidence, task status dashboard, pending messages, conflicts, evidence index, successor verification checklist, and authorization state

### Requirement: Templates are structure only

The templates SHALL state or imply that they provide structure and evidence capture only, not authorization, approval, validation success, or gate bypass.

#### Scenario: Successor packet is filled

- **WHEN** a successor startup packet or rollover handoff template is filled
- **THEN** the filled template remains continuity evidence only and does not authorize automatic successor thread creation, commit, push, CI, archive, release, deployment, publication, secret access, validation bypass, PM/Advisor bypass, Reviewer bypass, or owner-decision bypass
