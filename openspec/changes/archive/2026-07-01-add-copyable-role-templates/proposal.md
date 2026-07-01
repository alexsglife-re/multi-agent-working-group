# Change: Add Copyable Role Templates

## Why

The repository already has scenario-style examples, but real workstreams still require agents to recreate PM, Advisor, Worker, Reviewer, C0, blocked, and handoff output shapes by memory. That increases drift and encourages long append-only handoff documents. A small set of copyable templates can make the workflow easier to run without adding automation.

Existing v0.3 and earlier handoffs or local working documents should remain historical evidence. They should not be bulk-rewritten into the new shape because that could make old evidence look newer or more authoritative than it is.

## What Changes

- Add a `templates/` directory with copyable role and workflow templates.
- Add guidance for handling legacy v0.3 or earlier documents: preserve originals, migrate only the current active state, and reference old material through evidence pointers.
- Update README, changelog, roadmap, TODO, validation docs, and `SKILL.md` for `v0.4.5`.
- Update local validation to check the new version marker and accepted template spec after archive.

## Non-Goals

- No automation, template generator, CLI scaffolding, CI, release, tag, deployment, or public publication.
- No bulk rewrite of old handoff documents.
- No change to normal commit/push, PM/Advisor, Reviewer, OpenSpec, or secret-scan gates.
