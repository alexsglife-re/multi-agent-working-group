## Context

The accepted workflow already requires a layered Leader record: a current-state card, a claim-indexed evidence index, and historical archive notes. It also requires complete gate, role, validation, authorization, cleanup, and review-invocation state to survive compaction. Current copyable handoff sources are 244 and 261 lines before project-specific content, while the Owner reports that a prior Leader document exceeded 4,000 lines before manual reduction to roughly 50 lines.

Neither a universal 50-line cap nor a universal 300-line cap is safe. The smaller cap can force omission of legitimate control facts; the larger cap adds unnecessary structure to small work and still does not solve dense large-project coordination. This design introduces two in-file profiles with provisional, non-blocking classification thresholds and warning-only size measurements, and explicitly defers evidence-backed Hierarchical sharding.

The current local validator is intentionally read-only, marker-based, and non-semantic. Profile validation must preserve that boundary.

The Owner explicitly authorized `v1.0.0 — Progressive Leader State Profiles` as the development target. Throughout feature implementation and archive, `v0.4.18` remains the current public version. Converting v1.0.0 from development to public status, creating its tag or GitHub Release, and publishing release content require later independent gates.

## Goals / Non-Goals

**Goals:**

- Keep small work lightweight while giving medium work a predictable single-file structure.
- Preserve the complete applicable accepted retention floor regardless of size.
- Make profile selection reviewable without forcing an eight-dimension scorecard on ordinary small work.
- Detect when Standard is insufficient without pretending the first change solves large-project sharding.
- Replace repeated history copying with stable evidence pointers and refresh-in-place projections.
- Provide warning-only measurements and fixtures that can support later calibration.
- Keep development-target and public-release status truthful across README, changelog, roadmap, TODO, validation documentation, and validator markers.

**Non-Goals:**

- Designing or implementing Hierarchical root/card/shard storage.
- Making numerical thresholds enforceable gates.
- Adding timers, background compaction, automatic mutation, or destructive cleanup.
- Proving factual truth, authorization validity, or runtime lifecycle compliance in shell validation.
- Rewriting existing review, cleanup, provider-separation, or rollover requirements to make templates shorter.
- Treating the development-target declaration as tag, GitHub Release, publication, or deployment authorization.

## Decisions

### 1. Use structural profiles instead of a universal line cap

Structural active-state inventory selects the profile. Line and UTF-8 byte bands are diagnostic warnings only and deliberately overlap; they never select a profile.

Compact applies when current active state has at most two workstreams, five blockers, eight live role lifecycles, eight validation-freshness groups, ten dependency/conflict edges, five overlap edges, two high-risk gates, and two authorization domains. Its provisional target is 40–100 physical lines, with warnings at 140 lines or 16 KiB.

Standard applies after any Compact structural trigger is exceeded, provided current active state remains within five workstreams, ten blockers, fifteen live role lifecycles, fifteen validation-freshness groups, thirty dependency/conflict edges, twenty overlap edges, three high-risk gates, three authorization domains, and reliable single-file semantic projection. Its provisional target is 80–160 physical lines, with warnings at 200 lines or 24 KiB.

If any Standard structural trigger is exceeded or a reliable single-file projection cannot be maintained, the state becomes `hierarchical-required`. Observable projection failures are conflicting canonical ownership, unresolved duplicate current projections, missing or orphaned current pointers, or active cross-workstream facts that cannot be represented once with stable references. Fixtures can test these observable failures; whether an unusual active fact is semantically representable remains a documented Leader judgment subject to PM/Advisor review, not a shell-validator claim. Existing qualitative safe rollover and handoff rules continue to apply. This state is an honest detection result, not a claim that large-project active state is already bounded.

The structural ceilings are provisional but mandatory classification thresholds during the pilot: exceeding one changes the selected profile. Exceeding a structural threshold cannot by itself block work, truncate facts, or create a degraded safety state. Line and byte bands are warning-only diagnostics and never select a profile. Semantic and control failures remain fail-closed.

The Compact ceilings are pilot hypotheses for keeping the ordinary path within one small coordination surface: no more than two workstreams, five shared-file/control-surface overlap edges, low double-digit dependency/conflict edges, and no more than two concurrent high-risk or authorization control domains. Standard roughly doubles or triples that active coordination capacity while remaining one file. The purpose is to detect rising coordination cost early, not to assert empirically calibrated limits; fixture measurements and pilot observations must test false promotion and information-loss risk before any later enforcement proposal.

