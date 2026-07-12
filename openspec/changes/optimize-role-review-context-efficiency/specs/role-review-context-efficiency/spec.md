## ADDED Requirements

### Requirement: Review context efficiency preserves role capability
The workflow SHALL reduce repeated review context only by referencing unchanged material through stable, reproducible anchors and SHALL NOT reduce PM or Advisor provider/model capability, required review frequency, assigned review scope, independent authority, original-evidence access, gate coverage, or lifecycle patience.

#### Scenario: Unchanged evidence is omitted from a packet
- **WHEN** the Leader prepares a PM or Advisor packet after an accepted baseline
- **THEN** unchanged material is referenced through an exact reproducible anchor rather than recopied
- **AND** the role retains access to task-relevant original evidence within the approved scope

#### Scenario: Token reduction would truncate review
- **WHEN** a context or token limit would prevent a required role from completing its assigned review
- **THEN** the workflow MUST preserve the review scope and evidence access rather than force an incomplete or false `GO`

### Requirement: Distinct review checkpoints use short-lived sessions
The workflow SHALL default each distinct PM or Advisor review checkpoint to a fresh short-lived role session and SHALL restore continuity from verified artifacts rather than automatically carrying full historical model conversation context.

#### Scenario: Review target changes
- **WHEN** the commit, diff, gate, decision request, or materially visible packet changes
- **THEN** the Leader starts a fresh role session with a new Review ID or linked attempt and supplies the applicable baseline plus incremental evidence

#### Scenario: Same review needs a narrow follow-up
- **WHEN** a role requests one missing original file or a narrow clarification for the unchanged review target
- **THEN** the Leader MAY continue the same short-lived session without treating the follow-up as a different independent review

### Requirement: Review packets are evidence indexes
Every context-efficient PM or Advisor packet SHALL identify the Owner goal and authorization boundary, stable baseline, accepted anchor, current target and delta, validation freshness, known risks, unresolved questions, and direct original-evidence access. The packet MUST state that it is an index and starting point rather than a restriction or substitute for original evidence.

#### Scenario: Packet is insufficient
- **WHEN** a role cannot make a reliable decision from the compact packet
- **THEN** the role inspects or requests task-relevant original evidence and reports any remaining gap as `BLOCKED-EVIDENCE` rather than guessing

### Requirement: PM and Advisor packets preserve no-peek independence
The workflow SHALL keep PM and Advisor independent first-pass conclusions isolated while allowing both packets to derive from the same conclusion-free factual manifest.

#### Scenario: Advisor first pass is prepared
- **WHEN** the PM has already recorded a first-pass conclusion
- **THEN** the Advisor packet excludes that PM conclusion and records it as intentionally withheld until the Advisor first pass is complete

#### Scenario: Shared evidence manifest is reused
- **WHEN** the Leader derives PM and Advisor packets from one manifest
- **THEN** the manifest contains verified facts and evidence pointers but no PM or Advisor conclusion that would break no-peek review

### Requirement: Review invocations have reproducible identity and state
Every context-efficient role invocation SHALL record a Review ID, Attempt ID, role, review type, target, stable baseline anchor, packet fingerprint, invocation state, timing, result location, retry decision, and parent Attempt ID when retried.

#### Scenario: First invocation starts
- **WHEN** a PM or Advisor review call begins
- **THEN** its invocation record moves from `prepared` to `running` under one Review ID and Attempt ID

#### Scenario: Same packet has ambiguous state
- **WHEN** the same Review ID and packet fingerprint is `running` or `result-unknown`
- **THEN** the Leader MUST inspect available process, output, and CLI status evidence and MUST NOT blindly invoke the packet again

#### Scenario: Failure is confirmed and retry is needed
- **WHEN** evidence confirms an invocation failed or safely resolves an ambiguous result as retryable
- **THEN** the retry uses a new Attempt ID linked to the parent and records the retry reason without changing the required role capability or review scope

### Requirement: Compact role output preserves decision evidence
PM and Advisor outputs SHALL retain a decision of `GO`, `NO-GO`, or `BLOCKED-EVIDENCE`; P0/P1/P2 findings; inspected evidence; evidence gaps; validation freshness; required corrections; Owner-decision needs; recommended next action; and concise rationale.

#### Scenario: Evidence is missing but no defect is proven
- **WHEN** the available evidence cannot support a reliable `GO` or substantive `NO-GO`
- **THEN** the role returns `BLOCKED-EVIDENCE` and names the missing evidence

#### Scenario: Review has non-blocking findings
- **WHEN** the role reaches `GO` with P2 recommendations
- **THEN** the output retains those P2 findings without converting them into P0/P1 blockers or discarding them for brevity

### Requirement: Development adoption does not imply publication
The v0.4.17 role-review context-efficiency workflow SHALL remain a development target until implementation, validation, and review gates pass, and SHALL NOT be described as the current public version without separate Owner-authorized tag, release, and publication evidence.

#### Scenario: Draft transitions to implemented workflow
- **WHEN** the discussion draft is incorporated into executable workflow rules and templates
- **THEN** its non-authoritative draft status is removed or superseded only after the corresponding implementation, validation, and required review gates pass

#### Scenario: Development commits are pushed
- **WHEN** v0.4.17 development and archive commits reach the remote repository without Owner-authorized publication
- **THEN** public documentation continues to identify v0.4.16 as the current public version and identifies v0.4.17 only as the development target
