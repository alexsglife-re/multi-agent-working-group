## 1. Core Lifecycle Rules

- [x] 1.1 Replace fresh-per-checkpoint guidance in `references/review-context-efficiency.md` with one persistent PM and one persistent Advisor lifecycle per OpenSpec C-stage, plus default cross-stage restart.
- [x] 1.2 Update `SKILL.md`, `references/openspec-lifecycle.md`, and `references/role-templates-and-output.md` so same-stage continuity remains distinct from checkpoint decision freshness and sequential role cleanup.
- [x] 1.3 Define and consistently use Stage Session ID, C-stage, inherited-context flag, fresh-decision flag, no-peek state, restart reason, and transition-only lifecycle decision actor/time, with actor `leader|owner` identifying the decision maker.
- [x] 1.4 Define mandatory restart triggers for context reliability loss or pressure, independence contamination, provider/model/tool change, trust loss, unresolved state ambiguity, failed recovery, and Owner instruction.
- [x] 1.5 Preserve fresh short-lived sessions for distinct non-OpenSpec checkpoints, with unchanged-target clarification and no-provider-substitution boundaries.
- [x] 1.6 Define C0 as short-lived bootstrap whose role sessions close or restart before C1 without carrying C0 decisions or authorization.
- [x] 1.7 Ground Stage Session ID in exact Runtime Session ID/source/resume evidence; require a new Stage Session ID for `--no-session-persistence`, unproven process restart, or unavailable persistence, and allow Claude continuation only through exact `--resume <session-id>`.
- [x] 1.8 Make `role-review-context-efficiency` the canonical restart-trigger owner and have CLI-trust guidance reference it while adding provider and trust evidence.

## 2. Templates And Examples

- [x] 2.1 Extend PM, Advisor, factual-manifest, invocation-record, C0, git-gate, handoff, and successor templates with Stage Session ID, Runtime Session ID/source/resume evidence, canonical lifecycle/checkpoint values, and an explicit transition-only section for lifecycle decision actor and ISO-8601 decision time where applicable; routine same-stage records omit that section.
- [x] 2.2 Update template guidance to state that same-stage agents may retain verified context and their own prior reasoning but never inherit old `GO`, validation freshness, git/archive authorization, or the other role's current first-pass conclusion.
- [x] 2.3 Update the context-efficient review example to demonstrate multiple checkpoints under one Stage Session ID, a cross-stage restart, and a mandatory same-stage restart.
- [x] 2.4 Keep packet-retention and cleanup examples aligned by using `C-stage` for role lifecycle and `packet lifecycle checkpoint` for retention, without adding automatic deletion or changing cleanup authorization.

## 3. Documentation And Migration

- [x] 3.1 Update README and role-review documentation to explain the stage-scoped lifecycle and checkpoint-scoped fresh-decision model in plain language.
- [x] 3.2 Update roadmap, TODO, validation, adapters, installation, and traceability documentation only where existing lifecycle anchors require alignment.
- [x] 3.3 Remove or supersede contradictory fresh-session-per-checkpoint wording while preserving historical archived OpenSpec evidence.
- [x] 3.4 Keep the current public and development version markers unchanged and make no adapter maturity, tag, release, publication, or deployment claim.

## 4. Deterministic Validation

- [x] 4.1 Add positive validator coverage for same-stage Stage Session ID continuity with new Review IDs, target fingerprints, fresh decision/validation/authorization states, and no-peek isolation.
- [x] 4.2 Add negative validator cases for cross-stage lifecycle reuse, inherited old decisions or authorization, missing lifecycle fields or runtime identity, missing lifecycle decision actor, missing or timezone-free lifecycle decision time, false intact continuity, ambiguous Claude `--continue`, blind restart while an old attempt may still run, current-first-pass contamination, and ignored mandatory restart triggers.
- [x] 4.3 Run shell syntax checks, local validation with the active change, strict OpenSpec validation, diff checks, English-only checks, and secret-pattern scans.
- [x] 4.4 Add positive validator fixtures showing actor and ISO-8601 decision time for normal cross-stage close/restart, early restart/close, C0 close, and degraded or unavailable continuity transitions, and showing their absence from routine same-stage invocation records.

## 5. Review And Closeout Preparation

- [x] 5.1 Obtain independent PM, Advisor, and required Reviewer assessment of the implemented lifecycle semantics with no unresolved P0/P1.
- [x] 5.2 Verify all task checkboxes, accepted-spec sync readiness, archive readiness, and that no version number changed before requesting any git or archive gate.
