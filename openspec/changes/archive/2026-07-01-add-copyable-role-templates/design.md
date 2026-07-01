# Design: Add Copyable Role Templates

## Approach

Add plain Markdown templates under `templates/`. Each template is designed to be copied into a workstream note, handoff, agent prompt, or review response and filled in by the Leader or role agent.

The templates should be intentionally narrow:

- They provide structure, not approval.
- They preserve P0/P1, validation, evidence, and authorization state.
- They do not replace PM/Advisor/Reviewer judgment.
- They do not authorize commit, push, deployment, release, or any high-risk/default-exclusion action.

## Template Set

- `templates/README.md`: index, use rules, and legacy document handling.
- `templates/c0-goal-analysis.md`: OpenSpec plus multi-agent startup analysis.
- `templates/pm-review.md`: PM first-pass and gate review shape.
- `templates/advisor-review.md`: Advisor independent critique and gate review shape.
- `templates/worker-assignment.md`: bounded Worker dispatch shape.
- `templates/worker-return.md`: Worker completion/blocker return shape.
- `templates/reviewer-report.md`: independent review report shape.
- `templates/blocked-report.md`: blocked-state report shape.
- `templates/compact-handoff.md`: current state card, evidence index, and archive note shape.
- `templates/git-gate.md`: commit/push gate evidence shape.

## Legacy Document Handling

Existing v0.3 or earlier handoffs, ledgers, and role outputs are treated as historical evidence. When a workstream continues from an old document:

1. Preserve the old document unchanged unless the owner explicitly asks for cleanup.
2. Create a new current state card using the v0.4.5 template.
3. Copy only currently verified facts into the active template.
4. Reference old material in the evidence index with freshness and verification status.
5. Avoid appending old documents verbatim below the new active handoff.

This prevents template adoption from falsifying history while still giving future Leaders a compact current entry point.

## Safety

The change is documentation-only. It should not add runtime state stores, automation, external tools, or hidden authorization paths.
