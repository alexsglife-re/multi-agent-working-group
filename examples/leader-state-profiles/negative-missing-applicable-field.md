# Negative Fixture: Missing Applicable Field

Fixture ID: FX-NEG-MISSING-FIELD
Expected result: fail
Expected reason: ERR-MISSING-APPLICABLE-FIELD
Scenario type: deterministic structural negative; not a live authorization record.

## Profile Inventory

Leader state profile: Compact
Inventory scope: current-active-only
Active workstreams: 1
Blockers: 0
Live role lifecycles: 1
Validation-freshness groups: 1
Dependency/conflict edges: 0
Overlap edges: 0
High-risk gates: 1
Active authorization domains: 1
Bound authorization keys: 1
Authorization key: auth:owner:repository:commit:main:revoked:current-scope-change
Projection assessment: reliable-single-file

## Applicable-Field Contract

Schema required keys: owner-instruction,authorization-revocation,validation-freshness
Present keys: owner-instruction,validation-freshness
Intentionally absent key: authorization-revocation

Field owner-instruction: evaluate a revoked commit domain before any gate action.
Field validation-freshness: fresh for this fixture definition.

The absent `authorization-revocation` key is applicable because the one active
authorization domain is revoked. The validator can derive the failure by set
difference between `Schema required keys` and `Present keys`; the expected
reason label is not the proof.
