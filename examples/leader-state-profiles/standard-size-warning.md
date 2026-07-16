# Synthetic Standard Size-Warning Fixture

Fixture ID: FX-SIZE-WARNING
Expected result: pass-with-warning
Expected reason: WARN-LINES-NONBLOCKING
Scenario type: synthetic structural-ceiling instance; not observed project history or live authority.
Schema required keys: profile-selection,owner-goal-scope,active-state,workstreams-relationships,findings-blockers,files,authorization-state,role-continuity,validation-freshness,cleanup-context,next-action-stops,evidence-index,archive-capability,measurement
Present keys: profile-selection,owner-goal-scope,active-state,workstreams-relationships,findings-blockers,files,authorization-state,role-continuity,validation-freshness,cleanup-context,next-action-stops,evidence-index,archive-capability,measurement

## S01 — Profile Selection

Leader state profile: Standard
Inventory scope: current-active-only
Measurement source: synthetic:standard-structural-ceilings
Measurement source kind: fixture-measurement
Measurement time: 2026-07-15T13:00:00-07:00
Measurement freshness: fresh
Selection detail: full-counts
Profile selection basis: all eight deterministic counts are at Standard ceilings and exceed multiple Compact ceilings.
Exceeded trigger keys: compact.workstreams,compact.blockers,compact.role-lifecycles,compact.validation-groups,compact.dependency-conflict-edges,compact.overlap-edges,compact.high-risk-gates,compact.authorization-domains
Projection assessment: reliable-single-file
Projection evidence kind: structural
Checkpoint event: validation-fixture
Checkpoint evidence/time: examples/leader-state-profiles/standard-size-warning.md; 2026-07-15T13:00:00-07:00

| Dimension | Count | Compact max | Standard max |
| --- | ---: | ---: | ---: |
| Active workstreams | 5 | 2 | 5 |
| Blockers | 10 | 5 | 10 |
| Live role lifecycles | 15 | 8 | 15 |
| Validation-freshness groups | 15 | 8 | 15 |
| Dependency/conflict edges | 30 | 10 | 30 |
| Overlap edges | 20 | 5 | 20 |
| High-risk gates | 3 | 2 | 3 |
| Active authorization domains | 3 | 2 | 3 |

## S02 — Owner, Goal, Stage, And Scope

Owner instruction: exercise the provisional Standard structural ceilings without omitting applicable control facts.
Owner decisions needed: none for this deterministic fixture.
Global goal: prove that a valid size warning remains non-blocking.
Stage / archive requirement: validation fixture / not applicable.
Scope: this fixture only.
Non-goals: no runtime claim, authorization grant, release execution, publication execution, deployment execution, schema mutation, or reconstruction of historical state.
Risk / mode: synthetic validation / fixture-only.
Current status: structurally complete and awaiting measurement verification.
Global next action: compare embedded physical measurements with wc -l -c.

## S03 — Active Workstreams And Relationships

| ID | Goal | Status | Next action |
| --- | --- | --- | --- |
| ws-1 | Synthetic bounded workstream 1 | active | Preserve current control fact set 1 |
| ws-2 | Synthetic bounded workstream 2 | active | Preserve current control fact set 2 |
| ws-3 | Synthetic bounded workstream 3 | active | Preserve current control fact set 3 |
| ws-4 | Synthetic bounded workstream 4 | active | Preserve current control fact set 4 |
| ws-5 | Synthetic bounded workstream 5 | active | Preserve current control fact set 5 |

### Dependency And Conflict Edges

