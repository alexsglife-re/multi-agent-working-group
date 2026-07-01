## 1. Version Metadata

- [x] 1.1 Review OpenClaw `CHANGELOG.md` and README version presentation for rule-level inspiration only.
- [x] 1.2 Add `CHANGELOG.md` with an Unreleased / v0.4.0 planned entry covering role boundaries, examples, validation, and metadata.
- [x] 1.3 Add a visible v0.4.0 stabilization note to `README.md` without claiming tag, release, push, deployment, or public publication.
- [x] 1.4 Decide whether `agents/openai.yaml` should remain versionless for v0.4.0 and document the decision if left unchanged.
- [x] 1.5 Update `docs/TODO.md` checkboxes for completed version-metadata work.

## 2. Operating Examples

- [x] 2.1 Review ClawTeam/OpenClaw task, approval, checkpoint, and handoff materials for rule-level patterns only.
- [x] 2.2 Add `examples/commit-gate.md` showing normal non-high-risk commit flow after PM plus Advisor consensus, required validation, and post-commit PM plus Advisor review.
- [x] 2.3 Add `examples/push-gate.md` showing normal non-high-risk push flow after PM plus Advisor consensus, required validation, target clarity, secret/credential scan, required status checks, and post-push PM plus Advisor review.
- [x] 2.4 Add `examples/handoff-task.md` showing continuity recovery where old handoffs are evidence, not authority.
- [x] 2.5 Review all examples for consistent Advisor, Reviewer, Worker, Leader, and Owner wording.
- [x] 2.6 Update `docs/TODO.md` checkboxes for completed example work.

## 3. Role Boundary Promotion

- [x] 3.1 Review `docs/ROLE_BOUNDARIES.md`, `examples/small-doc-task.md`, `examples/medium-worker-task.md`, and reference notes before editing `SKILL.md`.
- [x] 3.2 Update `SKILL.md` to clarify that Small Task Mode uses no PM, Worker, or Reviewer.
- [x] 3.3 Update `SKILL.md` to clarify that Leader direct execution must be narrow, explicit, and low-risk.
- [x] 3.4 Update `SKILL.md` to clarify that medium or higher work must not become hidden Worker execution by Leader.
- [x] 3.5 Update `SKILL.md` git-exit wording to match the global rule for normal non-high-risk commit/push after PM plus Advisor consensus and required gates, with post-result PM plus Advisor review.
- [x] 3.6 Confirm `SKILL.md` preserves explicit Owner approval for high-risk and default-exclusion actions.
- [x] 3.7 Update `docs/TODO.md` checkboxes for completed role-boundary promotion work.

## 4. Validation And Roadmap

- [x] 4.1 Update `docs/VALIDATION.md` with v0.4.0 checks for Small Task Mode, hidden Worker execution, Reviewer misuse, git-gate wording, English-only docs, and reference-source automation creep.
- [x] 4.2 Update `docs/ROADMAP.md` to mark Stage 1 as mostly complete and Stage 2 as the v0.4.0 focus.
- [x] 4.3 Update README status text so it matches the roadmap, TODO, and changelog.
- [x] 4.4 Update `docs/TODO.md` checkboxes for completed validation and roadmap work.

## 5. Review And Gate

- [x] 5.1 Run OpenSpec validation for `stabilize-v040-role-boundaries`.
- [x] 5.2 Run manual documentation checks from `docs/VALIDATION.md`.
- [x] 5.3 Check that all project docs remain English-only.
- [x] 5.4 Check git status and classify files as baseline documentation adoption versus v0.4.0 changes before any git gate.
- [x] 5.5 Run PM plus Advisor review of the completed local diff.
- [x] 5.6 If PM plus Advisor agree with no unresolved P0/P1 and no high-risk/default-exclusion action is present, proceed with normal commit under the global rule.
- [ ] 5.7 After commit, run PM plus Advisor review of the actual commit result.
- [ ] 5.8 If PM plus Advisor agree, required checks are fresh, target is clear, and applicable secret/credential scanning passes, proceed with normal push under the global rule.
- [ ] 5.9 After push, check required status/CI evidence when available and run PM plus Advisor review of the actual push result before reporting completion.
