# Design: Add Local Validation Tool

## Approach

Create `scripts/validate-local.sh` as a small Bash script that runs from the repository root and performs deterministic read-only checks. The script should be portable enough for a local macOS checkout and should avoid dependencies beyond Git, common shell utilities, and the already adopted OpenSpec CLI.

## Command Shape

```sh
./scripts/validate-local.sh
./scripts/validate-local.sh --require-no-active-changes
./scripts/validate-local.sh --skip-global-skill
```

Default behavior:

- Treat malformed core docs, missing expected version markers, failed OpenSpec validation, and global `SKILL.md` mismatch as failures.
- Report active OpenSpec changes as informational so the command can run during implementation.
- Compare `$HOME/.codex/skills/multi-agent-working-group/SKILL.md` with repo `SKILL.md` when the global file exists.

Optional behavior:

- `--require-no-active-changes` fails when OpenSpec still has active changes. This is intended for final closeout after archive.
- `--skip-global-skill` skips the global installed skill comparison.

## Checks

- Confirm the command is running inside the repository root.
- Confirm `SKILL.md` frontmatter starts at the top and includes the expected `name` and a `description`.
- Confirm README, changelog, TODO, roadmap, validation docs, and `SKILL.md` contain the current local version marker.
- Confirm required OpenSpec accepted specs exist.
- Run `openspec list --json`.
- Run `openspec validate --all`.
- Compare global installed skill when present and not skipped.

## Safety

The script must not mutate repository files, global skill files, Git state, OpenSpec state, or network state. It is a convenience check only and does not replace human or agent review gates.
