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

### Requirement: Stage-scoped role lifecycles preserve provider state and checkpoint freshness
The workflow SHALL treat an OpenSpec C-stage-scoped PM or Advisor lifecycle as a context-continuity boundary and each checkpoint within it as a fresh decision boundary. Same-C-stage continuity SHALL NOT permit provider/model routing changes, inherited gate decisions, stale validation, inherited authorization, skipped review, or weakened evidence access. A cross-C-stage transition or canonical mandatory trigger defined by `role-review-context-efficiency` SHALL create a new lifecycle supplied with verified baseline and continuity evidence. CLI evidence SHALL record provider, model, tool environment, workspace-trust state, Runtime Session ID or unavailable marker, runtime identity source, and exact resume evidence when supported.

#### Scenario: Advisor continues within one C-stage
- **WHEN** the current checkpoint remains in the Advisor's C-stage and no canonical restart trigger applies
- **THEN** the Advisor uses the same runtime-proven Stage Session ID and required provider/model routing
- **AND** receives current incremental evidence under a new Review ID and fresh decision state

#### Scenario: Advisor enters another C-stage
- **WHEN** work crosses into a new OpenSpec C-stage
- **THEN** the Advisor starts a new lifecycle by default with required routing and verified continuity evidence
- **AND** does not inherit an earlier decision, validation freshness, or authorization

#### Scenario: Provider route is unavailable
- **WHEN** the required Advisor lifecycle cannot use its required provider/model
- **THEN** the workflow follows existing blocked or Owner-approved degradation rules and MUST NOT silently substitute another provider

#### Scenario: CLI continuation selector is ambiguous
- **WHEN** a CLI offers an ambiguous selector such as Claude `--continue`
- **THEN** the workflow MUST NOT use it to prove exact same-stage continuity
- **AND** uses exact resume evidence or records a new Stage Session ID with restarted, degraded, or unavailable continuity

### Requirement: Agent lifecycle close or restart records stage-aware CLI evidence
The workflow SHALL keep a PM or Advisor lifecycle open by default until its C-stage completes unless a canonical restart trigger from `role-review-context-efficiency`, Owner instruction, or concrete failure requires earlier restart or close. Every normal cross-stage close/restart, early close/restart, C0 close, or recorded degraded/unavailable transition SHALL have a lifecycle transition record containing Stage Session ID, Runtime Session ID or unavailable marker, provider/model/tool and workspace-trust evidence, C-stage, canonical lifecycle reason, lifecycle decision actor `leader|owner`, ISO-8601 lifecycle decision time with timezone, last progress evidence, patience-window state, continuity status, and verified successor packet. Actor identifies the decision maker; `owner-instruction` remains only a restart reason. Routine same-C-stage invocation records omit the transition-only actor and time fields.

#### Scenario: Same-stage checkpoint completes
- **WHEN** one checkpoint completes and another required checkpoint remains in the same C-stage
- **THEN** the Leader keeps the runtime-proven lifecycle available by default rather than closing it solely because the checkpoint ended
- **AND** the routine invocation record does not invent lifecycle decision actor or decision time

#### Scenario: Cross-stage lifecycle closes normally
- **WHEN** a role completes its C-stage and closes or restarts for the next C-stage
- **THEN** CLI lifecycle evidence records actor and timezone-qualified decision time in addition to runtime, provider, trust, and continuity evidence

#### Scenario: Lifecycle restarts early
- **WHEN** a canonical role-review restart trigger applies before C-stage completion
- **THEN** the Leader records canonical reason, actor, timezone-qualified decision time, provider and trust evidence and starts a successor without inherited decision or authorization

### Requirement: Ambiguous invocation state follows evidence-based patience
The workflow SHALL treat delayed output and `result-unknown` invocation state as lifecycle evidence requiring inspection and patience, not as confirmed failure, cleanup work, or permission for blind retry.

#### Scenario: Role output is delayed
- **WHEN** a PM or Advisor attempt is still `running` and no concrete failure evidence exists
- **THEN** the Leader preserves the attempt, applies the recorded patience window, and MUST NOT duplicate or close it solely because of short silence

#### Scenario: Result remains unknown
- **WHEN** available process, output, and CLI status checks cannot resolve whether an attempt completed
- **THEN** the Leader records `result-unknown`, preserves the gate as unresolved, and does not downgrade the condition into cleanup
