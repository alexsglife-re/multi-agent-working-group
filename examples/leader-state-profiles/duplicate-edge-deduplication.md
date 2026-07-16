# Fixture: Duplicate Edge Deduplication

Fixture ID: FX-EDGE-DEDUP
Expected result: pass
Expected reason: OK-CLASSIFIED
Scenario type: deterministic normalization fixture.

## Profile Inventory

Leader state profile: Compact
Inventory scope: current-active-only
Active workstreams: 2
Blockers: 0
Live role lifecycles: 0
Validation-freshness groups: 1
Dependency/conflict edges: 1
Overlap edges: 0
High-risk gates: 0
Active authorization domains: 1
Bound authorization keys: 1
Authorization key: auth:fixture-owner:fixture:verify:edge-deduplication:pending:structural-validation
Projection assessment: reliable-single-file

## Reported Edge Tuples

Edge report: type=dependency; from=ws-a; to=ws-b; normalized-key=build-before-test
Edge report: type=dependency; from=ws-a; to=ws-b; normalized-key=build-before-test
Edge report: type=dependency; from=ws-a; to=ws-b; normalized-key=build-before-test

Reported edge rows: 3
Expected unique normalized tuples: 1
Expected unique tuple: dep:ws-a>ws-b:build-before-test
Deduplication key fields: type,from,to,normalized-key

All three reports normalize to the same ordered tuple. They count once, so the
classification remains Compact; duplicate observation does not inflate the
dependency/conflict dimension.
