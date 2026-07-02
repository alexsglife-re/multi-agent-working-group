# Copyable Templates

These templates are reusable shapes for common Multi-Agent Working Group outputs. They are meant to be copied, filled in, and kept short.

Version: v0.4.9 recommended templates.

## Use Rules

- Templates provide structure only.
- A filled template is evidence, not authority.
- Do not treat a template as PM approval, Advisor approval, Reviewer approval, validation success, commit authorization, push authorization, release approval, deployment approval, or secret access approval.
- Keep filled templates current and compact.
- Move bulky detail into evidence references when safe local storage exists.
- Preserve unresolved P0/P1, owner-decision needs, validation freshness, stop conditions, and git authorization state.
- Treat rollover templates as continuity evidence only; successor startup packet != automatic thread creation.
- Treat Owner-recorded CLI role assignment as current-project trust setup authorization only after verifying the source applies to the current project and workstream.
- CLI trust setup fields do not authorize parent-directory trust, home-directory trust, all-repository trust, dangerous permission bypass, secrets, global policy changes, git actions, CI, deployment, release, publication, or external effects.
- Treat `Rollover Opportunity` as early preparation, not immediate handoff and not inherited authorization.
- Use compression count value/source/confidence; do not claim platform-visible summaries are actual total compactions.
- Task dashboards are evidence inputs to canonical state selection, not a separate state machine or runtime dashboard.
- Treat global memory, project memory, handoff, and startup-packet model preferences as hints to verify for the current workstream.
- Record provider/model per role, model source, source freshness/current verification, and PM/Advisor separation status.
- Use `provider-separated` only for different AI service providers; same-provider model/version variants are degraded or partial separation.
- Do not treat short silence as failure for PM, Advisor, or substantive Worker work; record expected wait/recheck behavior and concrete closure or restart reasons.

## Template Index

| Template | Use |
| --- | --- |
| `c0-goal-analysis.md` | Start a Multi-Agent Working Group plus OpenSpec workstream. |
| `pm-review.md` | Capture PM first-pass analysis or gate review. |
| `advisor-review.md` | Capture Advisor independent critique or gate review. |
| `worker-assignment.md` | Dispatch one bounded Worker slice. |
| `worker-return.md` | Capture Worker completion, blocker, validation, and changed files. |
| `reviewer-report.md` | Capture independent review findings. |
| `blocked-report.md` | Stop cleanly when a gate, validation, or evidence blocker appears. |
| `compact-handoff.md` | Refresh Leader handoff state without append-only growth. |
| `successor-startup-packet.md` | Prepare rollover takeover evidence without automatically creating a new conversation. |
| `git-gate.md` | Capture commit or push gate evidence. |

## Leader Rollover Use

Use `successor-startup-packet.md` when `Rollover Recommended`,
`Rollover Strongly Recommended`, or `Rollover Required` applies. The packet is
for a future Leader to verify current evidence before continuing. It does not
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

Recommended note:

```text
Legacy source:
  <path or handoff title>

Handling:
  Preserved as historical evidence. Not edited in place.

Current-state extraction:
  Only verified current facts were copied into the v0.4.9 compact handoff.

Not carried forward:
  Superseded plans, old validation output, old agent transcripts, stale git state,
  and repeated narrative.
```

If the old document is the only place a key claim exists, keep the claim in the evidence index with freshness marked as `stale until re-verified`. Do not use it as authorization for commit, push, scope expansion, gate bypass, or external effects.
