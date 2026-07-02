## Why

Real use after v0.4.6 showed that Claude CLI or Codex CLI can still block on
workspace trust prompts even when the Owner has already assigned that CLI to a
PM, Advisor, Worker, or Reviewer role. The current rule reports
`workspace-trust-blocked`, but it does not clearly allow the Leader to complete
current-project trust setup from an already recorded Owner role assignment.

## What Changes

- Treat an Owner-recorded CLI role assignment as authorization to complete
  workspace trust setup for the exact current project root.
- Allow that Owner-recorded assignment to come from the current conversation,
  global memory, project rules, project memory, handoff, startup packet,
  continuity record, ledger, template, or verified OpenSpec evidence.
- Require the Leader to verify that the source applies to the current project
  and workstream before using it as authorization.
- Keep trust setup tightly scoped to the current project root and assigned CLI
  role.
- Require a minimal read-only probe after trust setup before relying on CLI
  output.
- Preserve hard boundaries: no dangerous permission bypass, no unrelated
  directory trust, no secrets, no global policy expansion, and no git or
  external-effect authorization.
- Update templates, validation guidance, and local validation checks for the
  new v0.4.7 protocol.

## Capabilities

### New Capabilities

- None.

### Modified Capabilities

- `cli-trust-and-openspec-lifecycle`: Adds Owner-recorded CLI role assignment
  as current-project workspace trust setup authorization, with scope limits,
  source verification, state tracking, and post-setup probe requirements.

## Impact

- Affected documentation and workflow artifacts: `SKILL.md`, README,
  changelog, roadmap, TODO, validation docs, role templates, and local
  validation script.
- Affected OpenSpec artifacts: `cli-trust-and-openspec-lifecycle` delta spec
  and this change's proposal, design, and tasks.
- No runtime code, CLI wrapper, subprocess orchestration, credential access,
  dangerous permission bypass, commit/push authorization, release, deployment,
  or public publication is introduced.
