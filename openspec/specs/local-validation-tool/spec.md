# local-validation-tool Specification

## Purpose
Define the repository's lightweight read-only local validation command for documentation, OpenSpec, version-marker, and installed skill sync checks.
## Requirements
### Requirement: Repository provides a local validation command
The project SHALL provide a repo-local validation command that can be run before commit or push to check the documentation-first skill package without network access.

#### Scenario: Contributor runs local validation
- **WHEN** a contributor runs the local validation command from the repository checkout
- **THEN** the command checks core documentation markers, `SKILL.md` frontmatter, OpenSpec health, accepted spec presence, and global skill sync when the global installed skill file exists

### Requirement: Local validation is read-only
The local validation command SHALL NOT mutate repository files, global skill files, Git state, OpenSpec state, or external services.

#### Scenario: Validation finds a problem
- **WHEN** a local validation check fails
- **THEN** the command reports the failing check and exits non-zero without attempting to repair files automatically

### Requirement: Local validation supports active-change and closeout modes
The local validation command SHALL support a default mode that can run during active OpenSpec work and a closeout mode that requires no active OpenSpec changes.

#### Scenario: Active OpenSpec change exists during implementation
- **WHEN** active OpenSpec changes exist and closeout mode was not requested
- **THEN** the command reports the active changes as informational and continues other checks

#### Scenario: Closeout mode is requested
- **WHEN** the command is run with closeout mode enabled and active OpenSpec changes exist
- **THEN** the command fails and reports that archive or cleanup is still required

### Requirement: Validation checks provider-separation markers
The local validation command SHALL include lightweight checks that the skill and templates contain stable provider-separation markers without attempting to become a semantic policy engine.

#### Scenario: Provider separation markers are present
- **WHEN** local validation runs
- **THEN** it checks for skill text defining provider-level separation, same-provider variant degradation, hint-to-verify memory handling, and current verified model records

#### Scenario: Template separation fields are present
- **WHEN** local validation runs
- **THEN** it checks state-carrying templates for provider/model-per-role, PM/Advisor separation status, model source, and current verification fields

### Requirement: Validation checks agent patience markers
The local validation command SHALL check selected text markers for the current local documentation version's agent patience and lifecycle rules.

#### Scenario: v0.4.9 patience markers are missing
- **WHEN** a contributor removes the agent patience rule or lifecycle fields from the skill or templates
- **THEN** the local validation command fails with a targeted message

### Requirement: Validation checks installation guidance markers
The local validation command SHALL check selected text markers for the installation and migration guide when present.

#### Scenario: Installation guide is missing required boundaries
- **WHEN** a contributor removes installation guidance, validation commands, global skill sync boundaries, or non-transferable authorization warnings
- **THEN** the local validation command fails with a targeted message

### Requirement: Validation checks invocation and closeout markers
The local validation command SHALL include lightweight checks that the skill and docs preserve v0.4.10 invocation, migration, and closeout markers without becoming a semantic policy engine.

#### Scenario: Invocation markers are present
- **WHEN** local validation runs
- **THEN** it checks for skill text describing task-trait based skill invocation and boundaries against automatic subagent spawning, external Advisor calls, git exits, archive, CI, and next-goal execution

#### Scenario: Closeout markers are present
- **WHEN** local validation runs
- **THEN** it checks for final output or template text that requires a plain-language completion summary, verification evidence, remaining uncertainty or skipped checks, and recommended next goals

#### Scenario: Migration markers are present
- **WHEN** local validation runs
- **THEN** it checks installation guidance for adoption steps and non-transferable authorization, role continuity, validation freshness, workspace trust, secrets, and stale handoff authority

### Requirement: Validation checks platform-neutral positioning markers
The local validation command SHALL include lightweight checks that public docs
preserve v0.4.11 platform-neutral protocol positioning without claiming
unvalidated full runtime support.

#### Scenario: Platform-neutral markers are present
- **WHEN** local validation runs
- **THEN** it checks for README and installation text that identifies Multi-Agent Working Group as a portable protocol and Codex as the reference adapter

#### Scenario: Adapter markers are present
- **WHEN** local validation runs
- **THEN** it checks for adapter guidance describing maturity labels, required mapping fields, and non-transferable authority boundaries

#### Scenario: Unverified support is not overclaimed
- **WHEN** local validation runs
- **THEN** it checks for wording that non-Codex runtimes are planned guidance or compatible patterns until validated, not fully supported adapters

### Requirement: Validation preserves SKILL.md hard-boundary anchors
The local validation command SHALL prevent progressive reference restructuring
from reducing the hard-boundary anchor set that remains directly checked in
`SKILL.md`.

#### Scenario: SKILL.md anchor set is checked
- **WHEN** local validation runs after progressive reference restructuring
- **THEN** it checks that the current `template_contains "SKILL.md"` hard-boundary anchor count is not reduced
- **AND** it checks that current hard-boundary anchor phrases remain anchored to `SKILL.md` rather than silently moving to reference file checks
- **AND** it checks each current hard-boundary anchor phrase individually rather than relying only on a total count

#### Scenario: New references are checked
- **WHEN** local validation runs after reference files are introduced
- **THEN** it checks that required reference files exist and contain detailed gate language for their domains

#### Scenario: Default exclusion summary is missing from SKILL.md
- **WHEN** default-exclusion details exist in a reference but no fail-closed default-exclusion summary remains in `SKILL.md`
- **THEN** local validation fails

### Requirement: Validation checks mandatory reference routing
The local validation command SHALL check that `SKILL.md` contains mandatory
reference routing statements for the domains moved into progressive references.

#### Scenario: Routing statement is missing
- **WHEN** detailed rules exist for the git/default-exclusion, OpenSpec lifecycle, CLI trust, rollover/handoff, or role-output domains
- **THEN** local validation fails unless `SKILL.md` contains the corresponding MUST-read routing statement

#### Scenario: Routing marker is weak
- **WHEN** local validation checks a mandatory domain routing statement
- **THEN** it uses deterministic marker text strong enough to prove the affected domain requires a reference read before acting

### Requirement: Validation supports representative scenario checks
The local validation command and validation documentation SHALL include
representative checks for domains most likely to lose constraints during a
structure-only refactor.

#### Scenario: Representative scenarios are reviewed
- **WHEN** v0.4.12 validation is run
- **THEN** it covers commit/push, tag/release/default exclusions, OpenSpec-backed work, Small Task Mode at git gates, handoff/rollover, CLI trust, and missing PM or Advisor fail-closed behavior
