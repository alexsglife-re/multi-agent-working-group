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

The command also checks that tracked Markdown documentation is English-only.
Ignored local reference checkouts under `references/external/` are not project
publication docs and are not included in that check.

## Baseline Checks

- Confirm the working tree state before editing:
  - `git status --short --branch`
- Confirm the target remote and branch when git publication is being considered:
  - `git remote -v`
  - `git branch --show-current`
- Review changed files before finalizing:
  - `git diff --stat`
  - `git diff -- README.md docs/ROADMAP.md docs/VALIDATION.md SKILL.md agents/openai.yaml`

## Public Release Checks

Run these checks before a public tag, GitHub Release, or other publication:

```sh
git status --short --branch -uall
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
rg -n "(token|api[_-]?key|secret|password|private key|/Users/|gmail|Keychain|GITHUB_PAT)" .
```

- `LICENSE` exists and matches the intended public reuse model.
- `CONTRIBUTING.md` explains how to open issues, change `SKILL.md`, and run validation.
- `SECURITY.md` tells contributors not to post secrets, credentials, or private project context.
- `CODE_OF_CONDUCT.md` exists if the repository accepts outside contribution.
- Public docs keep the skill model-agnostic and do not hard-code personal provider or model defaults.
- Public docs do not include private machine paths, private project details, credentials, or local-only memory rules.
- `openspec/changes/archive/` is described as design history, not required reading for ordinary users.
- A release tag such as `v0.4.11` points at the reviewed release commit, not at an older pre-release-preparation commit.
- GitHub Release notes, when created, describe the reviewed version and do not claim deployment, CI, or automation that does not exist.

## README Checks

- The README explains what the skill is for.
- The README presents Multi-Agent Working Group as a portable protocol with Codex as the reference adapter.
- The README explains what the skill does not authorize.
- The repository layout matches the actual files.
- Usage guidance does not imply automatic permission to commit, push, deploy, release, or perform destructive actions.
- Runtime guidance does not describe planned or compatible adapters as fully supported before validation.
- Links to roadmap and validation docs remain accurate.
- Tracked Markdown documentation contains no CJK text unless a future accepted
  change explicitly broadens the documentation language policy.

## Roadmap Checks

- The roadmap stays incremental.
- Later-stage automation is not described as already available.
- Each stage has a practical goal and exit criteria.
- Public release, license, CI, and packaging choices remain framed as decisions until accepted, or as accepted release-preparation work once the repository is explicitly prepared for public reuse.
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
- A workspace-trust failure first checks whether applicable Owner-recorded role authorization permits current-project trust setup; if no applicable authorization exists, record `workspace-trust-blocked` and do not silently convert it into role unavailability, same-model degradation, stale-output reuse, or model switching.
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

## v0.4.7 CLI Workspace Trust Setup Protocol Checks

Run these checks for the `v0.4.7` CLI workspace trust setup set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, `templates/`, `examples/`, `scripts/validate-local.sh`, and the OpenSpec change.

- Owner-recorded CLI role assignment is described as current-project workspace trust setup authorization for Claude CLI, Codex CLI, or similar CLI agents assigned as PM, Advisor, Worker, Reviewer, or another role.
- Allowed authorization sources include current Owner instruction, global memory, project rules, project memory, handoff, startup packet, continuity record, ledger, template, and verified OpenSpec evidence.
- The Leader must verify that the source applies to the exact current project and workstream before using it as authorization.
- Stale, historical-only, superseded, or mismatched role records do not authorize trust setup.
- Trust setup remains scoped to the exact current project root and assigned CLI role.
- Trust setup does not authorize parent-directory trust, home-directory trust, all-repository trust, unrelated project access, dangerous permission bypass, broad file access, secrets, credentials, browser data, global policy changes, git actions, CI, deployment, release, publication, or other external effects.
- Trust states include `not-needed`, `preflight-needed`, `owner-recorded-role-authorized`, `trust-setup-attempted`, `trusted-verified`, and `blocked`.
- Trust-state template fields also include `owner-confirmation-needed` where a CLI trust record can represent a needed Owner confirmation.
- `owner-confirmation-needed` is reserved for missing/stale authorization, trust outside the current project root, dangerous permission bypass, secret access, unrelated directory access, global policy changes, git actions, CI, deployment, release, publication, or external effects.
- `trusted-verified` is recorded only after a post-setup minimal read-only probe succeeds.
- Blocked trust setup does not silently become role unavailability, model switching, same-model fallback, or stale-output reuse.
- Examples do not teach the old behavior of treating an untrusted CLI workspace as immediately blocked before checking applicable Owner-recorded role authorization.
- Reference-source influence from ClawTeam/OpenClaw remains rule-level only: prompt-detection ideas and setup/verify/troubleshooting structure are allowed; copied runtime code, silent prompt confirmation, subprocess orchestration, worktree automation, dangerous permission bypass, and global allowlist automation remain out of scope.

