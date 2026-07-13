## 1. Normative Workflow Rules

- [x] 1.1 Extend `references/review-context-efficiency.md` with permanent protocol, durable audit, and lifecycle-bound working-material retention classes.
- [x] 1.2 Define C1 and C2 compaction checkpoints, C3 gate retention, and C4 final cleanup timing without weakening any OpenSpec, git, status, or post-action gate.
- [x] 1.3 Define the final applicable cleanup gate for non-OpenSpec tasks covering no-git, commit-only, pushed, and Owner-authorized publication or deployment scopes.
- [x] 1.4 Add fail-closed cleanup blockers for active or ambiguous invocation state, unresolved P0/P1, `BLOCKED-EVIDENCE`, evidence gaps, required corrections or decisions, incomplete reviews, and later applicable gates.
- [x] 1.5 State that lifecycle eligibility permits non-destructive compaction only; destructive removal remains Owner-only for an exact scope under applicable gates, with no time-based, background, automatic, or retrospective bulk deletion.

## 2. Audit Record And Templates

- [x] 2.1 Extend `templates/review-invocation-record.md` with retention class, final applicable gate or OpenSpec checkpoint, cleanup blocker check, cleanup decision, scope, actor, time, and retained-record location.
- [x] 2.2 Update PM and Advisor packet/template guidance so reusable blank templates remain permanent while filled instances are lifecycle-bound and original-evidence access remains unrestricted within approved scope.
- [x] 2.3 Document the minimum durable audit record including invocation identity, exact target anchors, fingerprint, timing, decision, findings, validation, evidence pointers, retry lineage, cleanup disposition, and complete required role reasoning, option comparison, recommendations, objections, and key error details directly or at a durable result location.
- [x] 2.4 Add or update a copyable cleanup checklist that requires explicit eligibility verification before any lifecycle-bound material is removed.

## 3. Examples And Documentation

- [x] 3.1 Add an OpenSpec C1-C4 example showing stage compaction, retained evidence needed by later gates, and final cleanup only after archive closeout.
- [x] 3.2 Add a non-OpenSpec small-task example showing cleanup immediately after its final applicable gate without inventing an OpenSpec lifecycle.
- [x] 3.3 Add negative examples for `running`, `result-unknown`, unresolved P0/P1, evidence gaps, incomplete post-action review, attempted blank-template deletion, and incomplete audit records.
- [x] 3.4 Update role-output and OpenSpec lifecycle guidance to distinguish packet cleanup from role-agent cleanup and to preserve validation, role, git, CI/status, secret-scan, release, authorization, and original-evidence boundaries.
- [x] 3.5 Update README, changelog, roadmap, TODO, traceability, and validation documentation for the new retention lifecycle without claiming measured token savings or proven quality improvement.
- [x] 3.6 State that active and retransmitted review context is bounded while stored lifecycle-bound files may grow until exact-scope Owner-authorized removal and compact durable audit evidence intentionally grows; do not claim a storage cap.

## 4. Deterministic Validation

- [x] 4.1 Extend `scripts/validate-local.sh` with deterministic anchors for all three retention classes, OpenSpec checkpoints, small-task final gates, minimum audit evidence, and explicit non-destructive cleanup.
- [x] 4.2 Add fail-closed validation fixtures or checks that reject active or ambiguous invocations, unresolved blockers, incomplete gates, permanent-template targets, and incomplete retained audit records.
- [x] 4.3 Verify valid OpenSpec and small-task example anchors are present and each unsafe cleanup-predicate case fails with its intended reason code.
- [x] 4.4 Run `bash -n scripts/validate-local.sh`, `./scripts/validate-local.sh`, `openspec validate define-review-packet-retention-cleanup --strict`, `openspec validate --all --strict`, `git diff --check`, English-only documentation checks, and applicable secret-pattern scans.

## 5. Review And Lifecycle Closeout

- [x] 5.1 Obtain independent PM and Claude Advisor review of the C1 proposal with no-peek first passes and resolve all P0/P1 findings before implementation.
- [x] 5.2 Obtain independent Reviewer, PM, and Claude Advisor review of the implemented diff, preserving packet access to task-relevant original evidence.
- [x] 5.3 Complete normal commit, actual-commit review, push, status/CI checks when available, and post-push review only after the applicable gates pass.
- [x] 5.4 Sync the accepted `role-review-context-efficiency` specification and archive this change through C4 after implementation and validation.
- [x] 5.5 Validate the archived state with `./scripts/validate-local.sh --require-no-active-changes` and `openspec validate --all --strict`.
- [x] 5.6 Complete the archive commit, actual-commit review, push, status checks when available, and post-push PM/Advisor review.
