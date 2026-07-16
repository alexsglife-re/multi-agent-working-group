# Compact Leader State Template

Version: v1.0.0 development template.

Use for a freshly measured current-active state that satisfies every Compact
structural ceiling. This is one active-state and handoff instance, not a full
history. Keep durable reasoning and raw output at stable evidence locations.
Applicable accepted facts always win over the target and warning bands.

Absence is not approval. Omit an optional section only when it is genuinely
inapplicable; never omit a triggered field, unresolved control fact, or stop
condition. This template grants no authority, approval, validation freshness,
role continuity, gate bypass, or automatic next action.

Successor, profile, authority, validation, role, and gate decisions are not inherited.
The complete applicable retention floor wins; do not truncate facts.
Physical size warnings are non-blocking and never select a profile.

## Profile Selection

```text
Leader state profile: Compact
Inventory scope: current-active-only
Measurement source: <current-state evidence pointer>
Measurement source kind: direct-current-state | takeover-verification | transition-measurement | fixture-measurement
Measurement time: <ISO-8601 time with timezone>
Measurement freshness: fresh | stale | unknown
Selection detail: light-attestation | full-counts
Profile selection basis: <all Compact triggers checked; none exceeded | full-count result>
Exceeded trigger keys: none
Projection assessment: reliable-single-file
Projection evidence kind: not-applicable | structural | reviewed-leader-judgment
Checkpoint event: initial-creation | takeover | material-state-change | stage-boundary | rollover-refresh | handoff | successor-takeover | disputed-classification | transition-review | validation-fixture
Checkpoint evidence/time: <pointer>; <ISO-8601 time with timezone>
```

For takeover, disputed classification, transition, or fixture use, add all
eight deterministic counts. Ordinary small work uses the light attestation.

## Current-State Projection

```text
Owner instruction and current decision: <current verified instruction; decision needs>
Goal / active workstream(s): <goal; WS IDs and completion conditions>
Stage / archive requirement: <stage or C-stage>; <required | not applicable>
Scope / non-goals: <allowed>; <forbidden>
Risk / mode: <tier>; <workflow mode>
Status / first next action: <current status>; <one action and dependencies>
Blockers / conflicts: <none verified | canonical unresolved items>
P0 / P1 / current findings: <none verified | severity, status, evidence pointer>
Changed / do-not-touch files: <paths>; <paths>
Stop conditions / next high-risk gate: <conditions>; <gate or none>
ContextBudget: <one canonical state; count value/source/confidence; last check; action>
```

## Authorization And Gates

```text
Active authorization domains: <actor, scope, action, target, status=requested|pending|granted|denied|revoked|expired, expiry-or-revocation condition>
Standing default exclusions: <retained scope/stop conditions; not counted unless current action, current gate, or first next action triggers the active-domain rule>
A current denial is active, fail-closed, and counted until its action, gate, or first next action is no longer current; an unrequested standing exclusion is retained but not counted.
Commit / push: <default no or current verified state>; <default no or current verified state>
Gate decisions: <current status and evidence pointer>
Inheritance: prohibited; any successor must freshly verify authority and gates
```

## Roles And Review

Include only applicable live/current role facts; never infer approval from an
omitted role.

```text
PM / Advisor / Reviewer: <identity; lifecycle state; current finding; result pointer>
Worker(s): <running, result-unknown, returned-unconsumed, or required state>
Provider/model separation: <models, sources, freshness, separation/degradation>
CLI workspace trust: <not applicable | role, authorization source, root, trust/probe evidence>
Review invocation: <C-stage; Stage Session IDs; Review ID; Attempt IDs; target fingerprint; states>
Lifecycle patience: <expected size; wait/recheck; last progress; state; restart reason>
Required Reviewer approval: <not applicable | pending | verified with pointer>
Cleanup: <status by role; delivery-evidence impact; non-blocking basis if applicable>
```

## Validation

```text
Run: <validation group, target/run identity, result, evidence pointer>
Not run: <required checks and reason>
Failures: <none verified | current failures and stop behavior>
Freshness: <fresh-current-target | stale | not-applicable for each applicable target>
```

## Plain-Language Closeout (when closing or handing off)

```text
What changed: <ordinary-language result>
What was verified: <checks and evidence actually observed>
What remains uncertain or was not checked: <items | none and why>
Recommended next goal: <advice only; verify authorization before starting>
```

## Evidence Index

Use one row per current claim; this is the claim-indexed reconstruction path,
not a substitute for current control facts above.

| Claim ID | Current claim | Evidence location | Freshness/status | Leader verification |
| --- | --- | --- | --- | --- |
| C-01 | <claim> | <stable path, command, commit, result, or note> | current / stale / historical | verified / inferred / unverified |

## Historical Archive Note

```text
Archive-note location/convention: <stable path>
Current archive-note pointer: <pointer | none because no history exists>
Not carried forward: <superseded narrative, logs, diffs, or none>
```

An absent archive note is not approval, deletion permission, or proof that
history was reviewed.

## Rendering Measurement

```text
Physical lines: <complete rendered instance line count>
UTF-8 bytes: <complete rendered instance byte count>
Size warning state: within-warning | line-warning | byte-warning | line-and-byte-warning
Compact diagnostics: target 40-100 lines; warn above 140 lines or 16384 bytes
Warning response: preserve all applicable facts; warning is non-blocking
Optional sections omitted: <only genuinely inapplicable sections>
```
