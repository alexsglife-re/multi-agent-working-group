## 1. OpenSpec Planning

- [x] 1.1 Create `add-advisor-model-diversity` OpenSpec change.
- [x] 1.2 Add proposal, design, spec, and tasks artifacts for the v0.4.1 scope.
- [x] 1.3 Validate the OpenSpec change.

## 2. Skill Rule Update

- [x] 2.1 Add Advisor model diversity defaults to `SKILL.md`.
- [x] 2.2 Add startup behavior for unspecified Advisor model/provider.
- [x] 2.3 Add startup packet and handoff fields for Advisor model/provider, diversity status, same-model override, and degradation.
- [x] 2.4 Confirm existing Advisor minimum context, verification, failure, and git-gate rules are preserved.

## 3. Version And Project Docs

- [x] 3.1 Update `CHANGELOG.md` with v0.4.1 planned/current upgrade notes and v0.4.0 completed local stabilization wording.
- [x] 3.2 Update `README.md` current status and usage notes for Advisor model diversity.
- [x] 3.3 Update `docs/TODO.md` with v0.4.1 tasks.
- [x] 3.4 Update `docs/VALIDATION.md` with v0.4.1 model-diversity checks.
- [x] 3.5 Update `docs/ROADMAP.md` current recommended next step.

## 4. Verification And Review

- [x] 4.1 Run OpenSpec validation.
- [x] 4.2 Run manual validation checks for the changed docs and `SKILL.md`.
- [x] 4.3 Check git diff and ensure `.codex/` and `.claude/` remain untracked and out of scope.
- [x] 4.4 Run PM plus different-model Advisor review of the completed local diff.
- [x] 4.4a Add `.claude/` and `.codex/` to `.gitignore` so local generated directories are not accidentally staged.
- [ ] 4.5 If PM plus Advisor agree with no unresolved P0/P1 and gates pass, proceed through normal commit/push closeout when requested or applicable.
