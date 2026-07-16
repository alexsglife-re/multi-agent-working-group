# Repo-Grounded Medium Standard Fixture

Fixture ID: `FX-MEDIUM-REPO`
Expected result: `pass`
Expected reason: `OK-CLASSIFIED`
Scenario type: deterministic repository fixture; not a live authorization record.
Schema required keys: profile-selection,owner-goal-scope,active-state,workstreams-relationships,findings-blockers,files,authorization-state,role-continuity,validation-freshness,cleanup-context,next-action-stops,evidence-index,archive-capability,measurement
Present keys: profile-selection,owner-goal-scope,active-state,workstreams-relationships,findings-blockers,files,authorization-state,role-continuity,validation-freshness,cleanup-context,next-action-stops,evidence-index,archive-capability,measurement

## S01 — Profile Selection

Leader state profile: Standard
Inventory scope: current-active-only
Measurement source: `examples/medium-worker-task.md`
Measurement source kind: fixture-measurement
Measurement time: 2026-07-15T12:30:00-07:00
Measurement freshness: fresh
Selection detail: full-counts
Profile selection basis: deterministic current-active inventory exceeds Compact workstreams and satisfies every Standard ceiling.
Exceeded trigger keys: compact.workstreams
Projection assessment: reliable-single-file
Projection evidence kind: not-applicable
Checkpoint event: validation-fixture
Checkpoint evidence/time: `examples/medium-worker-task.md`; 2026-07-15T12:30:00-07:00

| Dimension | Count | Compact max | Standard max |
| --- | ---: | ---: | ---: |
| Active workstreams | 3 | 2 | 5 |
| Blockers | 0 | 5 | 10 |
| Live role lifecycles | 3 | 8 | 15 |
| Validation-freshness groups | 3 | 8 | 15 |
| Dependency/conflict edges | 4 | 10 | 30 |
| Overlap edges | 1 | 5 | 20 |
| High-risk gates | 0 | 2 | 3 |
| Active authorization domains | 0 | 2 | 3 |

## S02 — Owner, Goal, Stage, And Scope

Owner instruction: add medium-task guidance so future agents know when Leader delegates to Worker.
Owner decisions needed: none for this fixture; git publication remains outside the source task.
Global goal: add one reusable medium documentation-task example.
Stage / archive requirement: verify / not applicable in the source scenario.
Scope: `examples/medium-worker-task.md` only.
Non-goals: no `SKILL.md`, README, roadmap, validation, permission, security, release, or publication change.
Risk / mode: medium / multi-agent workflow.
Current status: bounded Worker return is ready for Leader verification.
Global next action: verify the returned file against the PM/Advisor consensus baseline.

## S03 — Active Workstreams And Relationships

| ID | Goal / completion condition | Status | Next action |
| --- | --- | --- | --- |
| ws-plan | Establish accepted scope and stop conditions | current | Keep consensus baseline available |
| ws-write | Produce the bounded example file | returned-unconsumed | Leader inspects Worker return |
| ws-verify | Verify scope, role boundaries, and no git authorization | pending | Run VG-1 through VG-3 |

Dependency edge: `dep:ws-plan>ws-write:approved-scope`
Dependency edge: `dep:ws-write>ws-verify:worker-return`
Dependency edge: `dep:ws-plan>ws-verify:consensus-baseline`
Conflict edge: `conflict:ws-plan+ws-write:scope-wording-conflict`
Overlap edge: `overlap:ws-write+ws-verify:examples/medium-worker-task.md`
Cross-workstream ownership: S03 owns relationship state; source wording remains at the provenance pointer.

## S04 — Findings, Blockers, And Stops

Canonical blockers: none verified.
Unresolved P0 / P1: none verified in the deterministic source scenario.
Current P2: none recorded.
Incidents / emergency stops: none verified.
Stop: any edit outside `examples/medium-worker-task.md`.
Stop: wording implies commit, push, release, deployment, or publication authorization.
Stop: wording makes Reviewer universal for small or medium documentation work.
Next high-risk gates: none; a later git action would require its independent accepted gate.

## S05 — Files And Ownership

