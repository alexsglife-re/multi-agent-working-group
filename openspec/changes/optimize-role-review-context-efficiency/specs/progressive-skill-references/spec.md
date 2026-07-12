## ADDED Requirements

### Requirement: Skill routes context-efficient review work to a dedicated reference
`SKILL.md` SHALL retain an always-loaded fail-closed summary of the role-review context-efficiency boundary and SHALL require the Leader to read the dedicated reference before preparing, dispatching, retrying, or accepting a context-efficient PM or Advisor review.

#### Scenario: Leader prepares an incremental role packet
- **WHEN** a Leader uses a stable baseline and incremental evidence for PM or Advisor review
- **THEN** `SKILL.md` requires the dedicated context-efficiency reference to be read before dispatch

#### Scenario: Dedicated reference is unavailable
- **WHEN** the role-review context-efficiency reference is missing, unreadable, or has not been read
- **THEN** the Leader does not claim or apply the context-efficient packet protocol and continues only under the existing full review rules without weakening any gate

### Requirement: Progressive routing preserves review guarantees
The always-loaded skill summary and dedicated reference SHALL state that reducing repeated material cannot reduce provider/model routing, review frequency, no-peek independence, original-evidence access, gate coverage, lifecycle patience, or Leader verification.

#### Scenario: Contributor moves packet details into a reference
- **WHEN** implementation places packet identity and retry details in the dedicated reference
- **THEN** `SKILL.md` still retains the fail-closed quality-preservation boundary and mandatory routing marker
