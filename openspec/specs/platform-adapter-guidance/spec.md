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

### Requirement: Adapter docs include guide template guardrails
Adapter guidance SHALL provide a reusable guide template or checklist for
future runtime adapters while preserving maturity labels and validation
requirements.

#### Scenario: Contributor drafts a runtime guide
- **WHEN** a contributor wants to draft a Claude, OpenClaw, Hermes Agent, or
  other runtime adapter guide
- **THEN** the adapter documentation requires the guide to state its maturity
  label, validation evidence, role mapping, readable scope, writable scope,
  workspace trust, validation commands, git gates, handoff rules, unsupported
  actions, and non-transferable state boundaries

### Requirement: Adapter docs avoid unsupported runtime claims
Adapter guidance SHALL NOT create runtime-specific guide pages or skeletons that
look like validated support before the runtime has been tested with real read,
review, validation, handoff, and git-gate workflows.

#### Scenario: Runtime is not validated
- **WHEN** the documentation names a non-Codex runtime without validated adapter
  evidence
- **THEN** the runtime remains labeled as adapter guide planned or compatible
  pattern rather than fully supported

### Requirement: Runtime installation guidance distinguishes installability from validated support
The documentation SHALL provide cross-runtime installation guidance for runtimes
whose skill-folder layout can consume the repository's `SKILL.md` and
supporting files, while preserving adapter maturity labels and validation
requirements.

#### Scenario: Reader installs the Codex reference adapter
- **WHEN** a reader follows runtime installation guidance for Codex
- **THEN** the documentation gives global and project-level Codex skill paths
- **AND** identifies Codex as the reference adapter

#### Scenario: Reader installs for Claude Code
- **WHEN** a reader follows runtime installation guidance for Claude Code
- **THEN** the documentation gives personal and project-level Claude Code skill
  paths using a `SKILL.md` folder with `references/`
- **AND** keeps Claude Code under `adapter guide planned` with install guidance
  available and validation pending rather than fully validated adapter support

### Requirement: Runtime installation docs preserve non-transferable state
Runtime installation guidance SHALL state that copying the skill folder
transfers only workflow instructions and supporting references, not authority
or live workstream state.

#### Scenario: User copies the skill to another runtime
- **WHEN** a user installs the skill folder into Codex, Claude Code, or another
  runtime
- **THEN** the documentation states that commit, push, tag, release, deployment,
  publication, workspace trust, validation freshness, role continuity, and
  secret access do not transfer

### Requirement: Non-Codex runtime status remains evidence-based
Adapter documentation SHALL keep runtime support labels aligned with actual
validation evidence.

#### Scenario: Claude Code has install guidance but no full workflow validation
- **WHEN** adapter documentation lists Claude Code
- **THEN** it labels Claude Code as `adapter guide planned`
- **AND** may note that install guidance is available and validation is pending
- **AND** does not describe Claude Code as fully supported

#### Scenario: OpenClaw or Hermes Agent is named
- **WHEN** adapter documentation lists OpenClaw or Hermes Agent
- **THEN** it labels the runtime as adapter guide planned unless real validation
  evidence is added