Dependency edge dep:ws-1>ws-2:ordered-reason-01: unique normalized tuple 1; evidence synthetic:dependency-01.
Dependency edge dep:ws-2>ws-3:ordered-reason-02: unique normalized tuple 2; evidence synthetic:dependency-02.
Dependency edge dep:ws-3>ws-4:ordered-reason-03: unique normalized tuple 3; evidence synthetic:dependency-03.
Dependency edge dep:ws-4>ws-5:ordered-reason-04: unique normalized tuple 4; evidence synthetic:dependency-04.
Dependency edge dep:ws-5>ws-1:ordered-reason-05: unique normalized tuple 5; evidence synthetic:dependency-05.
Dependency edge dep:ws-1>ws-2:ordered-reason-06: unique normalized tuple 6; evidence synthetic:dependency-06.
Dependency edge dep:ws-2>ws-3:ordered-reason-07: unique normalized tuple 7; evidence synthetic:dependency-07.
Dependency edge dep:ws-3>ws-4:ordered-reason-08: unique normalized tuple 8; evidence synthetic:dependency-08.
Dependency edge dep:ws-4>ws-5:ordered-reason-09: unique normalized tuple 9; evidence synthetic:dependency-09.
Dependency edge dep:ws-5>ws-1:ordered-reason-10: unique normalized tuple 10; evidence synthetic:dependency-10.
Dependency edge dep:ws-1>ws-2:ordered-reason-11: unique normalized tuple 11; evidence synthetic:dependency-11.
Dependency edge dep:ws-2>ws-3:ordered-reason-12: unique normalized tuple 12; evidence synthetic:dependency-12.
Dependency edge dep:ws-3>ws-4:ordered-reason-13: unique normalized tuple 13; evidence synthetic:dependency-13.
Dependency edge dep:ws-4>ws-5:ordered-reason-14: unique normalized tuple 14; evidence synthetic:dependency-14.
Dependency edge dep:ws-5>ws-1:ordered-reason-15: unique normalized tuple 15; evidence synthetic:dependency-15.
Dependency edge dep:ws-1>ws-2:ordered-reason-16: unique normalized tuple 16; evidence synthetic:dependency-16.
Dependency edge dep:ws-2>ws-3:ordered-reason-17: unique normalized tuple 17; evidence synthetic:dependency-17.
Dependency edge dep:ws-3>ws-4:ordered-reason-18: unique normalized tuple 18; evidence synthetic:dependency-18.
Dependency edge dep:ws-4>ws-5:ordered-reason-19: unique normalized tuple 19; evidence synthetic:dependency-19.
Dependency edge dep:ws-5>ws-1:ordered-reason-20: unique normalized tuple 20; evidence synthetic:dependency-20.
Dependency edge dep:ws-1>ws-2:ordered-reason-21: unique normalized tuple 21; evidence synthetic:dependency-21.
Dependency edge dep:ws-2>ws-3:ordered-reason-22: unique normalized tuple 22; evidence synthetic:dependency-22.
Dependency edge dep:ws-3>ws-4:ordered-reason-23: unique normalized tuple 23; evidence synthetic:dependency-23.
Dependency edge dep:ws-4>ws-5:ordered-reason-24: unique normalized tuple 24; evidence synthetic:dependency-24.
Dependency edge dep:ws-5>ws-1:ordered-reason-25: unique normalized tuple 25; evidence synthetic:dependency-25.
Dependency edge dep:ws-1>ws-2:ordered-reason-26: unique normalized tuple 26; evidence synthetic:dependency-26.
Dependency edge dep:ws-2>ws-3:ordered-reason-27: unique normalized tuple 27; evidence synthetic:dependency-27.
Dependency edge dep:ws-3>ws-4:ordered-reason-28: unique normalized tuple 28; evidence synthetic:dependency-28.
Dependency edge dep:ws-4>ws-5:ordered-reason-29: unique normalized tuple 29; evidence synthetic:dependency-29.
Dependency edge dep:ws-5>ws-1:ordered-reason-30: unique normalized tuple 30; evidence synthetic:dependency-30.

### Overlap Edges

