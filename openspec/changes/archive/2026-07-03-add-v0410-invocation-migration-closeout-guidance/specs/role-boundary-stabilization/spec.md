## ADDED Requirements

### Requirement: Skill invocation is selected from task traits
The skill SHALL define task traits that require or strongly recommend using `multi-agent-working-group`, including explicit Owner request, PM/Advisor/Worker/Reviewer coordination, external Advisor review, OpenSpec lifecycle work, medium or higher risk, delegated implementation, guarded commit or push, context rollover, cross-conversation handoff, and complex verification.

#### Scenario: Task clearly fits the skill
- **WHEN** a task includes PM/Advisor coordination, external Advisor review, OpenSpec lifecycle work, medium or higher risk, delegated Worker work, guarded git exits, rollover, handoff, or complex verification
- **THEN** the Leader selects and applies the `multi-agent-working-group` workflow unless a stricter project rule or concrete blocker prevents it

#### Scenario: Task is narrow and low-risk
- **WHEN** a task is small, local, low-risk, and does not require spec workflow, PM/Worker/Reviewer ownership, external Advisor review, or guarded git exits
- **THEN** the Leader may use Small Task Mode or complete directly when all existing Small Task Mode conditions are met

### Requirement: Automatic invocation does not create automatic authority
The skill SHALL state that automatically considering or invoking the skill means applying the workflow and checklist. It SHALL NOT mean automatic subagent spawning, automatic external Advisor calls, automatic workspace trust, automatic commit, automatic push, automatic archive, automatic CI, automatic next-goal execution, or bypass of Owner-only high-risk/default-exclusion gates.

#### Scenario: Skill trigger is detected
- **WHEN** the Leader detects that a task should use this skill
- **THEN** the Leader applies the skill workflow and records needed gates, but does not silently create agents, call external providers, trust workspaces, commit, push, archive, or begin another goal without the applicable authorization and evidence

### Requirement: Closeout is plain-language and evidence-based
The skill SHALL require final Leader outputs for completed work to include a concise plain-language summary of what changed, what was verified, what remains uncertain or not done, and recommended next goals. Next-goal recommendations SHALL be advice only unless the Owner has already authorized continued work.

#### Scenario: Work round completes
- **WHEN** a work round reaches completion or a safe stopping point
- **THEN** the Leader reports the completed work in ordinary language, lists key verification evidence, names any remaining uncertainty or skipped checks, and recommends the next goal without treating the recommendation as authorization to start it

#### Scenario: Owner is not a specialist
- **WHEN** the Leader reports final status to the Owner
- **THEN** the output avoids unexplained jargon or briefly explains necessary terms in practical language
