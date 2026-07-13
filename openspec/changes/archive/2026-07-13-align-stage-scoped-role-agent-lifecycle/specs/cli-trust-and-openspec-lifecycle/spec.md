## ADDED Requirements

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

## REMOVED Requirements

### Requirement: Short-lived role sessions preserve lifecycle and provider state
**Reason**: For OpenSpec work, the checkpoint-scoped short-session boundary is replaced by runtime-proven C-stage continuity with fresh checkpoint decisions. Non-OpenSpec short-session rules remain owned by `role-review-context-efficiency`.

**Migration**: Keep routing stable inside a runtime-proven C-stage lifecycle, restart across C-stages or canonical triggers, use exact runtime resume evidence, and keep non-OpenSpec distinct checkpoints short-lived.
