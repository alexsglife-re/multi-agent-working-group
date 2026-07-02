## Context

v0.4.6 introduced rollover thresholds based on observed compression or summary
counts. v0.4.7 real use showed the weakness of that signal: the Leader may see
only one platform summary even when the Owner knows that many compressions
actually occurred. The current protocol also has safe rollover boundaries, but
does not make those boundaries a first-class early opportunity state.

The design keeps rollover documentation-only. It updates rules, templates,
examples, and validation. It does not add automation, runtime dashboards,
automatic successor threads, automatic agent spawning, or authorization
inheritance.

## Goals / Non-Goals

**Goals:**

- Add `Rollover Opportunity` as an early, non-mandatory state.
- Keep exactly one canonical ContextBudget state per check.
- Make compression count value/source/confidence explicit and weak by default.
- Define opportunity scenarios that trigger earlier than existing
  count-threshold recommendations.
- Preserve normal same-workstream commit/push/CI/archive automation when
  PM/Advisor and existing gates pass.
- Strengthen successor authorization boundaries.
- Add Leader delegation discipline to avoid hidden Worker execution for
  Medium, Complex, High-risk, or substantive Worker-suitable implementation
  work.

**Non-Goals:**

- No automatic successor conversation creation.
- No automatic agent spawning.
- No dashboard runtime or board UI.
- No copied ClawTeam/OpenClaw code or runtime behavior.
- No new release/tag/deployment behavior.
- No weakening of PM/Advisor, Reviewer, validation, secret-scan, git, CI, or
  archive gates.

## Decisions

### Decision: Single canonical state

Each context-budget check records exactly one canonical state. The state order
is:

```text
Normal
Soft Warning
Rollover Opportunity
ContextBudget Watch
Rollover Recommended
Rollover Strongly Recommended
Rollover Required
```

When multiple triggers apply, the highest applicable state wins. This avoids a
separate compression-count track, dashboard track, and gate-risk track.

### Decision: Compression counts are weak evidence

The old `observed count + count confidence` shape is replaced with:

```text
Compression count value:
Compression count source: platform-visible | owner-reported | inferred | unknown
Compression count confidence: high | medium | low | unknown
```

Platform-visible summaries are only evidence of what the Leader can see. They
must not be described as the actual total compaction count unless
independently verified or Owner-reported.

### Decision: Opportunity requires a boundary plus a heavier next step

`Rollover Opportunity` is not a recommendation to immediately switch. It means
the Leader has reached a good boundary and the next step is more expensive,
longer, or harder to recover from. The default action is to refresh the
current-state card and evidence index, and to update only a lightweight
successor packet skeleton when useful. A complete successor packet is reserved
for `Rollover Recommended` or higher, or when the Owner explicitly requests
handoff.

### Decision: Dashboards are evidence, not state machines

The existing task status dashboard, pending messages, conflicts, overlaps,
gate state, role continuity, and evidence index remain fields in compact
handoff and successor packets. They are inputs to canonical state selection,
not a parallel board state machine.

### Decision: Historical gate state is not successor authorization

Successor packets may record that a prior Leader passed a commit, push, CI, or
archive gate. That is historical evidence only. A successor Leader must
re-verify current Owner instruction, git state, OpenSpec state, validation
freshness, PM/Advisor/Reviewer continuity, unresolved P0/P1, and current
authorization before continuing.

### Decision: Leader should not be a hidden Worker

For Medium, Complex, High-risk, implementation-heavy, or substantive
Worker-suitable work, the Leader should dispatch bounded Worker slices when
practical. Leader direct work remains appropriate for orchestration,
synthesis, verification, owner communication, small low-risk work, tiny
connective edits, and narrow documentation synchronization where dispatch
overhead would exceed the work.

## Risks / Trade-offs

- **Risk: Over-triggering handoff at every clean stage boundary.** Mitigation:
  `Rollover Opportunity` requires a clean boundary plus a heavier next step.
- **Risk: State drift from multiple parallel state vocabularies.** Mitigation:
  exactly one canonical ContextBudget state per check; dashboards are evidence
  inputs only.
- **Risk: Successor misreads historical gate status as authorization.**
  Mitigation: templates and validation state that historical gate status is
  evidence only and successor execution requires fresh verification.
- **Risk: Template bloat.** Mitigation: reuse existing compact handoff and
  successor packet fields; Opportunity refreshes current state and evidence
  first, with complete successor packet generation reserved for Recommended+
  states or explicit Owner handoff requests.
- **Risk: Worker dispatch overhead for tiny tasks.** Mitigation: allow Leader
  direct execution for small low-risk tasks and tiny integration edits.
