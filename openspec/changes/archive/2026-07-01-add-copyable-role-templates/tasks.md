# Tasks

## OpenSpec

- [x] Create proposal, design, tasks, and spec delta.
- [x] Validate the OpenSpec change.
- [x] Archive the change after implementation and validation.

## Templates

- [x] Add `templates/README.md` with use rules and legacy document handling.
- [x] Add C0, PM, Advisor, Worker assignment, Worker return, Reviewer, blocked, compact handoff, and git gate templates.
- [x] Ensure templates preserve validation freshness, unresolved P0/P1, evidence references, and authorization state.
- [x] Ensure templates do not imply automatic commit, push, release, deployment, publication, or secret access.

## Documentation

- [x] Update README repository layout and version state.
- [x] Update changelog, roadmap, TODO, and validation docs for `v0.4.5`.
- [x] Update `SKILL.md` to mention templates and legacy document handling without weakening gates.
- [x] Update local validation script for `v0.4.5` markers and the accepted template spec.

## Verification

- [x] Run local validation during the active change.
- [x] Run `openspec validate add-copyable-role-templates --strict`.
- [x] Run `openspec validate --all`.
- [x] After archive, run local validation with `--require-no-active-changes`.
