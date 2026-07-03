## 1. Specification and docs

- [x] Update `SKILL.md` with skill invocation triggers and automatic-invocation boundaries.
- [x] Update `SKILL.md` final output requirements with plain-language completion summary and next-goal recommendation requirements.
- [x] Update README/CHANGELOG/TODO/ROADMAP/VALIDATION version markers and summaries for v0.4.10.
- [x] Update `docs/INSTALLATION.md` with a practical migration/adoption checklist.
- [x] Update accepted specs after implementation or during archive sync.

## 2. Templates and examples

- [x] Update state-carrying templates with completion summary and next-goal recommendation fields.
- [x] Add or update an example showing when to use this skill and when Small Task Mode is enough.
- [x] Preserve v0.4.9 provider separation, model-source verification, PM/Advisor patience, and substantive Worker patience guidance.

## 3. Validation

- [x] Add local validation checks for v0.4.10 invocation, migration, and closeout markers.
- [x] Run `openspec validate --all`.
- [x] Run `./scripts/validate-local.sh`.
- [x] After archive, run `./scripts/validate-local.sh --require-no-active-changes`.
