## ADDED Requirements

### Requirement: Leader templates render profile-aware active-state instances
The project SHALL provide genuinely reduced Compact and Standard active-state and handoff instances through separate templates or a deterministic profile-aware renderer. Existing full blank template source length MUST NOT be represented as active-instance length.

#### Scenario: A representative repo-grounded small fixture is rendered
- **WHEN** a small fixture cites the archived change, accepted template, or accepted example from which its active-state facts were derived and has no triggered optional sections
- **THEN** the rendered Compact instance asserts the expected profile and deterministic counts, uses a lightweight profile attestation, omits inapplicable visible sections, preserves every triggered accepted field, records physical-line and UTF-8-byte measurements, and treats size warnings as non-blocking

#### Scenario: A representative repo-grounded medium fixture is rendered
- **WHEN** a medium fixture cites its repository provenance, exceeds Compact structure, and satisfies Standard
- **THEN** the rendered Standard instance asserts the expected profile and deterministic counts, uses stable sections, omits inapplicable visible sections, preserves every triggered accepted field, records physical-line and UTF-8-byte measurements, and treats size warnings as non-blocking

### Requirement: Reduced rendering does not weaken accepted fields
Profile-aware rendering SHALL treat the complete applicable accepted state-carrying field set as the retention floor, including changed and do-not-touch files; validation run, not run, and freshness; PM, Advisor, and Reviewer continuity; required Reviewer approval; provider and model separation evidence; lifecycle patience; cleanup; and review-invocation identity when applicable.

#### Scenario: A mandatory field is applicable
- **WHEN** an accepted triggering condition makes a state-carrying field applicable
- **THEN** every profile renders that field or a stable accepted projection and MUST NOT replace it with assumed approval or an unverified default

#### Scenario: Full reasoning is stored elsewhere
- **WHEN** durable role output contains required reasoning
- **THEN** the profile instance retains the current finding and stable evidence pointer without applying a storage cap to the durable output
