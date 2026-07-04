## ADDED Requirements

### Requirement: Validation checks cleanup discipline anchors
The local validation command SHALL check stable text anchors for sequential
cleanup, cleanup failure non-blocking boundaries, cleanup failure escalation,
and cleanup status reporting.

#### Scenario: Cleanup anchors are missing
- **WHEN** a contributor removes the sequential cleanup, cleanup non-blocking boundary, cleanup escalation, or cleanup status text from the skill or docs
- **THEN** local validation fails with a targeted cleanup-discipline check

#### Scenario: Cleanup status template marker is missing
- **WHEN** a contributor removes cleanup status fields from the closeout or handoff templates
- **THEN** local validation fails with a targeted template check

### Requirement: Validation checks Leader delegation anchors
The local validation command SHALL check stable text anchors for Leader work
budget self-check guidance, Worker-first context control, and bounded Worker
prompt/return evidence requirements.

#### Scenario: Leader budget marker is missing
- **WHEN** a contributor removes the Leader work-budget self-check text
- **THEN** local validation fails with a targeted delegation-discipline check

#### Scenario: Worker-first marker is missing
- **WHEN** a contributor removes Worker-first context-control guidance
- **THEN** local validation fails with a targeted context-control check

### Requirement: Validation describes anchor limits
Validation documentation SHALL state that the local validation command checks
documentation and template consistency, not runtime compliance with cleanup or
delegation behavior.

#### Scenario: Local validation passes
- **WHEN** local validation passes after v0.4.13
- **THEN** docs explain that the pass confirms required rule markers and template fields exist, not that a past multi-agent task actually followed the cleanup or delegation procedure
