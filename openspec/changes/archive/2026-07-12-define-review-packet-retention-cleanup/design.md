## Context

The v0.4.17 context-efficiency protocol defines short-lived sessions, stable-baseline references, incremental packets, invocation identity, and no-blind-retry behavior. It does not yet classify packet artifacts or say when filled packets and copied evidence stop being active working material. Repeated OpenSpec gates and small-task reviews can therefore leave redundant packet documents indefinitely even though the original repository evidence remains available.

The change is documentation and validation focused. Its stakeholders are Leaders who control lifecycle transitions, PM and Advisor roles that require unrestricted task-relevant original-evidence access, Reviewers who verify the rules, and Owners who retain authority over destructive or exceptional actions.

## Goals / Non-Goals

**Goals:**

- Distinguish permanent reusable templates and stable rules from lifecycle-bound filled packets and duplicated evidence.
- Define conservative OpenSpec stage checkpoints for compaction and final cleanup.
- Define the final applicable cleanup gate for small tasks that do not use OpenSpec.
- Preserve a minimum durable audit record sufficient to reconstruct invocation identity, decisions, blockers, validation, evidence pointers, and retry lineage.
- Fail closed when an invocation or gate is unresolved.
- Keep cleanup explicit, reviewable, task-scoped, and non-destructive by default.
- Add deterministic positive and negative validation scenarios.

**Non-Goals:**

- No daemon, scheduler, time-based retention job, automatic deletion, or background cleanup.
- No removal or mutation of reusable blank templates, accepted specifications, archived OpenSpec artifacts, original repository evidence, or required audit records.
- No restriction on PM or Advisor provider/model capability, review scope or frequency, independent no-peek authority, task-relevant original-evidence access, lifecycle patience, or gate coverage.
- No cleanup authorization for unrelated projects, unrelated tasks, secrets, credentials, external systems, or user files.
- No tag, release, deployment, or publication behavior.

## Decisions

### Decision: Classify records by lifecycle instead of file name alone

The workflow uses three retention classes:

1. **Permanent protocol material:** reusable blank templates, stable project rules, accepted specifications, and archived OpenSpec artifacts. These are not task cleanup targets.
2. **Durable audit evidence:** the minimum retained record for each required review and gate plus the complete required role reasoning, option comparison, recommendation, objections, and key error details, either embedded or preserved at a durable original result location. This remains after compaction or cleanup; a terse decision summary is not sufficient.
3. **Lifecycle-bound working material:** filled packets, generated prompts, copied unchanged evidence, scratch manifests, and superseded packet renderings. These may be compacted after the applicable checkpoint and blocker checks; removal additionally requires explicit Owner authorization for the exact destructive scope and all applicable gates.

Classification by purpose prevents a filled copy from becoming permanent merely because it uses a permanent template, and prevents the template itself from being deleted merely because filled instances are disposable.

Alternative considered: require every filled packet to remain active and be retransmitted forever. Rejected because it defeats context control without adding review evidence when original sources and a durable audit record remain available. Stored packet files may nevertheless continue accumulating until exact-scope Owner-authorized removal occurs.

### Decision: Compact at OpenSpec checkpoints and establish removal eligibility only after the final applicable gate

OpenSpec work uses conservative lifecycle checkpoints:

- At the end of C1, proposal-review working packets may be compacted after both independent first passes, required corrections, and the C1 scope decision are complete. The durable record and evidence pointers remain available to C2.
- At the end of C2, implementation-review packets superseded by verified current evidence may be compacted after validation and required implementation review complete. Material still needed for C3 git gates remains active.
- During C3, current pre-commit, actual-commit, pre-push, post-push, status, and other applicable gate packets remain active until their corresponding gates and required follow-up reviews complete.
- At C4, non-destructive final compaction and destructive-removal eligibility occur only after archive validation, applicable archive commit/push/status work, and required post-action PM/Advisor review complete. If C4 is not yet applicable or complete, the active evidence needed to finish it is retained. Eligibility never replaces exact Owner authorization for removal.

Compaction means non-destructively replacing redundant active detail with the durable audit record and reproducible pointers. Removal means deleting confirmed lifecycle-bound material and remains a separately Owner-authorized destructive action. Neither lifecycle eligibility nor compaction changes original evidence, gate state, or removal authorization.

Alternative considered: retain all packets until C4 with no intermediate compaction. Rejected because completed-stage duplication can grow throughout long changes. Alternative considered: delete every stage packet immediately. Rejected because later gates may still depend on unresolved or active evidence.

### Decision: Small tasks clean up after their final applicable gate

For a task without OpenSpec, the final applicable gate is determined by actual scope:

- review-only or local no-git work: required final review;
- commit-only work: actual-commit review;
- pushed work: required status/CI evidence and post-push review;
- tag, release, publication, or deployment work: the corresponding Owner-authorized action and post-action closeout review.

Non-destructive lifecycle-bound packet compaction may occur immediately after that final applicable gate is complete and the blocker check passes. The same point may establish eligibility for a separately Owner-authorized removal, but does not authorize deletion. This avoids inventing an OpenSpec lifecycle for genuinely small tasks while preserving every gate that the task actually uses.

