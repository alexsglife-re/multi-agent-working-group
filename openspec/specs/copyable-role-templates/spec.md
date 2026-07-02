# copyable-role-templates Specification

## Purpose
Define copyable templates for common Multi-Agent Working Group role outputs, gate evidence, blocked reports, compact handoff recovery, and successor startup packets, including safe handling for legacy or bloated documents.
## Requirements
### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for PM, Advisor, Worker assignment, Worker return, Reviewer report, blocked report, C0 analysis, compact handoff, successor startup, and git gate capture. Templates for PM, Advisor, Worker, C0, compact handoff, successor startup, and blocked reports SHALL record lifecycle patience state when substantive role work is expected, in progress, blocked, or restarted.

#### Scenario: Future agent captures long-running role state
- **WHEN** a PM, Advisor, or substantive Worker is still working or has been restarted
- **THEN** the relevant template provides fields for expected wait window, last contact, progress evidence, patience state, and closure or restart reason

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

### Requirement: Legacy documents remain historical evidence
The project SHALL define how v0.3 or older handoffs, ledgers, and role outputs are handled when v0.4.5 templates are adopted.

#### Scenario: Workstream resumes from an old handoff
- **WHEN** a Leader resumes from a v0.3 or older handoff document
- **THEN** the Leader preserves the old document as historical evidence, creates a new current state using the v0.4.5 template, copies only verified current facts into the active state, and references old material through the evidence index with freshness and verification status

#### Scenario: Old handoff is long
- **WHEN** an old handoff or ledger is long or append-only
- **THEN** the Leader MUST NOT paste it verbatim into the new active handoff and MUST instead summarize current verified state plus evidence pointers

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
