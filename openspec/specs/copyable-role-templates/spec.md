# copyable-role-templates Specification

## Purpose
Define copyable templates for common Multi-Agent Working Group role outputs, gate evidence, blocked reports, compact handoff recovery, and successor startup packets, including safe handling for legacy or bloated documents.
## Requirements
### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for PM, Advisor, Worker assignment, Worker return, Reviewer report, blocked report, C0 analysis, compact handoff, successor startup, and git gate capture. Templates for PM, Advisor, Worker, C0, compact handoff, successor startup, and blocked reports SHALL record lifecycle patience state when substantive role work is expected, in progress, blocked, or restarted. State-carrying templates SHALL provide fields for a plain-language completion summary and recommended next goals when a work round closes or hands off.

#### Scenario: Future agent captures long-running role state
- **WHEN** a PM, Advisor, or substantive Worker is still working or has been restarted
- **THEN** the relevant template provides fields for expected wait window, last contact, progress evidence, patience state, and closure or restart reason

#### Scenario: Future agent closes a work round
- **WHEN** a work round completes or reaches a safe handoff boundary
- **THEN** the relevant template provides fields for what changed, what was verified, remaining uncertainty or skipped checks, and recommended next goals

### Requirement: Templates are structure only
The templates SHALL state or imply that they provide structure and evidence capture only, not authorization, approval, validation success, gate bypass, automatic next-goal execution, or automatic role spawning.

#### Scenario: Template is used before commit or push
- **WHEN** a role or gate template is filled in before commit or push
- **THEN** the filled template remains evidence for the applicable PM/Advisor/Reviewer and git gates, not a substitute for those gates

#### Scenario: Completion summary recommends a next goal
- **WHEN** a filled template recommends a next goal
- **THEN** the recommendation does not authorize starting that goal unless the Owner has already given that instruction

### Requirement: Legacy documents remain historical evidence
The project SHALL define how v0.3 or older handoffs, ledgers, and role outputs are handled when v0.4.5 templates are adopted.

#### Scenario: Workstream resumes from an old handoff
- **WHEN** a Leader resumes from a v0.3 or older handoff document
- **THEN** the Leader preserves the old document as historical evidence, creates a new current state using the v0.4.5 template, copies only verified current facts into the active state, and references old material through the evidence index with freshness and verification status

#### Scenario: Old handoff is long
- **WHEN** an old handoff or ledger is long or append-only
- **THEN** the Leader MUST NOT paste it verbatim into the new active handoff and MUST instead summarize current verified state plus evidence pointers

### Requirement: State templates record provider separation
The template set SHALL include provider/model-per-role, model source, PM/Advisor separation status, and freshness/applicability verification fields in templates that carry workstream state.

#### Scenario: C0 template records model source
- **WHEN** a Leader fills the C0 goal analysis template for a workstream using PM and Advisor
- **THEN** the template includes fields for PM provider/model, Advisor provider/model, model source, PM/Advisor separation status, and current verification status

#### Scenario: Handoff templates record model source
- **WHEN** a Leader fills compact handoff or successor startup templates for a workstream with PM/Advisor state
- **THEN** the templates include provider/model-per-role, separation status, model source, freshness, and applicability verification fields

#### Scenario: Same provider variant is recorded
- **WHEN** PM and Advisor use different variants from the same provider
- **THEN** the templates provide a status that records the state as degraded or partial rather than full provider separation

### Requirement: Templates record cleanup status
The template set SHALL provide cleanup status fields for closeout or handoff
contexts where role-agent cleanup was attempted, skipped, degraded, or failed.
Cleanup status fields SHALL record whether cleanup issues affect delivery
evidence.

#### Scenario: Final closeout uses a template
- **WHEN** a Leader fills a final closeout or compact handoff template after multi-agent work
- **THEN** the template provides fields for role cleanup attempted, skipped, degraded, failed, and delivery-evidence impact

#### Scenario: Cleanup failure is non-blocking
- **WHEN** cleanup failure is reported as non-blocking
- **THEN** the template requires the Leader to state why task, git, validation, secret-safety, authorization, and required role evidence are confirmed from evidence in hand