### Decision: Retain a minimum audit record

Before compaction or cleanup, the Leader records at least:

- Review ID, Attempt ID, parent Attempt ID when present, role, review type, and invocation state;
- target, exact commit/diff/gate anchor, stable baseline anchor, and packet fingerprint;
- start/completion time, result location, retry decision and reason;
- decision, P0/P1/P2 findings, evidence gaps, required corrections, and Owner-decision needs;
- validation commands, freshness, results, and applicable status/CI or secret-scan evidence;
- task-relevant original-evidence pointers and the final applicable gate or OpenSpec checkpoint;
- cleanup decision, scope, actor, time, and retained-record location.

The durable record also preserves each required PM or Advisor output's complete reasoning, option comparison, recommendation, objections, and key error details, either directly or through a durable original result location. Filled input packets and generated prompts may be lifecycle-bound; required role output is not reduced to a short `GO` or `NO-GO` summary.

Pointers must be reproducible enough for a future Leader or role to re-inspect original evidence. A summary without identity, findings, or evidence pointers is not sufficient.

### Decision: Cleanup fails closed on unresolved state

Compaction and removal eligibility are forbidden when any related invocation is `prepared`, `running`, or `result-unknown`; when P0/P1 findings, `BLOCKED-EVIDENCE`, evidence gaps, required corrections, required Owner decisions, or required reviews remain unresolved; or when a later applicable gate still needs the material. `failed-confirmed` and `superseded` records may be compacted or marked eligible for separately Owner-authorized removal only after retry lineage and final disposition are durably recorded.

This blocker model reuses invocation state rather than introducing a separate cleanup state machine. Short silence remains insufficient evidence of failure or cleanup safety.

### Decision: Lifecycle eligibility does not authorize destructive cleanup

The upgrade documents and validates lifecycle semantics; it does not implement background deletion. A Leader-recorded eligibility decision may authorize non-destructive compaction only. Any file deletion or other destructive removal remains a default exclusion requiring explicit Owner authorization naming the exact scope plus all applicable gates. Existing historical packet files are preserved unless a later, separately Owner-authorized task identifies exact targets and applies the same rules. This change does not preauthorize deletion of current, future, or historical packets.

Alternative considered: automatically delete packets by age or at every stage transition. Rejected because age does not prove gate completion, invocation resolution, or audit sufficiency, and unattended deletion could erase required evidence.

### Decision: Validate rules and fail-closed examples deterministically

Validation will check required normative anchors in the reference, role-output guidance, templates or examples, and accepted spec. Positive examples cover completed OpenSpec and small-task cleanup. Negative examples cover `running`, `result-unknown`, unresolved P0/P1, evidence gaps, incomplete post-action review, attempted template deletion, and cleanup without a minimum audit record.

Validation proves documented coverage and internal consistency; it does not prove that every external role runtime enforces cleanup automatically.

## Risks / Trade-offs

- **Risk: Cleanup removes context needed by a later gate.** Mitigation: final-applicable-gate rules, explicit blocker checks, and reproducible original-evidence pointers.
- **Risk: Stored packet and audit records continue growing.** Mitigation: keep audit records compact and pointer-based while preserving complete required role reasoning at a durable result location. The change controls active and retransmitted context and establishes eligibility rules; it does not impose a storage cap. Lifecycle-bound files may continue growing until exact-scope Owner-authorized removal, and durable audit evidence intentionally grows linearly with required reviews.
- **Risk: Stage compaction is mistaken for authorization to delete original evidence.** Mitigation: retention classes explicitly exclude original evidence, accepted specs, archives, and permanent templates.
- **Risk: Manual cleanup is inconsistently performed.** Mitigation: add explicit lifecycle checklists, examples, and deterministic validation anchors without introducing unsafe automation.
- **Risk: PM/Advisor quality declines because packet files disappear.** Mitigation: cleanup occurs only after the applicable gate, original evidence remains readable, and future reviews start from stable baselines plus retained audit pointers.
- **Risk: Existing historical packet directories do not meet the new format.** Mitigation: apply the rules prospectively; do not bulk-delete or rewrite historical evidence during migration.

## Migration Plan

1. Add normative retention and cleanup rules to the context-efficiency reference and role-output guidance.
2. Extend invocation and packet templates or examples with retention class, final applicable gate, blocker check, minimum audit record, and explicit cleanup decision fields.
3. Add deterministic validation anchors and positive/negative scenarios.
4. Apply the lifecycle prospectively to newly created filled packets; preserve existing historical material unless separately reviewed and explicitly scoped.
5. After implementation and review, sync and archive this OpenSpec change through the normal C3/C4 gates.

Rollback is documentation-only: revert the affected workflow documentation and validation changes through normal git gates. Rollback MUST NOT delete audit evidence created while the rules were active.

## Open Questions

- None. The implementation may choose exact task-local storage paths, but those paths must preserve the retention classes and audit requirements above.
