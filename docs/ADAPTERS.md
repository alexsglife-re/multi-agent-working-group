# Runtime Adapters

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

## Current Adapter Status

| Runtime | Status | Notes |
| --- | --- | --- |
| Codex | `reference adapter` | Current packaged form through `SKILL.md`, templates, examples, and local validation. |
| Claude / Claude Code | `adapter guide planned` | The protocol can map to Claude roles, but a validated standalone adapter guide is not shipped yet. |
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
