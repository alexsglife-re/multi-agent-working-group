# TODO

This file tracks near-term project work. It is a planning aid, not an authorization record. Commit, push, release, deployment, and external publication still require the gates described in `SKILL.md`.

## v0.4.0: Role Boundary And Operating Examples Stabilization

Goal: stabilize the documentation-first workflow around role boundaries, Leader direct execution, Worker delegation, blocked-state reporting, and git gates before adding automation.

### Version Metadata

- [x] Add `CHANGELOG.md`.
- [x] Add a `v0.4.0` changelog entry for role boundaries, examples, and validation docs.
- [x] Add a visible current-version note to `README.md`.
- [x] Confirm whether any agent metadata should carry the version number.

### Examples

- [x] Add small low-risk documentation task example.
- [x] Add blocked task example.
- [x] Add medium Worker delegation example.
- [x] Add commit gate example.
- [x] Add push gate example.
- [x] Add handoff or continuity recovery example.
- [x] Review examples for consistent wording around Advisor, Reviewer, Worker, Leader, Owner authorization, Small Task Mode, and the normal git gate rule.

### Role Boundary Promotion

- [x] Review `docs/ROLE_BOUNDARIES.md` and identify only the shortest stable rules to promote.
- [x] Update `SKILL.md` to clarify that Small Task Mode uses no PM, Worker, or Reviewer.
- [x] Update `SKILL.md` to clarify that Leader direct execution must be narrow, explicit, and low-risk.
- [x] Update `SKILL.md` to clarify that medium or higher work must not become hidden Worker execution by Leader.
- [x] Align `SKILL.md` normal non-high-risk commit and push wording with the PM plus Advisor gate.
- [x] Clarify that a normal push to `main` is allowed by the normal PM plus Advisor gate when all requirements pass and no protected-branch bypass or exception is needed.
- [x] Confirm `SKILL.md` still keeps high-risk and default-exclusion actions behind explicit Owner approval.
- [x] Verify that Reviewer remains conditional for documentation tasks and required for code or higher-risk gates as defined by the skill.

### Validation

- [x] Update `docs/VALIDATION.md` for `v0.4.0` stabilization checks.
- [x] Check that examples do not imply commit or push authorization outside the applicable git gates.
- [x] Check that push-gate examples distinguish normal `origin/main` push from Owner-only protected-branch bypass or exception actions.
- [x] Check that examples do not require Reviewer for small low-risk tasks.
- [x] Check that medium examples do not allow Leader to perform hidden Worker execution.
- [x] Check that `README.md`, `ROADMAP.md`, `docs/ROLE_BOUNDARIES.md`, examples, and `SKILL.md` remain consistent.
- [x] Confirm project docs remain English-only.

### Roadmap And Release Readiness

- [x] Update `docs/ROADMAP.md` to mark Stage 1 as mostly complete.
- [x] Update `docs/ROADMAP.md` to show Stage 2 as the `v0.4.0` focus.
- [x] Keep lightweight validation tooling, CI, packaging, and automation out of scope unless explicitly approved.
- [x] Run a final manual review before entering the applicable commit gate.

## v0.4.1: Advisor Model Diversity

Goal: make Advisor independence stronger by defaulting Advisor to a different AI model when available, while preserving bounded context, explicit Owner overrides, and existing review gates.

### OpenSpec

- [x] Create `add-advisor-model-diversity` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate the OpenSpec change.

### Skill Rules

- [x] Add Advisor model-diversity defaults to `SKILL.md`.
- [x] Require Leader to ask for Advisor model/provider when no project, session, continuity, or handoff record exists.
- [x] Record Advisor model/provider, diversity status, same-model override, and degradation reason in startup/handoff context.
- [x] Preserve minimum-necessary Advisor context, no-peek independence, Leader verification, and existing failure rules.

### Documentation And Validation

- [x] Update README, changelog, roadmap, and validation docs for v0.4.1.
- [x] Confirm same-model Advisor use is allowed only by explicit Owner request and is recorded as an override.
- [x] Confirm single-model environments are recorded as degradation rather than silently treated as model diversity.
- [x] Confirm model diversity is not described as a correctness guarantee or gate bypass.

## v0.4.2: CLI Trust And OpenSpec Lifecycle Closure

Goal: make CLI-based role agents, trusted Advisor context, PM/Advisor model separation, goal completion, and OpenSpec C0-C4 closure explicit before adding any automation.

### OpenSpec

- [x] Create `add-cli-trust-and-openspec-c0-lifecycle` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate and archive the OpenSpec change after implementation and git closeout.

