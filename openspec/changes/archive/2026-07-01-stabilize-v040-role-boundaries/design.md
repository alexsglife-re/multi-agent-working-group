## Context

The repository is in a documentation-first stage. `SKILL.md` is already globally installed as the current v0.3 skill, while the repository now contains new local reference notes, examples, role-boundary notes, validation guidance, and a v0.4.0 TODO list. Most of those files are still untracked, so any later commit gate must distinguish baseline documentation adoption from additional v0.4.0 changes.

The v0.4.0 work changes future workflow interpretation. It is therefore not Small Task Mode. It needs OpenSpec-scoped planning, PM plus Advisor consensus, bounded Worker slices for implementation, and post-change verification.

Reference check:

- HKUDS/ClawTeam and win4r/ClawTeam-OpenClaw provide useful rule-level patterns: stage gates, task states, blocked reports, plan approval, Worker loops, and role-scoped recovery.
- Their runtime patterns such as automatic spawning, tmux/subprocess orchestration, worktree automation, board UI, automatic approval, and frequent Worker commits are intentionally out of scope.
- OpenClaw's changelog discipline supports adding `CHANGELOG.md`, but this project should not present v0.4.0 as released until the release gate passes.

## Goals / Non-Goals

**Goals:**

- Make v0.4.0 visible as the current stabilization target.
- Add missing examples for commit gates, push gates, and handoff or continuity recovery.
- Promote only minimal stable role-boundary rules into `SKILL.md`.
- Align normal non-high-risk commit/push wording with the global PM plus Advisor gate.
- Keep high-risk and default-exclusion actions behind explicit Owner approval.
- Update validation and roadmap docs to reflect v0.4.0 readiness criteria.
- Keep all project docs English-only.

**Non-Goals:**

- Do not add automation, CI, packaging, public release, tags, deployment, or external publication.
- Do not adopt ClawTeam/OpenClaw runtime code, CLI commands, spawn behavior, worktree behavior, or automatic approval behavior.
- Do not broaden Advisor permissions beyond the existing minimum-needed read-only model.
- Do not let examples or TODO entries authorize commit, push, release, deployment, or other external effects by themselves.

## Decisions

### Decision 1: Use OpenSpec as the v0.4.0 scope boundary

The change affects `SKILL.md` semantics and git-gate wording, so it needs proposal/design/spec/tasks artifacts before implementation. This avoids turning accumulated notes into unreviewed skill behavior.

Alternative considered: directly edit `SKILL.md` from `docs/TODO.md`. Rejected because the TODO includes role and git-gate semantics that require PM plus Advisor consensus and explicit validation.

### Decision 2: Promote minimal rules, keep long rationale in docs

`SKILL.md` should receive only stable operational rules:

- Small Task Mode uses no PM, Worker, or Reviewer.
- Leader direct execution must be narrow, explicit, and low-risk.
- Medium or higher work must not become hidden Worker execution by Leader.
- Reviewer must not review its own implementation.
- Normal non-high-risk commit/push may proceed after PM plus Advisor consensus and required gates, with post-result PM plus Advisor review.
- High-risk and default exclusions still require explicit Owner approval.

Longer explanations and examples stay in `docs/ROLE_BOUNDARIES.md` and `examples/`.

Alternative considered: copy the full role-boundary document into `SKILL.md`. Rejected because it would make the skill harder to scan and risk freezing discussion prose as normative protocol.

### Decision 3: Treat examples as gate tests

The missing examples should act as executable mental tests for the protocol:

- `commit-gate.md` verifies commit authorization wording.
- `push-gate.md` verifies outgoing-scope, target, secret-scan, and post-push review wording.
- `handoff-task.md` verifies old context remains evidence, not authority.

Alternative considered: update only validation docs. Rejected because examples make the rules easier for future agents to apply.

### Decision 4: Preserve explicit high-risk Owner gates

The global rule allows normal non-high-risk commits and pushes after PM plus Advisor consensus and required gates, including normal push to `main` when target clarity, validation, required reviews, and applicable secret/credential scanning pass. It does not authorize force-push, history rewrite, protected-branch bypass/exception actions, tags/releases, deployment, schema migrations, credentials/secrets, security/auth/permission changes, destructive operations, or irreversible external effects.

Alternative considered: require Owner approval for every commit/push. Rejected because it conflicts with the current global owner rule.

## Risks / Trade-offs

- Git-gate wording may be over-broadened -> Mitigate by explicitly naming high-risk/default exclusions and post-result PM plus Advisor review.
- Reviewer may be over-required for documentation examples -> Mitigate by stating Reviewer is conditional for docs and required for code or higher-risk gates as defined by the skill.
- Leader direct execution may blur into hidden Worker execution -> Mitigate through `SKILL.md`, examples, and validation checks.
- Untracked baseline files may be mixed with new v0.4.0 edits -> Mitigate by requiring pre-commit file-scope review and separating baseline adoption from new changes in reports.
- Reference-source automation may creep into scope -> Mitigate by keeping ClawTeam/OpenClaw influence at the rule and vocabulary level only.

## Migration Plan

1. Complete OpenSpec artifacts.
2. Implement documentation and skill updates in TODO order.
3. Run manual validation against `docs/VALIDATION.md`.
4. Request or use the normal global PM plus Advisor commit/push gate only after PM plus Advisor review, required validation, clear target, and high-risk exclusion checks.
5. After commit or push, run PM plus Advisor review of the actual result before reporting the flow complete.

Rollback strategy: since this is documentation and skill text only, revert the affected files in a normal git commit if PM plus Advisor or later validation finds an accepted rule is wrong.

## Open Questions

- Should `agents/openai.yaml` carry a version field, or should the version remain README/CHANGELOG-only for v0.4.0?
- Should v0.4.0 be marked as planned until commit/push completes, or current once local docs and `SKILL.md` are updated?
