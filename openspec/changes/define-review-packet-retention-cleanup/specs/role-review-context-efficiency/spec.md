## ADDED Requirements

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