### Skill Rules

- [x] Add CLI agent workspace-trust preflight rules to `SKILL.md`.
- [x] Clarify that an Owner-specified Advisor is a trusted bounded collaboration role, not an ordinary third-party service.
- [x] Require PM and Advisor to default to different AI models when model selection is available.
- [x] Block silent PM/Advisor same-model degradation unless the Owner explicitly approves and the override is recorded.
- [x] Define Owner goal completion as including applicable validation, commit, push, status review, post-result review, and OpenSpec archive.
- [x] Add OpenSpec C0 goal/task analysis before C1 proposal work when this skill and OpenSpec are used together.

### Documentation And Validation

- [x] Update README, changelog, roadmap, TODO, and validation docs for v0.4.2.
- [x] Add an OpenSpec C0-C4 lifecycle example.
- [x] Sync the updated `SKILL.md` to the global installed skill.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before commit, after commit, before push, and after push.

## v0.4.3: Leader State Compaction

Goal: keep Leader handoff and continuity documents compact by separating current state, evidence references, and archived history before adding automation.

### OpenSpec

- [x] Create `add-leader-state-compaction` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Skill Rules

- [x] Add the three-layer current state card, evidence index, and historical archive notes model to `SKILL.md`.
- [x] Require active handoff or ledger updates to be refreshed instead of append-only when context bloat is visible.
- [x] Preserve unresolved P0/P1, PM/Advisor findings, validation freshness, stop conditions, and git authorization state during compaction.

### Documentation And Validation

- [x] Add compact handoff example.
- [x] Update README, changelog, roadmap, TODO, and validation docs for v0.4.3.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## v0.4.4: Lightweight Local Validation Tooling

Goal: make the repeated README, SKILL, OpenSpec, version-marker, and installed-skill sync checks runnable through one local read-only command.

### OpenSpec

- [x] Create `add-local-validation-tool` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Local Tooling

- [x] Add `scripts/validate-local.sh`.
- [x] Keep the command read-only and no-network.
- [x] Support normal active-change validation and closeout validation requiring no active OpenSpec changes.
- [x] Check `SKILL.md` frontmatter, current version markers, accepted OpenSpec specs, OpenSpec validation, and installed global skill sync.

### Documentation And Validation

- [x] Update README, changelog, roadmap, TODO, validation docs, and `SKILL.md` for v0.4.4.
- [x] Run the local validation command.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## v0.4.5: Copyable Role Templates

Goal: make common PM, Advisor, Worker, Reviewer, C0, blocked, handoff, and git-gate outputs easy to copy without expanding old handoff documents.

### OpenSpec

- [x] Create `add-copyable-role-templates` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Templates

- [x] Add `templates/README.md`.
- [x] Add C0, PM, Advisor, Worker assignment, Worker return, Reviewer, blocked, compact handoff, and git gate templates.
- [x] Document how to handle legacy v0.3 or bloated handoff documents without rewriting history.
- [x] Confirm templates preserve unresolved P0/P1, validation freshness, evidence references, and authorization state.

### Documentation And Validation

- [x] Update README, changelog, roadmap, TODO, validation docs, and `SKILL.md` for v0.4.5.
- [x] Update local validation for v0.4.5 template checks.
- [x] Run the local validation command.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## v0.4.6: Leader Rollover Protocol

Goal: make Leader context rollover explicit enough to trigger in real long-running work without adding automatic successor conversation creation.

### OpenSpec

- [x] Create `add-leader-rollover-protocol` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and review.

### Skill Rules

- [x] Add context-budget fields and non-overlapping compression/summary thresholds.
- [x] Add `Rollover Strongly Recommended`.
- [x] Clarify that v0.4.6 automatically detects rollover conditions and prepares handoff evidence, but does not automatically create a successor conversation.
- [x] Define sealed-ready behavior before Worker dispatch, commit, push, CI, archive, or high-risk gates.
- [x] Require successor verification before continuing from a rollover packet.

### Templates And Validation

- [x] Add `templates/successor-startup-packet.md`.
- [x] Update compact handoff and template README for context-budget state, pending messages, conflicts, and single active current-state card handling.
- [x] Update README, changelog, roadmap, validation docs, and local validation checks for v0.4.6.
- [x] Run the local validation command.
- [x] Run OpenSpec validation and documentation checks.
- [x] Complete PM plus different-model Advisor review before archive and git closeout.

## v0.4.7: CLI Workspace Trust Setup Protocol