## v0.4.8 Leader Rollover Opportunity Protocol Checks

Run these checks for the `v0.4.8` rollover opportunity set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, `templates/`, `examples/`, `scripts/validate-local.sh`, and the OpenSpec change.

- `Rollover Opportunity` is documented as an early preparation state, not an immediate handoff requirement and not a successor authorization source.
- Each context-budget check records exactly one canonical ContextBudget state, and the highest applicable state wins.
- Compression count fields include value, source, and confidence.
- Compression count source includes `platform-visible`, `owner-reported`, `inferred`, and `unknown`.
- Platform-visible summaries are not described as actual total compaction counts unless independently verified or Owner-reported.
- Owner-reported compression undercount is recorded distinctly from platform-visible evidence.
- `Rollover Opportunity` requires a clean boundary plus a heavier next step, not a boundary alone.
- Opportunity scenarios include C-stage boundary plus new or long stage, validated slice plus Worker dispatch, refreshed evidence plus commit/push/CI/archive or new OpenSpec change, and Owner-reported compression undercount plus heavier next step.
- Same-workstream PM plus Advisor gate automation for normal non-high-risk commit, push, CI/status, and archive progression remains allowed when existing gates pass.
- Rollover and successor packets do not automatically create new conversations, spawn agents, or inherit commit/push/CI/archive authorization.
- Historical gate state is recorded as evidence only; successor execution requires fresh verification.
- Dashboard fields remain evidence inputs to canonical state selection and do not create a separate state machine or runtime dashboard.
- Leader delegation discipline discourages hidden Worker execution for Medium, Complex, High-risk, or substantive Worker-suitable work while preserving small low-risk, orchestration, synthesis, verification, owner communication, narrow documentation sync, and tiny connective edits for Leader direct work.
- Reference-source influence from ClawTeam/OpenClaw remains rule-level only: task states, explicit approval vocabulary, scoped context, and board-style summaries are allowed; runtime code, automatic spawning, subprocess orchestration, board UI, cost dashboard automation, and thread automation remain out of scope.

## v0.4.9 Provider Separation, Agent Patience, And Migration Guidance Checks

Run these checks for the `v0.4.9` provider separation and model source verification set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `SKILL.md`, `templates/`, `scripts/validate-local.sh`, and the OpenSpec change.

- Advisor diversity defaults to provider-level separation when provider-level separation is available.
- PM/Advisor separation defaults to provider-level separation when provider-level separation is available.
- Provider-level separation means different AI service providers; same-provider model names, versions, families, or capability tiers are not described as full separation.
- Separation statuses include `provider-separated`, `model-family-separated`, `same-provider-variant`, `same-model-owner-override`, `degraded`, and `blocked`.
- `model-family-separated` and `same-provider-variant` are recorded as degraded or partial unless they also satisfy provider-level separation.
- Owner-approved same-model pairing is recorded as `same-model-owner-override` and is degraded for separation evidence.
- Global memory, project memory, handoff, and startup-packet model preferences are treated as hints to verify for the current workstream, not stale authority.
- A current verified model record applies only to the exact current project, workstream, role, task stage, and available tool environment.
- C0, compact handoff, and successor startup packet templates record provider/model per role, model source, source freshness/current verification, separation status, and override or degradation reason.
- The skill remains model-agnostic and does not hard-code concrete model names or provider-specific defaults.
- PM and Advisor short silence during substantive review, OpenSpec stages, commit/push/CI/archive gates, high-risk gates, or large handoff packets is not described as task failure.
- Complex, implementation-heavy, validation-heavy, or otherwise substantive bounded Worker slices use the same evidence-based patience principle.
- Agent closure or restart requires a concrete lifecycle reason such as completion, blocked state, tool/session failure, exceeded patience window without progress evidence, stale evidence, role drift, context overload, rollover boundary, or Owner instruction.
- C0, PM, Advisor, Worker, compact handoff, successor startup, and blocked templates record expected wait/recheck behavior, progress evidence, patience state, or closure/restart reason where relevant.
- Documentation does not add automatic timers, polling loops, process supervision, or runtime session registry.
- Installation and migration guidance covers local checkout use, optional global skill sync, migration to another machine, adoption in another project, validation commands, and non-transferable state.
- Installation and migration guidance does not imply packaging automation, release publication, automatic global overwrite, secret migration, or transfer of commit/push/CI/archive authorization.