Alternative considered: fixed 300-line maximum. Rejected because it is insensitive to active complexity and can be both excessive for small work and insufficient for dense coordination.

### 2. Count current active control state only

Profile counts exclude indexed historical records, durable role results, raw validation output, and durable audit evidence. Those records remain uncapped at their stable locations. The active record carries only the current projection and pointers required for control and reconstruction.

Counting units will be deterministic:

- An active workstream is an unresolved, independently actionable scope with a current next action or blocker.
- A blocker is one canonical unresolved condition; duplicate projections count once.
- A live role lifecycle is one current PM, Advisor, Reviewer, Worker, or other governed role lifecycle, not every runtime process or historical attempt.
- A validation-freshness group is a set of checks sharing one target, run identity, and freshness state; unrelated targets cannot be merged merely to reduce a count.
- A dependency edge is one tuple of an ordered pair of active workstreams and one normalized dependency reason. A conflict edge is one tuple of an unordered pair of active workstreams and one normalized conflict reason. Duplicate reports of the same tuple count once; distinct normalized reasons count separately.
- An overlap edge is one tuple of an unordered pair of active workstreams and either one normalized shared-file path or one named shared control surface where independent edits cannot be assumed safe. The same workstream pair sharing multiple normalized files or control surfaces produces multiple edges; duplicate reports of the same tuple count once.
- A high-risk gate is one currently pending gate classified high-risk by existing workflow rules.
- An authorization domain is one authority boundary currently requested,
  pending, granted, denied, revoked, or expired for the current action, current gate,
  or first next action. Deduplicate it by `(actor, normalized scope, normalized
  action, normalized target, status, normalized expiry-or-revocation
  condition)`. Standing default exclusions that none of those actions request
  remain recorded as scope or stop conditions but do not count. Independently
  decidable domains cannot be merged or omitted to force a lower profile.
  A current denial remains active and counted until its action, gate, or first
  next action is no longer current; an unrequested standing exclusion does not.

An object spanning multiple workstreams remains one canonical object. Each distinct normalized dependency or conflict reason creates the applicable pairwise edge tuples to affected workstreams, and duplicate tuples are removed. Zero is valid for every dimension except active workstreams when an active-state instance is required.

### 3. Keep selection evidence light but reviewable

Every selection or refresh records a `Profile selection basis` with current-active-only scope, measurement source, time, and freshness. Ordinary new small work records `all Compact triggers checked; none exceeded`; it does not display all eight dimensions. Full counts are recorded for takeover, disputed classification, profile transition, and fixtures. Standard and `hierarchical-required` records name the exceeded triggers.

This attestation is a workflow assertion subject to review, not semantic proof from the local validator.

### 4. Treat accepted state requirements as the retention floor

The retention floor is the complete applicable accepted field set, not a new closed list. Illustrative groups include Owner decisions and instructions; authorization grants, denials, and revocations; P0/P1 and current role findings; blockers and conflicts; required reasoning pointers; changed and do-not-touch files; validation run, not run, failures, and freshness; incidents mapped to existing errors, blockers, validation failures, or emergency stops; running and result-unknown roles; next high-risk gates; provider/model separation evidence; lifecycle patience; cleanup; review-invocation identity; PM/Advisor/Reviewer continuity; and required Reviewer approval.

Reduced rendering may omit visibly empty or inapplicable sections, but absence never implies approval or authorizes omission of applicable accepted semantics. Active state stores compact status, severity, and a stable pointer to durable full reasoning rather than recopied reasoning history.

### 5. Preserve the layered record inside a single active-state instance

Compact and Standard each use one physical active-state instance containing the current-state projection and claim-indexed evidence index, plus stable pointers that preserve historical archive-note capability. Durable evidence, raw outputs, and historical notes remain external. This avoids a parallel dashboard state machine while keeping current claims reconstructable.

Compact uses schema section/key as implicit canonical ownership. Standard uses stable section IDs. Source identity and freshness metadata are added only when an actual derived copy exists.

### 6. Use event-driven transitions with hysteresis

Profile freshness is checked at takeover, material scope change, profile transition, C-stage boundary, rollover refresh, and before a relevant gate when the last classification is no longer fresh for that target. No timer or background job is introduced.