Overlap edge overlap:ws-1+ws-3:synthetic/shared-01.md: unique normalized tuple 1; evidence synthetic:overlap-01.
Overlap edge overlap:ws-2+ws-4:synthetic/shared-02.md: unique normalized tuple 2; evidence synthetic:overlap-02.
Overlap edge overlap:ws-3+ws-5:synthetic/shared-03.md: unique normalized tuple 3; evidence synthetic:overlap-03.
Overlap edge overlap:ws-1+ws-4:synthetic/shared-04.md: unique normalized tuple 4; evidence synthetic:overlap-04.
Overlap edge overlap:ws-2+ws-5:synthetic/shared-05.md: unique normalized tuple 5; evidence synthetic:overlap-05.
Overlap edge overlap:ws-1+ws-3:synthetic/shared-06.md: unique normalized tuple 6; evidence synthetic:overlap-06.
Overlap edge overlap:ws-2+ws-4:synthetic/shared-07.md: unique normalized tuple 7; evidence synthetic:overlap-07.
Overlap edge overlap:ws-3+ws-5:synthetic/shared-08.md: unique normalized tuple 8; evidence synthetic:overlap-08.
Overlap edge overlap:ws-1+ws-4:synthetic/shared-09.md: unique normalized tuple 9; evidence synthetic:overlap-09.
Overlap edge overlap:ws-2+ws-5:synthetic/shared-10.md: unique normalized tuple 10; evidence synthetic:overlap-10.
Overlap edge overlap:ws-1+ws-3:synthetic/shared-11.md: unique normalized tuple 11; evidence synthetic:overlap-11.
Overlap edge overlap:ws-2+ws-4:synthetic/shared-12.md: unique normalized tuple 12; evidence synthetic:overlap-12.
Overlap edge overlap:ws-3+ws-5:synthetic/shared-13.md: unique normalized tuple 13; evidence synthetic:overlap-13.
Overlap edge overlap:ws-1+ws-4:synthetic/shared-14.md: unique normalized tuple 14; evidence synthetic:overlap-14.
Overlap edge overlap:ws-2+ws-5:synthetic/shared-15.md: unique normalized tuple 15; evidence synthetic:overlap-15.
Overlap edge overlap:ws-1+ws-3:synthetic/shared-16.md: unique normalized tuple 16; evidence synthetic:overlap-16.
Overlap edge overlap:ws-2+ws-4:synthetic/shared-17.md: unique normalized tuple 17; evidence synthetic:overlap-17.
Overlap edge overlap:ws-3+ws-5:synthetic/shared-18.md: unique normalized tuple 18; evidence synthetic:overlap-18.
Overlap edge overlap:ws-1+ws-4:synthetic/shared-19.md: unique normalized tuple 19; evidence synthetic:overlap-19.
Overlap edge overlap:ws-2+ws-5:synthetic/shared-20.md: unique normalized tuple 20; evidence synthetic:overlap-20.

Cross-workstream ownership: S03 owns each relationship tuple exactly once.
Duplicate relationship tuples: none.

## S04 — Findings, Blockers, And Stops

Blocker blocker-01: unresolved synthetic condition 1; canonical owner S04; evidence synthetic:blocker-01.
Blocker blocker-02: unresolved synthetic condition 2; canonical owner S04; evidence synthetic:blocker-02.
Blocker blocker-03: unresolved synthetic condition 3; canonical owner S04; evidence synthetic:blocker-03.
Blocker blocker-04: unresolved synthetic condition 4; canonical owner S04; evidence synthetic:blocker-04.
Blocker blocker-05: unresolved synthetic condition 5; canonical owner S04; evidence synthetic:blocker-05.
Blocker blocker-06: unresolved synthetic condition 6; canonical owner S04; evidence synthetic:blocker-06.
Blocker blocker-07: unresolved synthetic condition 7; canonical owner S04; evidence synthetic:blocker-07.
Blocker blocker-08: unresolved synthetic condition 8; canonical owner S04; evidence synthetic:blocker-08.
Blocker blocker-09: unresolved synthetic condition 9; canonical owner S04; evidence synthetic:blocker-09.
Blocker blocker-10: unresolved synthetic condition 10; canonical owner S04; evidence synthetic:blocker-10.

Unresolved P0: none represented.
Unresolved P1: none represented.
Current P2: none represented.
Incidents / emergency stops: none represented.
Stop: an enumerated count no longer matches its S01 value.
Stop: any pointer, canonical source, selection basis, or applicable field becomes invalid.
Next high-risk gates: gate-01, gate-02, and gate-03; fixture-only pending decisions with no granted authority.

## S05 — Files And Ownership

Changed file: examples/leader-state-profiles/standard-size-warning.md, owned by this fixture slice.
Do not touch: every file outside examples/leader-state-profiles/.
Shared resources: the 20 normalized S03 overlap tuples.
Canonical current projection: stable sections S01 through S12 in this file.
Conflicting or duplicate ownership: none.
Derived copies: none; synthetic evidence pointers identify source records without asserting external existence.
Copy freshness metadata: not applicable because no current fact is copied from a live canonical source.

## S06 — Authorization And Gate State

