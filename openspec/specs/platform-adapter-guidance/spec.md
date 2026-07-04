# platform-adapter-guidance Specification

## Purpose
Define how public documentation presents Multi-Agent Working Group as a
portable multi-agent workflow protocol, how it labels Codex as the reference
adapter, and how it prevents unvalidated runtime support claims.

## Requirements
### Requirement: Project presents a platform-neutral protocol
The public documentation SHALL describe Multi-Agent Working Group as a portable
multi-agent workflow protocol, while identifying Codex as the current reference
adapter rather than the only intended runtime.

#### Scenario: Reader opens the README
- **WHEN** a reader opens the README
- **THEN** the first-screen description identifies the project as a portable workflow protocol and states that Codex is the reference packaged adapter

### Requirement: Adapter maturity is explicit
The documentation SHALL distinguish validated adapter support from planned or
compatible guidance for other runtimes.

#### Scenario: Runtime is named before validation
- **WHEN** the documentation names Claude, OpenClaw, Hermes Agent, or another non-Codex runtime before a validated adapter exists
- **THEN** it labels that runtime as planned guidance or compatible pattern rather than fully supported

### Requirement: Adapter guide defines required mapping fields
The project SHALL document the minimum fields a runtime adapter must define to
apply the protocol safely.

#### Scenario: Contributor plans a new adapter
- **WHEN** a contributor wants to adapt the protocol to a runtime
- **THEN** the adapter guidance lists required mappings for Leader, PM, Advisor, Worker, Reviewer, readable scope, writable scope, workspace trust, validation, git gates, handoff, and unsupported actions

### Requirement: Adapter guidance preserves authority boundaries
Runtime adapter guidance SHALL preserve the protocol rule that installing,
copying, invoking, or adapting the protocol does not transfer authorization,
workspace trust, validation freshness, role continuity, secret access, or
external-effect permission.

#### Scenario: User adopts a non-Codex runtime
- **WHEN** a user maps the protocol to Claude, OpenClaw, Hermes Agent, or another runtime
- **THEN** the documentation states that the new runtime must re-verify current project state, authority, trust, validation, and role continuity before acting
