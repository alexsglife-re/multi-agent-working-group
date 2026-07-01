# Tasks

## OpenSpec

- [x] Create proposal, design, tasks, and spec deltas.
- [x] Validate the OpenSpec change.
- [x] Archive the change after implementation and validation.

## Skill Rules

- [x] Update `SKILL.md` for `v0.4.6` Leader Rollover Protocol.
- [x] Add context-budget fields and non-overlapping compression/summary thresholds.
- [x] Add `Rollover Strongly Recommended` and clarify highest-state-wins behavior.
- [x] Define sealed-ready behavior when rollover is required before Worker dispatch, commit, push, CI, archive, or high-risk gates.
- [x] Clarify that v0.4.6 automatically detects rollover conditions and prepares handoff evidence, but does not automatically create a successor conversation.

## Templates And Examples

- [x] Add `templates/successor-startup-packet.md`.
- [x] Update `templates/compact-handoff.md` with context-budget and rollover fields.
- [x] Update `templates/README.md` to include the successor packet template and rollover safety rules.
- [x] Update examples so rollover handoff remains compact and evidence-based.

## Documentation And Validation

- [x] Update README repository layout and current version.
- [x] Update changelog, roadmap, TODO, and validation docs for `v0.4.6`.
- [x] Update local validation to check `v0.4.6` markers, accepted rollover spec, and successor packet template.
- [x] Sync the updated `SKILL.md` to the global installed skill.

## Verification

- [x] Run local validation during the active change.
- [x] Run `openspec validate add-leader-rollover-protocol --strict`.
- [x] Run `openspec validate --all`.
- [x] After archive, run local validation with `--require-no-active-changes`.