Bound authorization keys: 3
Authorization key: auth:owner:repository:release:release-candidate:pending:exact-tag-target-and-release-gate; evidence synthetic:auth-release.
Authorization key: auth:owner:environment:deploy:production:pending:deployment-gate-and-target; evidence synthetic:auth-deploy.
Authorization key: auth:owner:schema:migrate:primary-schema:pending:migration-plan-and-rollback; evidence synthetic:auth-schema-migration.
Standing unrequested exclusion: publication is retained as scope but is not counted as an active authorization domain.
High-risk gate gate-01: tag and release decision pending outside this fixture.
High-risk gate gate-02: production deployment decision pending outside this fixture; publication is not entered.
High-risk gate gate-03: primary schema migration decision pending outside this fixture.
Historical gate evidence: none.
Successor inheritance: prohibited; every authorization and gate requires fresh verification.

## S07 — Role And Review Continuity

Role role-01: Worker lifecycle current; finding none unresolved; result pointer synthetic:role-01; patience complete.
Role role-02: Worker lifecycle current; finding none unresolved; result pointer synthetic:role-02; patience complete.
Role role-03: Worker lifecycle current; finding none unresolved; result pointer synthetic:role-03; patience complete.
Role role-04: Worker lifecycle current; finding none unresolved; result pointer synthetic:role-04; patience complete.
Role role-05: Worker lifecycle current; finding none unresolved; result pointer synthetic:role-05; patience complete.
Role role-06: Reviewer lifecycle current; finding none unresolved; result pointer synthetic:role-06; patience complete.
Role role-07: Reviewer lifecycle current; finding none unresolved; result pointer synthetic:role-07; patience complete.
Role role-08: Reviewer lifecycle current; finding none unresolved; result pointer synthetic:role-08; patience complete.
Role role-09: Reviewer lifecycle current; finding none unresolved; result pointer synthetic:role-09; patience complete.
Role role-10: Reviewer lifecycle current; finding none unresolved; result pointer synthetic:role-10; patience complete.
Role role-11: PM lifecycle current; finding none unresolved; result pointer synthetic:role-11; patience complete.
Role role-12: PM lifecycle current; finding none unresolved; result pointer synthetic:role-12; patience complete.
Role role-13: PM lifecycle current; finding none unresolved; result pointer synthetic:role-13; patience complete.
Role role-14: Advisor lifecycle current; finding none unresolved; result pointer synthetic:role-14; patience complete.
Role role-15: Advisor lifecycle current; finding none unresolved; result pointer synthetic:role-15; patience complete.

Provider/model separation: synthetic roles do not assert providers or models.
CLI workspace trust: not applicable; no role runtime is invoked.
Review invocation: deterministic fixture identities only; not evidence that a review occurred.
Required Reviewer approval: pending if a later real gate makes it applicable.
Unconsumed Worker returns / result-unknown evidence: none.

## S08 — Validation Freshness

Validation group vg-01: target synthetic:target-01; run identity run-01; passed; fresh; evidence synthetic:validation-01.
Validation group vg-02: target synthetic:target-02; run identity run-02; passed; fresh; evidence synthetic:validation-02.
Validation group vg-03: target synthetic:target-03; run identity run-03; passed; fresh; evidence synthetic:validation-03.
Validation group vg-04: target synthetic:target-04; run identity run-04; passed; fresh; evidence synthetic:validation-04.
Validation group vg-05: target synthetic:target-05; run identity run-05; passed; fresh; evidence synthetic:validation-05.
Validation group vg-06: target synthetic:target-06; run identity run-06; passed; fresh; evidence synthetic:validation-06.
Validation group vg-07: target synthetic:target-07; run identity run-07; passed; fresh; evidence synthetic:validation-07.
Validation group vg-08: target synthetic:target-08; run identity run-08; passed; fresh; evidence synthetic:validation-08.
Validation group vg-09: target synthetic:target-09; run identity run-09; passed; fresh; evidence synthetic:validation-09.
Validation group vg-10: target synthetic:target-10; run identity run-10; passed; fresh; evidence synthetic:validation-10.
Validation group vg-11: target synthetic:target-11; run identity run-11; passed; fresh; evidence synthetic:validation-11.
Validation group vg-12: target synthetic:target-12; run identity run-12; passed; fresh; evidence synthetic:validation-12.
Validation group vg-13: target synthetic:target-13; run identity run-13; passed; fresh; evidence synthetic:validation-13.
Validation group vg-14: target synthetic:target-14; run identity run-14; passed; fresh; evidence synthetic:validation-14.
Validation group vg-15: target synthetic:target-15; run identity run-15; passed; fresh; evidence synthetic:validation-15.

