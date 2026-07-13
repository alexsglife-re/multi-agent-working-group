## Why

Context-efficient PM and Advisor review packets reduce repeated transmission, but filled packets and duplicated evidence can still accumulate without a defined lifecycle. The project needs auditable, fail-closed retention and cleanup eligibility rules that control active and retransmitted review context without reducing review capability, evidence access, independence, or gate coverage.

## What Changes

- Define permanent retention for reusable blank templates and stable project rules, while treating filled review packets, copied evidence, and generated prompts as lifecycle-bound working material.
- Define OpenSpec stage-bound compaction and cleanup checkpoints, with final cleanup after the applicable C4 archive closeout.
- Define cleanup timing for small tasks that do not use OpenSpec, based on the final applicable review, git, push, publication, or deployment gate.
- Require durable preservation of complete required role reasoning and a minimum audit record after packet compaction, including invocation identity, target, decision, findings, validation, evidence pointers, and retry lineage; a terse decision summary alone is insufficient.
- Forbid cleanup while an invocation is `prepared`, `running`, or `result-unknown`, or while P0/P1 findings, evidence gaps, required corrections, or required gate reviews remain unresolved.
- Require compaction to be explicit, reviewable, and non-destructive by default; lifecycle eligibility never authorizes file deletion, which remains an Owner-only destructive action for an exact scope under applicable gates.
- Bound active and retransmitted review context while acknowledging that stored lifecycle-bound packet files may continue growing until exact-scope Owner-authorized removal and that compact durable audit evidence intentionally grows with required reviews.
- Add deterministic validation for the documented lifecycle, retention floor, and fail-closed blockers.

## Capabilities

### New Capabilities

<!-- None. -->

### Modified Capabilities

- `role-review-context-efficiency`: Extend context-efficient review requirements with packet retention classes, lifecycle checkpoints, minimum audit evidence, and fail-closed cleanup rules.

## Impact

- Affects the role-review context-efficiency reference, related workflow/template guidance, validation anchors, and accepted OpenSpec requirements.
- Does not change PM or Advisor provider/model routing, review frequency or scope, independent no-peek behavior, original-evidence access, required gates, or Leader verification.
- Does not delete historical evidence automatically, add a destructive cleanup command, authorize file removal without exact Owner approval, or authorize cleanup across unrelated projects or tasks.
