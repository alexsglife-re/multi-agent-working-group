## 1. Proposal Gate

- [x] Confirm PM and Advisor reviewed the v0.4.13 scope.
- [x] Confirm proposal frames cleanup discipline as the net-new capability.
- [x] Confirm Leader work-budget numeric thresholds are guidance/self-check triggers, not automatic failures.
- [x] Confirm cleanup failure non-blocking language cannot weaken validation, PM/Advisor/Reviewer, git, CI/status, secret-scan, release, or authorization gates.
- [x] Run `openspec validate --all`.

## 2. Skill And Reference Updates

- [x] Update `SKILL.md` hard-boundary summary with sequential cleanup, cleanup failure boundaries, Leader work budget, and Worker-first context-control anchors.
- [x] Update `references/role-templates-and-output.md` with cleanup status reporting, sequential close rules, and bounded Worker prompt/return details.
- [x] Update `references/context-rollover.md` with Worker-first context-control guidance before rollover pressure rises.
- [x] Update `references/TRACEABILITY.md` with v0.4.13 hard-boundary mappings.

## 3. Template Updates

- [x] Add cleanup status fields to closeout or handoff templates that carry final workstream state.
- [x] Update Worker assignment and return templates if needed for budget-triggered Worker dispatch and evidence requirements.
- [x] Confirm templates remain evidence only and do not authorize cleanup, commit, push, release, or gate bypass.

## 4. Validation And Docs

- [x] Update `scripts/validate-local.sh` with v0.4.13 cleanup and delegation anchors.
- [x] Update `docs/VALIDATION.md` to state anchor checks do not prove runtime compliance.
- [x] Update README, CHANGELOG, docs/TODO, and docs/ROADMAP for v0.4.13.
- [x] Confirm public docs do not imply new automation, automatic spawning, or new release/git authorization.

## 5. Verification

- [x] Run `./scripts/validate-local.sh --skip-global-skill` during active implementation.
- [x] Run `openspec validate --all`.
- [x] Run `git diff --check`.
- [x] Run representative checks for sequential cleanup, cleanup non-blocking boundaries, cleanup escalation, cleanup status fields, Leader budget trigger, and Worker-first context control.
- [x] Get PM and Advisor confirmation that existing fail-closed gates are not weakened.

## 6. Closeout

- [x] Archive the OpenSpec change.
- [x] Run `./scripts/validate-local.sh --require-no-active-changes`.
- [x] Run `openspec validate --all`.
- [x] Sync installed global skill files when ready.
- [x] Complete commit/push gates if the Owner requests publication of the implementation.
