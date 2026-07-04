# agent-cleanup-discipline Specification

## Purpose
Define role-agent cleanup order, cleanup failure boundaries, and final cleanup
status reporting without weakening delivery, validation, review, git, CI/status,
secret-safety, release, or authorization gates.
## Requirements
### Requirement: Role-agent cleanup is sequential
The protocol SHALL require multi-agent role cleanup or close actions to run
sequentially rather than in parallel. The Leader MUST record the result of each
role-agent cleanup or close attempt before starting the next cleanup action.

#### Scenario: Multiple role agents need cleanup
- **WHEN** a multi-agent workstream reaches final cleanup and more than one role agent needs closing
- **THEN** the Leader closes or cleans up one role agent at a time
- **AND** records each close result before closing the next role agent

#### Scenario: Cleanup tooling supports parallel close
- **WHEN** tooling allows closing multiple agents in one parallel operation
- **THEN** the Leader does not use parallel close for role-agent cleanup

### Requirement: Gate-bearing roles stay open until gates pass
The protocol SHALL state that normal cleanup order is Worker, Reviewer, PM, then
Advisor, but MUST NOT close any role that is still needed for a required gate,
cleanup-impact judgment, unresolved P0/P1 review, post-action review, or Owner
decision.

#### Scenario: Advisor is still needed after commit
- **WHEN** a commit has completed but the push gate or cleanup-impact judgment still needs Advisor review
- **THEN** the Leader does not close the Advisor before that gate or judgment is complete

#### Scenario: Normal cleanup order is safe
- **WHEN** no remaining gate or cleanup-impact decision depends on a role
- **THEN** the Leader may use the normal cleanup order Worker, Reviewer, PM, then Advisor

### Requirement: Cleanup failure is narrowly non-blocking
The protocol SHALL define cleanup/close as role-agent teardown or lifecycle
hygiene only. Cleanup failure SHALL NOT mean validation failure, PM/Advisor or
Reviewer gate failure, commit/push/CI/status failure, secret/credential scan
failure, release/tag failure, or authorization-state failure.

#### Scenario: Cleanup fails after delivery evidence is complete
- **WHEN** the primary goal, required validation, required reviews, git or release checks, CI/status checks, secret-safety checks, and authorization state are already confirmed from evidence in hand
- **AND** a role-agent cleanup or close action fails
- **THEN** the Leader may still produce final closeout
- **AND** reports the cleanup failure as degraded cleanup evidence rather than as delivery failure

#### Scenario: Cleanup label is used for a gate failure
- **WHEN** validation, required review, git status, CI/status, secret-safety, release, or authorization evidence is missing or failed
- **THEN** the Leader MUST NOT classify that problem as non-blocking cleanup

### Requirement: Cleanup failure escalates when it blocks evidence
The protocol SHALL require cleanup failure to become blocking when it prevents
confirming task state, git state, CI/status state, validation state, secret
safety, authorization state, or required role evidence.

#### Scenario: Cleanup failure hides required role output
- **WHEN** a cleanup or close failure prevents the Leader from confirming required PM, Advisor, Reviewer, or Worker evidence
- **THEN** the Leader treats the failure as P1 or P0 according to impact and does not report the work as complete

#### Scenario: Cleanup failure does not affect evidence
- **WHEN** the cleanup failure does not affect current task, git, validation, secret-safety, authorization, or role-evidence confirmation
- **THEN** the Leader records it as a cleanup issue and continues final closeout when other gates are complete

### Requirement: Final closeout reports cleanup status
The protocol SHALL require final closeout to report cleanup status when role
cleanup was attempted, skipped, degraded, or failed. The report SHALL state
whether cleanup issues affect delivery evidence.

#### Scenario: Cleanup is skipped
- **WHEN** role cleanup is skipped because no role-agent cleanup is needed or a role must remain open for a gate
- **THEN** final closeout records the cleanup status and reason

#### Scenario: Cleanup fails
- **WHEN** role cleanup fails after delivery evidence is otherwise complete
- **THEN** final closeout reports which cleanup failed and whether delivery evidence is affected
