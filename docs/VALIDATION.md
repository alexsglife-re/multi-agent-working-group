# Validation Checklist

Use this checklist before accepting changes to this repository. It is intentionally lightweight so it can be run manually during early development.

## Local Command

Run the lightweight local validation command before normal commit or push gates:

```sh
./scripts/validate-local.sh
```

After archiving an OpenSpec-backed change, run closeout mode:

```sh
./scripts/validate-local.sh --require-no-active-changes
```

The command is read-only and no-network. It does not replace PM, Advisor, Reviewer, OpenSpec archive, secret scanning, or git gate requirements.

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

## v0.4.3 Leader State Compaction Checks

Run these checks for the `v0.4.3` Leader state compaction set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, examples, and the OpenSpec change.

- Long-running or spec-bound Leader state uses a current state card, evidence index, and historical archive notes.
- The current state card is the single active takeover entry point and does not hide required gate facts behind "see evidence index".
- Active handoff or ledger updates are refreshed around current verifiable state instead of repeatedly appending old handoff text.
- Evidence indexes map each key claim to evidence type, evidence location or command, freshness/currentness status, and Leader verification status.
- Old handoffs, archived notes, summaries, and evidence indexes remain evidence only and are not described as authorization for commit, push, scope expansion, gate bypass, or external effects.
- Compact handoffs still preserve current goal, stage or C-stage, gate state, PM/Advisor/Reviewer continuity, unresolved P0/P1, validation freshness, changed and do-not-touch files, next action, stop conditions, and commit/push authorization state.
- Bulky raw material is summarized and referenced when safe local evidence storage exists, including long logs, full command output, full diffs, repeated check output, completed stage narrative, and superseded handoff text.
- Compaction does not remove PM/Advisor reasoning, Worker results, findings, recommendations, objections, key error details, owner-decision needs, validation status, or required review evidence.
- Reference-source influence from ClawTeam/OpenClaw remains rule-level only: layered state, task/status summaries, evidence references, and board-style overview concepts are allowed; runtime state stores, inbox automation, dashboards, automatic spawning, subprocess orchestration, and worktree automation remain out of scope.

## v0.4.4 Lightweight Local Validation Checks

Run these checks for the `v0.4.4` local validation set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, `scripts/validate-local.sh`, and the OpenSpec change.

- The local validation command is read-only and no-network.
- The local validation command reports failures without modifying files automatically.
- The default mode can run during an active OpenSpec change and reports active changes as informational.
- The closeout mode fails when active OpenSpec changes remain.
- The command checks `SKILL.md` frontmatter, current version markers, accepted OpenSpec specs, `openspec validate --all`, and installed global skill sync when the global skill file exists.
- The command does not claim to replace PM, Advisor, Reviewer, Leader verification, OpenSpec archive, secret scanning, CI/status checks, or git gates.
- Documentation does not describe local validation as CI, packaging automation, release automation, or automatic repair.

## v0.4.5 Copyable Role Template Checks

Run these checks for the `v0.4.5` template set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, `templates/`, `scripts/validate-local.sh`, and the OpenSpec change.

- Templates are fill-in structures, not authorization or approval.
- Templates preserve scope, risk, evidence, validation freshness, unresolved P0/P1, owner-decision needs, stop conditions, and commit/push authorization state where relevant.
- PM and Advisor templates preserve independent first-pass review and model/provider recording.
- Worker templates keep Worker ownership bounded to allowed files or modules and prohibit scope expansion, self-approval, commit, and push.
- Reviewer template states that Reviewer must not review their own implementation.
- Blocked report template clearly distinguishes completed local work from not-performed gated actions.
- Compact handoff template uses a current state card, evidence index, and historical archive note.
- Legacy v0.3 or bloated documents are preserved as historical evidence, not bulk-rewritten in place.
- Migration guidance says to copy only verified current facts into the v0.4.5 compact handoff and reference old material through the evidence index.
- Templates do not imply bypass of PM, Advisor, Reviewer, validation, OpenSpec archive, secret scanning, CI/status, commit gates, push gates, release approval, deployment approval, or public publication approval.

## v0.4.6 Leader Rollover Protocol Checks

Run these checks for the `v0.4.6` rollover set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, `templates/`, `examples/`, `scripts/validate-local.sh`, and the OpenSpec change.

- Leader Rollover Protocol is described as automatic detection plus handoff preparation, not automatic successor thread creation.
- Context-budget records include state, observed compression/summary count, count confidence, last check, reason, next safe boundary, and rollover action.
- Compression/summary thresholds are non-overlapping and include 0-1, 2, 3-4, 5-6, 7, 8+, 6+ before gated actions, and unknown count with unreliable current-state verification.
- `Rollover Strongly Recommended` is documented as a preparation signal, not a gate bypass or authorization.
- `Rollover Required` enters sealed-ready behavior before Worker dispatch, commit, push, CI, archive, or high-risk gates when the threshold applies.
- Sealed-ready behavior does not allow new Worker dispatch, accepting new Worker results for the handed-off workstream, commit/push/CI/archive gates, or external-effect actions until reliable takeover verification is restored.
- The workflow keeps a single active current-state card for a workstream during sealed-ready; older packets are historical evidence if superseded.
- Successor startup packets include current state, context-budget evidence, task status dashboard, pending messages, conflicts, overlaps, evidence index, authorization state, and successor verification checklist.
- Successor startup packet guidance says successor packet != automatic thread creation.
- Successor Leaders must re-verify project instructions, memory, skill rules, owner instruction, git state, OpenSpec state, validation freshness, PM/Advisor/Reviewer continuity, Worker state, unresolved P0/P1, and authorization state before continuing.
- Legacy v0.3 or bloated handoffs remain historical evidence and are not pasted verbatim into active rollover packets.
- Reference-source influence from ClawTeam/OpenClaw remains rule-level only: task states, explicit approval vocabulary, scoped context, and board-style summaries are allowed; runtime code, automatic spawning, subprocess orchestration, board UI, cost dashboard automation, and thread automation remain out of scope.

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
- Leader state compaction preserves active current-state cards, evidence indexes, and archived history boundaries when long handoff or continuity state is involved.
- Local validation command output is recorded when it is relevant to commit, push, or closeout gates.
- Copyable templates remain evidence-capture aids and do not create new authorization paths.
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
- Documentation does not imply that compacting handoff state permits dropping unresolved P0/P1, validation freshness, PM/Advisor findings, owner-decision needs, or git authorization state.
- Documentation does not imply that old handoffs, archive notes, summaries, or evidence indexes are authority for current action.
- Documentation does not imply that local validation authorizes commit, push, archive, release, deployment, external publication, CI bypass, secret-scan bypass, or reviewer-gate bypass.
- Documentation does not imply that templates authorize commit, push, archive, release, deployment, external publication, secret access, CI bypass, reviewer bypass, or PM/Advisor bypass.
- Documentation does not imply that rollover states or successor startup packets automatically create successor threads or carry forward commit/push/CI/archive authorization.
- Documentation does not imply that compression/summary counts alone authorize gate bypass or external effects.
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

The project may later expand the local validation command. Good next candidates:

- Markdown link checks for local files.
- YAML parsing for `agents/openai.yaml`.
- Required-section checks for `SKILL.md`.
- Secret-pattern scanning over outgoing diffs before push.
