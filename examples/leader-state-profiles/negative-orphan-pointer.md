# Negative Fixture: Orphan Current Pointer

Fixture ID: FX-NEG-ORPHAN-POINTER
Expected result: fail
Expected reason: ERR-ORPHAN-POINTER
Scenario type: deterministic pointer negative; not observed repository damage.

## Profile Inventory

Leader state profile: hierarchical-required
Inventory scope: current-active-only
Active workstreams: 1
Blockers: 0
Live role lifecycles: 1
Validation-freshness groups: 1
Dependency/conflict edges: 0
Overlap edges: 0
High-risk gates: 0
Active authorization domains: 1
Bound authorization keys: 1
Authorization key: auth:owner:repository:validate:current-state:pending:restore-safe-projection
Projection assessment: projection-failed
Projection failure key: projection.orphaned-current-pointer

## Pointer Record

Pointer ID: current-validation-result
Pointer required for current action: yes
Pointer target: examples/leader-state-profiles/nonexistent-current-validation.md
Pointer target existence expectation: missing
Pointer freshness: fresh
Allowed freshness for current action: fresh

The repository path named by `Pointer target` intentionally does not exist.
The validator can test path existence directly. Reclassifying the state as
`hierarchical-required` records projection failure but does not repair the
orphan or convert this semantic failure to pass.