Goal: let Owner-recorded Claude CLI, Codex CLI, and similar CLI role assignments authorize exact current-project workspace trust setup without asking again, while keeping dangerous permission bypass, broad trust, secrets, and external effects out of scope.

### OpenSpec

- [x] Create `add-cli-workspace-trust-setup-protocol` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and validation.

### Skill Rules

- [x] Treat applicable Owner-recorded CLI role assignment as authorization for exact current-project trust setup.
- [x] Allow authorization sources from current instruction, global memory, project rules, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence.
- [x] Require source applicability verification before using a recorded assignment as authorization.
- [x] Add trust setup states and require `trusted-verified` only after a minimal read-only probe succeeds.
- [x] Preserve boundaries against parent-directory trust, home-directory trust, all-repo trust, unrelated project access, dangerous permission bypass, secrets, global policy changes, git actions, CI, deployment, release, publication, and external effects.

### Templates And Validation

- [x] Update C0, PM, Advisor, and blocked templates for trust authorization source, setup state, target root, and probe evidence.
- [x] Update README, changelog, roadmap, validation docs, and local validation checks for v0.4.7.
- [x] Run local validation and OpenSpec validation.
- [x] Sync the updated `SKILL.md` to the global installed skill.

## v0.4.8: Leader Rollover Opportunity Protocol

Goal: prepare rollover earlier at clean boundaries before context reliability degrades, without relying on platform-visible compression counts as actual totals and without inheriting authorization across successor contexts.

### OpenSpec

- [x] Create `add-rollover-opportunity-protocol` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and validation.

### Skill Rules

- [x] Add `Rollover Opportunity` as an early preparation state.
- [x] Require exactly one canonical ContextBudget state per check with highest applicable state winning.
- [x] Replace compression count confidence-only recording with count value, source, and confidence.
- [x] Preserve same-workstream PM plus Advisor gate automation while preventing successor authorization inheritance.
- [x] Add Leader delegation discipline for Medium, Complex, High-risk, or substantive Worker-suitable work.

### Templates And Validation

- [x] Update compact handoff and successor packet templates for v0.4.8 context-budget fields.
- [x] Add example coverage for Owner-reported compression undercount and early rollover opportunity preparation.
- [x] Update README, changelog, roadmap, validation docs, and local validation checks for v0.4.8.
- [x] Run local validation and OpenSpec validation.
- [x] Sync the updated `SKILL.md` to the global installed skill.

## v0.4.9: Provider Separation, Agent Patience, And Migration Guidance

Goal: make Advisor diversity and PM/Advisor model separation mean provider-level separation by default, and make memory-driven model preferences current verified evidence rather than stale authority.

### OpenSpec

- [x] Create `clarify-model-source-and-provider-separation` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and validation.

### Skill Rules

- [x] Clarify that full Advisor diversity and PM/Advisor separation require different AI service providers when provider-level separation is available.
- [x] Define same-provider model, version, family, or capability variants as degraded or partial separation rather than full separation.
- [x] Add separation status vocabulary for provider-separated, model-family-separated, same-provider-variant, same-model-owner-override, degraded, and blocked.
- [x] Treat global memory, project memory, handoff, and startup-packet model preferences as hints to verify against the current workstream.
- [x] Define current verified model records for provider/model per role, source, current verification, separation status, and override or degradation evidence.
- [x] Clarify PM/Advisor lifecycle patience so short silence during substantive review is not treated as role failure.
- [x] Extend lifecycle patience to complex, implementation-heavy, validation-heavy, or otherwise substantive bounded Worker slices.
- [x] Add installation and migration guidance without packaging automation, release publication, or authorization transfer.

### Templates And Validation

- [x] Update C0, compact handoff, successor startup packet, and template README fields for provider/model source and separation status.
- [x] Update PM, Advisor, Worker, compact handoff, successor startup, and blocked templates with patience/lifecycle fields.
- [x] Add `docs/INSTALLATION.md` and link it from README and roadmap.
- [x] Update README, changelog, roadmap, validation docs, and local validation checks for v0.4.9.
- [x] Run local validation and OpenSpec validation.
- [x] Sync the updated `SKILL.md` to the global installed skill.

## v0.4.10: Invocation, Migration, And Plain-Language Closeout Guidance

Goal: make future agents automatically select this workflow when task traits fit, help people migrate or adopt the skill safely, and make completed work summaries easy for non-specialist Owners to read.

### OpenSpec

- [x] Create `add-v0410-invocation-migration-closeout-guidance` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Archive the OpenSpec change after implementation and validation.

### Skill Rules