Promotion occurs at the first freshness checkpoint where a higher trigger is verified. Demotion requires every applicable lower exit condition to hold at two consecutive freshness checkpoints plus an explicit Leader decision. `Standard` may demote to `Compact` only at or below 1 workstream, 4 blockers, 6 live role lifecycles, 6 validation-freshness groups, 8 dependency/conflict edges, 4 overlap edges, 1 high-risk gate, and 1 authorization domain. `hierarchical-required` may demote to `Standard` only at or below 4 workstreams, 8 blockers, 12 live role lifecycles, 12 validation-freshness groups, 24 dependency/conflict edges, 16 overlap edges, 2 high-risk gates, and 2 authorization domains, with no observable single-file projection failure. These provisional exit bands are intentionally below entry ceilings to prevent boundary oscillation; line and byte measurements do not control demotion.

### 7. Render genuine profile instances

Implementation will provide separate reduced Compact and Standard instance templates. A renderer is rejected for this documentation-first repository because it would introduce a new executable capability and maintenance surface solely to generate Markdown. The current 244-line and 261-line sources are evidence of the need; they are not treated as Compact instances.

Profile fixtures live under `examples/leader-state-profiles/` as rendered Markdown instances with explicit provenance, expected profile, deterministic structural counts, and expected warning state. Compact rendering omits inapplicable sections, uses one stable key per current control fact, and may use compact inline lists for bounded values; it MUST NOT hide multiple control facts in unstructured prose or a single oversized line. Physical-line and UTF-8-byte measurements apply to the complete rendered fixture file. A feasibility fixture must prove a full applicable Compact retention floor can remain below the 140-line warning before the remaining template and validator work proceeds; otherwise the line baseline returns to OpenSpec review instead of forcing truncation.

### 8. Keep successor projection aligned with accepted rollover states

At Rollover Opportunity, the Leader refreshes current state and evidence and updates only a lightweight successor skeleton when useful. At Recommended, Strongly Recommended, Required, actual handoff, or explicit Owner handoff request, the Leader prepares the complete accepted packet. Profile projection never transfers authorization, approval, validation freshness, or role continuity to a successor.

### 9. Validate structure, not truth

Local validation may measure physical lines and UTF-8 bytes, check profile declarations and selection-basis fields, detect missing required markers, and run deterministic fixtures. It cannot certify that counts are truthful, a role actually ran, authorization is valid, or the projection is semantically sufficient. No `degraded-oversize` state is created from size alone during the pilot.

## Risks / Trade-offs

- [Provisional thresholds may be poorly calibrated] → Use structural numbers only for mandatory profile classification, keep them non-blocking, keep line/byte bands warning-only, collect representative fixtures, and require a separate reviewed calibration-exit change before any safety enforcement.
- [Eight structural dimensions may burden trivial work] → Use a one-line Compact attestation for ordinary small work and require full counts only in four higher-evidence cases.
- [Complete retention floor may exceed the target band] → Correctness wins; emit a warning, preserve facts, and use template-floor measurements to recalibrate later.
- [Large work remains unbounded] → Emit `hierarchical-required`, retain accepted qualitative safety, and avoid claiming completion until a separate Hierarchical design is validated.
- [Pointers can become stale] → Require stable identity and freshness for derived copies and fixture coverage for missing, stale, orphaned, and conflicting pointers.
- [A renderer could hide required fields] → Validate rendered fixtures and treat missing applicable semantics as fail-closed even while size remains warning-only.

## Migration Plan

1. Add the profile requirements, terminology, provisional non-blocking classification thresholds, and warning-only size boundaries to the skill and references.
2. Add separate reduced Compact and Standard templates without removing the current accepted retention semantics. First render and measure one repo-grounded Compact feasibility fixture; stop and amend the provisional line baseline if the complete fixture exceeds 140 lines.
3. Add representative repo-grounded small and medium fixtures, takeover-to-Standard, above-Standard, transition, dependency/conflict-edge and overlap-edge boundaries, missing-field, and synthetic large stress fixtures. Repo-grounded fixtures must cite the archived change, accepted template, or accepted example from which their active-state facts were derived.
4. Add structural local checks and document their non-semantic limits.
5. Pilot warnings and gather measurements; do not block work based on numeric size.
6. Propose separate Hierarchical and calibration-exit changes using pilot evidence.

Rollback consists of removing profile selection and warning output while retaining the pre-existing accepted layered record and rollover rules. No stored durable evidence is deleted during migration or rollback.

## Open Questions

- Do pilot observations support the provisional lower exit bands, or should a later calibration change revise them?
- Which archived repo changes provide the most representative additional small and medium fixture provenance without importing project-specific policy?
- Is the original Owner-reported 4,000-line fact inventory available, or should only a labeled synthetic stress fixture be used?
