# Compact Leader State Feasibility Fixture

Fixture identity:
  Fixture ID: FX-SMALL-REPO
  Expected result: pass
  Expected reason: OK-CLASSIFIED
  Purpose: prove that the complete applicable small-task retention floor can render as Compact.
  Scenario type: deterministic repository fixture; not a live authorization record.
  Schema required keys: profile-selection,owner-goal-scope,active-state,files,authorization-state,role-continuity,validation-freshness,cleanup-context,next-action-stops,evidence-index,archive-capability,measurement
  Present keys: profile-selection,owner-goal-scope,active-state,files,authorization-state,role-continuity,validation-freshness,cleanup-context,next-action-stops,evidence-index,archive-capability,measurement

Provenance:
  Scenario source: examples/small-doc-task.md
  Profile rules: openspec/changes/add-progressive-leader-state-profiles/specs/leader-state-compaction/spec.md
  Rendering rules: openspec/changes/add-progressive-leader-state-profiles/specs/copyable-role-templates/spec.md
  Rollover rules: openspec/changes/add-progressive-leader-state-profiles/specs/leader-rollover-protocol/spec.md
  Source status: current local OpenSpec C2 inputs.
  Source freshness: verified for this fixture at 2026-07-15T12:00:00-07:00.

Profile selection:
  Leader state profile: Compact
  Inventory scope: current-active-only
  Measurement source: the Scenario, Classification, and Minimal Startup Packet in examples/small-doc-task.md.
  Measurement source kind: fixture-measurement
  Measurement time: 2026-07-15T12:00:00-07:00.
  Measurement freshness: fresh
  Selection detail: full-counts
  Profile selection basis: all Compact triggers checked; none exceeded.
  Exceeded trigger keys: none
  Projection assessment: reliable-single-file
  Projection evidence kind: not-applicable
  Checkpoint event: validation-fixture
  Checkpoint evidence/time: examples/small-doc-task.md; 2026-07-15T12:00:00-07:00.
  Structural thresholds: provisional pilot baselines; classification-only and non-blocking.
  Active workstreams: 1
  Blockers: 0
  Live role lifecycles: 0
  Validation-freshness groups: 1
  Dependency/conflict edges: 0
  Overlap edges: 0
  High-risk gates: 0
  Active authorization domains: 0
  Expected classification: Compact

Current-state projection:
  Owner instruction: add a short README section explaining what this repository is for.
  Goal: produce one concise repository-purpose section.
  Active workstream: WS-1 README purpose documentation.
  Current stage: execute.
  Risk: small low-risk.
  Mode: Small Task Mode.
  Spec workflow: not required for the source scenario.
  Scope allowed: README documentation only.
  Scope forbidden: behavior, permissions, security, integrations, release state, and external publication.
  Current status: edit not started in this fixture.
  Blockers: none verified.
  Unresolved P0: none verified.
  Unresolved P1: none verified.
  P2: none recorded.

Files and ownership:
  Allowed changed file: README.md.
  Changed files: none; fixture represents pre-edit active state.
  Do-not-touch: SKILL.md, references/, templates/, scripts/, openspec/, release metadata, and git history.
  Canonical current-state owner: this fixture section and key structure.
  Derived current facts: none; no per-fact fingerprint is required.

Authorization and gates:
  Bound authorization keys: 0
  Current-active authorization domains counted: none; standing default exclusions are retained but not counted.
  Commit authorization: not granted.
  Push authorization: not granted.
  Other authorization domains: not applicable to current active scope; omission is not approval.
  Gate decision inheritance: prohibited.

Role continuity and review:
  PM lifecycle: not required by Small Task Mode; no approval inferred.
  Advisor lifecycle: not required before the local edit; no git gate has been entered.
  Worker lifecycle: not required; Leader direct execution is allowed for this narrow task.
  Reviewer lifecycle: not required by the source scenario; no approval inferred.
  Provider/model separation: not applicable because no PM/Advisor pair is active.
  Review-invocation identity: not applicable because no role review is triggered.
  Lifecycle patience: no role process is running or result-unknown.

Validation state:
  Validation group VG-1: post-edit README scope and safety checks.
  Validation status: not run because the fixture is pre-edit.
  Validation freshness: stale; must be run after the edit.
  Required checks: re-read the changed section.
  Required checks: verify git status and intended-file-only diff.
  Required checks: verify no secret, credential, private path, or behavior-changing instruction was added.
  Required checks: verify the task remained eligible for Small Task Mode.
  Validation failure behavior: fail closed and stop; size status cannot override it.

Cleanup and context:
  Cleanup state: no role or packet cleanup is applicable; no cleanup approval inferred.
  Cleanup-impact state: none for this fixture.
  ContextBudget state: Normal.
  Compression count value/source/confidence: 0 / fixture-defined / high.
  Successor material: not triggered; absence does not transfer authority or freshness.

Next action and stop conditions:
  First next action: edit only README.md with the concise purpose section.
  Next validation: run every VG-1 check after editing.
  Completion evidence: report the changed file and checks actually performed.
  Stop: requested content requires behavior or policy changes.
  Stop: any file outside README.md must change.
  Stop: commit, push, archive, release, publication, or deployment is requested without a fresh gate.
  Stop: validation fails or an unresolved P0/P1 appears.
  Stop: security, permission, credential, schema, or external-effect scope appears.

Claim-indexed evidence index:
  C-01 profile thresholds and retention floor: leader-state-compaction/spec.md; current.
  C-02 reduced Compact rendering requirements: copyable-role-templates/spec.md; current.
  C-03 source task scope and gate state: examples/small-doc-task.md; current for fixture.
  C-04 successor non-inheritance rule: leader-rollover-protocol/spec.md; current.
  C-05 measurement result: this file; fresh after the recorded wc checks.
  Pointer rule: each relative filename above resolves from the repository root or the change specs directory named in Provenance.

Historical archive-note capability:
  Archive note directory convention: examples/leader-state-profiles/archive-notes/.
  Current archive-note pointer: none; no history exists for this deterministic fixture.
  Archive-note absence: not approval, deletion permission, or evidence that history was reviewed.

Rendering and warning assertion:
  Physical lines: 132
  UTF-8 bytes: 7191
  Compact provisional target: 40-100 physical lines.
  Compact warning thresholds: 140 physical lines or 16384 UTF-8 bytes.
  Size warning state: within-warning; the instance is below both warning thresholds.
  Warning semantics: non-blocking; applicable facts must never be truncated to satisfy size.
  Optional sections omitted: only untriggered detail; omission never means approval or successful validation.
