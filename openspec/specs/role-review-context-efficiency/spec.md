# role-review-context-efficiency Specification

## Purpose
Define a context-efficient PM and Advisor review protocol that reduces repeated material while preserving role capability, independent review, original-evidence access, gate coverage, reproducible invocation identity, and publication boundaries.

## Requirements
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

### Requirement: Review packet artifacts have explicit retention classes
The workflow SHALL classify reusable blank templates, stable project rules, accepted specifications, and archived OpenSpec artifacts as permanent protocol material; SHALL classify minimum invocation and decision evidence plus complete required role reasoning, option comparison, recommendations, objections, and key error details as durable audit evidence; and SHALL classify filled input packets, generated prompts, copied unchanged evidence, scratch manifests, and superseded renderings as lifecycle-bound working material. Cleanup MUST NOT remove permanent protocol material, original task evidence, or the durable audit evidence required by this specification.

#### Scenario: Filled packet uses a reusable template
- **WHEN** a task-specific PM or Advisor packet is created from a reusable blank template
- **THEN** the filled packet is lifecycle-bound working material
- **AND** the reusable blank template remains permanent protocol material

#### Scenario: Cleanup targets original evidence
- **WHEN** a proposed cleanup scope includes an accepted specification, archived OpenSpec artifact, reusable blank template, stable project rule, or task-relevant original evidence
- **THEN** the workflow MUST reject that target from packet cleanup

### Requirement: OpenSpec review packets follow stage-bound retention checkpoints
For OpenSpec-backed work, the workflow SHALL permit non-destructive compaction of completed-stage lifecycle-bound packets only after the corresponding independent reviews, corrections, decisions, and validation are complete; SHALL retain working material needed by later applicable gates; and SHALL defer destructive-removal eligibility until C4 archive validation and every applicable archive commit, push, status, and post-action review gate complete. Eligibility does not authorize removal.

#### Scenario: C1 proposal review is complete
- **WHEN** both independent C1 first passes, required corrections, and the scope decision are complete with no cleanup blocker
- **THEN** redundant C1 packet material MAY be compacted into its durable audit record and reproducible evidence pointers
- **AND** evidence needed for C2 remains accessible

#### Scenario: C3 push review remains pending
- **WHEN** implementation is complete but required push, status, or post-push review is not complete
- **THEN** the workflow MUST retain lifecycle-bound material needed for the pending gate
- **AND** MUST NOT treat C2 completion as final cleanup authorization

#### Scenario: C4 closeout is complete
- **WHEN** archive validation and all applicable archive commit, push, status, and post-action reviews are complete with no cleanup blocker
- **THEN** non-destructive compaction MAY proceed and confirmed lifecycle-bound packet material MAY become eligible for separately Owner-authorized removal
- **AND** MUST retain permanent protocol material, original evidence, and the minimum durable audit record

### Requirement: Small-task packet cleanup eligibility follows the final applicable gate
For a task that does not use OpenSpec, the workflow SHALL determine the final applicable gate from the task's actual scope and SHALL permit non-destructive lifecycle-bound packet compaction, or eligibility for separately Owner-authorized removal, only after that gate and its required follow-up review complete. The final applicable gate SHALL be final review for no-git work, actual-commit review for commit-only work, status or CI evidence plus post-push review for pushed work, or post-action closeout review for Owner-authorized tag, release, publication, or deployment work. Gate completion does not itself authorize destructive removal.

#### Scenario: Small local task has no git exit
- **WHEN** a non-OpenSpec task requires review but no commit, push, publication, or deployment action
- **THEN** non-destructive packet compaction MAY occur and removal eligibility MAY be recorded after the required final review completes and no blocker remains

#### Scenario: Small task is pushed
- **WHEN** a non-OpenSpec task includes a normal push
- **THEN** compaction and removal eligibility MUST wait for required status or CI evidence and post-push PM and Advisor review

#### Scenario: Small task includes publication
- **WHEN** a non-OpenSpec task includes an Owner-authorized tag, release, publication, or deployment action
- **THEN** compaction and removal eligibility MUST wait for the corresponding post-action closeout review

### Requirement: Packet cleanup preserves a minimum durable audit record
Before compacting or cleaning lifecycle-bound packet material, the workflow SHALL retain Review ID, Attempt ID, parent Attempt ID when applicable, role, review type, state, target and exact anchor, stable baseline anchor, packet fingerprint, timing, result location, retry decision and reason, decision, P0/P1/P2 findings, evidence gaps, required corrections, Owner-decision needs, validation freshness and results, applicable status or CI and secret-scan evidence, reproducible original-evidence pointers, final applicable gate or OpenSpec checkpoint, and the cleanup decision, scope, actor, time, and retained-record location. It SHALL also retain each required role output's complete reasoning, option comparison, recommendation, objections, and key error details directly or at a durable original result location; a terse decision summary alone is insufficient.

