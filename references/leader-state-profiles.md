# Progressive Leader State Profiles

This file extends `SKILL.md`. It cannot weaken `SKILL.md`, another required
reference, accepted OpenSpec requirements, project rules, or Owner
instructions, and it grants no authorization by itself. Read it before
selecting, refreshing, rendering, or transitioning a Leader active-state
profile.

The profiles control the size and review cost of the current active Leader
record. They do not cap durable evidence, authorize omission, or replace the
accepted rollover and handoff protocol.

## Canonical Values

Use these exact values in profile records and fixtures:

```text
Leader state profile: Compact | Standard | hierarchical-required
Inventory scope: current-active-only
Measurement source kind: direct-current-state | takeover-verification | transition-measurement | fixture-measurement
Measurement freshness: fresh | stale | unknown
Selection detail: light-attestation | full-counts
Size warning state: within-warning | line-warning | byte-warning | line-and-byte-warning
Projection assessment: reliable-single-file | projection-failed
Projection evidence kind: structural | reviewed-leader-judgment | not-applicable
Transition direction: retain | promote | demote
Checkpoint event: initial-creation | takeover | material-state-change | stage-boundary | rollover-refresh | handoff | successor-takeover | disputed-classification | transition-review | validation-fixture
```

Do not invent synonyms such as `large`, `oversize`, `degraded-oversize`, or
`hierarchical`. `hierarchical-required` is an interim classification, not a
completed Hierarchical storage design and not a rollover state.

## Current-Active-Only Inventory

Count only objects that can change or constrain the current action, current
gate, current role work, or first next action. Exclude resolved history,
superseded projections, durable role results, raw validation output, historical
archive notes, and durable audit evidence when a stable pointer preserves
access. Moving an object out of the count does not authorize deleting it.

Use these deterministic counting units:

- **Active workstream:** one independently actionable current goal or external
  workstream with its own completion condition. A workstream stays active while
  work, a blocker, an unresolved result, or a current gate remains.
- **Blocker:** one canonical unresolved condition preventing an action or gate.
  Duplicate projections of the same condition count once.
- **Live role lifecycle:** one PM, Advisor, Worker, Reviewer, or other required
  role lifecycle that is running, result-unknown, required for a current gate,
  or retained for same-stage continuity.
- **Validation-freshness group:** one validation claim that shares the same
  command or evidence source, target fingerprint, scope, and freshness. A
  materially different target, scope, source, or freshness is another group.
- **Dependency edge:** one tuple `(from-workstream, to-workstream,
  normalized-reason-key)`. Direction matters.
- **Conflict edge:** one tuple `(lower-sorted-workstream,
  higher-sorted-workstream, normalized-reason-key)`. Direction does not matter.
- **Overlap edge:** one tuple `(lower-sorted-workstream,
  higher-sorted-workstream, normalized-resource-key)`, where the resource is a
  shared file or named control surface on which independent edits cannot be
  assumed safe.
- **High-risk gate:** one current default-exclusion or other high-risk decision
  gate. Multiple artifacts governed by the same decision and authorization
  boundary count once; independently decidable gates count separately.
- **Authorization domain:** count only a domain whose authority is currently
  requested, pending, granted, denied, revoked, or expired for the current action,
  current gate, or first next action. Retain standing default exclusions that
  are not requested by any of those as scope or stop conditions, but do not
  count them. Deduplicate a counted domain by the tuple `(actor, normalized
  scope key, normalized action key, normalized target key, status,
  normalized expiry-or-revocation-condition key)`. A different tuple is a
  different domain, including a status or condition change. Do not merge
  independently decidable domains or omit a currently relevant domain merely
  to remain within Compact.

A current denial remains an active fail-closed control fact and counted domain
until the denied action, gate, or first next action is no longer current. An
unrequested standing default exclusion is retained but not counted.

An object spanning workstreams remains one object in its own dimension. Create
the applicable relationship edge for each affected workstream pair and each
distinct reason or resource key, then deduplicate identical tuples. Zero is
valid in every dimension except active workstreams when an active-state
instance is required.

### Normalized keys

