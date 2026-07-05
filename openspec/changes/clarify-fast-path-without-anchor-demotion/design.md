## Context

`SKILL.md` is currently the always-loaded router and hard-boundary summary. v0.4.12 intentionally moved long-form details into `references/` while preserving hard-boundary anchors in `SKILL.md`, and v0.4.14 explicitly kept adoption scenarios out of `SKILL.md` to avoid heavier load.

The v0.4.15 planning review identified a useful improvement: make it easier for users and agents to know when they can stay on the main skill file and when they must load a reference. The same review also identified a reliability risk: if "reduce load" is interpreted as moving validated anchors out of `SKILL.md`, the always-loaded safety surface becomes weaker.

## Goals / Non-Goals

**Goals:**

- Clarify Fast Path / Slow Path as reading order, not gate reduction.
- Explicitly distinguish Fast Path reading order from Small Task Mode role rules.
- Keep action-triggered mandatory reference routing as the controlling rule.
- Preserve all current `SKILL.md` hard-boundary validation anchors in `SKILL.md`.
- Add validation markers proving v0.4.15 does not silently demote anchors to references.
- Make future skill-load work safer by documenting the no-anchor-loss constraint.

**Non-Goals:**

- No broad compression of `SKILL.md`.
- No line-count target that overrides safety anchors.
- No demotion of `template_contains "SKILL.md"` checks to reference files.
- No automation, runtime behavior, CI, release automation, or agent spawning.
- No changes to commit, push, release, OpenSpec, cleanup, secret, auth, security, schema, or destructive-action gates.

## Decisions

1. **Use Fast Path / Slow Path language instead of deleting detail.**

   Fast Path means a narrow low-risk or read-only task can start from `SKILL.md`, project instructions, and only the references for domains actually touched. Slow Path means the task has entered a routed domain and must load the relevant reference before acting. This improves usage efficiency by reducing unnecessary reads without changing any gate.

2. **Keep action-triggered routing stronger than task classification.**

   A task can start as small and later reach a git, OpenSpec, CLI trust, role-output, rollover, release, secret, auth, security, schema, destructive, or irreversible action. The implementation must say that the action-triggered MUST-read route wins at that point.

3. **Separate Fast Path from Small Task Mode.**

   Fast Path is about which files to read first. Small Task Mode is about whether PM, Worker, and Reviewer roles are required for a narrow small low-risk task. The implementation must state that Fast Path does not grant Small Task Mode, remove role requirements, or change git-gate Advisor review requirements.

4. **Preserve all current `SKILL.md` anchors.**

   The local validation script already checks current hard-boundary phrases against `SKILL.md`. v0.4.15 adds explicit checks that the anchor set remains anchored to `SKILL.md` and that Fast Path cannot be used to bypass a reference read.

5. **Document anchor demotion as a separate Owner-visible decision.**

   If a future change intentionally moves a hard-boundary anchor out of `SKILL.md`, that is not a mechanical validation update. It must be treated as a boundary demotion requiring explicit review, traceability, and Owner-visible authorization.

## Risks / Trade-offs

- [Risk] Fast Path wording could be misread as permission to skip required references. -> Mitigation: state directly in `SKILL.md` that Fast Path never skips a mandatory reference once a routed domain is touched.
- [Risk] Fast Path wording could be confused with Small Task Mode role reduction. -> Mitigation: state directly in `SKILL.md` that Fast Path controls reading order only and does not grant Small Task Mode or change role gates.
- [Risk] Validation changes could silently repoint anchor checks from `SKILL.md` to references. -> Mitigation: add documentation and validation markers that no current `SKILL.md` anchor is demoted in this change.
- [Risk] The change may not reduce line count. -> Mitigation: accept that line-count reduction is advisory only; the efficiency gain is clearer reading order and fewer unnecessary reference reads.
- [Risk] Future contributors may re-open broad compression without checking reference coverage. -> Mitigation: add traceability guidance that anchor demotion is a separate reviewed decision, not a cleanup.
