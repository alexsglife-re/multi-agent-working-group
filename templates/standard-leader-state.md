# Standard Leader State Template

Version: v1.0.0 release template.

Use when a freshly measured current-active state exceeds at least one Compact
ceiling, satisfies every Standard ceiling, and remains a reliable single-file
projection. This file is the canonical current projection and claim-indexed
evidence index; durable reasoning, raw output, and history remain at stable
external locations.

Absence is not approval. Omit a visibly empty section only when it is genuinely
inapplicable. Applicable accepted fields always override size targets and
warnings. This template transfers no authority, approval, validation freshness,
role continuity, gate decision, or automatic next action.

Successor, profile, authority, validation, role, and gate decisions are not inherited.
The complete applicable retention floor wins; do not truncate facts.
Physical size warnings are non-blocking and never select a profile.

Stable section IDs (`S01`-`S12`) are canonical ownership keys. Add canonical
source identity and copy freshness only beside an actual derived copy; do not
add per-fact fingerprints when no derived copy exists.

## S01 — Profile Selection

```text
Leader state profile: Standard
Inventory scope: current-active-only
Measurement source: <current-state evidence pointer>
Measurement source kind: direct-current-state | takeover-verification | transition-measurement | fixture-measurement
Measurement time: <ISO-8601 time with timezone>
Measurement freshness: fresh | stale | unknown
Selection detail: full-counts
Profile selection basis: <deterministic current-active inventory result>
Exceeded trigger keys: <compact.<dimension> keys>
Projection assessment: reliable-single-file
Projection evidence kind: not-applicable | structural | reviewed-leader-judgment
Checkpoint event: initial-creation | takeover | material-state-change | stage-boundary | rollover-refresh | handoff | successor-takeover | disputed-classification | transition-review | validation-fixture
Checkpoint evidence/time: <pointer>; <ISO-8601 time with timezone>
```

| Dimension | Current count | Compact max | Standard max |
| --- | ---: | ---: | ---: |
| Active workstreams |  | 2 | 5 |
| Blockers |  | 5 | 10 |
| Live role lifecycles |  | 8 | 15 |
| Validation-freshness groups |  | 8 | 15 |
| Dependency/conflict edges |  | 10 | 30 |
| Overlap edges |  | 5 | 20 |
| High-risk gates |  | 2 | 3 |
| Authorization domains |  | 2 | 3 |

## S02 — Owner, Goal, Stage, And Scope

```text
Owner instruction: <latest verified instruction>
Owner decisions / decision needs: <current decisions and pending needs>
Global goal / completion condition: <goal>
Stage or C-stage / archive requirement: <stage>; <required | not applicable>
Scope / non-goals: <allowed>; <forbidden>
Risk tier / workflow mode: <tier>; <mode>
Current status / global next action: <status>; <one action and dependencies>
```

## S03 — Active Workstreams And Relationships

| Workstream ID | Current goal / completion condition | Status | Blocker or gate | Next action |
| --- | --- | --- | --- | --- |
| WS-1 |  |  |  |  |

```text
Dependency edges: <from, to, normalized reason key>
Conflict edges: <sorted pair, normalized reason key>
Overlap edges: <sorted pair, repository path or named control surface>
Cross-workstream facts: <canonical section/key and affected WS IDs>
```

## S04 — Findings, Blockers, And Stops

```text
Canonical blockers / conflicts: <none verified | IDs, severity, status, pointer>
Unresolved P0 / P1: <none verified | current findings and pointer>
Current P2: <none recorded | current findings and disposition>
Incidents / emergency stops: <none verified | current state and pointer>
Stop conditions: <conditions>
Next high-risk gates: <gate, owner decision, and evidence needed>
```

## S05 — Files And Ownership

```text
Changed files: <paths and owning workstream>
Do-not-touch files: <paths and reason>
Shared control surfaces: <surface and owning section/key>
Conflicting or duplicate ownership: none verified | <fail closed and reclassify>
```

For an actual derived copy only:

```text
Derived copy: <section/key and copied fact>
Canonical source identity: <stable section/key or external evidence identity>
Copy freshness: <fresh | stale | unknown; verified time/evidence>
```