- [x] Add task-trait guidance for when agents should use or explicitly consider `multi-agent-working-group`.
- [x] Clarify that automatic skill invocation means workflow/checklist reasoning only, not automatic spawning, external Advisor calls, workspace trust, commit, push, archive, CI, or next-goal execution.
- [x] Require plain-language closeout summaries that separate what changed, what was actually verified, what remains uncertain or was not checked, and recommended next goals.
- [x] Clarify that next-goal recommendations are advice only unless the Owner has already given explicit current-session authorization.

### Templates And Validation

- [x] Update state-carrying templates with closeout and next-goal fields.
- [x] Add or update installation/adoption guidance and invocation examples.
- [x] Update README, changelog, roadmap, validation docs, and local validation checks for v0.4.10.
- [x] Run local validation and OpenSpec validation.
- [x] Sync the updated `SKILL.md` to the global installed skill.

## v0.4.11: Platform-Neutral Protocol Positioning

Goal: present Multi-Agent Working Group as a portable multi-agent workflow
protocol with Codex as the reference packaged adapter, while documenting Claude,
OpenClaw, Hermes Agent, and other runtimes through explicit adapter maturity
labels.

### OpenSpec

- [x] Create `add-platform-neutral-protocol-positioning` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate and archive the OpenSpec change after implementation and review.

### Documentation

- [x] Update README first-screen positioning, layout, usage, validation, and current status for v0.4.11.
- [x] Add `docs/ADAPTERS.md` with maturity labels and runtime mapping checklist.
- [x] Update installation guidance to separate generic protocol adoption from Codex reference-adapter installation.
- [x] Update roadmap, changelog, TODO, and validation docs for v0.4.11.

### Validation

- [x] Update local validation checks for platform-neutral positioning markers.
- [x] Run local validation and OpenSpec validation.
- [x] Complete PM plus Advisor review before archive and git closeout.

## v0.4.12: Progressive Skill References

Goal: reduce ordinary skill-read burden by moving long-form detail into
progressive references while keeping `SKILL.md` as the always-loaded
fail-closed hard-boundary summary.

### OpenSpec

- [x] Create `split-skill-into-progressive-references` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Complete PM plus Advisor proposal review emphasizing no capability or constraint reduction.
- [x] Validate and archive the OpenSpec change after implementation and review.

### Implementation

- [x] Add progressive reference files and traceability map.
- [x] Refactor `SKILL.md` into a router plus hard-boundary summary.
- [x] Preserve existing `SKILL.md` validation anchors and add evidence-boundary anchors.
- [x] Update local validation checks for references and routing.
- [x] Update README, changelog, TODO, roadmap, and validation docs for v0.4.12.

### Validation

- [x] Run local validation, OpenSpec validation, and diff whitespace checks.
- [x] Complete PM plus Advisor review that confirms no skill capability or constraint was reduced.

## v0.4.13: Leader Delegation And Cleanup Discipline

Goal: keep long multi-agent work from growing the Leader context unnecessarily
and make end-of-task role-agent cleanup orderly without weakening delivery
gates.

### OpenSpec

- [x] Create `add-leader-delegation-and-cleanup-discipline` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Complete PM plus Advisor proposal review emphasizing no capability or
  constraint reduction.
- [x] Validate and archive the OpenSpec change after implementation and review.

### Implementation

- [x] Add sequential role-agent cleanup rules and cleanup failure boundaries to
  `SKILL.md` and references.
- [x] Add Leader work-budget self-check guidance and Worker-first context
  control.
- [x] Update compact handoff, successor startup, Worker assignment, and Worker
  return templates with cleanup/delegation fields.
- [x] Update local validation checks for cleanup and delegation anchors.
- [x] Update README, changelog, TODO, roadmap, and validation docs for v0.4.13.

### Validation

- [x] Run local validation, OpenSpec validation, representative anchor checks,
  and diff whitespace checks.
- [x] Complete PM plus Advisor review that confirms fail-closed gates were not
  weakened.

## v0.4.14: Adoption Scenarios And Adapter Guardrails

Goal: make the protocol easier for first-time readers to adopt in concrete
scenarios while preventing unvalidated runtime adapter guidance from looking
like supported integration.

### OpenSpec

- [x] Create `add-adoption-scenarios-and-adapter-guardrails` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate and archive the OpenSpec change after implementation and review.

### Documentation

- [x] Add `docs/ADOPTION.md` with scenario guidance.
- [x] Update README with Quick Start, Use Cases, Safety Boundaries, and concise
  deeper-doc links.
