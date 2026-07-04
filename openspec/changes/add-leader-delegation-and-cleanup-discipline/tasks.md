## 1. Proposal Gate

- [ ] Confirm PM and Advisor reviewed the v0.4.13 scope.
- [ ] Confirm proposal frames cleanup discipline as the net-new capability.
- [ ] Confirm Leader work-budget numeric thresholds are guidance/self-check triggers, not automatic failures.
- [ ] Confirm cleanup failure non-blocking language cannot weaken validation, PM/Advisor/Reviewer, git, CI/status, secret-scan, release, or authorization gates.
- [ ] Run `openspec validate --all`.

## 2. Skill And Reference Updates

- [ ] Update `SKILL.md` hard-boundary summary with sequential cleanup, cleanup failure boundaries, Leader work budget, and Worker-first context-control anchors.
- [ ] Update `references/role-templates-and-output.md` with cleanup status reporting, sequential close rules, and bounded Worker prompt/return details.
- [ ] Update `references/context-rollover.md` with Worker-first context-control guidance before rollover pressure rises.
- [ ] Update `references/TRACEABILITY.md` with v0.4.13 hard-boundary mappings.

## 3. Template Updates

- [ ] Add cleanup status fields to closeout or handoff templates that carry final workstream state.
- [ ] Update Worker assignment and return templates if needed for budget-triggered Worker dispatch and evidence requirements.
- [ ] Confirm templates remain evidence only and do not authorize cleanup, commit, push, release, or gate bypass.

## 4. Validation And Docs

- [ ] Update `scripts/validate-local.sh` with v0.4.13 cleanup and delegation anchors.
- [ ] Update `docs/VALIDATION.md` to state anchor checks do not prove runtime compliance.
- [ ] Update README, CHANGELOG, docs/TODO, and docs/ROADMAP for v0.4.13.
- [ ] Confirm public docs do not imply new automation, automatic spawning, or new release/git authorization.

## 5. Verification

- [ ] Run `./scripts/validate-local.sh --skip-global-skill` during active implementation.
- [ ] Run `openspec validate --all`.
- [ ] Run `git diff --check`.
- [ ] Run representative checks for sequential cleanup, cleanup non-blocking boundaries, cleanup escalation, cleanup status fields, Leader budget trigger, and Worker-first context control.
- [ ] Get PM and Advisor confirmation that existing fail-closed gates are not weakened.

## 6. Closeout

- [ ] Archive the OpenSpec change.
- [ ] Run `./scripts/validate-local.sh --require-no-active-changes`.
- [ ] Run `openspec validate --all`.
- [ ] Sync installed global skill files when ready.
- [ ] Complete commit/push gates if the Owner requests publication of the implementation.