Changed file: `examples/medium-worker-task.md`, owned by `ws-write` until consumed.
Do not touch: `SKILL.md`, README, roadmap, validation documentation, other examples, release metadata, and git history.
Canonical source identity: `examples/medium-worker-task.md` sections Scenario through Worker Return.
Derived copy: this fixture summarizes current role and scope facts from the canonical source.
Copy freshness: fresh at 2026-07-15T12:30:00-07:00 for this deterministic fixture.
Conflicting or duplicate ownership: none verified.

## S06 — Authorization And Gate State

Bound authorization keys: 0
The current action and first next action are local verification, and no current gate is active.
Standing default exclusion `auth-commit`: commit not granted and not counted.
Standing default exclusion `auth-push`: push not granted and not counted.
Other default exclusions: release, publication, deployment, security, permission, schema, and destructive actions remain unauthorized.
Historical gate evidence: none.
Successor inheritance: prohibited; a successor freshly verifies every domain.

## S07 — Role And Review Continuity

PM `pm-source`: current lifecycle; accepted scope and criteria; result at `examples/medium-worker-task.md#pm-first-pass`.
Advisor `advisor-source`: current lifecycle; challenged risk and stop conditions; result at `examples/medium-worker-task.md#advisor-first-pass`.
Worker `worker-source`: returned-unconsumed; bounded file drafted; result at `examples/medium-worker-task.md#worker-return`.
Reviewer: inapplicable because the source task is medium documentation only and no stricter gate is active; omission is not approval.
Provider/model separation: source example specifies independent PM and Advisor passes but no provider identities; no provider claim is inferred.
Review invocation identity: source-example sections are deterministic provenance, not runtime review evidence.
Required Reviewer approval: not applicable to this source scenario; must be reassessed if scope changes.
Lifecycle patience: no process is running or result-unknown; Worker return must be consumed before retry.

## S08 — Validation Freshness

Validation group `vg-scope`: target current file; not run; stale until Leader verifies intended-file-only scope.
Validation group `vg-boundaries`: target current wording; not run; stale until role and authorization wording is checked.
Validation group `vg-diff`: target repository state; not run; stale until git status and diff are inspected.
Validation failures: none observed because checks have not run; absence is not success.
Required next checks: re-read file, inspect intended-file-only diff, and verify no authorization inference.
Size diagnostics cannot override semantic or validation failure.

## S09 — Cleanup And Context Budget

Cleanup by role: not needed for source-example identities; they are not live runtimes.
Delivery-evidence impact: none.
ContextBudget state: Normal.
Compression count: 0 / fixture-defined / high confidence.
Last check / action: 2026-07-15T12:30:00-07:00 / no rollover action.

## S10 — First Next Action

First next action: Leader verifies the returned example against the consensus baseline.
Dependencies: fresh `vg-scope`, `vg-boundaries`, and `vg-diff` evidence.
Expected evidence: bounded diff and recorded verification result.
Stop if: scope expands, validation fails, or an unresolved P0/P1 appears.

## S11 — Claim-Indexed Evidence Index

| Claim | Evidence | Freshness | Leader verification |
| --- | --- | --- | --- |
| Profile counts and classification | this fixture S01 and `references/leader-state-profiles.md` | current fixture baseline | structurally reviewable |
| Medium-task scope | `examples/medium-worker-task.md#scenario` | current fixture source | verified by direct projection |
| PM and Advisor findings | source PM and Advisor sections | current fixture source | evidence only, not authority |
| Worker return | source Worker Return section | current fixture source | returned-unconsumed |
| Git actions remain unauthorized | source Classification and Commit Or Push Gate | current fixture source | verified by direct projection |

## S12 — Historical Archive And Measurement

Archive-note location: `examples/leader-state-profiles/archive-notes/` convention only.
Current archive-note pointer: none because this deterministic fixture has no history.
Not carried forward: full role reasoning already available at the stable source pointer.
Physical lines: 149
UTF-8 bytes: 8808
Size warning state: within-warning
Standard diagnostics: target 80-160 lines; warn above 200 lines or 24576 bytes.
Warning response: preserve applicable facts; warning is non-blocking.
Optional sections omitted: detailed Reviewer runtime fields, CLI trust, cleanup failure detail, and successor packet because their triggers are inapplicable.
