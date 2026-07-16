# Negative Fixture: Invalid Selection Basis

Fixture ID: FX-NEG-SELECTION-BASIS
Expected result: fail
Expected reason: ERR-INVALID-SELECTION-BASIS
Scenario type: deterministic selection negative; not a live Leader decision.

## Claimed Selection

Leader state profile: Compact
Inventory scope: current-active-only
Measurement source: this file's physical line count
Measurement source kind: fixture-measurement
Measurement freshness: fresh
Selection detail: full-counts
Selection basis method: line-count-only
Structural inventory used for selection: no
Profile selection basis: file is short enough for Compact
Projection assessment: reliable-single-file

## Informational Counts Not Used By The Claim

Active workstreams: 1
Blockers: 0
Live role lifecycles: 0
Validation-freshness groups: 1
Dependency/conflict edges: 0
Overlap edges: 0
High-risk gates: 0
Active authorization domains: 1
Bound authorization keys: 1
Authorization key: auth:fixture-owner:fixture:classify:leader-state-profile:pending:full-structural-measurement

Line and byte measurements never select a profile. The validator can derive
the failure from `Selection basis method: line-count-only` and
`Structural inventory used for selection: no`, regardless of whether the informational
counts would otherwise fit Compact.
