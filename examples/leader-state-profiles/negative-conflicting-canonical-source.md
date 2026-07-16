# Negative Fixture: Conflicting Canonical Source

Fixture ID: FX-NEG-CONFLICT-SOURCE
Expected result: fail
Expected reason: ERR-CONFLICTING-CANONICAL-SOURCE
Scenario type: deterministic ownership negative; not live authorization.

## Profile Inventory

Leader state profile: hierarchical-required
Inventory scope: current-active-only
Active workstreams: 2
Blockers: 1
Live role lifecycles: 2
Validation-freshness groups: 1
Dependency/conflict edges: 1
Overlap edges: 1
High-risk gates: 1
Active authorization domains: 2
Bound authorization keys: 2
Authorization key: auth:owner:repository:commit:main:revoked:current-scope-change
Authorization key: auth:owner:repository:commit:main:granted:fresh-gate-review
Projection assessment: projection-failed
Projection failure key: projection.canonical-ownership-conflict

## Canonical Records

Canonical record: key=authorization.commit; value=revoked; source=S06/auth-commit; freshness=fresh
Canonical record: key=authorization.commit; value=granted; source=S03/ws-b-gate; freshness=fresh
Expected canonical values per key: exactly-one-current-value

Both records claim current canonical ownership of the same normalized key and
carry incompatible values. The validator can group `Canonical record` entries
by key and detect multiple distinct current values; the expected reason label
is not used to derive the conflict.