#### Scenario: Packet duplicates become eligible after closeout
- **WHEN** lifecycle-bound packet copies become eligible for compaction or separately Owner-authorized removal
- **THEN** the workflow records the minimum durable audit fields before compaction and before any authorized removal
- **AND** a future Leader can identify the reviewed target, decision, findings, validation, retry lineage, and original evidence from the retained record

#### Scenario: Proposed retained summary lacks evidence pointers
- **WHEN** the proposed retained record omits reproducible task-relevant original-evidence pointers or invocation identity
- **THEN** cleanup MUST be blocked until the durable audit record is complete

### Requirement: Packet cleanup fails closed on unresolved reviews and gates
The workflow MUST NOT compact related lifecycle-bound material or mark it eligible for removal while an invocation is `prepared`, `running`, or `result-unknown`; while any P0 or P1 finding, `BLOCKED-EVIDENCE` result, evidence gap, required correction, Owner decision, required role review, or applicable later gate remains unresolved; or while cleanup impact cannot be determined. A `failed-confirmed` or `superseded` attempt MAY be compacted or marked eligible only after its retry lineage and final disposition are retained; actual removal still requires exact Owner authorization.

#### Scenario: Invocation is still running
- **WHEN** a related PM or Advisor invocation remains `running`
- **THEN** cleanup is blocked
- **AND** short silence MUST NOT be reclassified as failure or cleanup safety

#### Scenario: Invocation result is unknown
- **WHEN** a related invocation is `result-unknown`
- **THEN** the Leader MUST inspect available process, output, and CLI status evidence
- **AND** MUST NOT clean or blindly retry the affected packet

#### Scenario: Review has unresolved P1
- **WHEN** a required review records an unresolved P1 finding
- **THEN** cleanup is blocked until correction and required re-review resolve the finding

#### Scenario: Superseded attempt has recorded lineage
- **WHEN** an attempt is `superseded` and its parent or child linkage, retry reason, and final disposition are durably recorded
- **THEN** its redundant lifecycle-bound rendering MAY be compacted or marked eligible for separately Owner-authorized removal after all other blockers clear

### Requirement: Packet cleanup eligibility does not authorize destructive removal
The workflow SHALL require an explicit, task-scoped Leader eligibility decision after verified preconditions and SHALL NOT introduce time-based, background, unattended, or automatically destructive deletion. The eligibility decision MAY authorize non-destructive compaction but MUST NOT authorize file deletion or other destructive removal. Actual removal remains an Owner-only default exclusion requiring explicit authorization naming the exact scope and all applicable gates. Historical packet material SHALL remain preserved unless a separately scoped, explicitly Owner-authorized action identifies exact eligible targets under the same retention and blocker rules.

#### Scenario: Stage transition occurs
- **WHEN** an OpenSpec stage or small-task gate completes
- **THEN** completion MAY make lifecycle-bound material eligible for explicit cleanup
- **AND** MUST NOT automatically delete files or evidence or create destructive-action authorization

#### Scenario: Existing historical packet directory is discovered
- **WHEN** historical filled packets predate this requirement
- **THEN** the workflow preserves them by default
- **AND** requires a separately scoped eligibility review plus explicit Owner authorization before any removal

#### Scenario: Leader records lifecycle eligibility
- **WHEN** the Leader records that lifecycle-bound working material is eligible for cleanup
- **THEN** non-destructive compaction MAY proceed after blocker checks
- **AND** destructive file removal MUST remain blocked without exact Owner authorization and applicable gates

### Requirement: Retention controls active context without promising a storage cap
The workflow SHALL state that lifecycle compaction bounds active and retransmitted review context while durable audit evidence intentionally grows with required reviews. It SHALL state that stored lifecycle-bound packet files may continue growing until exact-scope Owner-authorized removal. It MUST NOT claim a storage cap or use storage reduction to truncate required role reasoning.

#### Scenario: Required reviews accumulate over time
- **WHEN** additional required PM or Advisor reviews complete
- **THEN** their compact durable audit evidence remains retained
- **AND** redundant lifecycle-bound working copies only become eligible for compaction or separately authorized removal, so stored files may continue accumulating until authorized removal occurs

### Requirement: Packet retention and cleanup rules are deterministically validated
The project SHALL provide deterministic documentation anchors or cleanup-predicate cases for retention classes, OpenSpec checkpoints, small-task final gates, minimum durable audit evidence, and fail-closed blockers. Validation MUST include negative cases for active or ambiguous invocation state, unresolved P0/P1 or evidence gaps, incomplete post-action review, attempted permanent-template cleanup, and an incomplete audit record.

#### Scenario: Valid completed cleanup example is checked
- **WHEN** local validation inspects a completed OpenSpec or small-task cleanup example
- **THEN** it confirms the final applicable gate, blocker clearance, retained audit record, and preserved permanent material

#### Scenario: Unsafe cleanup example is checked
- **WHEN** a cleanup-predicate case proposes cleanup with a `running` or `result-unknown` invocation, unresolved blocker, incomplete gate, permanent template target, or incomplete audit record
- **THEN** deterministic validation rejects the case with its intended reason