Workstream IDs and named reason/control-surface keys are stable ASCII
lower-kebab identifiers. Normalize a newly introduced label by trimming it,
Unicode-normalizing it to NFKC, lowercasing it, replacing each run outside
`[a-z0-9]` with one hyphen, and trimming leading or trailing hyphens. Reuse the
first recorded key for the same semantic reason; a wording change does not
create a new edge. If two genuinely different meanings normalize to the same
key, append a stable qualifying suffix and record the distinction in the
evidence index. Do not merge distinct meanings merely to reduce counts.

Normalize a shared file to its repository-relative POSIX path after resolving
`.` and `..`; use the verified absolute POSIX path only for an allowed file
outside the repository. File keys are case-sensitive. Named control surfaces
use the stable key algorithm above. Sort unordered pair IDs lexicographically
before deduplication.

## Profile Selection

The structural ceilings below are provisional pilot baselines, but they are
mandatory classification checks:

| Current-active dimension | Compact maximum | Standard maximum |
| --- | ---: | ---: |
| Active workstreams | 2 | 5 |
| Blockers | 5 | 10 |
| Live role lifecycles | 8 | 15 |
| Validation-freshness groups | 8 | 15 |
| Dependency/conflict edges, combined | 10 | 30 |
| Overlap edges | 5 | 20 |
| High-risk gates | 2 | 3 |
| Authorization domains | 2 | 3 |

First assess single-file projection. Select `hierarchical-required` whenever
that projection fails, regardless of counts. With a reliable projection,
select `Compact` when every Compact ceiling is satisfied; select `Standard`
when any Compact ceiling is exceeded and every Standard ceiling is satisfied;
and select `hierarchical-required` when any Standard ceiling is exceeded.

Observable projection failures are conflicting canonical ownership,
unresolved duplicate current projections, a missing or orphaned current
pointer, or an active cross-workstream fact that cannot be represented once
with stable references. Record whether the failure was structurally observable
or required reviewed Leader judgment. Preserve all applicable current facts
and use the accepted qualitative rollover and handoff controls; do not force
the state into Compact or Standard or claim that large-project state is
bounded.

### Profile selection basis

Every selection or refresh records:

```text
Leader state profile:
Inventory scope: current-active-only
Measurement source:
Measurement source kind: direct-current-state | takeover-verification | transition-measurement | fixture-measurement
Measurement time: timezone-qualified timestamp
Measurement freshness: fresh | stale | unknown
Selection detail: light-attestation | full-counts
Profile selection basis:
Exceeded trigger keys: none | comma-separated normalized trigger keys
Projection assessment: reliable-single-file | projection-failed
Projection evidence kind: structural | reviewed-leader-judgment | not-applicable
```

Use stable trigger keys in the form `compact.<dimension>`,
`standard.<dimension>`, or `projection.<failure>`, with dimensions
`workstreams`, `blockers`, `role-lifecycles`, `validation-groups`,
`dependency-conflict-edges`, `overlap-edges`, `high-risk-gates`, and
`authorization-domains`. Projection failure keys are
`canonical-ownership-conflict`, `duplicate-current-projection`,
`missing-current-pointer`, `orphaned-current-pointer`, and
`unrepresentable-cross-workstream-fact`.

Ordinary new or freshly measured small work may use the light attestation
`all Compact triggers checked; none exceeded` and omit the eight-count
scorecard. Full deterministic counts are mandatory for takeover, disputed
classification, profile transition, and validation fixtures. Standard and
`hierarchical-required` records always name the exceeded triggers. A takeover
selects the measured profile directly; it never passes through Compact first,
and prior profile selection is evidence rather than inherited authority.

## Retention Floor And Canonical Ownership

The retention floor is the complete applicable accepted state-carrying field
set. It is not a new closed checklist. Resolve the applicable fields through
the accepted sources below:

| Field family | Canonical rule source |
| --- | --- |
| Owner instruction, scope, authorization, risk, git and default exclusions | `SKILL.md`; `references/git-exit-rules.md` |
| PM, Advisor, Worker, Reviewer, lifecycle, invocation identity, patience, cleanup, provider/model separation | `SKILL.md`; `references/cli-trust.md`; `references/role-templates-and-output.md`; `references/review-context-efficiency.md` |
| OpenSpec stage, archive, validation and gate freshness | `references/openspec-lifecycle.md` |
| Context budget, current-state card, handoff and successor facts | `references/context-rollover.md` |
| Project-specific state, changed/do-not-touch files, incidents, blockers, conflicts and next-action dependencies | Current project rules and accepted project specs |

