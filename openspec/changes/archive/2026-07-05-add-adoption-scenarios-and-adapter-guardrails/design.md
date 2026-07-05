## Context

The repository already has strong protocol rules, adapter maturity labels, and
local validation. The remaining adoption gap is reader experience: the README
is useful but dense, installation guidance mixes protocol adoption with Codex
adapter setup, and adapter documentation needs a practical way to draft future
runtime guides without implying validated support.

The change is documentation-first and must preserve the progressive skill
reference model. `SKILL.md` should stay quick to load; detailed scenarios belong
in docs and examples.

## Goals / Non-Goals

**Goals:**

- Give first-time readers a quick path to understand how to use the protocol.
- Document scenario-based adoption paths for common task types.
- Keep README concise enough to scan while preserving enough substance to avoid
  over-compression.
- Clarify adapter guide drafting requirements without overclaiming Claude,
  OpenClaw, Hermes Agent, or other runtime support.
- Add lightweight validation anchors for the new documentation shape.

**Non-Goals:**

- Do not change the core behavior of `SKILL.md`.
- Do not create tags, releases, GitHub metadata changes, CI, packaging
  automation, automatic link checking, or publishing automation.
- Do not ship runtime-specific Claude, OpenClaw, or Hermes Agent adapter guides
  until real validation exists.
- Do not rewrite historical commit messages or old release history.

## Decisions

1. Add `docs/ADOPTION.md` instead of putting scenario detail in `SKILL.md`.
   This keeps the always-loaded skill path short and lets README link to a
   fuller usage guide.

2. Rename and compress README usage sections into Quick Start, Use Cases, and
   Safety Boundaries. The README should stay moderately informative, not a
   minimal landing page and not a full manual.

3. Treat adapter work as a template/checklist, not runtime-specific skeletons.
   This preserves the existing maturity labels and prevents readers from
   mistaking planned runtime guidance for validated support.

4. Add examples for release preparation and long-running documentation
   workstreams because these match the current positioning beyond pure code
   changes.

5. Update local validation with deterministic text anchors only. Validation
   should catch accidental removal of the new adoption and adapter guardrail
   docs, but it should not become a semantic policy engine.

## Risks / Trade-offs

- [Risk] README becomes too long again.
  -> Mitigation: keep scenario detail in `docs/ADOPTION.md` and link out from
  README.

- [Risk] Adapter guide template looks like runtime support.
  -> Mitigation: keep runtime status table unchanged and require guide status,
  validation evidence, unsupported actions, and non-transferable-state sections.

- [Risk] Validation anchors become noisy or brittle.
  -> Mitigation: check stable headings and safety phrases, not every paragraph.

- [Risk] Users mistake adoption guidance for authorization.
  -> Mitigation: repeat that the protocol transfers workflow/checklists only,
  not permission, trust, validation freshness, or external-effect authority.
