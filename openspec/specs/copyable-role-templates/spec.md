# copyable-role-templates Specification

## Purpose
Define copyable templates for common Multi-Agent Working Group role outputs, gate evidence, blocked reports, and compact handoff recovery, including safe handling for legacy or bloated documents.
## Requirements
### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for common multi-agent workstream outputs, including C0 analysis, PM review, Advisor review, Worker assignment, Worker return, Reviewer report, blocked report, compact handoff, and git gate evidence.

#### Scenario: Leader starts a new workstream
- **WHEN** a Leader needs a reusable output shape for a common role or gate
- **THEN** the Leader can copy a template that preserves scope, risk, evidence, validation, unresolved P0/P1, and authorization state

### Requirement: Templates are structure only
The templates SHALL state or imply that they provide structure and evidence capture only, not authorization, approval, validation success, or gate bypass.

#### Scenario: Template is used before commit or push
- **WHEN** a role or gate template is filled in before commit or push
- **THEN** the filled template remains evidence for the applicable PM/Advisor/Reviewer and git gates, not a substitute for those gates

### Requirement: Legacy documents remain historical evidence
The project SHALL define how v0.3 or older handoffs, ledgers, and role outputs are handled when v0.4.5 templates are adopted.

#### Scenario: Workstream resumes from an old handoff
- **WHEN** a Leader resumes from a v0.3 or older handoff document
- **THEN** the Leader preserves the old document as historical evidence, creates a new current state using the v0.4.5 template, copies only verified current facts into the active state, and references old material through the evidence index with freshness and verification status

#### Scenario: Old handoff is long
- **WHEN** an old handoff or ledger is long or append-only
- **THEN** the Leader MUST NOT paste it verbatim into the new active handoff and MUST instead summarize current verified state plus evidence pointers