Illustrative required facts include Owner decisions and instructions;
authorization grants, denials and revocations; unresolved P0/P1 and current
role findings; blockers and conflicts; required reasoning pointers; changed
and do-not-touch files; validation run, not run, failures and freshness;
incidents; running and result-unknown roles; next high-risk gates; provider and
model separation; lifecycle patience and cleanup; review-invocation identity;
PM/Advisor/Reviewer continuity; and required Reviewer approval. Preserve any
other applicable accepted field even when it is not listed here.

Compact and Standard each use one physical active-state instance with a current
projection, claim-indexed evidence index, and stable pointers to durable
evidence and archive notes. Compact uses its schema section and key as implicit
canonical ownership. Standard uses stable section IDs as canonical ownership.
Do not add per-fact fingerprints or source metadata when no derived copy
exists.

When a fact is copied into a derived summary, record the canonical source
identity and the copy freshness beside the derived copy. A stale, unknown,
missing, orphaned, or conflicting source cannot be repaired by relabeling it;
refresh it from the canonical source or fail closed. Full durable reasoning
stays at its stable evidence location while active state retains current
status, severity, and pointer. Compact may omit visibly empty inapplicable
sections, but absence is never approval and cannot omit a triggered field.

## Event-Driven Refresh And Transitions

Refresh selection when an event can make prior inventory or projection stale:

- initial creation or takeover verification;
- material scope, workstream, blocker, relationship, gate, authorization, role,
  or validation-freshness change;
- OpenSpec C-stage boundary or another required workflow stage boundary;
- rollover/current-state refresh, actual handoff, or successor takeover;
- a disputed classification, profile transition review, or validation fixture.

These are event-driven freshness checkpoints. Do not poll on a timer, mutate a
profile in the background, or infer a transition from document size.
Record the matching canonical `Checkpoint event` value, its evidence pointer,
and a timezone-qualified checkpoint time. Use `material-state-change` for any
listed material field change and `stage-boundary` for OpenSpec or other
required workflow boundaries.

Promote at the first freshness checkpoint where a higher structural or
projection trigger is freshly verified. Record the prior profile, new profile,
full counts, trigger keys, measurement evidence, and decision time.

Demotion requires all lower exit conditions at two consecutive freshness
checkpoints and then an explicit Leader decision. The checkpoints must be
caused by distinct qualifying events and each must have fresh measurements;
re-reading unchanged evidence does not create a second checkpoint.

| Demotion dimension | Standard to Compact maximum | hierarchical-required to Standard maximum |
| --- | ---: | ---: |
| Active workstreams | 1 | 4 |
| Blockers | 4 | 8 |
| Live role lifecycles | 6 | 12 |
| Validation-freshness groups | 6 | 12 |
| Dependency/conflict edges, combined | 8 | 24 |
| Overlap edges | 4 | 16 |
| High-risk gates | 1 | 2 |
| Authorization domains | 1 | 2 |

Demotion from `hierarchical-required` also requires no observable single-file
projection failure at both checkpoints. If any lower exit condition fails, the
consecutive-checkpoint sequence resets. One qualifying checkpoint retains the
current profile. Two qualifying checkpoints make demotion eligible but do not
perform it; only an explicit Leader decision records `Transition direction:
demote`. Line and byte measurements never control promotion or demotion.

## Three-Way Pilot Boundary

1. **Structural classification:** ceilings and exit bands select or retain a
   profile. Exceeding them alone never blocks work, truncates facts, creates a
   degraded safety state, or authorizes omission.
2. **Size diagnostics:** Compact targets 40–100 physical lines and warns above
   140 lines or 16 KiB. Standard targets 80–160 physical lines and warns above
   200 lines or 24 KiB. Count the complete rendered instance and UTF-8 bytes.
   These overlapping, provisional bands are warning-only and never select a
   profile or block non-emergency work.
3. **Semantic and control correctness:** a missing applicable field,
   conflicting canonical source, invalid or stale required pointer, invalid
   selection basis, lost authorization/validation/role continuity, or another
   semantic/control failure remains fail-closed from the start, regardless of
   size.

When applicable facts exceed a size warning, preserve them and emit the exact
warning state. Do not truncate, infer approval, suppress a gate, or create
`degraded-oversize`. Only a separately accepted calibration-exit change may
make a size threshold enforceable.
