# Proposal: Add Installation And Migration Guide

## Why

The skill is currently usable in this checkout and as a synchronized global skill, but a future user or machine needs a concise guide for installing, syncing, validating, and migrating the skill without relying on memory from this workstation.

## What Changes

- Add installation and migration guidance for local checkout use, global Codex skill sync, and project adoption.
- Document validation commands for normal development and closeout.
- Explain what should and should not be migrated: skill files and docs may move; current workstream authorization, commit/push approval, CI/archive permission, and stale handoff facts do not.
- Keep concrete model selection out of the skill guide; model/provider routing remains driven by Owner instruction, global/project memory, project rules, handoff, startup packet, or current verified records.

## Non-Goals

- No packaging automation, release tags, CI, public publication, or installer script.
- No automatic global skill overwrite.
- No hard-coded concrete model names.
- No migration of secrets, credentials, unrelated project state, or historical authorization.
