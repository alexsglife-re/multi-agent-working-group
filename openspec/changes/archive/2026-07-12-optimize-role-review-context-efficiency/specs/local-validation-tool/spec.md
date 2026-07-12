## ADDED Requirements

### Requirement: Validation checks role-review context-efficiency anchors
The local validation command SHALL check deterministic markers for stable baseline plus incremental packets, short-lived review sessions, original-evidence access, no-peek packet isolation, and the rule that context reduction cannot reduce capability or required gates.

#### Scenario: Quality-preservation marker is removed
- **WHEN** a contributor removes the skill or reference text preserving provider/model routing, review frequency, review scope, no-peek independence, original-evidence access, gate coverage, or lifecycle patience
- **THEN** local validation fails with a targeted role-review context-efficiency message

#### Scenario: Evidence-access marker is removed
- **WHEN** a role packet no longer states that it is an index rather than a restriction or substitute for task-relevant original evidence
- **THEN** local validation fails with a targeted evidence-access message

### Requirement: Validation checks review identity and no-blind-retry anchors
The local validation command SHALL check template and reference markers for Review ID, Attempt ID, packet fingerprint, invocation states, linked retries, and the prohibition on repeating a `running` or `result-unknown` packet without resolving available evidence.

#### Scenario: Retry guard is removed
- **WHEN** a contributor removes the no-blind-retry rule or required invocation states
- **THEN** local validation fails with a targeted retry-safety message

#### Scenario: Required output fields are removed
- **WHEN** a role packet omits `GO`, `NO-GO`, `BLOCKED-EVIDENCE`, P0/P1/P2, evidence gaps, validation freshness, or Owner-decision needs
- **THEN** local validation fails with a targeted role-output check

### Requirement: Validation documents runtime limits
Validation documentation SHALL state that context-efficiency marker checks prove required documentation and template structure exists but do not prove runtime compliance, actual token savings, or review quality by themselves.

#### Scenario: Context-efficiency validation passes
- **WHEN** the local validation command passes for v0.4.17
- **THEN** documentation still requires fresh PM/Advisor review and evidence-based gates rather than claiming the validator measured role execution quality

### Requirement: Validation separates public and development versions
The local validation command SHALL represent the current public version and current development target with separate explicit semantics, such as `PUBLIC_VERSION=v0.4.16` and `DEVELOPMENT_VERSION=v0.4.17`, and SHALL NOT treat development-version markers as evidence of an Owner-authorized tag, release, or publication.

#### Scenario: v0.4.17 is under development
- **WHEN** v0.4.17 implementation and documentation exist without an Owner-authorized v0.4.17 publication
- **THEN** local validation checks README's current public marker as v0.4.16 and checks roadmap, TODO, validation, or unreleased changelog development markers as v0.4.17

#### Scenario: Development text claims publication
- **WHEN** a v0.4.17 development marker causes README or release-facing documentation to claim v0.4.17 is the current public version without matching authorized release evidence
- **THEN** local validation fails with a targeted public/development version-state message

### Requirement: Validation registers context-efficiency artifacts
The local validation command SHALL register the `role-review-context-efficiency` spec, the dedicated context-efficiency reference, and every new reusable review template in the corresponding required-artifact arrays. The spec check SHALL accept the active delta during normal implementation validation and SHALL require the accepted spec path in no-active-change/archive mode. The dedicated reference SHALL participate in the existing global installed-reference sync check.

#### Scenario: Context-efficiency artifacts are implemented
- **WHEN** the v0.4.17 implementation is validated
- **THEN** `REQUIRED_ACCEPTED_SPECS` includes `role-review-context-efficiency`, `REQUIRED_REFERENCES` includes `references/review-context-efficiency.md`, and `REQUIRED_TEMPLATES` includes `templates/review-factual-manifest.md` and `templates/review-invocation-record.md`

#### Scenario: Template marker convention is unchanged
- **WHEN** the new templates are added without an intentional template-version migration
- **THEN** they retain `Version: v0.4.13 recommended template.` and local validation checks that marker through the existing required-template loop

### Requirement: Validation raises the SKILL hard-boundary anchor floor
The local validation command SHALL add distinct `SKILL.md` checks for mandatory context-efficiency reference routing and the fail-closed quality-preservation boundary, and SHALL raise `SKILL_ANCHOR_BASELINE` from 55 to at least 57 or the higher verified resulting anchor count.

#### Scenario: Two new SKILL anchors are added
- **WHEN** implementation adds exactly the mandatory-routing and quality-preservation anchors
- **THEN** `SKILL_ANCHOR_BASELINE` is at least 57 and local validation fails if either anchor is removed

#### Scenario: More than two new SKILL anchors are added
- **WHEN** implementation adds additional `SKILL.md` context-efficiency anchors
- **THEN** the baseline uses the verified resulting count rather than remaining at 57 or the old floor of 55
