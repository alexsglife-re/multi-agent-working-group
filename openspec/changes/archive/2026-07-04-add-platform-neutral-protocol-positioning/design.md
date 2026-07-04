## Context

The public `v0.4.10` release presents the repository primarily as a Codex
skill. The underlying workflow is broader: Leader, PM, Advisor, Worker,
Reviewer, handoff, validation, and git/release gates can be applied by multiple
agent runtimes if the runtime can preserve role boundaries and evidence
capture.

The public documentation needs a sharper distinction between the reusable
protocol and the current Codex packaging. It should also avoid claiming full
support for Claude, OpenClaw, Hermes Agent, or other runtimes before adapter
guides are validated.

## Goals / Non-Goals

**Goals:**

- Reposition the project as a portable multi-agent workflow protocol.
- Keep Codex as the reference packaged adapter.
- Add adapter guidance and maturity labels for Codex, Claude, OpenClaw, Hermes
  Agent, and future runtimes.
- Make installation docs distinguish generic protocol adoption from Codex
  skill installation.
- Add validation checks so future edits do not regress into Codex-only wording
  or overclaim unverified adapter support.

**Non-Goals:**

- Do not rewrite the core protocol in `SKILL.md`.
- Do not add runtime automation, subprocess orchestration, CI, packaging
  automation, or release automation.
- Do not claim Claude, OpenClaw, or Hermes Agent are fully supported adapters
  until their adapter guides are validated in real use.
- Do not import runtime code or reference-project implementation details.

## Decisions

1. **Protocol-first positioning**

   Public documentation will describe Multi-Agent Working Group as a portable
   protocol first, with Codex as the reference adapter. This keeps the public
   value proposition accurate without breaking the current Codex skill entry
   point.

2. **Adapter maturity labels**

   Adapter docs will use explicit maturity labels:

   - `reference adapter`: packaged and validated in this repository.
   - `adapter guide planned`: runtime named as a target, but not validated.
   - `compatible pattern`: the protocol can be mapped manually, but support is
     not packaged.
   - `unsupported`: known mismatch or missing required capability.

   This prevents marketing language from becoming a false support claim.

3. **Single adapter overview before per-runtime guides**

   This change adds `docs/ADAPTERS.md` as the canonical overview. Per-runtime
   files can be added later after real validation. The overview will include a
   mapping checklist that future adapter documents must answer.

4. **Validation by markers, not semantic parsing**

   `scripts/validate-local.sh` will add lightweight marker checks for v0.4.11.
   It will not attempt to prove that every runtime adapter works.

## Risks / Trade-offs

- **Risk: Users read runtime names as full support.** Mitigation: use maturity
  labels and repeated "not fully supported until validated" wording.
- **Risk: Existing Codex users think support was removed.** Mitigation: keep
  Codex as the reference adapter and keep Codex install instructions intact.
- **Risk: Validation becomes brittle.** Mitigation: check a small number of
  stable positioning markers rather than broad prose.
