# Copyable Templates

These templates are reusable shapes for common Multi-Agent Working Group outputs. They are meant to be copied, filled in, and kept short.

Version: v0.4.13 recommended templates.

This is the collection baseline. Individual templates may declare a later development version when first introduced or materially revised; existing template provenance is not bulk-rewritten.

## Use Rules

- Templates provide structure only.
- A filled template is evidence, not authority.
- Do not treat a template as PM approval, Advisor approval, Reviewer approval, validation success, commit authorization, push authorization, release approval, deployment approval, or secret access approval.
- Keep filled templates current and compact.
- Use `review-factual-manifest.md` for shared conclusion-free facts and `review-invocation-record.md` for Review ID, Attempt ID, packet fingerprint, lifecycle state, and linked retry evidence.
- PM and Advisor packets remain separate for independent no-peek first passes and remain indexes rather than restrictions on original evidence.
- For OpenSpec C1-C4, reuse a runtime-proven Stage Session ID within one C-stage while creating a fresh Review ID and checkpoint decision for each changed target. Cross-stage and mandatory-trigger transitions restart the lifecycle by default; non-OpenSpec distinct checkpoints remain short-lived.
- Lifecycle transition actor/time fields belong only to transition records. Routine same-stage invocation records omit them.
- Reusable blank templates are permanent protocol material; filled instances are lifecycle-bound working material.
- Use `review-packet-cleanup-checklist.md` before packet compaction. Lifecycle eligibility permits non-destructive compaction only; file mutation or removal remains exact-scope Owner-only.
- Move bulky detail into evidence references when safe local storage exists.
- Preserve unresolved P0/P1, owner-decision needs, validation freshness, stop conditions, and git authorization state.
- Treat rollover templates as continuity evidence only; successor startup packet != automatic thread creation.
- Treat Owner-recorded CLI role assignment as current-project trust setup authorization only after verifying the source applies to the current project and workstream.
- CLI trust setup fields do not authorize parent-directory trust, home-directory trust, all-repository trust, dangerous permission bypass, secrets, global policy changes, git actions, CI, deployment, release, publication, or external effects.
- Treat `Rollover Opportunity` as early preparation, not immediate handoff and not inherited authorization.
- At `Rollover Opportunity`, refresh the selected profile, canonical active
  state, and evidence index; use `successor-opportunity-skeleton.md` only when
  lightweight preparation is useful. Use the complete successor packet for
  Recommended, Strongly Recommended, Required, actual handoff, or an explicit
  Owner handoff request.
- Select Compact or Standard from current-active-only structural inventory,
  not from document length. Physical-line and UTF-8-byte bands are diagnostic
  warnings only; applicable accepted facts are never truncated to fit them.
- Compact may omit genuinely inapplicable visible sections and uses its
  section/key as implicit canonical ownership. Standard uses stable section
  IDs. Add source/freshness metadata only for actual derived copies.
- Absence is not approval. Every triggered accepted state-carrying field must
  remain in the active projection or an accepted stable projection.
- Use compression count value/source/confidence; do not claim platform-visible summaries are actual total compactions.
- Task dashboards are evidence inputs to canonical state selection, not a separate state machine or runtime dashboard.
- Treat global memory, project memory, handoff, and startup-packet model preferences as hints to verify for the current workstream.
- Record provider/model per role, model source, source freshness/current verification, and PM/Advisor separation status.
- Use `provider-separated` only for different AI service providers; same-provider model/version variants are degraded or partial separation.
- Do not treat short silence as failure for PM, Advisor, or substantive Worker work; record expected wait/recheck behavior and concrete closure or restart reasons.
- When a work round completes or reaches a safe stopping point, include a plain-language closeout: what changed, what was actually verified, what remains uncertain or was not checked, and recommended next goals.
- Recommended next goals are advice only. Do not start them unless the Owner has already given explicit current-session authorization.
- Skill invocation means applying workflow/checklist reasoning only. It never creates external effects or transfers authority; examples include agent spawning, external Advisor calls, workspace trust, commit, push, archive, CI, deployment, publication, secret access, or next-goal execution.
- Role-agent cleanup status fields are evidence only. They do not authorize
  cleanup, commit, push, release, deployment, publication, gate bypass, or
  treating failed validation/review/git/secret/authorization evidence as
  non-blocking cleanup.
