# Leader State Profile Fixture Corpus

This directory is the deterministic fixture corpus for progressive Leader state
profiles. It is test evidence, not a live Leader record, authorization source,
or semantic proof.

## Corpus Contract

- `compact-feasibility.md` is the repo-grounded small rendered instance.
- `medium-standard.md` is the repo-grounded medium rendered instance.
- `standard-size-warning.md` is a synthetic, semantically valid Standard
  instance at the structural ceilings. Its complete physical size must trigger
  a warning without changing the expected pass result.
- `cases.tsv` is the canonical boundary and negative-case manifest. One row is
  one independently testable case; ordered transition rows share a
  `sequence_id`.
- `negative-*.md` fixtures expose the invalid structure used to derive each
  semantic/control failure: required-versus-present key sets, pointer freshness,
  target existence, canonical key/value records, or selection-basis method.
- `duplicate-edge-deduplication.md` exposes repeated reports and the unique
  normalized tuple expected after deduplication.
- `hierarchical-demotion-sequence.md` records two distinct recovered-projection
  checkpoints and the later explicit Leader demotion decision.

The rendered files exist only where physical measurement or omission of
inapplicable fields must be demonstrated. Boundary cases remain compact manifest
records so the fixture corpus does not reproduce the active-state bloat that the
profiles are designed to prevent.

## Provenance

Repo-grounded cases cite a repository path in `source`. Synthetic cases use a
stable `synthetic:*` source and must never be described as observed history.
Profile rules come from `references/leader-state-profiles.md` and the accepted
specifications under `openspec/specs/`.

The Owner reported that a prior Leader document grew beyond 4,000 lines. The
original document and fact inventory are not available in this repository.
`FX-LARGE-4001` is therefore a labeled synthetic classification stress case; it
is not a reconstruction, measurement, or factual description of that prior
document.

## Deterministic Columns

`cases.tsv` is UTF-8, tab-separated, has one header row, and uses no embedded
tabs or newlines. Counts use base-10 non-negative integers. The eight count
columns are always present in this order:

1. `workstreams`
2. `blockers`
3. `role_lifecycles`
4. `validation_groups`
5. `dependency_conflict_edges`
6. `overlap_edges`
7. `high_risk_gates`
8. `authorization_domains`

`authorization_domains` counts only domains currently requested, pending,
granted, denied, revoked, or expired for the current action, current gate, or
first next action. Standing default exclusions remain retained scope facts but
are not counted.

The appended 21st column, `authorization_keys`, binds that count without
changing the first 20 column indices. It is `none` if and only if
`authorization_domains` is zero. An explicit key uses
`auth:<actor>:<scope>:<action>:<target>:<status>:<condition>`, with normalized
lower-kebab components and a status of `requested`, `pending`, `granted`,
`denied`, `revoked`, or `expired`. A current denial is active state and counts;
an unrequested standing exclusion is retained scope but is not an authorization
domain and does not count. Comma separates distinct keys; duplicates are invalid.
A labeled synthetic cardinality case may use `gen:auth:N`, which expands to
`auth:synthetic-actor-01:synthetic-scope:synthetic-action-01:synthetic-target-01:pending:synthetic-condition-01`
through `N`. The size-warning fixture uses the stable enumeration anchor
`@standard-size-warning.md#authorization-and-gate-state`.

Every detailed or auxiliary fixture has exactly one classification count
source: its S01 count table or one plain `Active authorization domains: N`
field. Each fixture also has exactly one separate
`Bound authorization keys: N` field followed by exactly `N`
`Authorization key: auth:...` lines; zero uses `Bound authorization keys: 0`
and no key lines. A multi-step fixture applies this contract independently to
each step. Parsers must not consume the binding field as a second
classification count. A negative missing-field fixture can bind its active
authorization inventory while still omitting the distinct required semantic
field named by its required-versus-present contract.

Normalized keys are lower-kebab ASCII and carry a relationship type.
Dependencies use `dep:from>to:reason`; conflicts use
`conflict:left+right:reason`; overlaps use
`overlap:left+right:reason-or-resource`. Conflict and overlap pairs are
lexicographically sorted. Comma separates distinct keys; `none` means an empty
set. Duplicate normalized tuples count once. Stable typed anchors use
`dep:@relative-file#heading` or `overlap:@relative-file#heading` when the
complete enumeration is owned by that rendered fixture section. A synthetic
cardinality-only case may use
`gen:dep:N` or `gen:overlap:N`; these expand deterministically to
`dep:ws-1>ws-2:stress-dep-01` through `N` and
`overlap:ws-1+ws-2:stress/shared-01.md` through `N`, respectively. The
expanded keys, not the generator label, are the counted tuples.

Expected result is `pass`, `fail`, or `pass-with-warning`. Expected profile is
the profile selected after applying transition history; an eligible demotion
still retains the higher profile until an explicit Leader decision. Stable
reason codes are:

- `OK-CLASSIFIED`
- `OK-PROMOTED`
- `OK-RETAIN-HYSTERESIS`
- `OK-DEMOTION-ELIGIBLE`
- `OK-DEMOTED-BY-DECISION`
- `WARN-LINES-NONBLOCKING`
- `ERR-MISSING-APPLICABLE-FIELD`
- `ERR-STALE-POINTER`
- `ERR-ORPHAN-POINTER`
- `ERR-CONFLICTING-CANONICAL-SOURCE`
- `ERR-INVALID-SELECTION-BASIS`

Size warnings never convert a structurally and semantically valid case to
failure. Semantic/control errors fail closed even when the file is below every
size warning threshold.

Negative fixtures intentionally contain invalid control state. Their
`Expected reason` field is an assertion to compare after evaluation, not the
input used to decide failure. Validators derive the result from the structured
records described above. The orphan-pointer target is intentionally absent and
must remain absent.

Transition sequences are evaluated in `step` order. Both Standard-to-Compact
and `hierarchical-required`-to-Standard demotion retain the higher profile at
checkpoint 1, become eligible without mutation at checkpoint 2, and demote only
after the explicit Leader decision. Hierarchical demotion additionally requires
reliable single-file projection with no observable projection failure at both
checkpoints.

## Successor Expectations

`FX-SUCCESSOR-OPPORTUNITY` requires only the lightweight Opportunity skeleton
after refreshing canonical active state and evidence. It transfers no authority
and does not request a handoff. `FX-SUCCESSOR-COMPLETE` requires the complete
packet at Recommended, Strongly Recommended, Required, actual handoff, or an
explicit Owner handoff request. A successor must freshly verify profile,
authority, git/OpenSpec state, validation, roles, findings, Worker state, and the
dependencies of the first next action.

## Measurement

Measurements cover the complete rendered file and are recorded inside each
rendered fixture. Recompute them with:

```sh
wc -l -c examples/leader-state-profiles/compact-feasibility.md \
  examples/leader-state-profiles/medium-standard.md \
  examples/leader-state-profiles/standard-size-warning.md
```

Physical lines use newline-delimited `wc -l` results. Bytes are UTF-8 bytes.
Changing a rendered fixture requires updating its embedded values and rerunning
the structural validator. Validator success proves fixture structure and exact
measurements only; it does not prove facts, authorization, role execution,
pointer semantics, or safe successor action.
