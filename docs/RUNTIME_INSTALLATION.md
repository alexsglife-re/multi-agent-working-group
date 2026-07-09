# Runtime Installation

This guide shows where to copy the bare skill folder for runtimes that can read
`SKILL.md` plus supporting files.

It is installation guidance only. It does not prove full runtime adapter
support, install a plugin, create automation, trust a workspace, or authorize
commits, pushes, tags, releases, deployments, publications, metadata changes,
secret access, or role continuity.

## Installable Shape

This repository ships a bare skill folder shape:

```text
SKILL.md
references/
```

It is not a plugin package. There is no `plugin.json`, marketplace manifest, or
automatic installer. Installation means copying `SKILL.md` and `references/`
into the runtime's skill directory.

## Codex

Status: `reference adapter`.

Global install:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git /tmp/mawg
mkdir -p ~/.codex/skills/multi-agent-working-group/references
cp /tmp/mawg/SKILL.md ~/.codex/skills/multi-agent-working-group/SKILL.md
cp -R /tmp/mawg/references/. ~/.codex/skills/multi-agent-working-group/references/
```

Project install:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git /tmp/mawg
mkdir -p .codex/skills/multi-agent-working-group/references
cp /tmp/mawg/SKILL.md .codex/skills/multi-agent-working-group/SKILL.md
cp -R /tmp/mawg/references/. .codex/skills/multi-agent-working-group/references/
```

After installing, restart or refresh the Codex environment that loads skills.

## Claude Code

Status: `adapter guide planned`; install guidance is available and validation
is pending.

Claude Code skills use a named skill directory containing `SKILL.md` with YAML
frontmatter such as `name` and `description`. Supporting files can live beside
it. For this repository, copy `SKILL.md` and `references/` into a named
`multi-agent-working-group` directory.

Personal install:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git /tmp/mawg
mkdir -p ~/.claude/skills/multi-agent-working-group/references
cp /tmp/mawg/SKILL.md ~/.claude/skills/multi-agent-working-group/SKILL.md
cp -R /tmp/mawg/references/. ~/.claude/skills/multi-agent-working-group/references/
```

Project install:

```sh
git clone https://github.com/alexsglife-re/multi-agent-working-group.git /tmp/mawg
mkdir -p .claude/skills/multi-agent-working-group/references
cp /tmp/mawg/SKILL.md .claude/skills/multi-agent-working-group/SKILL.md
cp -R /tmp/mawg/references/. .claude/skills/multi-agent-working-group/references/
```

Restart Claude Code or refresh the environment that loads skills after adding a
new skill directory.

Use prompt:

```text
Use the multi-agent-working-group skill for this task.
```

This install path does not mean Claude Code is fully supported. A validated
Claude Code adapter guide still needs real read, review, validation, handoff,
and git-gate workflow evidence.

## OpenClaw And Hermes Agent

Status: `adapter guide planned`.

Do not copy Codex or Claude Code install commands into OpenClaw or Hermes Agent
as if they were validated adapters. Before claiming support, create a runtime
adapter guide that maps:

- Leader, PM, Advisor, Worker, and Reviewer roles;
- readable and writable scope;
- workspace trust;
- validation commands;
- commit, push, tag, release, deployment, publication, and metadata gates;
- handoff and continuity state;
- unsupported actions;
- non-transferable state.

## Verify The Checkout

From the cloned repository:

```sh
./scripts/validate-local.sh --skip-global-skill
openspec validate --all
```

Use `--skip-global-skill` when you only want to validate the checkout and do
not want to compare it with an installed Codex global skill.

## What Does Not Transfer

Copying this skill folder transfers only workflow instructions and supporting
references. It does not transfer:

- commit, push, tag, release, deployment, publication, or metadata-change
  authorization;
- workspace trust;
- validation freshness;
- PM, Advisor, Worker, Reviewer, or Leader continuity;
- secret, credential, Keychain, browser, or unrelated-project access;
- prior-session approval, stale handoff authority, or old role consensus.

Each runtime, project, session, and handoff must re-verify its own current
state before acting.
