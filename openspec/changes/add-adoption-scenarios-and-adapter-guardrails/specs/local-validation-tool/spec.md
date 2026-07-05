## ADDED Requirements

### Requirement: Validation checks adoption guidance anchors
The local validation command SHALL include lightweight checks that `v0.4.14`
adoption guidance remains present without adding CI, link checking, runtime
behavior enforcement, or automatic repair.

#### Scenario: Adoption anchors are present
- **WHEN** local validation runs after `v0.4.14`
- **THEN** it checks for README Quick Start, Use Cases, Safety Boundaries,
  `docs/ADOPTION.md`, and selected scenario headings

### Requirement: Validation checks adapter guide guardrail anchors
The local validation command SHALL include lightweight checks that adapter
guide template guardrails remain present without treating unvalidated runtime
guidance as support.

#### Scenario: Adapter guardrail anchors are present
- **WHEN** local validation runs after `v0.4.14`
- **THEN** it checks that adapter docs include guide-template or checklist
  markers, validation evidence fields, unsupported actions, and wording that
  unvalidated runtimes remain planned guidance or compatible patterns
