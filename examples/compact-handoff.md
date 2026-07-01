# Example: Compact Leader Handoff

This example shows how a Leader keeps handoff state compact during long-running or OpenSpec-backed work. The active handoff is a current state card plus evidence references, not an append-only transcript.

## Scenario

A workstream has gone through C0, C1, and part of C2. The old handoff file contains long PM/Advisor notes, validation output, and repeated summaries from earlier stages. Before a context rollover, the Leader refreshes the handoff.

## Current State Card

```text
Date/time:
  2026-07-01 15:20 America/Los_Angeles

Current goal:
  Add Leader state compaction rules to multi-agent-working-group.

Owner instruction:
  Complete the approved v0.4.3 Leader state compaction plan.

Stage:
  C2 implementation/verification.

Archive requirement:
  C4 archive is required before the OpenSpec-backed goal is complete.

Gate state:
  C2 validation gate in progress; commit/push gates not entered.

Context budget:
  State: ContextBudget Watch.
  Observed compression/summary count: 3.
  Count confidence: inferred.
  Last context-budget check: 2026-07-01 15:20 America/Los_Angeles.
  Trigger category: threshold.
  Reason: long C2 workstream with repeated summarized evidence.
  Next safe rollover boundary: after C2 validation and review.
  Rollover action: organize evidence index; no proactive rollover yet.

Sealed-ready state:
  not entered.
  Frozen active current-state card: this compact handoff.
  Frozen scope: none.
  Unconsumed Worker returns: none.

Scope:
  SKILL.md, docs/VALIDATION.md, README.md, CHANGELOG.md, docs/TODO.md,
  docs/ROADMAP.md, examples/compact-handoff.md, and the OpenSpec change.

Non-goals:
  No automation, no runtime state store, no reference-project code adoption,
  no release/tag/deployment.

PM/Advisor continuity:
  PM: PM-1, intact, GPT-5.5.
  Advisor: Advisor-1, intact, different model from PM.

Reviewer continuity:
  Reviewer: not required for this documentation-only phase.

Unresolved P0/P1:
  None known.

Validation:
  openspec validate add-leader-state-compaction --strict passed at 15:05.
  openspec validate --all still required after implementation.

Changed and do-not-touch files:
  Changed: docs and OpenSpec artifacts listed in scope.
  Do not touch: reference checkout files under references/external.

Next action:
  Finish documentation edits, run validation, complete PM/Advisor review.

Task status dashboard:
  Pending:
    - Full validation.
    - PM/Advisor review.
  In progress:
    - Documentation edits.
  Completed:
    - Proposal and design drafting.
  Blocked:
    - none.

Pending messages, conflicts, and overlaps:
  Pending messages:
    - none.
  Conflicts:
    - none.
  Overlaps:
    - none.

Commit/push authorization state:
  No commit or push yet. Normal gate may be evaluated only after review and validation.

Stop conditions:
  Failed validation, unresolved P0/P1, missing required Advisor evidence,
  high-risk/default-exclusion action, or Owner decision need.
```

## Evidence Index

```text
Claim:
  The change is OpenSpec-backed and apply-ready.
Evidence type:
  OpenSpec artifacts.
Evidence location:
  openspec/changes/add-leader-state-compaction/proposal.md
  openspec/changes/add-leader-state-compaction/design.md
  openspec/changes/add-leader-state-compaction/tasks.md
  openspec/changes/add-leader-state-compaction/specs/leader-state-compaction/spec.md
Freshness/status:
  Current as of C2 start.
Leader verification:
  Verified by openspec status and change validation.

Claim:
  Initial change validation passed.
Evidence type:
  Command result.
Evidence location:
  Command: openspec validate add-leader-state-compaction --strict
Freshness/status:
  Current before implementation; must rerun after edits.
Leader verification:
  Verified by Leader.

Claim:
  Reference projects support layered state as rule-level inspiration only.
Evidence type:
  Local reference notes and read-only source inspection.
Evidence location:
  docs/REFERENCE_NOTES.md
  references/external/HKUDS-ClawTeam/clawteam/team/models.py
  references/external/HKUDS-ClawTeam/clawteam/team/plan.py
  references/external/HKUDS-ClawTeam/clawteam/workspace/context.py
  references/external/win4r-ClawTeam-OpenClaw/clawteam/board/collector.py
Freshness/status:
  Historical reference evidence, not a current project state source.
Leader verification:
  Verified as rule-level inspiration only.

Claim:
  Prior C1 handoff said "proposal ready, implement next".
Evidence type:
  Prior handoff.
Evidence location:
  archive-notes/2026-07-01-c1-old-handoff.md
Freshness/status:
  Stale until re-verified against current files.
Leader verification:
  Evidence value only; not current authorization.
```

## Historical Archive Note

```text
Archive note:
  The old C1 handoff said "proposal ready, implement next".

Current verification:
  Proposal/design/spec/tasks exist.
  Change validation passed before implementation.
  This does not authorize commit or push.

Reason archived:
  The old note is useful history, but the active handoff now carries the current
  verified state. Keeping the old text inline would duplicate stale context.
```

## What Not To Do

Do not append the old handoff below the new one:

```text
Current state...

Previous handoff...

Previous previous handoff...

Long validation output...

Full Advisor transcript...
```

That pattern makes takeover harder. Keep the current state short, preserve the evidence pointer, and require the next Leader to re-verify current git, OpenSpec, validation, and role state.

## Successor Packet Reminder

If this workstream reaches `Rollover Required`, create a single active
successor startup packet instead of appending another long handoff. The packet
is evidence for a future Leader, not automatic successor thread creation and
not authorization for commit, push, CI, archive, or external effects.
