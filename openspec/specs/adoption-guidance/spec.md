# adoption-guidance Specification

## Purpose
Define reader-facing adoption guidance that helps first-time users understand
when to use the protocol, how to start safely, and where detailed scenario
guidance belongs without expanding the always-loaded skill entry point.

## Requirements
### Requirement: README exposes quick adoption path
The README SHALL give first-time readers a concise path to understand what the
protocol is, when to use it, how to start with the Codex reference adapter, and
where to read deeper adoption guidance.

#### Scenario: First-time reader scans README
- **WHEN** a first-time reader opens the README
- **THEN** the README includes Quick Start, Use Cases, and Safety Boundaries
- **AND** links to detailed adoption, installation, adapter, and validation
  documentation

### Requirement: Adoption guide defines scenario-based usage
The project SHALL provide scenario-based adoption guidance for common workflow
types without expanding the always-loaded skill entry point.

#### Scenario: Reader chooses a workflow level
- **WHEN** a reader wants to know whether to use the full workflow
- **THEN** the adoption guide describes practical usage for documentation
  tasks, release preparation, long-running project work, cross-conversation
  handoff, and ordinary small tasks

### Requirement: Adoption docs preserve authority boundaries
Adoption guidance SHALL state that using, copying, installing, or adapting the
protocol transfers only workflow/checklist structure and does not transfer
authorization, validation freshness, workspace trust, role continuity, secret
access, or external-effect permission.

#### Scenario: User adopts the protocol in another project
- **WHEN** a user applies the protocol to another project or runtime
- **THEN** the adoption guidance requires that project or runtime to re-check
  current state, local rules, validation, role evidence, and authorization
  before acting

### Requirement: Examples cover non-code adoption scenarios
The project SHALL include examples showing how to apply the protocol to
release-preparation and long-running documentation workstreams without
publishing, tagging, or claiming authorization.

#### Scenario: Reader looks for a release-preparation example
- **WHEN** a reader opens the examples directory
- **THEN** at least one example shows a release-preparation or long-running
  documentation workflow that keeps publication, tag, release, commit, and push
  gates separate from local drafting
