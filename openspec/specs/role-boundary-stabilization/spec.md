# role-boundary-stabilization Specification

## Purpose
Define the stable role-boundary, example, validation, and normal git-gate requirements introduced by the v0.4.0 documentation-first stabilization pass.
## Requirements
### Requirement: Version metadata documents v0.4.0
The project SHALL document v0.4.0 as the role-boundary and operating-examples stabilization target without implying release, tag, push, deployment, or public publication by itself.

#### Scenario: Version metadata is visible
- **WHEN** a reader opens the README and changelog after this change
- **THEN** they can identify v0.4.0 as the current stabilization target and see that git publication still follows the skill gates

### Requirement: Examples cover core operating gates
The project SHALL include examples for small direct documentation work, medium Worker delegation, blocked-state reporting, commit gates, push gates, and handoff or continuity recovery.

#### Scenario: Future agent selects the right example
- **WHEN** a future agent needs to decide whether a task is small, medium, blocked, commit-bound, push-bound, or handoff-bound
- **THEN** the examples provide a matching pattern without weakening role or git gates

### Requirement: Small Task Mode excludes PM, Worker, and Reviewer
The skill and examples SHALL state that Small Task Mode uses no PM, no Worker, and no Reviewer while preserving required validation, Advisor review at git gates, and stricter project rules.

#### Scenario: Small task reaches commit gate
- **WHEN** a small low-risk task is locally complete and commit is in scope
- **THEN** Advisor review and required git-gate checks apply, but PM, Worker, and Reviewer are not added solely because the task is small

### Requirement: Medium work cannot become hidden Leader execution
The skill and examples SHALL state that medium or higher work must not be executed by Leader as a hidden Worker slice when independent Worker ownership is required.

#### Scenario: Medium documentation work changes workflow interpretation
- **WHEN** a documentation task affects future workflow interpretation across multiple files or skill rules
- **THEN** Leader coordinates PM, Advisor, and Worker responsibilities rather than doing the substantive execution slice silently

### Requirement: Reviewer independence remains conditional and explicit
The skill and examples SHALL state that Reviewer must not review its own implementation and that Reviewer is required for code or higher-risk gates as defined by the skill, not for every documentation task by default.

#### Scenario: Documentation task stays medium but non-code
- **WHEN** a medium documentation task does not change code, security, permissions, API, database, architecture, or other stricter gates
- **THEN** Reviewer is not required by default, while PM plus Advisor review and validation still apply

### Requirement: Normal git exits follow PM plus Advisor gate
The skill and examples SHALL align with the global rule that normal non-high-risk commits and pushes may proceed after PM plus Advisor consensus, required Reviewer approval when applicable, fresh validation, clear target, and applicable secret or credential scanning before push. A normal push to `main` SHALL be eligible for this gate when it does not require a protected-branch bypass or exception.

#### Scenario: Normal commit is ready
- **WHEN** a normal non-high-risk commit-ready scope has PM plus Advisor agreement, no unresolved P0/P1, required validation is fresh, and required Reviewer approval has passed if applicable
- **THEN** the commit may proceed without asking Owner again, followed by PM plus Advisor review of the actual commit result

#### Scenario: Normal push is ready
- **WHEN** a normal non-high-risk push-ready scope has PM plus Advisor agreement, no unresolved P0/P1, required validation is fresh, required Reviewer approval has passed if applicable, target remote and branch are clear, and applicable secret or credential scanning passes
- **THEN** the push may proceed without asking Owner again, followed by CI/status checks when required and PM plus Advisor review of the actual push result

#### Scenario: Normal push targets main
- **WHEN** a normal non-high-risk push-ready scope targets `origin/main`, has PM plus Advisor agreement, no unresolved P0/P1, required validation is fresh, required Reviewer approval has passed if applicable, and applicable secret or credential scanning passes
- **THEN** the push may proceed under the normal gate unless it requires a force-push, history rewrite, protected-branch bypass/exception action, or another high-risk/default-exclusion action

### Requirement: High-risk and default exclusions still require Owner
The skill and examples SHALL preserve explicit Owner approval for force-push, history rewrite, protected-branch bypass/exception actions, tags/releases, deployment, schema migrations, credential or secret changes, security/auth/permission changes, destructive operations, irreversible external effects, and other high-risk actions.

#### Scenario: Push request includes a default exclusion
- **WHEN** a requested git or external action includes a default exclusion such as force-push, release, deployment, protected-branch bypass/exception action, credential change, schema migration, or security permission change
- **THEN** PM plus Advisor agreement is insufficient and explicit Owner approval is required

### Requirement: Validation checks prevent role and gate drift
The validation checklist SHALL include v0.4.0 checks for role-boundary consistency, Small Task Mode, hidden Worker execution, Reviewer misuse, commit/push authorization wording, English-only docs, and reference-source automation creep.

#### Scenario: Reviewer validates v0.4.0 docs
- **WHEN** a reviewer checks the v0.4.0-ready documentation set
- **THEN** the checklist catches small-task Reviewer misuse, medium hidden Leader execution, high-risk git gate weakening, and examples that imply unauthorized commit or push

### Requirement: Installation and migration guidance preserves authorization boundaries
The project SHALL document how to install, sync, and migrate the skill without implying transfer of workstream authorization, git authorization, validation freshness, role continuity, or external-effect permission.

#### Scenario: Skill is migrated to another machine or project
- **WHEN** a reader follows the installation or migration guide
- **THEN** the guide states that files and stable rules may be copied, but commit/push/CI/archive authorization, PM/Advisor agreement, Worker results, and stale handoff facts must be re-verified for the new machine, project, or workstream

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

### Requirement: Leader direct work has a budget trigger
The protocol SHALL require the Leader to treat substantive direct execution in
Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or
context-heavy work as an exception rather than the default. The protocol SHALL
provide a Leader work-budget self-check trigger and require the Leader to
dispatch a bounded Worker or record a concrete exception when direct work grows
beyond small connective edits.

#### Scenario: Leader direct edits exceed the self-check trigger
- **WHEN** Leader direct edits in a Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or context-heavy task exceed the documented self-check trigger
- **THEN** the Leader either dispatches a bounded Worker before continuing substantive execution or records a concrete exception explaining why Leader direct execution is safer

#### Scenario: Leader performs small connective work
- **WHEN** Leader work is limited to small connective edits, checklist updates, tiny validation-anchor fixes, or gate-required commands
- **THEN** the Leader may perform that work directly while preserving role and gate boundaries

### Requirement: Leader work-budget trigger is guidance, not automatic failure
The protocol SHALL describe numeric Leader work-budget values, such as more
than 2 files or roughly 80 diff lines, as a self-check trigger rather than an
automatic correctness failure.

#### Scenario: Mechanical edit exceeds the numeric trigger
- **WHEN** a mechanical or safer Leader-owned edit exceeds the numeric self-check trigger
- **THEN** the Leader may continue only after recording the exception and why Worker dispatch would add more risk or overhead than it removes

#### Scenario: Dense edit stays below the numeric trigger
- **WHEN** a dense or interpretive edit stays below the numeric self-check trigger but is substantively Worker-suitable
- **THEN** the Leader still treats Worker dispatch as the default unless a concrete exception is recorded
