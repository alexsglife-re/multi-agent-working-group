## Context

The repository already presents Multi-Agent Working Group as a portable
workflow protocol with Codex as the reference adapter. The current installation
guide focuses on Codex paths, while Claude Code official documentation supports
skills as `SKILL.md` folders with supporting files at personal or project
scope. OpenClaw and Hermes Agent remain planned adapter targets without
validated runtime guides.

The implementation must improve practical adoption without making the
always-loaded `SKILL.md` longer or weakening the existing adapter maturity
guardrails.

## Goals / Non-Goals

**Goals:**

- Give readers copyable Codex and Claude Code install paths.
- Explain that the repository is a bare skill folder, not a plugin package.
- Keep Claude Code guidance accurate but labeled below fully validated support.
- Keep OpenClaw and Hermes Agent as planned adapter guidance until real
  validation exists.
- Add validation checks that catch missing Claude Code install guidance and
  unsupported runtime overclaims.

**Non-Goals:**

- Do not install anything into `~/.claude/skills` or project `.claude/skills`.
- Do not create a plugin, marketplace package, or installation script.
- Do not validate OpenClaw or Hermes Agent runtime behavior in this change.
- Do not change `SKILL.md` core behavior unless required by review.
- Do not create a tag, release, deployment, or GitHub metadata update.

## Decisions

1. Keep `SKILL.md` behavior stable.
   - Rationale: v0.4.15 specifically protected skill-load efficiency and
     always-loaded anchors. Runtime install details belong in docs, not the
     always-loaded skill router.
   - Alternative considered: add Claude Code install notes to `SKILL.md`.
     Rejected because it increases load and does not affect task behavior.

2. Add `docs/RUNTIME_INSTALLATION.md`.
   - Rationale: Codex and Claude Code commands are useful, but README and the
     general installation guide should stay readable. A focused runtime
     installation page can carry copyable commands and boundaries.
   - Alternative considered: put all commands in README. Rejected because the
     README would become too long for first-time scanning.

3. Label Claude Code as install guidance available, validation pending.
   - Rationale: The file layout is compatible with Claude Code skills, but this
     repository has not yet validated a full Claude Code read/review/handoff/git
     gate workflow.
   - Taxonomy decision: keep Claude Code under the existing `adapter guide
     planned` maturity label and add "install guidance available; validation
     pending" as a status note, not as a fifth maturity label. Full support
     still requires real read, review, validation, handoff, and git-gate
     workflow evidence.
   - Alternative considered: mark Claude Code fully supported. Rejected because
     it would overstate validation evidence.

4. Keep OpenClaw and Hermes Agent at planned adapter guidance.
   - Rationale: They are target runtimes, but no package or validated workflow
     exists in this repository.
   - Alternative considered: add dedicated skeleton guides. Rejected because
     skeleton pages can look like support claims before validation.

5. Distinguish runtime installation commands from adapter guide skeletons.
   - Rationale: v0.4.14 validation intentionally prevents Claude/OpenClaw/Hermes
     runtime-specific guide skeletons that look like validated support. v0.4.16
     should allow a runtime installation command page only when it keeps adapter
     status labels, validation-pending language, and unsupported-action
     boundaries.
   - Alternative considered: disable the v0.4.14 guardrail. Rejected because
     the guardrail still protects against support overclaims.

## Risks / Trade-offs

- More docs can reduce readability -> keep README changes short and move
  commands to `docs/RUNTIME_INSTALLATION.md`.
- Claude Code behavior may evolve -> cite the guidance as current installation
  guidance and require runtime validation before support claims.
- Validation string anchors can be brittle -> follow the repository's existing
  deterministic marker pattern and keep checks scoped to critical wording.
- Users may confuse installation with authorization -> repeat
  non-transferable-state boundaries in runtime installation docs.
- Existing validation anchors may conflict with the new wording -> update the
  anchors so "install guidance available" remains a qualifier under planned
  guidance rather than a full-support claim.