### Requirement: Worker templates support bounded delegation
Worker assignment templates SHALL preserve bounded goal, allowed scope,
forbidden scope, required evidence, stop conditions, and cleanup or handoff
expectations when applicable.

#### Scenario: Worker is dispatched for context control
- **WHEN** Worker-first context control dispatches a Worker slice
- **THEN** the Worker assignment template captures the bounded target, allowed files or modules, forbidden files or modules, required evidence, and stop conditions

#### Scenario: Worker returns evidence
- **WHEN** a Worker returns from a bounded slice
- **THEN** the Worker return template captures changed files, validation, findings, blockers, next action, and whether any cleanup or handoff issue remains

### Requirement: Role templates support context-efficient review packets
The template set SHALL provide a shared factual manifest structure and separate PM and Advisor packet structures that capture Review ID, Attempt ID, review target, stable baseline, incremental evidence, validation freshness, evidence-access instructions, no-peek state, and the complete required response surface.

#### Scenario: Leader prepares independent first-pass packets
- **WHEN** the Leader prepares PM and Advisor first-pass reviews from the same factual evidence
- **THEN** the templates provide separate role packets with explicit conclusions-withheld fields and no conclusion from the other role

#### Scenario: Role needs original evidence
- **WHEN** the compact packet is insufficient for a reliable decision
- **THEN** the template states that task-relevant original evidence remains available within the approved scope and supports a `BLOCKED-EVIDENCE` result

### Requirement: State-carrying templates record review invocation identity
PM, Advisor, git-gate, compact-handoff, successor-startup, and other applicable state-carrying templates SHALL record Review ID, Attempt ID, packet fingerprint, invocation state, result location, retry decision, and parent Attempt ID when retried.

#### Scenario: Invocation result is unknown at handoff
- **WHEN** a role invocation remains `result-unknown` at a safe handoff boundary
- **THEN** the handoff records its identity, state, available process or output evidence, and the prohibition on blind retry

#### Scenario: Git gate uses context-efficient review
- **WHEN** PM or Advisor reviews a commit or push gate from an incremental packet
- **THEN** the git-gate record preserves the actual target, validation freshness, P0/P1/P2, evidence gaps, authorization state, and linked invocation identity

### Requirement: Leader templates render profile-aware active-state instances
The project SHALL provide genuinely reduced Compact and Standard active-state and handoff instances through separate templates or a deterministic profile-aware renderer. Existing full blank template source length MUST NOT be represented as active-instance length.

#### Scenario: A representative repo-grounded small fixture is rendered
- **WHEN** a small fixture cites the archived change, accepted template, or accepted example from which its active-state facts were derived and has no triggered optional sections
- **THEN** the rendered Compact instance asserts the expected profile and deterministic counts, uses a lightweight profile attestation, omits inapplicable visible sections, preserves every triggered accepted field, records physical-line and UTF-8-byte measurements, and treats size warnings as non-blocking

#### Scenario: A representative repo-grounded medium fixture is rendered
- **WHEN** a medium fixture cites its repository provenance, exceeds Compact structure, and satisfies Standard
- **THEN** the rendered Standard instance asserts the expected profile and deterministic counts, uses stable sections, omits inapplicable visible sections, preserves every triggered accepted field, records physical-line and UTF-8-byte measurements, and treats size warnings as non-blocking

### Requirement: Reduced rendering does not weaken accepted fields
Profile-aware rendering SHALL treat the complete applicable accepted state-carrying field set as the retention floor, including changed and do-not-touch files; validation run, not run, and freshness; PM, Advisor, and Reviewer continuity; required Reviewer approval; provider and model separation evidence; lifecycle patience; cleanup; and review-invocation identity when applicable.

#### Scenario: A mandatory field is applicable
- **WHEN** an accepted triggering condition makes a state-carrying field applicable
- **THEN** every profile renders that field or a stable accepted projection and MUST NOT replace it with assumed approval or an unverified default

#### Scenario: Full reasoning is stored elsewhere
- **WHEN** durable role output contains required reasoning
- **THEN** the profile instance retains the current finding and stable evidence pointer without applying a storage cap to the durable output
