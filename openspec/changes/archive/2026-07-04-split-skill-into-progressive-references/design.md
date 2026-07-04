## Context

`SKILL.md` currently contains the complete protocol in one file. That makes the
skill self-contained, but it also means every invocation has to load long
sections that are not needed for every task. The file is about 920 lines and
53 KB, and Codex often needs two reads to load it completely.

PM and Advisor review identified a real weakening risk: if hard constraints are
moved out of `SKILL.md`, an agent can miss them before it decides whether to
read a reference. Therefore the restructure must preserve a fail-closed router
in `SKILL.md`, not convert it into a directory.

## Goals / Non-Goals

**Goals:**

- Reduce ordinary startup/read burden by moving long-form details into
  progressive references.
- Preserve all existing skill capabilities, constraints, and gates.
- Keep `SKILL.md` self-sufficient for hard stops, default exclusions, and
  mandatory reference routing.
- Make reference reads mandatory for affected domains before acting.
- Strengthen validation so the refactor cannot pass by moving hard-boundary
  checks out of `SKILL.md`.

**Non-Goals:**

- Do not change workflow semantics, risk classification, PM/Advisor
  requirements, git gates, OpenSpec lifecycle, default exclusions, or
  authorization rules.
- Do not add automation, CI, packaging, runtime orchestration, release
  automation, or automatic role spawning.
- Do not make the line-count target a hard requirement.
- Do not publish another release as part of the structure change unless the
  Owner explicitly authorizes that later.

## Decisions

### Decision: `SKILL.md` remains the fail-closed authority

`SKILL.md` will keep all hard-boundary summaries needed to stop unsafe action
even when no reference has been read. References may expand details, but they
may not be the only place where a hard stop or default exclusion appears.
This includes PM/Advisor independent first-pass and no-peek review, Advisor
output as unverified evidence rather than authority, and handoff or other agent
output as evidence rather than authorization.

Alternative considered: make `SKILL.md` a short index. Rejected because it
reduces constraints when a reference read is skipped.

### Decision: Preserve the current `SKILL.md` validation anchor set

The existing `template_contains "SKILL.md"` assertions in
`scripts/validate-local.sh` are treated as the current hard-boundary anchor set.
The refactor may add anchors, but must not reduce the count, delete current
anchor phrases from `SKILL.md`, or silently repoint those checks to reference
files. Count preservation alone is insufficient: each current anchor phrase
must remain individually checked against `SKILL.md`.

Alternative considered: move detailed checks to reference files. Rejected for
hard-boundary anchors because that can produce green validation while weakening
the always-loaded router.

### Decision: References are progressive expansions

References will be scoped by capability domain. A candidate structure is:

- `references/git-exit-rules.md`
- `references/openspec-lifecycle.md`
- `references/context-rollover.md`
- `references/role-templates-and-output.md`
- `references/cli-trust.md`

This file set may be adjusted during implementation if PM/Advisor determine a
smaller set better preserves routing clarity and read burden. Each reference
must begin by stating that it extends `SKILL.md` and does not reduce any
constraint in `SKILL.md`.
Validation and routing checks key to domains, not filenames, so consolidating
or renaming reference files cannot drop a domain below a mandatory read floor.

### Decision: Line-count target is advisory

The rough target for `SKILL.md` is 300-450 lines, but safety wins over size. If
preserving the hard-boundary summary requires more lines, the refactor must keep
the lines.

### Decision: Representative scenario validation is required

Implementation closeout must validate representative scenarios against the new
structure:

- commit/push gate
- tag/release/default-exclusion gate
- OpenSpec-backed work
- Small Task Mode reaching a git gate
- handoff/rollover
- CLI workspace trust
- missing Advisor or PM in medium/complex/high-risk/commit-bound work

These scenarios can be checked through local validation markers, documentation
inspection, and PM/Advisor review. The key requirement is that each scenario
still reaches the same stop or gate as before.

## Risks / Trade-offs

- **Risk: validation re-pointing weakens `SKILL.md`.** Mitigation: require the
  current `SKILL.md` anchor set to remain individually anchored to `SKILL.md`.
- **Risk: unanchored hard-boundary prose is thinned without validation failing.**
  Mitigation: require a traceability map and add new `SKILL.md` validation
  anchors for any newly summarized hard boundary that is not covered by the
  current anchor set.
- **Risk: references increase total read burden for multi-domain tasks.**
  Mitigation: keep routing clear and allow fewer, larger references if that is
  simpler than many thin files.
- **Risk: line-count pressure removes constraints.** Mitigation: declare line
  count advisory and non-blocking; capability preservation is the blocking
  criterion.
- **Risk: agents skip references.** Mitigation: keep hard stops in `SKILL.md`
  and make reference reads mandatory before acting in affected domains.
- **Risk: docs and installed skill drift.** Mitigation: update docs and run full
  validation including installed global skill sync when implementation is
  ready.
