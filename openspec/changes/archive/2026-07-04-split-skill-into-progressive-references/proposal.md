## Why

`SKILL.md` is now large enough that Codex commonly needs more than one read to
load it completely. That increases startup burden and makes ordinary skill
invocation heavier than necessary.

The change is needed now because the skill is public and increasingly used as a
portable protocol. Reducing read burden is useful only if it does not reduce the
skill's capability, safety constraints, or gate strength.

## What Changes

- Add progressive reference structure for long-form details currently embedded
  in `SKILL.md`.
- Keep `SKILL.md` as the authoritative always-loaded router plus hard-boundary
  summary.
- Move only long explanations, detailed procedures, examples, and templates into
  `references/` files.
- Add mandatory routing rules in `SKILL.md` for when a Leader MUST read each
  reference before acting.
- Preserve all hard constraints in `SKILL.md` in fail-closed summary form.
- Explicitly preserve PM/Advisor independent first-pass review, no-peek review,
  Advisor output as unverified evidence, and handoff/agent output as evidence
  rather than authority in `SKILL.md`.
- Forbid reducing or migrating the current `SKILL.md` validation anchor set out
  of `SKILL.md`; each current anchor phrase must remain checked against
  `SKILL.md` individually.
- Update local validation to check both `SKILL.md` and the reference files.
- Treat the line-count reduction target as advisory only; capability and
  constraint preservation takes precedence.

No behavior semantics should change in this release. This is a structure-only
refactor unless a separate future change explicitly proposes behavior changes.

## Capabilities

### New Capabilities

- `progressive-skill-references`: defines how the skill may use progressive
  reference files without weakening always-loaded constraints.

### Modified Capabilities

- `local-validation-tool`: require validation to preserve `SKILL.md` hard-boundary
  anchors and to check the new reference files without moving hard constraints
  out of the always-loaded router.

## Impact

- Affected files likely include `SKILL.md`, new `references/*.md`, README,
  CHANGELOG, docs/TODO, docs/ROADMAP, docs/VALIDATION,
  `scripts/validate-local.sh`, and OpenSpec artifacts.
- No runtime code, external service integration, CI, packaging automation,
  release automation, or agent orchestration automation is added.
- No commit, push, tag, release, deployment, secret, permission, auth, schema,
  or destructive-operation authorization is changed.
