# Installation And Migration

This guide explains how to use this skill from a local checkout, sync it into a
global Codex skill directory, and migrate it to another machine or project.

It is documentation-only. It does not create a release, install a package, publish the skill, grant git authorization, or carry active workstream authority into a new place.

For v0.4.10, the main adoption rule is simple:

- copying or calling the skill gives you the workflow/checklist;
- it does not give you permission, fresh approval, or trusted continuity;
- every new machine, project, session, or handoff still has to verify its own current state.

## Prerequisites

- A local checkout of this repository.
- OpenSpec CLI available on the machine where full validation will run.
- Codex configured to read either this repository's `.codex/skills` entries or the global skill directory.

If OpenSpec is not installed, the skill can still be read and used as a
workflow protocol. OpenSpec-specific validation commands will not run until
OpenSpec is available.

## Install From GitHub

Clone the public repository:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git
cd multi-agent-working-group
```

Install the skill into the default Codex skill directory:

```sh
mkdir -p ~/.codex/skills/multi-agent-working-group
cp SKILL.md ~/.codex/skills/multi-agent-working-group/SKILL.md
```

Then restart Codex or refresh the environment that loads skills.

Verify the installed copy when OpenSpec is available:

```sh
openspec validate --all
./scripts/validate-local.sh
```

If you only want to validate the checkout without comparing against the global
installed copy:

```sh
./scripts/validate-local.sh --skip-global-skill
```

## Use From This Checkout

From the repository root:

```sh
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
```

Use `--skip-global-skill` only while developing local changes before the global installed skill has been synced.

Automatically using or calling this skill means applying its workflow and checklist reasoning only. It never creates external effects by itself, and it never transfers authority from a prior machine, project, thread, handoff, or role instance.

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

Global sync is a file-sync step, not an authority-sync step. Matching `SKILL.md` files do not prove that commit permission, push permission, review freshness, validation freshness, trusted workspace state, or handoff authority is still valid.

## Public Release Checklist

Before creating a public tag or GitHub Release:

```sh
git status --short --branch -uall
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
rg -n "(token|api[_-]?key|secret|password|private key|/Users/|gmail|Keychain|GITHUB_PAT)" .
```

Review every match from the content scan. Matches inside safety instructions
are usually expected. Real credentials, personal paths, private project names,
private logs, or local-only model-routing preferences are not safe for release.

Create the tag only after the release-preparation changes are committed:

```sh
git tag v0.4.10
```

Publish the tag and create the GitHub Release only when the maintainer intends
to perform the external publication step. A suggested first release title is:

```text
v0.4.10 - Initial public release
```

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

In plain language: moving the skill to another machine is like copying a checklist to another desk. The checklist moves. The permission to act does not.

## Adopt In Another Project

When another project uses this skill:

1. Read that project's local instructions first.
2. Treat this skill as a workflow protocol that project rules may tighten.
3. Run the project's own validation in addition to this repository's validation.
4. Start each OpenSpec-backed workstream with C0 analysis.
5. Record current provider/model routing from Owner instruction, project rules, project memory, handoff, startup packet, or a current verified model record.
6. Re-check current git state, validation state, trust state, and role continuity inside that project instead of assuming they carried over.

Do not hard-code a concrete PM, Advisor, Worker, or Reviewer model in this skill. Concrete provider/model selection belongs in Owner instructions, global memory, project memory, project rules, handoff, startup packets, or current verified records.

Using the skill automatically in another project means "follow this workflow unless the project has stricter rules." It does not mean "this project is now trusted" or "the old workstream is still in force."

## What Does Not Transfer

Migration does not transfer:

- authorization of any kind, including commit, push, archive, CI/status, release, deployment, publication, or other external-effect permission;
- role continuity for PM, Advisor, Worker, Reviewer, or Leader;
- validation freshness or proof that old validation still applies;
- workspace trust for CLI tools or proof that a new workspace is safe to trust;
- stale handoff authority, stale summary authority, or any "the old thread already approved this" assumption;
- secrets, credentials, API keys, browser data, or any right to read them;
- permission to perform external effects just because the skill was copied, installed, or invoked;
- assumptions from a prior session, another current session, another machine, another project, or another role instance;
- PM/Advisor agreement from another machine, project, or stale workstream;
- Worker results that have not been re-verified in the target workstream.

Old handoffs, summaries, and archived notes are evidence only. Re-verify current git state, OpenSpec state, validation, role continuity, unresolved P0/P1, model-source records, and authorization before acting.

Examples of what this means in practice are intentionally non-exhaustive:

- A copied handoff can explain what happened before, but it cannot approve the next commit.
- A globally installed skill can standardize the checklist, but it cannot make a new workspace trusted.
- A prior Advisor opinion can inform the new review, but it cannot stand in for a fresh review when the current gate requires one.

For a plain-language example of when to use the full workflow versus Small Task Mode, see [examples/skill-invocation.md](../examples/skill-invocation.md).
