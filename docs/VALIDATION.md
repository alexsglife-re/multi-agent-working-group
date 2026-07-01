# Validation Checklist

Use this checklist before accepting changes to this repository. It is intentionally lightweight so it can be run manually during early development.

## Baseline Checks

- Confirm the working tree state before editing:
  - `git status --short --branch`
- Confirm the target remote and branch when git publication is being considered:
  - `git remote -v`
  - `git branch --show-current`
- Review changed files before finalizing:
  - `git diff --stat`
  - `git diff -- README.md docs/ROADMAP.md docs/VALIDATION.md SKILL.md agents/openai.yaml`

## README Checks

- The README explains what the skill is for.
- The README explains what the skill does not authorize.
- The repository layout matches the actual files.
- Usage guidance does not imply automatic permission to commit, push, deploy, release, or perform destructive actions.
- Links to roadmap and validation docs remain accurate.

## Roadmap Checks

- The roadmap stays incremental.
- Later-stage automation is not described as already available.
- Each stage has a practical goal and exit criteria.
- Public release, license, CI, and packaging choices remain framed as decisions until accepted.
- Stage 1 is described as mostly complete, not as a published release.
- Stage 2 describes `v0.4.0` local stabilization as complete before `v0.4.1` follow-up work.

## v0.4.0 Role-Boundary Checks

Run these checks for the `v0.4.0` stabilization set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `docs/ROLE_BOUNDARIES.md`, `SKILL.md`, and examples.

- Small Task Mode uses no PM, no Worker, and no Reviewer.
- Small Task Mode still preserves required validation, dirty-worktree review, Advisor review at git gates, and stricter project rules.
- Leader direct execution remains narrow, explicit, and low-risk.
- Leader direct execution does not become hidden Worker execution for medium, complex, code, spec-required, or higher-risk work.
- Reviewer must not review their own implementation.
- Reviewer remains conditional for documentation tasks and required for code or higher-risk gates as defined by `SKILL.md`.
- Normal non-high-risk commits may proceed only through the PM plus Advisor gate with no unresolved P0/P1, fresh required validation, required Reviewer approval when applicable, and post-commit PM plus Advisor review.
- Normal non-high-risk pushes may proceed only through the PM plus Advisor gate with no unresolved P0/P1, fresh required validation, required Reviewer approval when applicable, clear target, applicable secret or credential scanning, required status or CI evidence when available, and post-push PM plus Advisor review.
- Normal push to `main` may proceed under the normal PM plus Advisor push gate when all normal requirements pass and no protected-branch bypass or exception action is needed.
- High-risk and default-exclusion actions still require explicit Owner approval; PM plus Advisor agreement is insufficient for those actions.
- Default exclusions include protected-branch bypass/exception actions, force-push, history rewrite, tags, releases, deployment, public publication, credentials, secrets, security/auth/permission changes, schema migrations, destructive actions, and irreversible external effects.
- Project docs remain English-only.
- Reference-source influence from ClawTeam/OpenClaw remains rule-level only: stage names, task states, blocked reports, gate vocabulary, and role-scoped recovery are allowed; runtime code, CLI behavior, automatic spawning, subprocess orchestration, worktree automation, board UI, automatic approval, CI automation, packaging automation, and release automation are rejected unless a future explicit approval changes scope.

## v0.4.1 Advisor Model-Diversity Checks

Run these checks for the `v0.4.1` Advisor model-diversity set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, and the OpenSpec change.

- Advisor defaults to a different AI model when model selection is available.
- Owner explicit instruction takes precedence over the different-model default.
- Same-model Advisor use is recorded as an explicit Owner override and is not described as satisfying model diversity.
- If no Advisor model/provider record exists for the project, session, continuity file, or handoff, Leader asks the Owner to specify one at startup.
- Single-model environments are recorded as model-diversity degradation rather than silently ignored.
- Different-provider or different-model Advisor review does not expand Advisor context beyond minimum necessary task evidence.
- Trusted Advisor context still excludes secrets, credentials, unrelated projects, broad context dumps, and irrelevant data unless explicitly authorized.
- Model diversity is not described as a correctness guarantee, automatic approval, gate bypass, or replacement for PM/Advisor independence, Leader verification, Reviewer requirements, validation, or unresolved P0/P1 stop conditions.

## v0.4.2 CLI Trust And OpenSpec Lifecycle Checks

Run these checks for the `v0.4.2` CLI trust and OpenSpec lifecycle set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, examples, and the OpenSpec change.