## v0.4.10 Invocation, Migration, And Plain-Language Closeout Guidance Checks

Run these checks for the `v0.4.10` invocation, migration, and closeout set: `README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`, `docs/VALIDATION.md`, `docs/INSTALLATION.md`, `SKILL.md`, `templates/`, `examples/`, `scripts/validate-local.sh`, and the OpenSpec change.

- Skill invocation is based on task traits such as explicit Owner request, PM/Advisor/Worker/Reviewer coordination, external Advisor review, OpenSpec lifecycle work, medium or higher risk, delegated implementation, guarded git exits, handoff, rollover, or complex verification.
- Automatic invocation is described as workflow/checklist reasoning only.
- Automatic invocation never creates external effects or transfers authority. Examples are non-exhaustive and include automatic agent spawning, external Advisor calls, workspace trust, commit, push, archive, CI, deployment, release, publication, secret access, Owner-only gate bypass, and next-goal execution.
- The workflow scales to task size, so narrow small low-risk work can still use Small Task Mode when every Small Task Mode condition is met.
- Installation and migration guidance explains that copying, syncing, installing, or invoking the skill transfers the checklist only, not permission or trusted continuity.
- Migration guidance gives concrete non-transfer examples: authorization, role continuity, validation freshness, workspace trust, stale handoff authority, secrets, external-effect permission, and prior/current-session assumptions.
- Completion summaries include what changed, what was actually verified, what remains uncertain or was not checked, recommended next goals, and authorization state.
- Remaining uncertainty or skipped checks are mandatory closeout fields; if none remain, the output says `none` and explains why.
- Verification evidence is separated from claims, recommendations, stale memory, old handoffs, or prior-session instructions.
- Recommended next goals are advice only unless the Owner has already given explicit current-session authorization.
- Plain-language final reporting avoids unexplained jargon or briefly explains necessary technical terms in practical terms.
- v0.4.10 does not weaken v0.4.9 provider separation, model-source verification, PM/Advisor patience, substantive Worker patience, installation boundaries, or non-transferable authorization rules.
- Documentation does not add automatic timers, polling loops, process supervision, runtime session registries, packaging automation, release publication, CI automation, or automatic repair.

## v0.4.11 Platform-Neutral Protocol Positioning Checks

