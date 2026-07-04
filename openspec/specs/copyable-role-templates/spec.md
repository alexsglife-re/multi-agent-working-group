# copyable-role-templates Specification

## Purpose
Define copyable templates for common Multi-Agent Working Group role outputs, gate evidence, blocked reports, compact handoff recovery, and successor startup packets, including safe handling for legacy or bloated documents.
## Requirements
### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for PM, Advisor, Worker assignment, Worker return, Reviewer report, blocked report, C0 analysis, compact handoff, successor startup, and git gate capture. Templates for PM, Advisor, Worker, C0, compact handoff, successor startup, and blocked reports SHALL record lifecycle patience state when substantive role work is expected, in progress, blocked, or restarted. State-carrying templates SHALL provide fields for a plain-language completion summary and recommended next goals when a work round closes or hands off.

#### Scenario: Future agent captures long-running role state
- **WHEN** a PM, Advisor, or substantive Worker is still working or has been restarted
- **THEN** the relevant template provides fields for expected wait window, last contact, progress evidence, patience state, and closure or restart reason

#### Scenario: Future agent closes a work round
- **WHEN** a work round completes or reaches a safe handoff boundary
- **THEN** the relevant template provides fields for what changed, what was verified, remaining uncertainty or skipped checks, and recommended next goals

### Requirement: Templates are structure only
The templates SHALL state or imply that they provide structure and evidence capture only, not authorization, approval, validation success, gate bypass, automatic next-goal execution, or automatic role spawning.

#### Scenario: Template is used before commit or push
- **WHEN** a role or gate template is filled in before commit or push
- **THEN** the filled template remains evidence for the applicable PM/Advisor/Reviewer and git gates, not a substitute for those gates

#### Scenario: Completion summary recommends a next goal
- **WHEN** a filled template recommends a next goal
- **THEN** the recommendation does not authorize starting that goal unless the Owner has already given that instruction

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

### Requirement: Templates record cleanup status
The template set SHALL provide cleanup status fields for closeout or handoff
contexts where role-agent cleanup was attempted, skipped, degraded, or failed.
Cleanup status fields SHALL record whether cleanup issues affect delivery
evidence.

#### Scenario: Final closeout uses a template
- **WHEN** a Leader fills a final closeout or compact handoff template after multi-agent work
- **THEN** the template provides fields for role cleanup attempted, skipped, degraded, failed, and delivery-evidence impact

#### Scenario: Cleanup failure is non-blocking
- **WHEN** cleanup failure is reported as non-blocking
- **THEN** the template requires the Leader to state why task, git, validation, secret-safety, authorization, and required role evidence are confirmed from evidence in hand

### Requirement: Worker templates support bounded delegation
Worker assignment templates SHALL preserve bounded goal, allowed scope,
forbidden scope, required evidence, stop conditions, and cleanup or handoff
expectations when applicable.

#### Scenario: Worker is dispatched for context control
- **WHEN** Worker-first context control dispatches a Worker slice
- **THEN** the Worker assignment template captures the bounded target, allowed files or modules, forbidden files or modules, required evidence, and stop conditions

#### Scenario: Worker returns evidence
- **WHEN** a Worker returns from a bounded slice
- **THEN** the Worker return template captures changed files, validation, findings, blockers, next action, and whether any cleanup or handoff issue remains
