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
- [x] Confirm `SKILL.md` still keeps high-risk and default-exclusion actions behind explicit Owner approval.
- [x] Verify that Reviewer remains conditional for documentation tasks and required for code or higher-risk gates as defined by the skill.

### Validation

- [x] Update `docs/VALIDATION.md` for `v0.4.0` stabilization checks.
- [x] Check that examples do not imply commit or push authorization outside the applicable git gates.
- [x] Check that examples do not require Reviewer for small low-risk tasks.
- [x] Check that medium examples do not allow Leader to perform hidden Worker execution.
- [x] Check that `README.md`, `ROADMAP.md`, `docs/ROLE_BOUNDARIES.md`, examples, and `SKILL.md` remain consistent.
- [x] Confirm project docs remain English-only.

### Roadmap And Release Readiness

- [x] Update `docs/ROADMAP.md` to mark Stage 1 as mostly complete.
- [x] Update `docs/ROADMAP.md` to show Stage 2 as the `v0.4.0` focus.
- [x] Keep lightweight validation tooling, CI, packaging, and automation out of scope unless explicitly approved.
- [x] Run a final manual review before entering the applicable commit gate.

## Later

- [ ] Add lightweight local validation tooling.
- [ ] Add installation and packaging guidance.
- [ ] Add license and public reuse decision if this becomes a reusable public skill package.
- [ ] Consider CI only after the manual workflow is stable.
