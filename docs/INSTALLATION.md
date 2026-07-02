# Installation And Migration

This guide explains how to use this skill from a local checkout, sync it into a global Codex skill directory, and migrate it to another machine or project.

It is documentation-only. It does not create a release, install a package, publish the skill, grant git authorization, or migrate active workstream approval.

## Prerequisites

- A local checkout of this repository.
- OpenSpec CLI available on the machine where validation will run.
- Codex configured to read either this repository's `.codex/skills` entries or the global skill directory.

## Use From This Checkout

From the repository root:

```sh
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
```

Use `--skip-global-skill` only while developing local changes before the global installed skill has been synced.

## Optional Global Skill Sync

The installed global skill is normally:

```text
~/.codex/skills/multi-agent-working-group/SKILL.md
```

After local changes are reviewed and ready to become the installed skill, copy the repository `SKILL.md` to that path using the machine's normal file-copy method, then run:

```sh
./scripts/validate-local.sh
```

The validation command compares the repository skill with the global installed skill when the global file exists.

## Migrate To Another Machine

Copy the repository or the skill bundle to the target machine, then verify from the target checkout:

```sh
git status --short --branch
openspec list --json
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
```

If the skill should be installed globally on that machine, sync `SKILL.md` into that machine's global Codex skill directory and rerun:

```sh
./scripts/validate-local.sh
```

Do not migrate secrets, credentials, API keys, browser data, unrelated project files, or local machine-specific trust state.

## Adopt In Another Project

When another project uses this skill:

1. Read that project's local instructions first.
2. Treat this skill as a workflow protocol that project rules may tighten.
3. Run the project's own validation in addition to this repository's validation.
4. Start each OpenSpec-backed workstream with C0 analysis.
5. Record current provider/model routing from Owner instruction, project rules, project memory, handoff, startup packet, or a current verified model record.

Do not hard-code a concrete PM, Advisor, Worker, or Reviewer model in this skill. Concrete provider/model selection belongs in Owner instructions, global memory, project memory, project rules, handoff, startup packets, or current verified records.

## What Does Not Transfer

Migration does not transfer:

- commit or push authorization;
- CI/status or archive authorization;
- release, deployment, publication, or external-effect permission;
- PM/Advisor agreement from another machine, project, or stale workstream;
- Worker results that have not been re-verified in the target workstream;
- validation freshness;
- role continuity;
- workspace trust for CLI tools;
- current-state authority from old handoffs or summaries.

Old handoffs, summaries, and archived notes are evidence only. Re-verify current git state, OpenSpec state, validation, role continuity, unresolved P0/P1, model-source records, and authorization before acting.
