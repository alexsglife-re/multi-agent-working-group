# cli-trust-and-openspec-lifecycle Specification

## Purpose
Define the v0.4.2-v0.4.7 requirements for CLI agent workspace trust, trusted Advisor context classification, PM/Advisor model separation, goal completion through applicable archive, and OpenSpec C0-C4 lifecycle closure.
## Requirements
### Requirement: CLI agent workspace trust preflight
The skill SHALL require the Leader to confirm a current-project workspace-trust preflight before relying on a CLI-based PM, Advisor, Worker, or Reviewer. The skill SHALL treat an Owner-recorded assignment of Claude CLI, Codex CLI, or another CLI-based agent to a role as authorization to complete workspace trust setup for the exact current project root, after the Leader verifies that the assignment source applies to the current project and workstream.

#### Scenario: CLI agent reports untrusted workspace
- **WHEN** a CLI agent such as Claude CLI, Codex CLI, or a similar tool cannot operate because the current project workspace is untrusted
- **THEN** the Leader MUST check whether a current Owner instruction, global memory, project rule, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence records that the Owner assigned that CLI agent to the current role
- **AND** if no applicable Owner-recorded assignment exists, the Leader MUST stop that role path as `workspace-trust-blocked`, report the blocker, and avoid silently switching roles, models, or evidence sources

#### Scenario: Owner-recorded CLI role authorizes current-project trust setup
- **WHEN** an applicable Owner-recorded source assigns Claude CLI, Codex CLI, or another CLI-based agent as PM, Advisor, Worker, Reviewer, or another role for the current project and workstream
- **THEN** the Leader MAY perform or confirm workspace trust setup for the exact current project root without asking the Owner again
- **AND** the Leader MUST record the source, assigned role, target project root, and trust state as `owner-recorded-role-authorized` or `trust-setup-attempted`

#### Scenario: CLI trust is established for current project
- **WHEN** the Owner-assigned CLI agent can be trusted for the exact current project workspace
- **THEN** the Leader MUST keep the trust scope limited to the current project and rerun a minimal read-only probe before relying on that agent output
- **AND** the Leader MUST record `trusted-verified` only after the read-only probe succeeds

#### Scenario: Trust setup exceeds current-project scope
- **WHEN** trust setup would require trusting a parent directory, home directory, all repositories, unrelated project, dangerous permission-bypass flag, secret access, browser data, broad file access, global policy change, git action, CI, deployment, release, or other external effect
- **THEN** the Leader MUST NOT treat Owner-recorded CLI role assignment as sufficient authorization
- **AND** the Leader MUST stop for explicit Owner confirmation and record the state as `owner-confirmation-needed` or `blocked`

#### Scenario: Recorded assignment is stale or mismatched
- **WHEN** the only available CLI role assignment source is stale, historical-only, superseded, or not applicable to the current project or workstream
- **THEN** the Leader MUST NOT use it as authorization for workspace trust setup
- **AND** the Leader MUST report the missing current authorization instead of silently relying on old role state

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

### Requirement: Agent patience is evidence-based
The skill SHALL require Leader to manage PM, Advisor, and substantive Worker lifecycle using evidence-based patience windows rather than short silence.

#### Scenario: Complex Worker is quiet during bounded work
- **WHEN** a Worker owns a bounded complex, implementation-heavy, or validation-heavy slice
- **THEN** the Leader MUST NOT close or replace the Worker merely because there is no short-term visible output
- **AND** the Leader SHOULD wait through the recorded patience window or request a progress check unless a concrete blocker, failure, owner instruction, or stale-evidence condition applies

#### Scenario: Agent lifecycle is closed or restarted
- **WHEN** the Leader closes, restarts, or replaces a PM, Advisor, or substantive Worker before the workstream stage is complete
- **THEN** the Leader MUST record the lifecycle reason, last contact or progress evidence, whether the patience window was exceeded, and what evidence packet the restarted role receives
