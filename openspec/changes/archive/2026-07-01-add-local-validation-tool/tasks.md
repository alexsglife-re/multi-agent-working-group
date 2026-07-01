# Tasks

## OpenSpec

- [x] Create proposal, design, tasks, and spec delta for the local validation tool.
- [x] Validate the OpenSpec change.
- [x] Archive the change after implementation and validation.

## Implementation

- [x] Add `scripts/validate-local.sh`.
- [x] Keep the command read-only, no-network, and locally runnable.
- [x] Support `--require-no-active-changes` and `--skip-global-skill`.
- [x] Check `SKILL.md` frontmatter, version markers, OpenSpec health, accepted spec files, and optional global skill sync.

## Documentation

- [x] Update README usage and repository layout.
- [x] Update changelog, roadmap, TODO, and validation docs for `v0.4.4`.
- [x] Update `SKILL.md` to reference the local validation command without weakening gates.

## Verification

- [x] Run the local validation command during the active change.
- [x] Run `openspec validate add-local-validation-tool --strict`.
- [x] Run `openspec validate --all`.
- [x] After archive, run the local validation command with `--require-no-active-changes`.
