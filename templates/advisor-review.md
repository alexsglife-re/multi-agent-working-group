# Advisor Review Template

Version: v0.4.13 recommended template.

```text
Role:
  Advisor Agent

Review type:
  first-pass critique | scope challenge | pre-commit gate | post-commit review | pre-push gate | post-push review | closeout

Context-efficient review identity:
  Stage Session ID:
  C-stage:
    C0-bootstrap | C1 | C2 | C3 | C4 | non-openspec
  Runtime Session ID:
  Runtime/provider kind:
    Claude | other
  Runtime identity evidence source:
  Runtime resume evidence:
  Runtime evidence state:
    exact-supported | unavailable | contradictory
  Inherited context:
    none | verified-same-stage | verified-restart-packet
  Continuity:
    intact-runtime-proven | restarted | degraded | unavailable
  Review ID:
  Attempt ID:
  Parent Attempt ID:
  Packet fingerprint:
  Target fingerprint:
  Fresh decision:
    confirmed | blocked
  No-peek state:
    isolated-current-first-pass | consensus-open | contaminated
  Validation freshness state:
    fresh-current-target | stale | not-applicable
  Authorization state:
    not-granted | owner-explicit-current-scope | normal-git-gate-current | blocked
  Invocation state:
    prepared | running | completed | failed-confirmed | result-unknown | superseded
  Stable baseline anchor:
  Incremental evidence target:
  Conclusions intentionally withheld:
    PM conclusions | none

Independence state:
  Reviewed before PM conclusions:
    yes | no | not applicable
  Provider/model:
  Model source:
  Source freshness/current verification:
  Model diversity/separation status:
    provider-separated | model-family-separated degraded |
    same-provider-variant degraded | same-model owner override degraded |
    degraded | blocked

Lifecycle patience:
  Work size:
    quick | substantive | large gate review | unknown
  Expected wait/recheck behavior:
  Last contact or progress evidence:
  Patience state:
    active | waiting | progress-check-needed | exceeded | blocked | complete
  Closure/restart reason, if any:
    cross-stage | context-reliability | context-pressure | independence-contamination | provider-change | model-change | tool-change | trust-loss | state-ambiguity | failed-recovery | owner-instruction | not-applicable

Claims challenged:
  - ...

Counterexamples considered:
  - ...

Risk check:
  Risk tier:
  Possible underestimated risks:
    - none | ...
  Default exclusions touched:
    yes | no

CLI workspace trust challenge, if relevant:
  Owner-recorded role authorization source inspected:
  Source applies to current project/workstream:
    yes | no | not applicable
  Trust state:
    not-needed | preflight-needed | owner-recorded-role-authorized | trust-setup-attempted | trusted-verified | owner-confirmation-needed | blocked
  Target project root is exact current project root:
    yes | no | not applicable
  Read-only probe passed before relying on CLI output:
    yes | no | not applicable
  Scope expansion concerns:
    none | parent/home/all-repo trust | dangerous permission bypass | secrets | global policy | git/CI/deploy/release/external effect | other

Findings:
  P0:
    - none | ...
  P1:
    - none | ...
  P2:
    - none | ...

Evidence inspected:
  Files:
    - ...
  Commands/results:
    - ...
  Agent outputs:
    - ...

Validation freshness:
  Fresh:
    - ...
  Stale or missing:
    - ...

Owner-decision needs:
  none | <plain-language decision needed>

Advisor conclusion:
  GO | NO-GO | BLOCKED-EVIDENCE
Evidence gaps:
  - none | ...
Required corrections:
  - none | ...
Recommended next action:
  ...
Concise rationale:
  ...
```

Same-stage continuity may retain verified context and Advisor's own prior reasoning. It never inherits an earlier `GO`, validation freshness, git/archive authorization, or PM's current first-pass conclusion. Claude continuity requires exact `--resume <session-id>`, never ambiguous `--continue`. Put Lifecycle Decision Actor `leader|owner` and timezone-qualified Lifecycle Decision Time only in a separate lifecycle transition record, never in a routine same-stage packet.

This packet is an index and starting point, not a restriction or substitute for original evidence. Inspect any task-relevant original evidence within the approved scope when needed.

This reusable blank template is permanent protocol material. A filled Advisor packet is lifecycle-bound working material; its complete required reasoning and minimum durable audit record remain durable after any eligible non-destructive compaction.
