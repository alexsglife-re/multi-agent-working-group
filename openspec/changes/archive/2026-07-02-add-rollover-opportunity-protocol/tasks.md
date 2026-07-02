## 1. Spec And Scope Lock

- [x] 1.1 Validate the OpenSpec change artifacts with strict validation.
- [x] 1.2 Resolve PM/Advisor C1 scope findings before implementation.

## 2. Documentation And Skill Rules

- [x] 2.1 Update `SKILL.md` for v0.4.8 `Rollover Opportunity`, single canonical state selection, and compression count value/source/confidence.
- [x] 2.2 Preserve same-workstream PM+Advisor gate automation while clarifying that rollover and successor packets do not inherit authorization.
- [x] 2.3 Add Leader delegation discipline that discourages hidden Worker execution for Medium, Complex, High-risk, implementation-heavy, or substantive Worker-suitable work.
- [x] 2.4 Update README, changelog, roadmap, TODO, and validation documentation for v0.4.8.

## 3. Templates And Examples

- [x] 3.1 Update compact handoff and successor startup packet templates with v0.4.8 fields and Opportunity state.
- [x] 3.2 Add an example covering owner-reported compression undercount and early rollover opportunity preparation.
- [x] 3.3 Ensure template language reuses existing dashboard fields as evidence inputs rather than adding a parallel board state machine.

## 4. Validation And Closeout

- [x] 4.1 Update `scripts/validate-local.sh` to check v0.4.8 markers and regression rules.
- [x] 4.2 Run `openspec validate --all`, `./scripts/validate-local.sh --skip-global-skill`, and whitespace checks before archive/global sync.
- [x] 4.3 Complete PM, Advisor, and Reviewer review with no unresolved P0/P1.
- [x] 4.4 Prepare archive, no-active-change validation, global skill sync, and git closeout evidence.
