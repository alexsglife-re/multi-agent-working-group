## 1. Specification and docs

- [x] Update `SKILL.md` model-diversity and PM/Advisor separation language for provider-level separation.
- [x] Update README/CHANGELOG/TODO/ROADMAP/VALIDATION version markers and summaries for v0.4.9.
- [ ] Update accepted specs after implementation or during archive sync.

## 2. Templates

- [x] Update C0, compact handoff, and successor startup templates with provider/model-per-role, model source, separation status, and verification fields.
- [x] Keep PM/Advisor review templates minimal unless a state field is needed.

## 3. Validation

- [x] Add local validation checks for provider-level separation, same-provider degradation, hint-to-verify model memory, current verified model records, and template fields.
- [x] Run `openspec validate --all`.
- [x] Run `./scripts/validate-local.sh`.
