## Context

The current v0.4.6 skill treats CLI workspace trust as a preflight. If Claude
CLI, Codex CLI, or a similar CLI agent reports an untrusted workspace, the
Leader records `workspace-trust-blocked` and does not rely on that role's
output. That avoids unsafe fallback, but it still leaves a practical gap: the
Owner may already have assigned Claude CLI or Codex CLI as PM, Advisor, Worker,
or Reviewer through current instructions, global memory, project rules,
handoff, startup packet, or continuity records. In that case, asking again for
current-project trust setup is redundant and stalls the workflow.

The upgrade should preserve the safety reason behind v0.4.2: workspace trust
must stay scoped to the current project, cannot become broad filesystem trust,
and cannot imply dangerous permission bypass or secret access.

## Goals / Non-Goals

**Goals:**

- Treat Owner-recorded CLI role assignment as authorization for exact
  current-project workspace trust setup.
- Define which evidence sources can carry Owner-recorded CLI role assignment.
- Require the Leader to verify the source applies to the current project and
  workstream before using it.
- Add explicit state vocabulary for trust setup progress and blockers.
- Require a minimal read-only probe after trust setup.
- Update documentation, templates, validation guidance, and local validation.

**Non-Goals:**

- Do not add a runtime CLI wrapper or subprocess orchestration.
- Do not copy ClawTeam/OpenClaw code or auto-confirm prompts silently.
- Do not use dangerous permission-bypass flags such as bypassing all
  permissions or sandbox approvals.
- Do not trust parent directories, home directories, all repositories, or
  unrelated projects.
- Do not authorize secrets, credentials, browser data, git actions, CI,
  deployment, release, or external effects.

## Decisions

### Decision 1: Owner-recorded role assignment implies current-project trust authorization

When a trusted source records that the Owner assigned Claude CLI, Codex CLI, or
another CLI-based agent to a role for the current workstream, the Leader may
complete workspace trust setup for the exact current project root without
asking again.

Alternative considered: require a fresh confirmation every time a trust prompt
appears. Rejected because the Owner's role assignment already authorizes the
bounded current-project setup needed for that role, and repeated prompts reduce
workflow reliability.

### Decision 2: Verify the authorization source before using it

Allowed sources include the current Owner instruction, global memory, project
rules, project memory, handoff, startup packet, continuity record, ledger,
template, or verified OpenSpec evidence. The Leader must verify that the source
is current for the project and workstream. Stale, historical-only, superseded,
or mismatched records do not authorize trust setup.

Alternative considered: trust any old handoff or memory entry automatically.
Rejected because this would let stale context authorize current local setup.

### Decision 3: Keep a small state vocabulary

The protocol will use:

```text
not-needed
preflight-needed
owner-recorded-role-authorized
trust-setup-attempted
trusted-verified
blocked
```

`owner-confirmation-needed` remains an exceptional state for broader trust
targets, stale or missing authorization records, dangerous permission bypass,
secret access, global policy changes, or other scope expansion.

Alternative considered: keep only `workspace-trust-blocked`. Rejected because
it cannot distinguish a setup step that is already owner-authorized from a true
blocker.

### Decision 4: Probe after trust setup before using output

After trust setup, the Leader must run a minimal read-only probe before relying
on the CLI role's output. The probe should verify access to the exact current
project and avoid secrets or broad filesystem reads.

Alternative considered: treat trust setup as sufficient. Rejected because the
actual role may still be unable to read the workspace, may be in the wrong
directory, or may have failed for a tool-specific reason.

## Risks / Trade-offs

- [Risk] The rule could be read as global trust approval. -> Mitigation: repeat
  the exact current project root boundary in skill text, templates, and
  validation.
- [Risk] The rule could be confused with dangerous permission bypass. ->
  Mitigation: explicitly ban dangerous permission bypass and require Owner
  confirmation for any broader permission mode.
- [Risk] Stale handoff or memory could authorize setup incorrectly. ->
  Mitigation: require source applicability verification and treat stale records
  as `owner-confirmation-needed` or `blocked`.
- [Risk] More states add process overhead. -> Mitigation: keep states few and
  map them directly to C0, blocked, and review templates.

## Migration Plan

1. Update the delta spec for `cli-trust-and-openspec-lifecycle`.
2. Update `SKILL.md` with the v0.4.7 protocol.
3. Update README, changelog, roadmap, TODO, and validation docs.
4. Update C0, blocked, PM, and Advisor templates with trust authorization and
   probe fields.
5. Update local validation checks and version markers.
6. Sync the repository `SKILL.md` to the installed global skill.
7. Validate, archive the OpenSpec change, and rerun closeout validation.

Rollback is documentation-only: revert the v0.4.7 docs/spec/template/script
changes if the rule proves too broad.
