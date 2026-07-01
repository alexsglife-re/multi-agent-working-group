# TODO

This file tracks near-term project work. It is a planning aid, not an authorization record. Commit, push, release, deployment, and external publication still require the gates described in `SKILL.md`.

## v0.4.0: Role Boundary And Operating Examples Stabilization

Goal: stabilize the documentation-first workflow around role boundaries, Leader direct execution, Worker delegation, blocked-state reporting, and git gates before adding automation.

### Version Metadata

- [x] Add `CHANGELOG.md`.
- [x] Add a `v0.4.0` changelog entry for role boundaries, examples, and validation docs.
- [x] Add a visible current-version note to `README.md`.
- [x] Confirm whether any agent metadata should carry the version number.

### Examples

- [x] Add small low-risk documentation task example.
- [x] Add blocked task example.
- [x] Add medium Worker delegation example.
- [x] Add commit gate example.
- [x] Add push gate example.
- [x] Add handoff or continuity recovery example.
- [x] Review examples for consistent wording around Advisor, Reviewer, Worker, Leader, Owner authorization, Small Task Mode, and the normal git gate rule.

### Role Boundary Promotion

- [x] Review `docs/ROLE_BOUNDARIES.md` and identify only the shortest stable rules to promote.
- [x] Update `SKILL.md` to clarify that Small Task Mode uses no PM, Worker, or Reviewer.
- [x] Update `SKILL.md` to clarify that Leader direct execution must be narrow, explicit, and low-risk.
- [x] Update `SKILL.md` to clarify that medium or higher work must not become hidden Worker execution by Leader.
- [x] Align `SKILL.md` normal non-high-risk commit and push wording with the PM plus Advisor gate.
- [x] Clarify that a normal push to `main` is allowed by the normal PM plus Advisor gate when all requirements pass and no protected-branch bypass or exception is needed.
- [x] Confirm `SKILL.md` still keeps high-risk and default-exclusion actions behind explicit Owner approval.
- [x] Verify that Reviewer remains conditional for documentation tasks and required for code or higher-risk gates as defined by the skill.

### Validation

- [x] Update `docs/VALIDATION.md` for `v0.4.0` stabilization checks.
- [x] Check that examples do not imply commit or push authorization outside the applicable git gates.
- [x] Check that push-gate examples distinguish normal `origin/main` push from Owner-only protected-branch bypass or exception actions.
- [x] Check that examples do not require Reviewer for small low-risk tasks.
- [x] Check that medium examples do not allow Leader to perform hidden Worker execution.
- [x] Check that `README.md`, `ROADMAP.md`, `docs/ROLE_BOUNDARIES.md`, examples, and `SKILL.md` remain consistent.
- [x] Confirm project docs remain English-only.

### Roadmap And Release Readiness

- [x] Update `docs/ROADMAP.md` to mark Stage 1 as mostly complete.
- [x] Update `docs/ROADMAP.md` to show Stage 2 as the `v0.4.0` focus.
- [x] Keep lightweight validation tooling, CI, packaging, and automation out of scope unless explicitly approved.
- [x] Run a final manual review before entering the applicable commit gate.

## v0.4.1: Advisor Model Diversity

Goal: make Advisor independence stronger by defaulting Advisor to a different AI model when available, while preserving bounded context, explicit Owner overrides, and existing review gates.

### OpenSpec

- [x] Create `add-advisor-model-diversity` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate the OpenSpec change.

### Skill Rules

- [x] Add Advisor model-diversity defaults to `SKILL.md`.
- [x] Require Leader to ask for Advisor model/provider when no project, session, continuity, or handoff record exists.
- [x] Record Advisor model/provider, diversity status, same-model override, and degradation reason in startup/handoff context.
- [x] Preserve minimum-necessary Advisor context, no-peek independence, Leader verification, and existing failure rules.

### Documentation And Validation

