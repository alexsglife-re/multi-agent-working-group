## ADDED Requirements

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
