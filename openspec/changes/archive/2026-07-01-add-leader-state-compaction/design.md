## Context

The skill already has ContextBudget states, a minimum handoff packet, PM/Advisor continuity memory guidance, and a warning that bulky raw material should be summarized and referenced. Those rules help detect context pressure, but they do not yet define how a Leader should keep active handoff state small over time.

The local reference projects `HKUDS/ClawTeam` and `win4r/ClawTeam-OpenClaw` split state across tasks, inboxes, events, plans, sessions, and workspace registries. The transferable rule-level idea is not automation; it is layering state so that the active view stays compact while raw evidence remains reachable.

## Goals / Non-Goals

**Goals:**

- Define a three-layer Leader state model: current state card, evidence index, and historical archive notes.
- Require active handoff or ledger refresh to replace stale repeated narrative with current verifiable state.
- Add clear rules for what belongs in active handoff text versus evidence references versus archived history.
- Add examples and validation checks that future agents can apply without a CLI or dashboard.

**Non-Goals:**

- Do not add automatic agent spawning, dashboards, mailbox tooling, or persistent runtime state.
- Do not copy reference project code or introduce their filesystem layout as a requirement.
- Do not weaken current PM/Advisor, OpenSpec, validation, git, or owner-authorization gates.
- Do not delete required reasoning, findings, objections, or key error details merely to save space.

## Decisions

### Decision 1: Use Three State Layers

Active Leader state will be split conceptually into:

- Current state card: the compact, current takeover state and the single active entry point.
- Evidence index: claim-indexed pointers to validation, diffs, agent outputs, commands, files, and decisions, including freshness and verification status.
- Historical archive notes: completed stage detail, old handoffs, long logs, and superseded narrative.

Alternative considered: add only a shorter handoff template. Rejected because template-only guidance still encourages copying old text into the next handoff.

### Decision 2: Refresh Active Handoff Instead Of Appending

The active handoff or ledger should be rewritten around the current state whenever it is updated. Old handoff text should be summarized and moved to an archive note or referenced as evidence.

Alternative considered: keep append-only handoffs but add headings. Rejected because append-only state is the root bloat pattern.

### Decision 3: Keep Evidence Reachable But Not Inline

Long logs, full diffs, complete command output, repeated agent outputs, and prior handoffs should be referenced by path, command, commit, or archive note when safe local evidence storage exists. The evidence index should be organized as claim -> evidence type/location -> freshness or currentness -> Leader verification status. The active state must retain the gate facts needed for takeover instead of replacing them with a vague pointer.

Alternative considered: aggressively delete old detail. Rejected because continuity still needs auditability and later verification.

### Decision 4: Validate Compaction As A Workflow Rule

Validation should check that documentation does not require large repeated handoff narratives and that examples preserve PM/Advisor findings, unresolved P0/P1, validation state, and next action.

Alternative considered: postpone validation until automation exists. Rejected because the project is intentionally documentation-first.

## Risks / Trade-offs

- [Risk] Over-compression could hide important blockers. -> Mitigation: active state must keep unresolved P0/P1, stop conditions, validation freshness, and next action.
- [Risk] Evidence references could become stale. -> Mitigation: references remain evidence only; new Leaders must re-verify current git/spec/validation state.
- [Risk] More rules could make the skill heavier. -> Mitigation: add one concise model and one concrete example before any automation.
- [Risk] Agents might treat archive notes as authority. -> Mitigation: repeat that archived history and old handoffs are evidence, not authorization.