- CLI-based PM, Advisor, Worker, or Reviewer roles require current-project workspace-trust preflight before their output is relied on.
- Workspace trust is scoped to the exact current project workspace and does not authorize unrelated directories, secrets, global policy changes, or broader file access.
- A workspace-trust failure is recorded as `workspace-trust-blocked` and does not silently become role unavailability, same-model degradation, stale-output reuse, or model switching.
- An Owner-specified Advisor is treated as a trusted bounded collaboration role for the current workstream, not as an ordinary third-party service.
- Trusted Advisor context still excludes secrets, credentials, unrelated projects, broad context dumps, and irrelevant data unless explicitly authorized.
- PM and Advisor default to different AI models when model selection is available.
- Same-model PM/Advisor pairing requires explicit Owner approval and is recorded as an override.
- Missing PM/Advisor model separation fails closed for commit/push-bound, OpenSpec-backed, small, medium, complex, high-risk, code, permission/API/database/architecture, or security work unless the Owner explicitly approves degradation.
- Owner goal completion includes validation, applicable commit/push/status checks, post-result PM plus Advisor review, and OpenSpec archive when archive belongs to the goal.
- OpenSpec-backed work using this skill starts at C0 Goal Analysis before C1 proposal work.
- C0 records owner goal, risk, active OpenSpec changes, applicable skills, PM/Advisor model routing and separation, CLI workspace-trust needs, Advisor trust/model state, git state, validation expectations, and archive requirement.
- C3 closeout is not described as final completion when C4 archive applies.
- The new example demonstrates blocked/degraded behavior without adding automation or weakening existing gates.

## Skill Checks

Run these checks whenever `SKILL.md` changes.

- Frontmatter remains at the top of the file.
- Frontmatter includes `name` and `description`.
- The skill description still matches the actual behavior.
- Project, owner, security, and spec workflow rules can only tighten this skill, not weaken it.
- Advisor permissions remain read-only and minimum necessary by default.
- Advisor output remains unverified until the Leader checks current evidence.
- PM and Advisor independence requirements remain clear.
- Advisor model/provider and diversity status are recorded when relevant.
- PM model/provider and PM/Advisor model separation status are recorded when relevant.
- CLI agent workspace-trust status is recorded when relevant.
- OpenSpec C-stage and C0 analysis are recorded when relevant.
- Same-model Advisor overrides and model-diversity degradation are explicit when they occur.
- Same-model PM/Advisor overrides and PM/Advisor model-separation degradation are explicit when they occur.
- Worker scope remains narrow and explicitly bounded.
- Reviewer does not review their own implementation.
- Leader direct execution remains narrow, explicitly labeled, and does not become hidden Worker execution.
- Small Task Mode remains a narrow exception, not a default bypass.
- Small Task Mode does not require PM, Worker, or Reviewer.
- Commit and push are still separate gates.
- Normal non-high-risk commit/push gates remain distinct from high-risk or default-exclusion Owner approval gates.
- A normal push whose target branch is `main` is allowed by the normal gate by itself; protected-branch bypass/exception actions still require explicit Owner approval.
- Default exclusions still include protected-branch bypass/exception actions, force-push, releases, credentials, security/auth changes, schema migrations, destructive actions, and irreversible external effects.
- Handoff remains continuity evidence, not authorization.
- Goal completion through C4 archive is explicit for OpenSpec-backed goals when archive applies.

## Agent Metadata Checks

Run these checks whenever `agents/openai.yaml` changes.

- `display_name` is human-readable.
- `short_description` matches the skill's purpose.
- `default_prompt` does not overpromise automation or authority.
- YAML remains valid.

## Safety Checks Before Commit

- No secrets, credentials, tokens, private keys, or local machine-specific private paths were added.
- Documentation does not authorize broader advisor access than `SKILL.md`.
- Documentation does not imply that Advisor model diversity expands context sharing, authorizes secrets, or proves correctness.
- Documentation does not imply that trusted Advisor context authorizes secrets, unrelated projects, broad dumps, or irrelevant data.
- Documentation does not imply that CLI workspace trust can be applied globally or to unrelated directories by default.
- Documentation does not imply that PM/Advisor same-model pairing can happen silently.
- Documentation does not imply that an OpenSpec-backed goal is complete before archive when archive applies.
- Documentation does not imply that CI, tests, secret scanning, or reviewer gates can be skipped.
- Documentation does not imply that Reviewer is required for small low-risk tasks.
- Any new examples clearly distinguish normal non-high-risk git gates from explicit Owner approval gates for high-risk/default-exclusion actions.
- Any unresolved risk or missing validation is documented before entering the applicable commit gate.

## Suggested Manual Review Flow

1. Read the changed files.
2. Compare behavior-changing edits against the Skill Checks section.
3. Confirm the README and roadmap still describe the actual repository state.
4. Run git diff review.
5. Record any skipped validation and why it was safe to skip.

## Future Automated Checks

The project may later add a local validation command. Good first candidates:

- Markdown link checks for local files.
- YAML parsing for `agents/openai.yaml`.
- Frontmatter parsing for `SKILL.md`.
- Required-section checks for `SKILL.md`.
- Secret-pattern scanning over outgoing diffs before push.
