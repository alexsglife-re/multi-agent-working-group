# Role Review Context Efficiency

This reference extends `SKILL.md`; it cannot weaken `SKILL.md` or create authorization.

## Quality Boundary

Context efficiency removes repeated transmission, not review capability. It must not change PM or Advisor provider/model routing, required review frequency, assigned scope, independent no-peek authority, access to task-relevant original evidence, gate coverage, lifecycle patience, or Leader verification. No hard token ceiling may force incomplete review or a false `GO`.

## Session And Packet Model

For OpenSpec-backed work, default to one runtime-proven PM lifecycle and one runtime-proven Advisor lifecycle within exactly one `C1`, `C2`, `C3`, or `C4` stage. C0 is a short-lived `C0-bootstrap`; close or restart its role sessions before C1. At a cross-C-stage boundary, start new PM and Advisor lifecycles by default. Same-stage continuity may retain verified context and the role's own prior reasoning, but every distinct checkpoint remains a fresh decision transaction with a new Review ID, Attempt ID, exact target fingerprint, and current decision, validation, authorization, and no-peek states. Never inherit an earlier `GO`, validation freshness, git/archive authorization, or the other role's current first-pass conclusion.

For non-OpenSpec work, use a fresh short-lived session for each distinct checkpoint. In either model, a narrow clarification or missing-file request for the unchanged target may remain in the same session and Review ID under a linked Attempt ID. A changed commit, diff, gate, decision request, or materially changed packet requires a new Review ID.

Canonical lifecycle values are C-stage `C0-bootstrap|C1|C2|C3|C4|non-openspec`; inherited context `none|verified-same-stage|verified-restart-packet`; fresh decision `confirmed|blocked`; no-peek `isolated-current-first-pass|consensus-open|contaminated`; validation freshness `fresh-current-target|stale|not-applicable`; authorization `not-granted|owner-explicit-current-scope|normal-git-gate-current|blocked`; continuity `intact-runtime-proven|restarted|degraded|unavailable`; runtime evidence `exact-supported|unavailable|contradictory`; and restart reason `cross-stage|context-reliability|context-pressure|independence-contamination|provider-change|model-change|tool-change|trust-loss|state-ambiguity|failed-recovery|owner-instruction|not-applicable`.

Stage Session ID is a workflow identity backed by the exact Runtime Session ID, its evidence source, runtime/provider kind, and exact resume mechanism when persistence is supported. Claude continuity is proven only when exact `--resume <session-id>` matches the recorded Runtime Session ID; ambiguous `--continue` cannot prove identity. Other runtimes use their verified exact runtime-specific resume mechanism and are not required to imitate Claude syntax. `--no-session-persistence`, an unproven process restart, or unavailable persistence requires a new Stage Session ID and continuity `restarted`, `degraded`, or `unavailable`, never `intact-runtime-proven`.

Restart the affected same-stage lifecycle when context reliability is lost, material context pressure exists, independence is contaminated, provider/model/tool routing changes, workspace trust is lost, invocation state remains ambiguous, recovery fails, or the Owner instructs restart. Cross-stage and mandatory-trigger restarts require a new Stage Session ID, non-intact continuity, matching canonical restart reason, and transition actor/time evidence. A `running` or `result-unknown` old attempt is quarantined until process/output/CLI evidence resolves concurrent-execution risk; a successor must not satisfy the same gate while that risk remains. No provider substitution is implicit.

A routine same-stage event requires the same Stage Session ID, `intact-runtime-proven`, no trigger, restart reason `not-applicable`, and no transition fields. Any restart or close outside a precisely modeled C0 close or cross-stage transition requires an applicable canonical trigger and matching reason, a new Stage Session ID, non-intact continuity, and transition actor/time. Every `restarted`, `degraded`, or `unavailable` record is a transition event with a new lifecycle ID and non-`not-applicable` reason except the precisely modeled C0 close.

Build one conclusion-free factual manifest and derive separate PM and Advisor packets. Never expose one role's first-pass conclusion to the other before both independent first passes finish. Each packet includes the Owner goal and authorization boundary, stable baseline and accepted anchor, current delta, changed files and behavior, fresh validation, known risks, unresolved questions, and evidence pointers.

The packet is an index and starting point, not a restriction or substitute for original evidence. The role may inspect any task-relevant original file and read-only evidence within the approved project scope. When the packet is insufficient, inspect or request original evidence and return `BLOCKED-EVIDENCE` if the gap remains.

## Invocation Identity