Validation failures: none represented.
Required next check: exact physical line and UTF-8 byte measurement of this complete file.
Required next check: deterministic enumeration counts for roles, validations, relationships, overlaps, blockers, gates, and authorization domains.
Size diagnostics cannot override semantic or validation failure.

## S09 — Cleanup And Context Budget

Cleanup by role: not needed because no runtime role exists.
Delivery-evidence impact: none.
Non-blocking cleanup basis: fixture has no task or runtime cleanup.
ContextBudget state: Normal.
Compression count: 0 / fixture-defined / high confidence.
Last check / reason / next boundary / action: 2026-07-15T13:00:00-07:00 / fixture construction / after measurement / verify only.

## S10 — First Next Action

First next action: verify embedded measurements and structural enumerations.
Dependencies: complete file content and deterministic corpus contract.
Expected evidence: wc -l -c output and structural validator result.
Stop if: a count mismatch or semantic/control error appears.

## S11 — Claim-Indexed Evidence Index

| Claim | Evidence location | Freshness | Leader verification |
| --- | --- | --- | --- |
| c-01 | Current synthetic control claim 1 | synthetic:claim-01 | fresh | structurally represented |
| c-02 | Current synthetic control claim 2 | synthetic:claim-02 | fresh | structurally represented |
| c-03 | Current synthetic control claim 3 | synthetic:claim-03 | fresh | structurally represented |
| c-04 | Current synthetic control claim 4 | synthetic:claim-04 | fresh | structurally represented |
| c-05 | Current synthetic control claim 5 | synthetic:claim-05 | fresh | structurally represented |
| c-06 | Current synthetic control claim 6 | synthetic:claim-06 | fresh | structurally represented |
| c-07 | Current synthetic control claim 7 | synthetic:claim-07 | fresh | structurally represented |
| c-08 | Current synthetic control claim 8 | synthetic:claim-08 | fresh | structurally represented |
| c-09 | Current synthetic control claim 9 | synthetic:claim-09 | fresh | structurally represented |
| c-10 | Current synthetic control claim 10 | synthetic:claim-10 | fresh | structurally represented |
| c-11 | Current synthetic control claim 11 | synthetic:claim-11 | fresh | structurally represented |
| c-12 | Current synthetic control claim 12 | synthetic:claim-12 | fresh | structurally represented |
| c-13 | Current synthetic control claim 13 | synthetic:claim-13 | fresh | structurally represented |
| c-14 | Current synthetic control claim 14 | synthetic:claim-14 | fresh | structurally represented |
| c-15 | Current synthetic control claim 15 | synthetic:claim-15 | fresh | structurally represented |
| c-16 | Current synthetic control claim 16 | synthetic:claim-16 | fresh | structurally represented |
| c-17 | Current synthetic control claim 17 | synthetic:claim-17 | fresh | structurally represented |
| c-18 | Current synthetic control claim 18 | synthetic:claim-18 | fresh | structurally represented |
| c-19 | Current synthetic control claim 19 | synthetic:claim-19 | fresh | structurally represented |
| c-20 | Current synthetic control claim 20 | synthetic:claim-20 | fresh | structurally represented |

## S12 — Historical Archive And Measurement

Archive-note location: examples/leader-state-profiles/archive-notes/ convention only.
Current archive-note pointer: none because this synthetic fixture has no history.
Not carried forward: none.
Physical lines: 261
UTF-8 bytes: 20209
Size warning state: line-warning
Standard diagnostics: target 80-160 lines; warn above 200 lines or 24576 bytes.
Expected warning: the physical-line threshold is exceeded; byte state follows the exact measurement.
Warning response: preserve all applicable facts; do not fail, truncate, infer approval, or create a degraded safety state.
Optional sections omitted: none applicable beyond live provider/runtime and historical detail, which are explicitly inapplicable.
