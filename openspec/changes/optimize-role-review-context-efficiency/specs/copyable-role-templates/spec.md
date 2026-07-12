## ADDED Requirements

### Requirement: Role templates support context-efficient review packets
The template set SHALL provide a shared factual manifest structure and separate PM and Advisor packet structures that capture Review ID, Attempt ID, review target, stable baseline, incremental evidence, validation freshness, evidence-access instructions, no-peek state, and the complete required response surface.

#### Scenario: Leader prepares independent first-pass packets
- **WHEN** the Leader prepares PM and Advisor first-pass reviews from the same factual evidence
- **THEN** the templates provide separate role packets with explicit conclusions-withheld fields and no conclusion from the other role

#### Scenario: Role needs original evidence
- **WHEN** the compact packet is insufficient for a reliable decision
- **THEN** the template states that task-relevant original evidence remains available within the approved scope and supports a `BLOCKED-EVIDENCE` result

### Requirement: State-carrying templates record review invocation identity
PM, Advisor, git-gate, compact-handoff, successor-startup, and other applicable state-carrying templates SHALL record Review ID, Attempt ID, packet fingerprint, invocation state, result location, retry decision, and parent Attempt ID when retried.

#### Scenario: Invocation result is unknown at handoff
- **WHEN** a role invocation remains `result-unknown` at a safe handoff boundary
- **THEN** the handoff records its identity, state, available process or output evidence, and the prohibition on blind retry

#### Scenario: Git gate uses context-efficient review
- **WHEN** PM or Advisor reviews a commit or push gate from an incremental packet
- **THEN** the git-gate record preserves the actual target, validation freshness, P0/P1/P2, evidence gaps, authorization state, and linked invocation identity
