## 1. Proposal Gate

- [x] Confirm proposal states v0.4.12 is structure-only and behavior-frozen.
- [x] Confirm proposal/design include PM and Advisor P0/P1 constraints: no capability reduction, no constraint reduction, no validation re-pointing of hard anchors out of `SKILL.md`.
- [x] Confirm proposal/design/spec explicitly preserve PM/Advisor independence, no-peek review, Advisor evidence-not-authority, and handoff or agent output evidence-not-authorization in `SKILL.md`.
- [x] Get PM and Advisor approval of proposal/design/spec before implementation.

## 2. Traceability

- [x] Create a hard-boundary traceability map for the current `SKILL.md` sections and validation anchors.
- [x] Mark each item as `stays in SKILL.md summary`, `moves to reference detail`, or `both`.
- [x] Confirm every existing `template_contains "SKILL.md"` hard-boundary phrase remains checked against `SKILL.md`.
- [x] Confirm each current `template_contains "SKILL.md"` phrase is checked individually, not only by total count.
- [x] Add new `SKILL.md` validation anchors for any newly summarized hard boundary not covered by the current anchor set.

## 3. Progressive Reference Implementation

- [x] Add reference files for the selected domains.
- [x] Ensure each reference states that it extends `SKILL.md`, cannot weaken `SKILL.md`, and grants no authorization by itself.
- [x] Refactor `SKILL.md` into an authoritative router plus hard-boundary summary.
- [x] Add deterministic mandatory MUST-read routing statements in `SKILL.md` for each domain, keyed to domain responsibility rather than only to reference filenames.
- [x] Keep hard stops, default exclusions, PM/Advisor gates, fail-closed rules, OpenSpec C0-C4, handoff/rollover non-inheritance, and output requirements in `SKILL.md` summary form.

## 4. Documentation And Validation

- [x] Update README, CHANGELOG, docs/TODO, docs/ROADMAP, and docs/VALIDATION for v0.4.12.
- [x] Update `scripts/validate-local.sh` to check `SKILL.md` anchors, references, routing statements, and representative scenarios.
- [x] Update validation so each current `SKILL.md` anchor phrase remains individually checked against `SKILL.md`.
- [x] Ensure validation still checks global installed skill sync when not skipped.

## 5. Verification

- [x] Run `./scripts/validate-local.sh --skip-global-skill` during active implementation.
- [x] Run `openspec validate --all`.
- [x] Run `git diff --check`.
- [x] Review representative scenarios: commit/push, tag/release/default exclusions, OpenSpec-backed work, Small Task Mode at git gates, handoff/rollover, CLI trust, and missing PM/Advisor fail-closed behavior.
- [x] Get PM and Advisor confirmation that capability and constraints did not decrease.

## 6. Closeout

- [x] Archive the OpenSpec change.
- [x] Run `./scripts/validate-local.sh --require-no-active-changes`.
- [x] Run `openspec validate --all`.
- [x] Run staged/outgoing secret scan before push.
- [ ] Commit with the required four-section message.
- [ ] Push after PM and Advisor gates pass.
- [ ] Check CI/status or record that no CI exists.
- [ ] Complete post-push PM and Advisor review.
