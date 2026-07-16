## ADDED Requirements

### Requirement: Local validation checks profile structure and measurements
The local validator SHALL perform deterministic marker and structural checks for profile declarations, profile selection basis, rendered fixtures, physical line measurements, and UTF-8 byte measurements without becoming a semantic policy engine.

#### Scenario: Compact fixture is checked
- **WHEN** local validation evaluates a Compact fixture
- **THEN** it checks the required declaration, selection-basis structure, applicable field anchors, physical lines, UTF-8 bytes, and warning state

#### Scenario: Detailed classification fixture is checked
- **WHEN** local validation evaluates takeover, disputed classification, transition, or boundary fixtures
- **THEN** it checks that all structural dimensions are explicitly represented and that the expected profile follows the fixture values

### Requirement: Profile validation preserves non-semantic boundaries
The local validator MUST NOT claim that profile counts are factually true, authorization is valid, a role lifecycle occurred, a pointer is semantically sufficient, or a successor can safely act without fresh verification.

#### Scenario: Structural validation passes
- **WHEN** every required marker, fixture expectation, and measurement check passes
- **THEN** documentation states that the result confirms structural consistency only and does not prove runtime or semantic compliance

#### Scenario: A size warning occurs during pilot
- **WHEN** a rendered fixture exceeds a provisional line or byte warning without a semantic or structural failure
- **THEN** validation reports a warning and MUST NOT fail solely because of size

### Requirement: Validation covers representative profile boundaries
Validation documentation and fixtures SHALL cover representative repo-grounded small and medium cases, takeover-direct-to-Standard, above-Standard, hysteresis, dependency/conflict-edge boundaries, overlap-edge boundaries, missing-mandatory-field, stale-pointer, and large stress cases.

#### Scenario: Original large inventory is unavailable
- **WHEN** the Owner-reported prior 4,000-line inventory cannot be inspected
- **THEN** validation uses a clearly labeled synthetic stress fixture and MUST NOT claim historical reconstruction

#### Scenario: Missing applicable field is detected
- **WHEN** a rendered fixture omits an applicable accepted retention-floor field
- **THEN** validation fails the structural fixture independently of line and byte size

### Requirement: Validation registers profile artifacts
The local validator SHALL register every new required profile reference and copyable template, SHALL require deterministic `SKILL.md` routing to the profile reference, and SHALL ratchet the verified `SKILL.md` hard-boundary anchor floor when profile anchors are added.

#### Scenario: Profile artifacts are added
- **WHEN** implementation adds the Leader-state profile reference, Compact template, Standard template, or Opportunity skeleton
- **THEN** required-reference and required-template validation includes each artifact and fails when any artifact or mandatory routing anchor is missing
