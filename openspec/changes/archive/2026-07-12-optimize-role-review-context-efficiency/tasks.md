## 1. Protocol And Router

- [x] 1.1 Reconcile `docs/ROLE_REVIEW_CONTEXT_EFFICIENCY_DRAFT.md` with the accepted proposal; keep it explicitly non-authoritative until the implementation, validation, and review gates pass, then replace or supersede its draft status with the adopted v0.4.17 workflow/reference documentation.
- [x] 1.2 Add `references/review-context-efficiency.md` defining stable baselines, factual manifests, separate no-peek packets, fresh short-lived sessions, original-evidence access, review identity, invocation states, and safe linked retries.
- [x] 1.3 Update `SKILL.md` with the always-loaded quality-preservation boundary and mandatory routing to the new reference before context-efficient PM or Advisor review work.
- [x] 1.4 Verify the new protocol does not change PM/Advisor provider/model routing, invocation frequency, gates, lifecycle patience, cleanup order, default exclusions, or Advisor evidence-not-authority treatment.

## 2. Review Packets And State Templates

- [x] 2.1 Add `templates/review-factual-manifest.md` as the conclusion-free shared evidence manifest and extend separate `templates/pm-review.md` and `templates/advisor-review.md` packet fields with stable baseline, incremental evidence, no-peek, evidence-access, and validation-freshness fields.
- [x] 2.2 Add `templates/review-invocation-record.md` covering Review ID, Attempt ID, packet fingerprint, required states, result location, retry decision, and parent attempt linkage.
- [x] 2.3 Extend existing PM, Advisor, git-gate, compact-handoff, successor-startup, C0, and other applicable state-carrying templates with review identity and unresolved `result-unknown` handling without duplicating full unchanged evidence.
- [x] 2.4 Preserve `GO`, `NO-GO`, `BLOCKED-EVIDENCE`, P0/P1/P2, inspected evidence, evidence gaps, validation freshness, required corrections, Owner-decision needs, next action, and rationale in applicable role outputs.
- [x] 2.5 Add or update representative examples for independent PM/Advisor packets, original-evidence escalation, a narrow same-session follow-up, delayed output, and a safely linked retry.

## 3. Documentation And Version v0.4.17

- [x] 3.1 Update README and relevant installation, adapter, roadmap, TODO, and workflow documentation to describe v0.4.17 Role Review Context Efficiency as the development target without claiming it is tagged, released, public, runtime-measured, or broader adapter support.
- [x] 3.2 Add an unreleased/in-development v0.4.17 changelog entry and synchronize version markers using separate `PUBLIC_VERSION=v0.4.16` and `DEVELOPMENT_VERSION=v0.4.17` semantics (or an equally clear minimal convention); keep README's current public-version marker at v0.4.16.
- [x] 3.3 Document that compact packets and role outputs are evidence rather than authorization and that tag, release, publication, and other default exclusions remain Owner-only.
- [x] 3.4 Document that validation proves marker and template consistency, not runtime compliance, actual token savings, or review quality by itself.

## 4. Validation And Non-Regression

- [x] 4.1 Extend `scripts/validate-local.sh` with targeted checks for the skill router, dedicated reference, stable-baseline plus incremental packet markers, no-peek isolation, original-evidence access, and quality preservation.
- [x] 4.2 Add targeted validation for Review ID, Attempt ID, packet fingerprint, all invocation states, linked retry fields, no-blind-retry behavior, and complete role-output fields.
- [x] 4.3 Update `docs/VALIDATION.md` with representative v0.4.17 scenarios and the limits of documentation-marker validation.
- [x] 4.4 Update local validation to check the public and development versions independently and fail if v0.4.17 development documentation falsely claims an Owner-authorized tag, release, or publication.
- [x] 4.5 Register `role-review-context-efficiency` in `REQUIRED_ACCEPTED_SPECS`, add an explicit active-change delta fallback so normal implementation validation can pass, require the accepted spec path in `--require-no-active-changes`/archive mode, and register `references/review-context-efficiency.md` in `REQUIRED_REFERENCES` so both repository presence and the existing global-reference sync loop are enforced.
- [x] 4.6 Register `templates/review-factual-manifest.md` and `templates/review-invocation-record.md` in `REQUIRED_TEMPLATES`; keep their and all touched template headers at `Version: v0.4.13 recommended template.` unless an intentional template-version migration is separately approved.
- [x] 4.7 Add at least two distinct fail-closed `SKILL.md` anchors and validator checks: mandatory context-efficiency reference routing, and preservation of role capability/frequency/no-peek/original-evidence/gates/lifecycle patience. Increase `SKILL_ANCHOR_BASELINE` from 55 to at least 57, or to the higher verified resulting anchor count if more than two anchors are added; do not leave the floor at 55.
- [x] 4.8 Run `./scripts/validate-local.sh`, `openspec validate --all`, `git diff --check`, English-only checks for changed development documentation, and applicable secret-pattern scans; resolve all P0/P1 failures.
- [x] 4.9 Verify the repository skill, installed global skill, and every `REQUIRED_REFERENCES` entry including `references/review-context-efficiency.md` according to the existing sync workflow, recording installed-copy sync separately from repository completion.

## 5. Independent Review And Closeout

- [x] 5.1 Obtain independent no-peek PM and Claude/Claude CLI Advisor review of the implementation and validation evidence, treat Advisor output as unverified evidence, and independently resolve all P0/P1 findings.
- [x] 5.2 Obtain required Reviewer approval for any implementation or script changes and refresh validation after corrections.
- [x] 5.3 Complete the normal commit gate with PM plus Advisor agreement, fresh validation, no unresolved P0/P1, required Reviewer approval, and applicable secret scanning; use the required four-section English handover commit message.
- [x] 5.4 Review the actual commit with PM and Advisor, then complete the normal push gate and post-push HEAD/remote plus CI/status checks without creating a tag, release, or publication.
- [x] 5.5 Obtain post-push PM and Advisor implementation closeout, synchronize accepted specs, archive the OpenSpec change, run archive and no-active-change validation, complete a separate archive commit gate and normal push gate when archive files change, check post-push HEAD/remote and CI/status, obtain fresh post-push PM plus Advisor archive review, and only then perform sequential role cleanup.
