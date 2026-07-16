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

### Requirement: Validation checks cleanup discipline anchors
The local validation command SHALL check stable text anchors for sequential
cleanup, cleanup failure non-blocking boundaries, cleanup failure escalation,
and cleanup status reporting.

#### Scenario: Cleanup anchors are missing
- **WHEN** a contributor removes the sequential cleanup, cleanup non-blocking boundary, cleanup escalation, or cleanup status text from the skill or docs
- **THEN** local validation fails with a targeted cleanup-discipline check

#### Scenario: Cleanup status template marker is missing
- **WHEN** a contributor removes cleanup status fields from the closeout or handoff templates
- **THEN** local validation fails with a targeted template check

### Requirement: Validation checks Leader delegation anchors
The local validation command SHALL check stable text anchors for Leader work
budget self-check guidance, Worker-first context control, and bounded Worker
prompt/return evidence requirements.

#### Scenario: Leader budget marker is missing
- **WHEN** a contributor removes the Leader work-budget self-check text
- **THEN** local validation fails with a targeted delegation-discipline check

#### Scenario: Worker-first marker is missing
- **WHEN** a contributor removes Worker-first context-control guidance
- **THEN** local validation fails with a targeted context-control check

### Requirement: Validation describes anchor limits
Validation documentation SHALL state that the local validation command checks
documentation and template consistency, not runtime compliance with cleanup or
delegation behavior.

#### Scenario: Local validation passes
- **WHEN** local validation passes after v0.4.13
- **THEN** docs explain that the pass confirms required rule markers and template fields exist, not that a past multi-agent task actually followed the cleanup or delegation procedure

### Requirement: Validation checks adoption guidance anchors
The local validation command SHALL include lightweight checks that `v0.4.14`
adoption guidance remains present without adding CI, link checking, runtime
behavior enforcement, or automatic repair.

#### Scenario: Adoption anchors are present
- **WHEN** local validation runs after `v0.4.14`
- **THEN** it checks for README Quick Start, Use Cases, Safety Boundaries,
  `docs/ADOPTION.md`, and selected scenario headings

### Requirement: Validation checks adapter guide guardrail anchors
The local validation command SHALL include lightweight checks that adapter
guide template guardrails remain present without treating unvalidated runtime
guidance as support.

#### Scenario: Adapter guardrail anchors are present
- **WHEN** local validation runs after `v0.4.14`
- **THEN** it checks that adapter docs include guide-template or checklist
  markers, validation evidence fields, unsupported actions, and wording that
  unvalidated runtimes remain planned guidance or compatible patterns

### Requirement: Validation checks Fast Path boundaries
The local validation command SHALL check that Fast Path wording remains a reading-order optimization and does not weaken mandatory reference routing.

#### Scenario: Fast Path wording is present
- **WHEN** local validation runs
- **THEN** it checks that `SKILL.md` states Fast Path never skips a mandatory reference once a routed domain is touched

#### Scenario: Slow Path routed domains are present
- **WHEN** local validation runs
- **THEN** it checks that `SKILL.md` lists routed domains including git exits, OpenSpec, CLI trust or model routing, role dispatch or output, rollover or handoff, release, secrets, auth, security, permission, schema, destructive, and irreversible actions

### Requirement: Validation documents SKILL.md anchor demotion guardrails
The local validation command SHALL check v0.4.15 guardrail markers showing that current `SKILL.md` anchors remain anchored and that anchor demotion is not a validation-maintenance shortcut.

#### Scenario: No-anchor-loss markers are present
- **WHEN** local validation runs
- **THEN** it checks documentation stating that current `SKILL.md` hard-boundary anchors remain in `SKILL.md`
- **AND** it checks that anchor demotion is an explicit reviewed boundary change rather than a validation-maintenance shortcut

### Requirement: Validation checks cross-runtime installation anchors
The local validation command SHALL check that v0.4.16 runtime installation
guidance remains present without turning runtime guidance into installation
automation.

