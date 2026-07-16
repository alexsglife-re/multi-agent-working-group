# Negative Fixture: Stale Required Pointer

Fixture ID: FX-NEG-STALE-POINTER
Expected result: fail
Expected reason: ERR-STALE-POINTER
Scenario type: deterministic pointer negative; not runtime role evidence.

## Profile Inventory

Leader state profile: Compact
Inventory scope: current-active-only
Active workstreams: 1
Blockers: 0
Live role lifecycles: 2
Validation-freshness groups: 1
Dependency/conflict edges: 0
Overlap edges: 0
High-risk gates: 1
Active authorization domains: 1
Bound authorization keys: 1
Authorization key: auth:owner:repository:commit:main:pending:fresh-advisor-review
Projection assessment: reliable-single-file

## Pointer Record

Pointer ID: advisor-current-finding
Pointer required for current action: yes
Pointer target: examples/medium-worker-task.md#advisor-first-pass
Pointer target existence expectation: exists
Pointer freshness: stale
Current target fingerprint match: no
Allowed freshness for current action: fresh

The target path exists, but its recorded evidence predates the current target.
The validator can compare `Pointer freshness` with `Allowed freshness`; a stale
required pointer fails closed independently of profile size.
