## Context

The Owner wants agents to apply `multi-agent-working-group` automatically when a task fits the workflow, but does not want hidden automation that silently creates agents, calls external tools, or bypasses gates. The Owner also wants non-specialist-friendly closeout summaries after completed work.

v0.4.9 already clarified provider-level model separation, PM/Advisor and substantive Worker patience, and migration basics. v0.4.10 should build on that foundation without redoing it or hard-coding concrete models.

## Goals / Non-Goals

**Goals:**
- Define task traits that should trigger use or explicit consideration of this skill.
- State that skill invocation is workflow selection and evidence capture, not automatic role creation or authorization.
- Improve install/migration adoption guidance for new machines and projects.
- Require final Leader outputs to be understandable to a non-specialist Owner.
- Include next-goal recommendations after completed work without starting the next goal unless already authorized.
- Keep validation lightweight and marker-based.

**Non-Goals:**
- Do not add automatic agent spawning, subprocess orchestration, polling loops, or session registries.
- Do not add automatic external advisor calls.
- Do not add packaging, release publication, deployment, CI automation, or automatic repair.
- Do not transfer commit/push/CI/archive authorization across machines, projects, successor packets, or stale handoffs.
- Do not hard-code concrete PM, Advisor, Worker, or Reviewer model names into the portable skill.

## Decisions

1. Skill invocation uses task traits, not magic background automation.
   - Trigger traits include explicit Owner request, PM/Advisor/Worker/Reviewer coordination, external Advisor review, OpenSpec lifecycle work, medium or higher risk, delegated implementation, guarded commit/push, cross-conversation handoff, context rollover, or complex verification.
   - The Leader may still use Small Task Mode for narrow low-risk work when all conditions are met.

2. "Automatically call the skill" means select and apply the workflow.
   - It does not mean silently creating subagents, calling Claude or another external provider, trusting a workspace, committing, pushing, archiving, or starting the next goal.
   - Role dispatch, external calls, git exits, archive, and high-risk/default-exclusion actions still use their existing gates.

3. Migration guidance is an adoption checklist, not packaging automation.
   - The guide should help a future user copy/sync the skill and verify state.
   - It must plainly say what does not transfer: authorization, role continuity, validation freshness, workspace trust, stale handoff authority, secrets, and external-effect permission.

4. Closeout outputs must be plain-language friendly.
   - Completed work should explain what changed, what passed, what is still uncertain or not done, and the recommended next goal.
   - The next-goal recommendation is advice only unless the Owner has already authorized continuing.

## Risks / Trade-offs

- [Risk] "Automatic invocation" could be read as automatic subagent or external tool use. -> [Mitigation] Add explicit non-goals and validation markers that block automatic spawning/calls.
- [Risk] Closeout summaries become long or repetitive. -> [Mitigation] Require a concise plain-language shape rather than a verbose report.
- [Risk] Migration guidance duplicates v0.4.9. -> [Mitigation] Keep v0.4.10 focused on adoption checklists and non-specialist wording, while preserving v0.4.9 boundaries.
