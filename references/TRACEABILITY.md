# Progressive References Traceability

The v0.4.18 release includes two always-loaded `SKILL.md` anchors: mandatory routing to `references/review-context-efficiency.md` and the fail-closed quality-preservation boundary. Detailed packet, evidence-access, identity, state, retry, retention, and cleanup rules live in that reference; templates and local validation retain the corresponding fields and checks.

This map supports the v0.4.18 public release. It is evidence for PM/Advisor/Leader review and does not create authorization.

The v0.4.18 public release extends `references/review-context-efficiency.md` with three retention classes, OpenSpec and small-task lifecycle checkpoints, minimum durable audit evidence, and fail-closed non-destructive compaction. It preserves original-evidence access and keeps destructive removal exact-scope Owner-only.

Its growth claim is limited to active and retransmitted review context. Stored lifecycle-bound files may continue growing until exact-scope Owner-authorized removal; no storage cap is claimed.

## Current SKILL.md Validation Anchors

All current `template_contains "SKILL.md"` hard-boundary anchor phrases remain in `SKILL.md` and remain individually checked by `scripts/validate-local.sh`.

v0.4.15 adds Fast Path / Slow Path reading-order guidance without demoting any
current `SKILL.md` hard-boundary anchor. Fast Path is a reading-order shortcut
only; it is not Small Task Mode, does not change role or git-gate requirements,
and never skips a mandatory reference once a routed domain is touched.

Anchor demotion is not a validation-maintenance shortcut. Moving any current
`SKILL.md` hard-boundary anchor to a reference file would be an explicit
boundary change requiring separate review, traceability, and Owner-visible
authorization.

## Section Mapping

| Current area | New SKILL.md summary | Reference detail |
| --- | --- | --- |
| Advisor minimum permissions | Advisor Minimum Permissions | references/cli-trust.md |
| Invocation and startup | When To Use This Skill; Startup Checklist | references/role-templates-and-output.md |
| Model routing and CLI trust | CLI Trust And Model Routing | references/cli-trust.md |
| Agent lifecycle and patience | Agent Lifecycle And Delegation | references/role-templates-and-output.md |
| Context budget, Worker-first context control, and rollover | Rollover And Handoff | references/context-rollover.md |
| Progressive Leader active-state selection, counting, retention, and transitions | Rollover And Handoff | references/leader-state-profiles.md |
| Risk/severity/failure/git gates | Risk And Severity; Git Exit And Default Exclusions | references/git-exit-rules.md |
| OpenSpec C0-C4 and local validation | OpenSpec Lifecycle; Validation And Verification | references/openspec-lifecycle.md |
| Startup packets, role output templates, cleanup status, and Leader work budget | Output Requirements | references/role-templates-and-output.md |
| Handoff and successor startup | Rollover And Handoff | references/context-rollover.md |
| Review packet retention, compaction, and cleanup eligibility | Context-efficient role review | references/review-context-efficiency.md |

## Progressive Leader-State Profile Anchors

This section maps the v1.0.0 development target only; it is not part of the
current v0.4.18 public-release claim.

`SKILL.md` now mandates `references/leader-state-profiles.md` before profile
selection, refresh, rendering, or transition and retains the hard-boundary
summary that structural inventory classifies while size only warns and
semantic/control failures remain fail-closed. The reference owns:

- current-active-only deterministic inventory and normalized relationship keys;
- Compact, Standard, and `hierarchical-required` classification;
- complete accepted retention-floor routing, canonical ownership, stable
  evidence pointers, and derived-copy freshness;
- event-driven refresh, immediate promotion, two-checkpoint explicit demotion,
  and no-background-mutation rules; and
- provisional non-blocking structural classification, warning-only line/byte
  diagnostics, and independent fail-closed semantic/control enforcement.

`references/context-rollover.md` integrates profile-aware Opportunity skeletons
and complete successor packets without changing accepted rollover states or
transferring authorization. Local validation may check registration, anchors,
rendered structure, and deterministic fixtures; it cannot prove inventory
truth, semantic sufficiency, role execution, or authorization validity.

## Explicit Hard Boundaries Added For v0.4.12

These boundaries remain in `SKILL.md` and have validation anchors:

- PM and Advisor expected output is independent first-pass / no-peek review before consensus.
- OpenSpec PM and Advisor lifecycles are runtime-proven and scoped to one C1-C4 stage by default; every changed checkpoint still has a fresh Review ID and decision state, while C0 and non-OpenSpec distinct checkpoints remain short-lived.
- Cross-stage and mandatory-trigger transitions record exact runtime evidence, a canonical reason, actor `leader|owner`, timezone-qualified decision time, and a verified successor packet without carrying old decisions or authorization.
- Advisor output is unverified evidence rather than authority.
- Handoff or prior agent output is evidence rather than authorization.

## Explicit Hard Boundaries Added For v0.4.13

These boundaries remain in `SKILL.md` and have validation anchors:

- Role-agent cleanup or close actions run sequentially, never in parallel.
- Cleanup/close means role-agent teardown or lifecycle hygiene only.
- Cleanup failure may be reported as degraded cleanup evidence rather than
  delivery failure only when delivery evidence is already confirmed from
  evidence in hand and required gates remain unaffected.
- Validation, PM/Advisor/Reviewer, git, CI/status, secret-scan, release/tag, or
  authorization failures must not be reclassified as non-blocking cleanup.
- Cleanup failure is blocking when it prevents confirming task state, git state,
  validation state, CI/status state, secret safety, authorization state, or
  required role evidence.
- More than 2 files or roughly 80 diff lines is a self-check trigger rather
  than an automatic correctness failure.
- Worker-first context control dispatches bounded Worker slices before Leader
  context grows toward rollover pressure when practical.
- Local validation checks anchor presence and template consistency, not runtime
  compliance with cleanup or delegation behavior.

## Explicit Guardrails Added For v0.4.15

These guardrails remain in `SKILL.md` and have validation anchors:

- Fast Path is a reading-order shortcut only.
- Fast Path is not Small Task Mode.
- Fast Path never skips a mandatory reference once a routed domain is touched.
- Slow Path covers git exits, OpenSpec, CLI trust or model routing, role
  dispatch or output, rollover or handoff, release or publication, secrets,
  auth, security, permission, schema, destructive, irreversible, and other
  default-exclusion work.
- Current `SKILL.md` hard-boundary anchors remain in `SKILL.md`; anchor
  demotion requires separate review and Owner-visible authorization.