Record Stage Session ID, C-stage, Runtime Session ID or unavailable marker, runtime evidence source, exact resume evidence, provider/model/tool and trust evidence, inherited-context flag, Review ID, Attempt ID, role, review type, target, stable baseline anchor, packet fingerprint, fresh-decision/no-peek/validation/authorization states, invocation state, start/completion time, result location, retry decision, and parent Attempt ID when retried.

States are `prepared`, `running`, `completed`, `failed-confirmed`, `result-unknown`, and `superseded`. Do not blindly repeat the same Review ID and packet fingerprint while it is `running` or `result-unknown`. First inspect process, output, and CLI status evidence. Short silence is not failure or cleanup. A confirmed retry uses a new Attempt ID linked to its parent and preserves the same capability and scope.

`failed-confirmed` means direct process, output, or CLI evidence confirms that the attempt cannot produce an acceptable result. `superseded` means a newer linked attempt or materially changed review target has replaced the attempt after its lineage and final disposition were recorded. Neither state by itself proves cleanup eligibility.

Lifecycle transitions, not routine same-stage invocation records, carry Lifecycle Decision Actor `leader|owner` and a timezone-qualified ISO-8601 Lifecycle Decision Time. Record those fields for normal cross-stage close/restart, early close/restart, C0 close, and degraded or unavailable continuity transitions. The actor is the decision maker; `owner-instruction` is only a restart reason. Routine same-stage records omit both fields rather than inventing `not-applicable` values.

## Required Role Response

Record:

- Decision: `GO`, `NO-GO`, or `BLOCKED-EVIDENCE`.
- P0, P1, and P2 findings.
- Evidence inspected and evidence gaps.
- Validation freshness.
- Required corrections and Owner-decision needs.
- Recommended next action and concise rationale.

Role output and packet records are evidence, not authorization.

## Retention Classes

Classify review material by purpose:

1. **Permanent protocol material:** reusable blank templates, stable project rules, accepted specifications, and archived OpenSpec artifacts. These are never packet-cleanup targets.
2. **Durable audit evidence:** invocation identity, exact target anchors, fingerprint, timing, decision, P0/P1/P2 findings, validation, evidence pointers, retry lineage, cleanup disposition, and each required role's complete reasoning, option comparison, recommendation, objections, and key error details directly or at a durable result location; a terse decision summary alone is insufficient.
3. **Lifecycle-bound working material:** filled packets, generated prompts, copied unchanged evidence, scratch manifests, and superseded renderings. A filled instance remains lifecycle-bound even when created from a permanent blank template.

A shared conclusion-free factual manifest is lifecycle-bound working material unless a specific manifest field is retained as part of the durable audit record. Durable audit evidence intentionally grows linearly with required reviews. The protocol bounds active and retransmitted review context, not stored files: lifecycle-bound packet files may continue growing until exact-scope Owner-authorized removal. These eligibility and audit rules do not impose a storage cap.

## Packet Lifecycle Checkpoints

Role-agent C-stage lifecycle and packet lifecycle checkpoint are separate concepts. For OpenSpec-backed work:

- **C1:** after both independent first passes, corrections, and the scope decision complete, redundant proposal-review material may be non-destructively compacted; retain the durable record and evidence needed by C2.
- **C2:** after validation and required implementation review complete, superseded implementation-review material may be non-destructively compacted; retain everything needed for C3.
- **C3:** retain current pre-commit, actual-commit, pre-push, post-push, status, and other gate material until each corresponding gate and follow-up review completes.
- **C4:** final non-destructive compaction and destructive-removal eligibility occur only after archive validation, applicable archive commit, push, and status work, and required post-action reviews complete.

For work that does not use OpenSpec, do not invent an OpenSpec lifecycle. Determine the final applicable gate from actual scope: required final review for no-git work; actual-commit review for commit-only work; status or CI evidence plus post-push review for pushed work; and post-action closeout review for Owner-authorized tag, release, publication, or deployment work.

## Fail-Closed Cleanup Decision

Non-destructive compaction replaces redundant active detail with the durable audit record and reproducible pointers without mutating or removing the original files. File mutation, deletion, or other destructive removal is not compaction.

Block compaction and removal eligibility while any related invocation is `prepared`, `running`, or `result-unknown`; any P0/P1, `BLOCKED-EVIDENCE`, evidence gap, required correction, Owner decision, required review, or later applicable gate remains unresolved; or cleanup impact is unknown. A `failed-confirmed` or `superseded` attempt is eligible only after retry lineage and final disposition are durably recorded.

Lifecycle eligibility permits non-destructive compaction only. Destructive removal remains an Owner-only default exclusion requiring explicit authorization naming the exact scope and all applicable gates. Do not add time-based, background, automatic, unattended, or retrospective bulk deletion. Preserve historical material prospectively unless a later exact-scope Owner-authorized task verifies eligibility.
