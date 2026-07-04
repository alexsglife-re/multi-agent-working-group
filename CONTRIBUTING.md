# Contributing

Thanks for helping improve Multi-Agent Working Group. This project is a Codex
skill and workflow protocol, so clarity and safety matter more than automation.

## Before Opening An Issue

- Search existing issues first.
- Describe the task or workflow that failed, not only the rule you want added.
- Include the relevant file, example, or validation output when possible.
- Do not include private project context, secrets, credentials, API keys,
  browser data, or full logs that may contain sensitive information.

Good issue topics include unclear role boundaries, confusing handoff language,
missing examples, validation failures, and places where the skill could imply
more authority than intended.

## Before Editing `SKILL.md`

`SKILL.md` is the operational contract. Treat edits to it as behavior changes.

Before proposing a `SKILL.md` change:

1. Read `docs/VALIDATION.md`.
2. Check whether the change belongs in an example or template instead.
3. Keep the skill model-agnostic. Do not hard-code personal provider or model
   preferences.
4. Keep project-specific rules out of the reusable skill unless they are
   broadly applicable.
5. Preserve the rule that project, owner, security, and spec workflow rules may
   tighten this skill but may not weaken it.

## Validation

Run these checks before submitting a pull request:

```sh
openspec validate --all
./scripts/validate-local.sh --skip-global-skill
git status --short --branch -uall
```

Also review the outgoing diff for sensitive content:

```sh
rg -n "(token|api[_-]?key|secret|password|private key|/Users/|gmail|Keychain|GITHUB_PAT)" .
```

The search above is intentionally broad. Matches inside safety instructions may
be fine; real credentials, personal paths, or private project details are not.

## Pull Request Checklist

- The change is scoped and understandable.
- Public docs do not include private machine paths or personal workflow rules.
- `SKILL.md` behavior changes are reflected in examples, templates, or
  validation docs when needed.
- Validation results and any skipped checks are listed in the pull request.
- The change does not add release automation, external publication, secret
  access, or git authority unless that scope is explicitly reviewed.
