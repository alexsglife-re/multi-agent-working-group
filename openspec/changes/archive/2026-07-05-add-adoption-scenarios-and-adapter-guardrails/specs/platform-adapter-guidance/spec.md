## ADDED Requirements

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