## S06 — Authorization And Gate State

Active authorization domains:
State enum: `requested|pending|granted|denied|revoked|expired`.

| Domain | Actor | Scope | Action | Target | State | Expiry or revocation condition | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| AUTH-1 |  |  |  |  | _state enum above_ |  |  |

```text
Standing default exclusions: <retained scope/stop conditions; not counted unless current action, current gate, or first next action triggers the active-domain rule>
A current denial is active, fail-closed, and counted until its action, gate, or first next action is no longer current; an unrequested standing exclusion is retained but not counted.
Commit / push: <default no or current verified states>
Historical gate evidence: <evidence only>
Successor inheritance: prohibited; successor must freshly verify every domain
```

## S07 — Role And Review Continuity

| Role | Identity | Lifecycle / continuity | Current finding or state | Result pointer |
| --- | --- | --- | --- | --- |
| PM |  |  |  |  |
| Advisor |  |  |  |  |
| Reviewer |  |  |  |  |
| Worker |  |  |  |  |

```text
Provider/model per role and source: <models; source; freshness/applicability>
Separation/diversity: <status and degradation/override reason>
CLI workspace trust: <not applicable | role, authorization source, root, trust/probe evidence>
Review invocation: <C-stage; Stage Session IDs; Review ID; Attempt IDs; packet fingerprint; target fingerprint; states>
No-peek / fresh decision: <states for the current checkpoint>
Required Reviewer approval: <not applicable | pending | verified with pointer>
Lifecycle patience: <expected size; wait/recheck; last progress; state; closure/restart reason>
Unconsumed Worker returns / result-unknown evidence: <none | identities and no-blind-retry rule>
```

## S08 — Validation Freshness

| Group | Target / run identity | Run or not run | Result | Freshness | Evidence |
| --- | --- | --- | --- | --- | --- |
| VG-1 |  |  |  | fresh-current-target / stale / not-applicable |  |

```text
Validation failures: <none verified | current failures and stop behavior>
Required next checks: <commands/evidence and target>
Size diagnostics cannot override semantic or validation failure.
```

## S09 — Cleanup And Context Budget

```text
Cleanup by role: <not needed | pending | attempted | skipped | degraded | failed>
Delivery-evidence impact: <none | affected | unknown>
Non-blocking cleanup basis, if used: <task/git/validation/secret/auth/role evidence>
ContextBudget state: <exactly one canonical state>
Compression count: <value/source/confidence; additional evidence>
Last check / reason / next boundary / action: <details>
```

## S10 — First Next Action

```text
First next action: <one action only>
Dependencies: <facts, gates, roles, files, or checks that must be fresh first>
Expected evidence: <result and stable location>
Stop if: <conditions>
```

Plain-language closeout, when closing or handing off:

```text
What changed: <ordinary-language result>
What was verified: <checks and evidence actually observed>
What remains uncertain or was not checked: <items | none and why>
Recommended next goal: <advice only; verify authorization before starting>
```

## S11 — Claim-Indexed Evidence Index

| Claim ID | Current claim | Evidence type/location | Freshness/status | Leader verification |
| --- | --- | --- | --- | --- |
| C-01 |  |  | current / stale / historical | verified / inferred / unverified |

Pointers must be stable and reconstruct each current claim. The index explains
the projection; it does not replace required current gate facts in S01-S10.

## S12 — Historical Archive And Measurement

```text
Archive-note location/convention: <stable path>
Current archive-note pointer: <pointer | none because no history exists>
Not carried forward: <superseded narrative, logs, diffs, or none>
Physical lines: <complete rendered instance line count>
UTF-8 bytes: <complete rendered instance byte count>
Size warning state: within-warning | line-warning | byte-warning | line-and-byte-warning
Standard diagnostics: target 80-160 lines; warn above 200 lines or 24576 bytes
Warning response: preserve all applicable facts; warning is non-blocking
Optional sections omitted: <only genuinely inapplicable sections>
```

An absent archive note is not approval, deletion permission, or proof that
history was reviewed.
