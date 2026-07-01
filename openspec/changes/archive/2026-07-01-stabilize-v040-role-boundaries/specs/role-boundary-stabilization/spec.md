## ADDED Requirements

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
