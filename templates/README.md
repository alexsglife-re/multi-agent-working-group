# Copyable Templates

These templates are reusable shapes for common Multi-Agent Working Group outputs. They are meant to be copied, filled in, and kept short.

Version: v0.4.5 recommended templates.

## Use Rules

- Templates provide structure only.
- A filled template is evidence, not authority.
- Do not treat a template as PM approval, Advisor approval, Reviewer approval, validation success, commit authorization, push authorization, release approval, deployment approval, or secret access approval.
- Keep filled templates current and compact.
- Move bulky detail into evidence references when safe local storage exists.
- Preserve unresolved P0/P1, owner-decision needs, validation freshness, stop conditions, and git authorization state.

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
| `git-gate.md` | Capture commit or push gate evidence. |

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
  Only verified current facts were copied into the v0.4.5 compact handoff.

Not carried forward:
  Superseded plans, old validation output, old agent transcripts, stale git state,
  and repeated narrative.
```

If the old document is the only place a key claim exists, keep the claim in the evidence index with freshness marked as `stale until re-verified`. Do not use it as authorization for commit, push, scope expansion, gate bypass, or external effects.
