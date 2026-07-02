## MODIFIED Requirements

### Requirement: Goal completion includes applicable archive
The skill SHALL define Owner goal completion as all goal-related work through validation, git closeout, status review, and OpenSpec archive when applicable. The skill SHALL NOT treat a short lack of PM or Advisor output during substantive review as role failure or permission to close the role without an evidence-based lifecycle reason.

#### Scenario: OpenSpec change is implemented and pushed
- **WHEN** an Owner asks the Leader to complete an OpenSpec-backed goal
- **THEN** the Leader MUST continue through archive and archive validation unless an Owner decision, failed gate, unresolved P0/P1, missing required role after the applicable patience window, or external blocker requires stopping

#### Scenario: PM or Advisor is quiet during a large review
- **WHEN** PM or Advisor is processing a substantive review, OpenSpec stage, commit/push/archive gate, or large evidence packet
- **THEN** the Leader MUST NOT treat short silence as task failure, close the role, or replace the role without recording a concrete lifecycle reason
- **AND** the Leader SHOULD wait through a role- and scope-appropriate patience window or request a progress check before declaring the role unavailable

### Requirement: OpenSpec work starts with C0 analysis
The skill SHALL require a C0 goal/task analysis stage before C1 proposal work whenever this skill and OpenSpec are used together. C0 SHALL record PM/Advisor lifecycle state and expected wait/recheck behavior when substantive PM/Advisor review is expected.

#### Scenario: Starting an OpenSpec-backed multi-agent workstream
- **WHEN** the Leader uses this skill together with OpenSpec for a workstream
- **THEN** the Leader MUST perform C0 analysis covering goal, risk, active changes, applicable skills, model routing, CLI trust needs, Advisor trust/model state, PM/Advisor lifecycle and patience state when relevant, git state, validation expectations, and completion target before moving to C1 proposal

## ADDED Requirements

### Requirement: Agent patience is evidence-based
The skill SHALL require Leader to manage PM, Advisor, and substantive Worker lifecycle using evidence-based patience windows rather than short silence.

#### Scenario: Complex Worker is quiet during bounded work
- **WHEN** a Worker owns a bounded complex, implementation-heavy, or validation-heavy slice
- **THEN** the Leader MUST NOT close or replace the Worker merely because there is no short-term visible output
- **AND** the Leader SHOULD wait through the recorded patience window or request a progress check unless a concrete blocker, failure, owner instruction, or stale-evidence condition applies

#### Scenario: Agent lifecycle is closed or restarted
- **WHEN** the Leader closes, restarts, or replaces a PM, Advisor, or substantive Worker before the workstream stage is complete
- **THEN** the Leader MUST record the lifecycle reason, last contact or progress evidence, whether the patience window was exceeded, and what evidence packet the restarted role receives
