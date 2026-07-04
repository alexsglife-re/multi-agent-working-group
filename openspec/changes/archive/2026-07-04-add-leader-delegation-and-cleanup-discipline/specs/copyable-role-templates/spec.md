## ADDED Requirements

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
- **THEN** the template requires the Leader to state why task, git, validation, secret-safety, authorization, and required role evidence remain confirmable

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