#### Scenario: Runtime installation markers are present
- **WHEN** local validation runs
- **THEN** it checks that README or installation docs link to runtime
  installation guidance
- **AND** it checks that Claude Code personal and project skill paths are
  documented

#### Scenario: Runtime installation boundary is present
- **WHEN** local validation runs
- **THEN** it checks that runtime installation docs state the repository is a
  bare skill folder rather than a plugin package
- **AND** it checks that copying the skill does not transfer authorization,
  workspace trust, validation freshness, role continuity, or secret access

### Requirement: Validation checks runtime support labels
The local validation command SHALL check that runtime adapter docs do not
overclaim Claude Code, OpenClaw, or Hermes Agent support.

#### Scenario: Runtime support labels are reviewed
- **WHEN** local validation runs
- **THEN** it checks that Claude Code remains under `adapter guide planned` with
  install guidance available and validation pending
- **AND** it checks that OpenClaw and Hermes Agent remain planned adapter
  guidance unless validation evidence is added
- **AND** it checks wording that fully supported runtime claims require
  validation evidence

#### Scenario: Runtime install commands do not become adapter guide skeletons
- **WHEN** local validation runs
- **THEN** it allows runtime installation commands only when they are separated
  from validated adapter guides
- **AND** it checks that docs still block runtime-specific guide skeletons that
  look like validated support before validation evidence exists

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

### Requirement: Local validation checks profile structure and measurements
The local validator SHALL perform deterministic marker and structural checks for profile declarations, profile selection basis, rendered fixtures, physical line measurements, and UTF-8 byte measurements without becoming a semantic policy engine.

#### Scenario: Compact fixture is checked
- **WHEN** local validation evaluates a Compact fixture
- **THEN** it checks the required declaration, selection-basis structure, applicable field anchors, physical lines, UTF-8 bytes, and warning state

#### Scenario: Detailed classification fixture is checked
- **WHEN** local validation evaluates takeover, disputed classification, transition, or boundary fixtures
- **THEN** it checks that all structural dimensions are explicitly represented and that the expected profile follows the fixture values

### Requirement: Profile validation preserves non-semantic boundaries
The local validator MUST NOT claim that profile counts are factually true, authorization is valid, a role lifecycle occurred, a pointer is semantically sufficient, or a successor can safely act without fresh verification.

#### Scenario: Structural validation passes
- **WHEN** every required marker, fixture expectation, and measurement check passes
- **THEN** documentation states that the result confirms structural consistency only and does not prove runtime or semantic compliance

#### Scenario: A size warning occurs during pilot
- **WHEN** a rendered fixture exceeds a provisional line or byte warning without a semantic or structural failure
- **THEN** validation reports a warning and MUST NOT fail solely because of size

### Requirement: Validation covers representative profile boundaries
Validation documentation and fixtures SHALL cover representative repo-grounded small and medium cases, takeover-direct-to-Standard, above-Standard, hysteresis, dependency/conflict-edge boundaries, overlap-edge boundaries, missing-mandatory-field, stale-pointer, and large stress cases.

#### Scenario: Original large inventory is unavailable
- **WHEN** the Owner-reported prior 4,000-line inventory cannot be inspected
- **THEN** validation uses a clearly labeled synthetic stress fixture and MUST NOT claim historical reconstruction

#### Scenario: Missing applicable field is detected
- **WHEN** a rendered fixture omits an applicable accepted retention-floor field
- **THEN** validation fails the structural fixture independently of line and byte size

### Requirement: Validation registers profile artifacts
The local validator SHALL register every new required profile reference and copyable template, SHALL require deterministic `SKILL.md` routing to the profile reference, and SHALL ratchet the verified `SKILL.md` hard-boundary anchor floor when profile anchors are added.

#### Scenario: Profile artifacts are added
- **WHEN** implementation adds the Leader-state profile reference, Compact template, Standard template, or Opportunity skeleton
- **THEN** required-reference and required-template validation includes each artifact and fails when any artifact or mandatory routing anchor is missing
