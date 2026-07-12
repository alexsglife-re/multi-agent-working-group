# Runtime Adapters

The v0.4.17 release adds portable review-packet rules only. It does not upgrade an adapter maturity label or claim new runtime validation.

Multi-Agent Working Group is a portable workflow protocol. A runtime adapter is
the concrete way a specific agent environment applies that protocol.

Codex is the current reference adapter because this repository ships a Codex
`SKILL.md` entry point. Claude, OpenClaw, Hermes Agent, and other runtimes can
use the same protocol when their adapter preserves role boundaries, evidence
capture, validation, and authorization gates.

## Maturity Labels

Use these labels when documenting runtime support:

| Label | Meaning |
| --- | --- |
| `reference adapter` | Packaged and validated in this repository. |
| `adapter guide planned` | Runtime is a target, but no validated adapter guide exists yet. |
| `compatible pattern` | The protocol can be mapped manually, but support is not packaged or validated. |
| `unsupported` | The runtime is known to miss required capabilities or violate protocol boundaries. |

Do not describe a runtime as fully supported until a guide has been tested with
real read, review, validation, handoff, and git-gate workflows.

Runtime installation commands can exist before full adapter validation. When
that happens, keep the maturity label conservative and record installation as a
status note such as "install guidance available; validation pending."

## Current Adapter Status

| Runtime | Status | Notes |
| --- | --- | --- |
| Codex | `reference adapter` | Current packaged form through `SKILL.md`, templates, examples, and local validation. |
| Claude / Claude Code | `adapter guide planned` | Install guidance is available for the `SKILL.md` plus `references/` folder shape; full adapter validation is still pending. |
| OpenClaw | `adapter guide planned` | Existing reference notes inform rule-level ideas only; no runtime adapter is packaged. |
| Hermes Agent | `adapter guide planned` | Target runtime for future adapter documentation. |
| Other agent runtimes | `compatible pattern` | Use the mapping checklist below before claiming support. |

## Adapter Mapping Checklist

Every runtime adapter guide should define:

- Leader role: who orchestrates, verifies, and communicates with the Owner.
- PM role: how product framing, risk, acceptance criteria, and next action are reviewed.
- Advisor role: how independent critique is performed without reading PM conclusions first.
- Worker role: how scoped implementation is assigned, bounded, and returned.
- Reviewer role: when post-change review is required and how self-review is avoided.
- Readable scope: which files, specs, memory, logs, and validation evidence the runtime can read.
- Writable scope: which files the runtime may edit, if any, and which roles are read-only.
- Workspace trust: how the runtime confirms the exact project workspace before relying on output.
- Validation: which local checks, tests, OpenSpec commands, or CI/status evidence are required.
- Git gates: how commit, push, tag, release, and external-effect gates are represented.
- Handoff: how current state, evidence indexes, unresolved findings, and authorization state are preserved.
- Unsupported actions: what the runtime must never do automatically.

## Adapter Guide Template

Use this outline when drafting a future runtime guide. Keep the guide labeled
`adapter guide planned` or `compatible pattern` until it has been validated
with real read, review, validation, handoff, and git-gate workflows.

```text
# <Runtime> Adapter Guide

Status:
  reference adapter | adapter guide planned | compatible pattern | unsupported

Validation evidence:
  <date, project, workflow tested, commands, gaps>

Role mapping:
  Leader:
  PM:
  Advisor:
  Worker:
  Reviewer:

Readable scope:
  <files, specs, docs, logs, validation evidence>

Writable scope:
  <which roles can edit which files, if any>

Workspace trust:
  <how exact project trust is confirmed before relying on output>

Validation:
  <local commands, tests, OpenSpec checks, CI/status expectations>

Git and external-effect gates:
  <commit, push, tag, release, deployment, publication, metadata changes>

Handoff:
  <current state, evidence index, unresolved findings, authorization state>

Unsupported actions:
  <actions this runtime guide must never perform automatically>

Non-transferable state:
  <authorization, validation freshness, trust, continuity, secrets>
```

## Adapter Review Checklist

- The guide status matches the validation evidence.
- The guide does not call a planned or compatible runtime fully supported.
- Role boundaries preserve Leader verification and no self-approval.
- Advisor output remains evidence, not authority.
- Workspace trust is scoped to the exact project.
- Validation and git gates are explicit.
- Tag, release, deployment, publication, destructive actions, secrets, auth,
  permission changes, and GitHub metadata changes remain Owner-only unless
  explicitly authorized for that action.
- Non-transferable state is listed clearly.

## Non-Transferable State

Adapting the protocol to another runtime transfers only the checklist and role
structure. It does not transfer:

- commit, push, tag, release, deployment, or publication authorization;
- workspace trust;
- validation freshness;
- PM, Advisor, Worker, Reviewer, or Leader continuity;
- secret or credential access;
- permission to read unrelated projects or personal data;
- stale handoff authority or prior-session approval.

Each runtime, project, session, and handoff must re-verify its own current
state before acting.
