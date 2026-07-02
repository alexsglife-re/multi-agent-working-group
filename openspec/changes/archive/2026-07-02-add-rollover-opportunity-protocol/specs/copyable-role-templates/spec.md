## MODIFIED Requirements

### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for common multi-agent workstream outputs, including C0 analysis, PM review, Advisor review, Worker assignment, Worker return, Reviewer report, blocked report, compact handoff, successor startup packet, and git gate evidence.

#### Scenario: Leader starts a new workstream
- **WHEN** a Leader needs a reusable output shape for a common role or gate
- **THEN** the Leader can copy a template that preserves scope, risk, evidence, validation, unresolved P0/P1, and authorization state

#### Scenario: Leader prepares rollover handoff
- **WHEN** a Leader needs to prepare a successor after context pressure, rollover opportunity, rollover recommendation, or required rollover
- **THEN** the repository provides a successor startup packet template that captures current state, canonical context-budget evidence, compression count value/source/confidence, task status dashboard, pending messages, conflicts, evidence index, successor verification checklist, and authorization state

### Requirement: Templates are structure only
The templates SHALL state or imply that they provide structure and evidence capture only, not authorization, approval, validation success, or gate bypass.

#### Scenario: Template is used before commit or push
- **WHEN** a role or gate template is filled in before commit or push
- **THEN** the filled template remains evidence for the applicable PM/Advisor/Reviewer and git gates, not a substitute for those gates

#### Scenario: Successor packet is filled
- **WHEN** a successor startup packet or rollover handoff template is filled
- **THEN** the filled template remains continuity evidence only and does not authorize automatic successor thread creation, automatic agent spawning, commit, push, CI, archive, release, deployment, publication, secret access, validation bypass, PM/Advisor bypass, Reviewer bypass, owner-decision bypass, or successor authorization inheritance

#### Scenario: Dashboard fields are filled
- **WHEN** a compact handoff or successor packet records task status, pending messages, conflicts, overlaps, role continuity, gate state, or evidence index fields
- **THEN** those fields remain evidence inputs to canonical state selection and MUST NOT create a separate board state machine or dashboard runtime