- Use Worker-first context control fields to explain why a bounded Worker slice
  was dispatched, or why Leader direct execution was safer for a narrow
  exception.

## Template Index

| Template | Use |
| --- | --- |
| `c0-goal-analysis.md` | Start a Multi-Agent Working Group plus OpenSpec workstream. |
| `pm-review.md` | Capture PM first-pass analysis or gate review. |
| `advisor-review.md` | Capture Advisor independent critique or gate review. |
| `worker-assignment.md` | Dispatch one bounded Worker slice. |
| `worker-return.md` | Capture Worker completion, blocker, validation, and changed files. |
| `reviewer-report.md` | Capture independent review findings. |
| `review-packet-cleanup-checklist.md` | Verify retention class, final gate, blockers, durable audit evidence, and exact cleanup scope. |
| `blocked-report.md` | Stop cleanly when a gate, validation, or evidence blocker appears. |
| `compact-handoff.md` | Refresh Leader handoff state without append-only growth. |
| `compact-leader-state.md` | Render a genuinely reduced Compact current-state and handoff instance. |
| `standard-leader-state.md` | Render a stable-section Standard current-state and handoff instance. |
| `successor-opportunity-skeleton.md` | Prepare lightweight Opportunity evidence without creating a complete handoff. |
| `successor-startup-packet.md` | Prepare rollover takeover evidence without automatically creating a new conversation. |
| `git-gate.md` | Capture commit or push gate evidence. |

## Leader Rollover Use

Use `successor-opportunity-skeleton.md` at `Rollover Opportunity` only when
lightweight preparation is useful. It points to the canonical active-state
record and does not duplicate the complete retention floor.

Use `successor-startup-packet.md` when `Rollover Recommended`,
`Rollover Strongly Recommended`, or `Rollover Required` applies. The packet is
also required for actual handoff or an explicit Owner handoff request. It is
profile-aware, but the successor must freshly verify profile selection,
authority, approval, git/OpenSpec state, validation freshness, findings, role
continuity, and Worker state before acting. The packet does not
create or authorize a successor thread, commit, push, CI, archive, release,
deployment, publication, secret access, PM/Advisor bypass, Reviewer bypass, or
validation bypass.

When `Rollover Required` applies, keep one active current-state card for the
workstream. Do not fork multiple competing handoffs. If a newer packet replaces
an older packet, mark the older packet as historical evidence.

## Handling Legacy Or Bloated Documents

Do not bulk-rewrite old v0.3 or earlier handoffs, ledgers, and role outputs into the new template shape. Old documents are historical evidence. Rewriting them can make stale facts look current.

When an old document is already bloated:

1. Freeze the old document as history.
2. Create a new `compact-handoff.md` current state card.
3. Copy only facts that are still needed and can be verified now.
4. Put old sections in the evidence index using `current`, `stale until re-verified`, or `historical only` for freshness/status, plus `verified`, `inferred`, or `unverified` for Leader verification.
5. Record what was intentionally not carried forward.
6. Update only the new current state card from then on.

Choose `compact-leader-state.md` when fresh current-active-only inventory
satisfies every Compact ceiling. Choose `standard-leader-state.md` directly
when a Compact trigger is exceeded but every Standard ceiling and reliable
single-file projection still hold; takeover never needs to pass through
Compact first. If Standard is exceeded or the projection is unreliable,
record `hierarchical-required`, preserve all applicable facts, and continue
the accepted qualitative rollover protocol. Do not force the state into either
template or claim that a Hierarchical storage design already exists.

For migration from a bloated active document, freeze the old document as
historical evidence, freshly inventory only current active state, render the
measured profile into a new canonical instance, and link retained history
through the claim-indexed evidence index and archive-note pointer. Do not copy
old narrative, stale validation, or historical gate decisions forward as
current truth.

Recommended note:

```text
Legacy source:
  <path or handoff title>

Handling:
  Preserved as historical evidence. Not edited in place.

Current-state extraction:
  Only verified current facts were copied into the v0.4.10 compact handoff.

Not carried forward:
  Superseded plans, old validation output, old agent transcripts, stale git state,
  and repeated narrative.
```

If the old document is the only place a key claim exists, keep the claim in the evidence index with freshness marked as `stale until re-verified`. Do not use it as authorization for commit, push, scope expansion, gate bypass, or external effects.
