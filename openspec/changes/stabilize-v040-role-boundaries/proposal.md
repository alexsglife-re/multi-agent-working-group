## Why

The project now has enough reference notes and operating examples to stabilize the v0.4.0 workflow around role boundaries, Leader direct execution, Worker delegation, blocked reporting, and git gates. This needs a scoped change because the work affects future agent behavior in `SKILL.md`, examples, validation, and release metadata rather than a small documentation edit.

## What Changes

- Add v0.4.0 release metadata, including a changelog entry and a visible README version note.
- Add missing operating examples for commit gates, push gates, and handoff or continuity recovery.
- Promote only the shortest stable role-boundary rules from `docs/ROLE_BOUNDARIES.md` into `SKILL.md`.
- Align git-gate wording with the global rule: normal non-high-risk commits and pushes may proceed after PM plus Advisor consensus and required gates, followed by PM plus Advisor review of the actual result.
- Preserve explicit Owner approval for high-risk actions and default exclusions such as force-push, releases, deployment, schema, credential, security, auth, permission, destructive, protected-branch bypass/exception, or irreversible external-effect changes.
- Update validation and roadmap docs so v0.4.0 checks are clear and examples remain consistent.
- Record reference-source influence from ClawTeam/OpenClaw at the rule level only: stage gates, task status vocabulary, blocked reports, role-scoped recovery, and approval concepts.

Non-goals:

- No automatic agent spawning, tmux/subprocess management, board UI, automatic worktree management, automatic merge, CI automation, packaging automation, public release, tag publication, or deployment.
- No direct adoption of ClawTeam/OpenClaw runtime code or CLI behavior.
- No broad rewrite of `SKILL.md`; only minimal stable rule promotion.
- No commit or push authorization is created by this proposal itself.

## Capabilities

### New Capabilities

- `role-boundary-stabilization`: Defines v0.4.0 requirements for Leader direct execution, Small Task Mode, Worker delegation, Reviewer independence, examples, validation, and git-gate wording.

### Modified Capabilities

- None.

## Impact

- Affected skill artifact: `SKILL.md`.
- Affected metadata and docs: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `docs/ROLE_BOUNDARIES.md`.
- Affected examples: `examples/commit-gate.md`, `examples/push-gate.md`, `examples/handoff-task.md`, plus consistency review of existing examples.
- Affected OpenSpec artifacts: this change under `openspec/changes/stabilize-v040-role-boundaries/`.
- No product code, dependencies, runtime APIs, CI, packaging, deployment, or external publication are in scope.