- [x] Update README, changelog, roadmap, and validation docs for v0.4.1.
- [x] Confirm same-model Advisor use is allowed only by explicit Owner request and is recorded as an override.
- [x] Confirm single-model environments are recorded as degradation rather than silently treated as model diversity.
- [x] Confirm model diversity is not described as a correctness guarantee or gate bypass.

## v0.4.2: CLI Trust And OpenSpec Lifecycle Closure

Goal: make CLI-based role agents, trusted Advisor context, PM/Advisor model separation, goal completion, and OpenSpec C0-C4 closure explicit before adding any automation.

### OpenSpec

- [x] Create `add-cli-trust-and-openspec-c0-lifecycle` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate and archive the OpenSpec change after implementation and git closeout.

### Skill Rules

- [x] Add CLI agent workspace-trust preflight rules to `SKILL.md`.
- [x] Clarify that an Owner-specified Advisor is a trusted bounded collaboration role, not an ordinary third-party service.
- [x] Require PM and Advisor to default to different AI models when model selection is available.
- [x] Block silent PM/Advisor same-model degradation unless the Owner explicitly approves and the override is recorded.
- [x] Define Owner goal completion as including applicable validation, commit, push, status review, post-result review, and OpenSpec archive.
- [x] Add OpenSpec C0 goal/task analysis before C1 proposal work when this skill and OpenSpec are used together.

### Documentation And Validation

- [x] Update README, changelog, roadmap, TODO, and validation docs for v0.4.2.
- [x] Add an OpenSpec C0-C4 lifecycle example.
- [x] Sync the updated `SKILL.md` to the global installed skill.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before commit, after commit, before push, and after push.

## v0.4.3: Leader State Compaction

Goal: keep Leader handoff and continuity documents compact by separating current state, evidence references, and archived history before adding automation.

### OpenSpec

- [x] Create `add-leader-state-compaction` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Skill Rules

- [x] Add the three-layer current state card, evidence index, and historical archive notes model to `SKILL.md`.
- [x] Require active handoff or ledger updates to be refreshed instead of append-only when context bloat is visible.
- [x] Preserve unresolved P0/P1, PM/Advisor findings, validation freshness, stop conditions, and git authorization state during compaction.

### Documentation And Validation

- [x] Add compact handoff example.
- [x] Update README, changelog, roadmap, TODO, and validation docs for v0.4.3.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## v0.4.4: Lightweight Local Validation Tooling

Goal: make the repeated README, SKILL, OpenSpec, version-marker, and installed-skill sync checks runnable through one local read-only command.

### OpenSpec

- [x] Create `add-local-validation-tool` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Local Tooling

- [x] Add `scripts/validate-local.sh`.
- [x] Keep the command read-only and no-network.
- [x] Support normal active-change validation and closeout validation requiring no active OpenSpec changes.
- [x] Check `SKILL.md` frontmatter, current version markers, accepted OpenSpec specs, OpenSpec validation, and installed global skill sync.

### Documentation And Validation

- [x] Update README, changelog, roadmap, TODO, validation docs, and `SKILL.md` for v0.4.4.
- [x] Run the local validation command.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## v0.4.5: Copyable Role Templates

Goal: make common PM, Advisor, Worker, Reviewer, C0, blocked, handoff, and git-gate outputs easy to copy without expanding old handoff documents.

### OpenSpec

- [x] Create `add-copyable-role-templates` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Templates

- [x] Add `templates/README.md`.
- [x] Add C0, PM, Advisor, Worker assignment, Worker return, Reviewer, blocked, compact handoff, and git gate templates.
- [x] Document how to handle legacy v0.3 or bloated handoff documents without rewriting history.
- [x] Confirm templates preserve unresolved P0/P1, validation freshness, evidence references, and authorization state.

### Documentation And Validation

- [x] Update README, changelog, roadmap, TODO, validation docs, and `SKILL.md` for v0.4.5.
- [x] Update local validation for v0.4.5 template checks.
- [x] Run the local validation command.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## Later

- [ ] Add installation and packaging guidance.
- [ ] Add license and public reuse decision if this becomes a reusable public skill package.
- [ ] Consider CI only after the manual workflow is stable.
