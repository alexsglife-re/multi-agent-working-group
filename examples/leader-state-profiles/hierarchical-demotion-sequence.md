# Fixture: Hierarchical-Required To Standard Hysteresis

Sequence ID: seq-hierarchical-demote
Expected result: pass for all three ordered steps
Scenario type: deterministic transition fixture; no background mutation.

The prior profile is `hierarchical-required`. Its prior projection failure has
been repaired before checkpoint 1. Each checkpoint is caused by a distinct
event and uses a fresh current-active-only measurement. Counts are at or below
the accepted exit bands of 4 workstreams, 8 blockers, 12 live role lifecycles,
12 validation groups, 24 dependency/conflict edges, 16 overlap edges, 2
high-risk gates, and 2 authorization domains.

## Step 1 — First Qualifying Checkpoint

Fixture ID: FX-HIER-DEMOTE-CP1
Step: 1
Checkpoint event: stage-boundary
Checkpoint evidence: synthetic:c2-to-c3-boundary
Measurement freshness: fresh
Projection assessment: reliable-single-file
Projection recovery: verified
Observable projection failures: none
Active workstreams: 4
Blockers: 8
Live role lifecycles: 12
Validation-freshness groups: 12
Dependency/conflict edges: 24
Overlap edges: 16
High-risk gates: 2
Active authorization domains: 2
Bound authorization keys: 2
Authorization key: auth:fixture-owner:fixture:verify:projection-recovery:pending:checkpoint-validation
Authorization key: auth:leader:fixture:demote:leader-state-profile:pending:two-checkpoint-evidence
Prior profile: hierarchical-required
Expected profile: hierarchical-required
Transition direction: retain
Expected reason: OK-RETAIN-HYSTERESIS

One qualifying checkpoint cannot demote the profile.

## Step 2 — Second Distinct Qualifying Checkpoint

Fixture ID: FX-HIER-DEMOTE-CP2
Step: 2
Checkpoint event: rollover-refresh
Checkpoint evidence: synthetic:fresh-rollover-refresh
Measurement freshness: fresh
Projection assessment: reliable-single-file
Projection recovery: verified
Observable projection failures: none
Active workstreams: 3
Blockers: 7
Live role lifecycles: 10
Validation-freshness groups: 10
Dependency/conflict edges: 20
Overlap edges: 12
High-risk gates: 2
Active authorization domains: 2
Bound authorization keys: 2
Authorization key: auth:fixture-owner:fixture:verify:projection-recovery:pending:checkpoint-validation
Authorization key: auth:leader:fixture:demote:leader-state-profile:pending:explicit-leader-decision
Prior profile: hierarchical-required
Expected profile: hierarchical-required
Transition direction: retain
Demotion eligibility: eligible
Expected reason: OK-DEMOTION-ELIGIBLE

Two qualifying checkpoints make demotion eligible but do not mutate the
profile automatically.

## Step 3 — Explicit Leader Decision

Fixture ID: FX-HIER-DEMOTE-DECISION
Step: 3
Decision evidence: synthetic:explicit-leader-transition-decision
Decision actor: Leader
Decision freshness: fresh
Projection assessment: reliable-single-file
Projection recovery: verified
Observable projection failures: none
Active workstreams: 3
Blockers: 7
Live role lifecycles: 10
Validation-freshness groups: 10
Dependency/conflict edges: 20
Overlap edges: 12
High-risk gates: 2
Active authorization domains: 2
Bound authorization keys: 2
Authorization key: auth:fixture-owner:fixture:verify:projection-recovery:granted:checkpoint-validation
Authorization key: auth:leader:fixture:demote:leader-state-profile:granted:explicit-leader-decision
Prior profile: hierarchical-required
Expected profile: Standard
Transition direction: demote
Demotion eligibility: eligible
Expected reason: OK-DEMOTED-BY-DECISION

Only this explicit decision records the transition to Standard. Size
measurements do not participate in any step.