Run these checks for the `v0.4.11` platform-neutral positioning set:
`README.md`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`,
`docs/VALIDATION.md`, `docs/INSTALLATION.md`, `docs/ADAPTERS.md`,
`scripts/validate-local.sh`, and the OpenSpec change.

- Public documentation describes Multi-Agent Working Group as a portable
  workflow protocol for AI-assisted work.
- Public documentation uses the phrase `portable workflow protocol for
  AI-assisted work` for the project positioning.
- Codex is described as the reference packaged adapter, not the only intended
  runtime.
- Claude, OpenClaw, Hermes Agent, and other non-Codex runtimes are labeled as
  planned adapter guidance or compatible patterns until validated.
- Adapter maturity labels distinguish `reference adapter`, `adapter guide
  planned`, `compatible pattern`, and `unsupported`.
- Adapter guidance lists required mappings for Leader, PM, Advisor, Worker,
  Reviewer, readable scope, writable scope, workspace trust, validation, git
  gates, handoff, and unsupported actions.
- Adapter guidance preserves non-transferable authorization, workspace trust,
  validation freshness, role continuity, secret access, and external-effect
  boundaries.
- Documentation does not add runtime automation, subprocess orchestration, CI,
  packaging automation, release automation, or copied runtime implementation
  details.

## v0.4.12 Progressive Skill References Checks

Run these checks for the `v0.4.12` progressive references set: `SKILL.md`,
`references/`, `README.md`, `CHANGELOG.md`, `docs/TODO.md`,
`docs/ROADMAP.md`, `docs/VALIDATION.md`, `scripts/validate-local.sh`, and the
OpenSpec change.

- `SKILL.md` remains the always-loaded router and fail-closed hard-boundary
  summary, not only a directory.
- Reference files extend `SKILL.md`; they do not weaken it, override it, or
  grant authorization by themselves.
- Every current `template_contains "SKILL.md"` hard-boundary phrase remains
  individually checked against `SKILL.md`.
- PM/Advisor independent first-pass and no-peek review remain in `SKILL.md`.
- Advisor output remains unverified evidence rather than authority.
- Handoff, successor packet, template, memory, prior consensus, and other agent
  output remain evidence rather than authorization.
- `SKILL.md` has mandatory reference routing for git/default exclusions,
  OpenSpec, CLI trust, rollover/handoff, and role-output domains.
- Missing or unread required references fail closed before the affected domain
  action continues.
- Validation checks the reference files, traceability map, routing statements,
  and representative scenarios for commit/push, tag/release/default exclusions,
  OpenSpec-backed work, Small Task Mode at git gates, handoff/rollover, CLI
  trust, and missing PM/Advisor fail-closed behavior.
- Line-count reduction is advisory only; capability and constraint preservation
  take precedence.

## v0.4.13 Leader Delegation And Cleanup Discipline Checks

Run these checks for the `v0.4.13` delegation and cleanup set: `SKILL.md`,
`references/`, `templates/`, `README.md`, `CHANGELOG.md`, `docs/TODO.md`,
`docs/ROADMAP.md`, `docs/VALIDATION.md`, `scripts/validate-local.sh`, and the
OpenSpec change.

- Role-agent cleanup or close actions are sequential and never parallel.
- Normal cleanup order is Worker, Reviewer, PM, then Advisor, while any role
  still needed for a required gate, cleanup-impact judgment, unresolved P0/P1
  review, post-action review, or Owner decision remains open.
- Cleanup/close means role-agent teardown or lifecycle hygiene only.
- Cleanup failure is non-blocking only when delivery evidence is already
  confirmed from evidence in hand and task, git, validation, CI/status,
  secret-safety, authorization, and required role evidence are unaffected.
- Cleanup failure cannot weaken validation, PM/Advisor/Reviewer, git,
  CI/status, secret-scan, release, or authorization gates.
- Cleanup failure escalates to blocking severity when it prevents confirming
  task state, git state, validation state, CI/status state, secret safety,
  authorization state, or required role evidence.
- Final closeout and handoff templates record role cleanup status, cleanup
  result by role, delivery-evidence impact, and the reason a non-blocking
  cleanup failure does not affect delivery evidence.
- Leader direct execution beyond small connective edits is treated as an
  exception for Medium, Complex, OpenSpec-backed, multi-file,
  implementation-heavy, or context-heavy work.
- More than 2 files or roughly 80 diff lines is a self-check trigger rather
  than an automatic correctness failure.
- When the Leader work-budget self-check trigger is reached, the Leader
  dispatches a bounded Worker or records a concrete exception explaining why
  direct Leader execution is safer.
- Worker-first context control dispatches bounded Worker slices before Leader
  context grows toward rollover pressure when practical.
- Worker-first context control does not require Worker dispatch for narrow
  low-risk edits or gate commands.
- Worker assignment and return templates preserve bounded scope, required
  evidence, stop conditions, cleanup or handoff expectations, and summarized
  raw-output handling.
- Validation checks anchor presence and template consistency, not runtime
  compliance with cleanup or delegation behavior.
- Documentation does not add automatic cleanup, automatic spawning, automatic
  diff-size measurement, automatic repair, CI automation, release automation,
  git authorization, release authorization, or gate bypass.

## v0.4.14 Adoption Scenarios And Adapter Guardrails Checks

Run these checks for the `v0.4.14` adoption and adapter guardrail set:
`README.md`, `docs/ADOPTION.md`, `docs/INSTALLATION.md`, `docs/ADAPTERS.md`,
`examples/`, `CHANGELOG.md`, `docs/TODO.md`, `docs/ROADMAP.md`,
`docs/VALIDATION.md`, `scripts/validate-local.sh`, and the OpenSpec change.

- README includes Quick Start, Use Cases, and Safety Boundaries near the top.
- README stays moderately concise and links deeper scenario detail to
  `docs/ADOPTION.md` rather than expanding `SKILL.md`.
- `docs/ADOPTION.md` covers documentation tasks, release preparation,
  long-running project work, cross-conversation handoff, and ordinary small
  tasks.
- Adoption guidance states that copying, installing, invoking, or adapting the
  protocol transfers only workflow/checklist structure, not authorization,
  validation freshness, workspace trust, role continuity, secret access, or
  external-effect permission.
- Installation guidance distinguishes adopting the workflow protocol from
  installing the Codex reference adapter.
- Adapter guidance includes an adapter guide template and review checklist.
- Adapter guidance does not create runtime-specific Claude, OpenClaw, Hermes
  Agent, or other runtime guide pages that look validated before real testing.
- Runtime wording continues to label unvalidated non-Codex runtimes as planned
  guidance or compatible patterns, not fully supported adapters.
- Examples include release-preparation and long-running documentation
  workstream scenarios without authorizing publication, tag, release, GitHub
  metadata mutation, commit, or push outside the normal gates.
- Documentation does not add CI, release automation, automatic publication,
  automatic GitHub metadata mutation, automatic runtime adapter support,
  automatic link checking, semantic validation enforcement, or heavier
  `SKILL.md` load.

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
- Provider-level separation is distinguished from same-provider model or version variants.
- Current verified model records distinguish current routing authority from stale memory or handoff evidence.
- PM, Advisor, and substantive Worker lifecycle patience rules distinguish short silence from concrete failure.
- Installation and migration guidance preserves authorization and validation freshness boundaries.
- Skill invocation triggers are documented without implying automatic subagent spawning, external Advisor calls, workspace trust, git exits, CI/archive automation, or next-goal execution.
- Final Leader outputs include a plain-language closeout with what changed, actual verification evidence, mandatory uncertainty/skipped-check reporting, recommended next goals, and authorization state.
- Recommended next goals are advice only unless the Owner has already given explicit current-session authorization.
- CLI agent workspace-trust status, authorization source, target project root, setup state, and probe result are recorded when relevant.
- Owner-recorded CLI role assignment for the current project and workstream authorizes exact current-project workspace trust setup without a repeated Owner prompt.
- Stale, historical-only, superseded, or mismatched CLI role records do not authorize workspace trust setup.
- `trusted-verified` is used only after a minimal read-only probe succeeds.
- OpenSpec C-stage and C0 analysis are recorded when relevant.
- Leader state compaction preserves active current-state cards, evidence indexes, and archived history boundaries when long handoff or continuity state is involved.
- Local validation command output is recorded when it is relevant to commit, push, or closeout gates.
- Copyable templates remain evidence-capture aids and do not create new authorization paths.
- Same-model Advisor overrides and model-diversity degradation are explicit when they occur.
- Same-model PM/Advisor overrides and PM/Advisor model-separation degradation are explicit when they occur.
- Worker scope remains narrow and explicitly bounded.
- Reviewer does not review their own implementation.
- Leader direct execution remains narrow, explicitly labeled, and does not become hidden Worker execution.
- Leader work-budget guidance remains a self-check trigger rather than an
  automatic correctness failure.
- Worker-first context control dispatches bounded Worker slices before Leader
  context grows when practical, without requiring Worker dispatch for narrow
  low-risk edits or gate commands.
- Role-agent cleanup or close actions run sequentially and not in parallel.
- Cleanup/close remains role-agent teardown or lifecycle hygiene only.
- Cleanup failure is non-blocking only when delivery evidence is already
  confirmed from evidence in hand and required gates are unaffected.
- Cleanup failure is blocking when it prevents confirming task, git,
  validation, CI/status, secret-safety, authorization, or required role
  evidence.
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
- Public-facing documentation does not include local-only model-routing rules or personal memory defaults.
- Platform-facing documentation does not claim full support for unvalidated runtimes.
- Documentation does not authorize broader advisor access than `SKILL.md`.
- Documentation does not imply that Advisor model diversity expands context sharing, authorizes secrets, or proves correctness.
- Documentation does not imply that trusted Advisor context authorizes secrets, unrelated projects, broad dumps, or irrelevant data.
- Documentation does not imply that CLI workspace trust can be applied globally or to unrelated directories by default.
- Documentation does not imply that Owner-recorded CLI role assignment authorizes parent-directory trust, home-directory trust, all-repository trust, dangerous permission bypass, broad file access, secrets, credentials, browser data, global policy changes, git actions, CI, deployment, release, publication, or external effects.
- Documentation does not imply that stale handoffs, historical-only records, superseded records, or mismatched project memories authorize current workspace trust setup.
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