- [x] Update `docs/INSTALLATION.md` to distinguish protocol adoption from Codex
  reference-adapter installation.
- [x] Update `docs/ADAPTERS.md` with adapter guide template and review
  checklist guardrails.
- [x] Add release-preparation and long-running documentation examples.

### Validation

- [x] Update validation docs and local validation anchors for v0.4.14.
- [x] Run local validation, OpenSpec validation, whitespace checks, and
  required PM plus Advisor review before git closeout.

## v0.4.15: Fast Path And Anchor Guardrails

Goal: make first-load reading order clearer without reducing the always-loaded
`SKILL.md` safety surface.

### OpenSpec

- [x] Create `clarify-fast-path-without-anchor-demotion` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Validate and archive the OpenSpec change after implementation and review.

### Skill Rules

- [x] Add Fast Path and Slow Path reading-order guidance to `SKILL.md`.
- [x] Clarify that Fast Path is not Small Task Mode and does not change role or
  git-gate requirements.
- [x] Clarify that Fast Path never skips a mandatory reference once a routed
  domain is touched.
- [x] Preserve all current `SKILL.md` hard-boundary anchors in `SKILL.md`.

### Documentation And Validation

- [x] Update traceability and validation docs for v0.4.15.
- [x] Update local validation anchors for Fast Path and no silent anchor
  demotion.
- [x] Confirm the current `template_contains "SKILL.md"` check count did not
  decrease from the v0.4.14 baseline.
- [x] Run local validation, OpenSpec validation, whitespace checks, and required
  PM plus Advisor plus Reviewer review before git closeout.

## v0.4.17: Role Review Context Efficiency (Published July 12, 2026)

- [x] Add stable-baseline plus incremental PM and Advisor packet rules.
- [x] Preserve no-peek first passes and original-evidence access.
- [x] Add review identity, invocation states, and safe linked retry guidance.
- [x] Keep public v0.4.16 separate during development, then promote v0.4.17 only after explicit Owner release authorization.
- [x] Complete independent review, git closeout, OpenSpec archive, and archive validation.

The completed release does not authorize any future tag, release, deployment, or publication.

## v0.4.18: Review Packet Retention And Cleanup (Development)

- [x] Define permanent protocol, durable audit, and lifecycle-bound working-material classes.
- [x] Define OpenSpec C1-C4 checkpoints and final applicable gates for non-OpenSpec tasks.
- [x] Preserve complete role reasoning, invocation identity, validation, evidence pointers, and retry lineage.
- [x] Add fail-closed blockers and explicit non-destructive compaction semantics.
- [x] Add cleanup checklist, positive/negative example anchors, and deterministic cleanup-predicate cases.
- [x] Scope growth claims to active/retransmitted context; do not claim a storage cap before exact-scope Owner-authorized removal.
- [ ] Complete implementation review, normal git closeout, OpenSpec sync/archive, and archive validation.
- [ ] Publish only after separate explicit Owner authorization for tag/release/publication.

## v0.4.16: Cross-Runtime Installation And Adapter Guardrails

Goal: document Codex and Claude Code installation paths while keeping runtime
support labels evidence-based.

### OpenSpec

- [x] Create `add-cross-runtime-installation-guidance` OpenSpec change.
- [x] Add proposal, design, spec, and tasks artifacts.
- [x] Complete C1 PM and Advisor review with no unresolved P0/P1.
- [x] Validate and archive the OpenSpec change after implementation and review.

### Runtime Installation

- [x] Add `docs/RUNTIME_INSTALLATION.md` with Codex and Claude Code install
  paths.
- [x] Keep Claude Code under `adapter guide planned` with install guidance
  available and validation pending.
- [x] Keep OpenClaw and Hermes Agent as planned adapter guidance until
  validation evidence exists.
- [x] Clarify that the repository is a bare skill folder rather than a plugin
  package.
- [x] Preserve non-transferable authority, workspace trust, validation
  freshness, role continuity, and secret-access boundaries.

### Documentation And Validation

- [x] Update README, installation, adapter, roadmap, TODO, changelog, and
  validation docs for v0.4.16.
- [x] Update local validation anchors for runtime installation guidance and
  support-overclaim prevention.
- [x] Run local validation, OpenSpec validation, whitespace checks, and required
  PM plus Advisor plus Reviewer review before git closeout.

## Later

- [ ] Decide whether installation guidance should later become packaging automation.
- [ ] Add per-runtime adapter guides for Claude, OpenClaw, and Hermes Agent after real validation.
- [ ] Consider CI only after the manual workflow is stable.
