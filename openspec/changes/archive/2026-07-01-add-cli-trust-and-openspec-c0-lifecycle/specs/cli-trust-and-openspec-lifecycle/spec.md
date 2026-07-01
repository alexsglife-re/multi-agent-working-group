## ADDED Requirements

### Requirement: CLI agent workspace trust preflight
The skill SHALL require the Leader to confirm a current-project workspace-trust preflight before relying on a CLI-based PM, Advisor, Worker, or Reviewer.

#### Scenario: CLI agent reports untrusted workspace
- **WHEN** a CLI agent such as Claude CLI, Codex CLI, or a similar tool cannot operate because the current project workspace is untrusted
- **THEN** the Leader MUST stop that role path as `workspace-trust-blocked`, report the blocker, and avoid silently switching roles, models, or evidence sources

#### Scenario: CLI trust is established for current project
- **WHEN** the Owner-assigned CLI agent can be trusted for the exact current project workspace
- **THEN** the Leader MUST keep the trust scope limited to the current project and rerun a minimal read-only probe before relying on that agent output

### Requirement: Trusted Advisor context classification
The skill SHALL classify an Owner-specified Advisor as a trusted bounded collaboration role for the current task, not as an ordinary third-party service.

#### Scenario: Main app prepares Advisor context
- **WHEN** the Owner explicitly specifies another model or tool as Advisor
- **THEN** the Leader MAY send necessary bounded task context to that Advisor and MUST still exclude secrets, credentials, unrelated projects, broad context dumps, and irrelevant data unless explicitly authorized

### Requirement: PM and Advisor model separation
The skill SHALL require PM and Advisor to default to different AI models when model selection is available.

#### Scenario: Only same-model PM and Advisor are available
- **WHEN** the Leader cannot use different AI models for PM and Advisor
- **THEN** the Leader MUST treat same-model PM/Advisor pairing as blocked and MUST NOT proceed unless the Owner explicitly approves and the override is recorded

### Requirement: Goal completion includes applicable archive
The skill SHALL define Owner goal completion as all goal-related work through validation, git closeout, status review, and OpenSpec archive when applicable.

#### Scenario: OpenSpec change is implemented and pushed
- **WHEN** an Owner asks the Leader to complete an OpenSpec-backed goal
- **THEN** the Leader MUST continue through archive and archive validation unless an Owner decision, failed gate, unresolved P0/P1, or external blocker requires stopping

### Requirement: OpenSpec work starts with C0 analysis
The skill SHALL require a C0 goal/task analysis stage before C1 proposal work whenever this skill and OpenSpec are used together.

#### Scenario: Starting an OpenSpec-backed multi-agent workstream
- **WHEN** the Leader uses this skill together with OpenSpec for a workstream
- **THEN** the Leader MUST perform C0 analysis covering goal, risk, active changes, applicable skills, model routing, CLI trust needs, Advisor trust/model state, and completion target before moving to C1 proposal
