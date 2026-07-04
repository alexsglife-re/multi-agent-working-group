## ADDED Requirements

### Requirement: Validation checks platform-neutral positioning markers
The local validation command SHALL include lightweight checks that public docs
preserve v0.4.11 platform-neutral protocol positioning without claiming
unvalidated full runtime support.

#### Scenario: Platform-neutral markers are present
- **WHEN** local validation runs
- **THEN** it checks for README and installation text that identifies Multi-Agent Working Group as a portable protocol and Codex as the reference adapter

#### Scenario: Adapter markers are present
- **WHEN** local validation runs
- **THEN** it checks for adapter guidance describing maturity labels, required mapping fields, and non-transferable authority boundaries

#### Scenario: Unverified support is not overclaimed
- **WHEN** local validation runs
- **THEN** it checks for wording that non-Codex runtimes are planned guidance or compatible patterns until validated, not fully supported adapters
