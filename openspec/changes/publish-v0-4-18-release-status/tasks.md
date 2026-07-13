## 1. C1 Proposal Gate

- [x] 1.1 Verify fresh takeover evidence, exact HEAD/origin/main, clean baseline, current public v0.4.17 state, archived v0.4.18 implementation, and Owner-authorized scope without inheriting old decisions or validation.
- [x] 1.2 Start one runtime-proven PM lifecycle and one runtime-proven Advisor lifecycle for C1; record exact stage/runtime identity and independent no-peek review evidence.
- [x] 1.3 Review proposal, design, delta spec, and tasks independently with PM and Advisor; resolve all P0/P1 findings and record P2 disposition without self-approval.
- [x] 1.4 Run strict validation for `publish-v0-4-18-release-status`, confirm apply-ready status, and close C1 PM then Advisor lifecycles sequentially with cross-stage transition evidence.

## 2. C2 Implementation And Validation

- [x] 2.1 Start new runtime-proven C2 PM and Advisor lifecycles with fresh stage evidence and no inherited C1 GO, validation, or authorization.
- [x] 2.2 Re-run targeted stale-marker discovery and establish the exact ten-file edit allowlist: `README.md`, `CHANGELOG.md`, `docs/ADAPTERS.md`, `docs/INSTALLATION.md`, `docs/ROADMAP.md`, `docs/TODO.md`, `docs/VALIDATION.md`, `references/TRACEABILITY.md`, `scripts/validate-local.sh`, and `templates/review-packet-cleanup-checklist.md`.
- [x] 2.3 Update the allowlisted documentation and template surfaces so v0.4.18 is public on July 12, 2026, directly related additive notes are formally scoped, and no next development target is invented.
- [x] 2.4 Update `scripts/validate-local.sh` so v0.4.18 is the public version, a no-active-development-target state is valid, and contradictory stale markers still fail.
- [x] 2.5 Add or update focused validator assertions for both the valid no-target state and invalid v0.4.17-public or v0.4.18-development claims.
- [x] 2.6 While the change remains active, run fresh repository-only validation as `./scripts/validate-local.sh --skip-global-skill` plus strict validation of this change and all specs; do not require the no-active-change mode, record any plain-validation machine-global mismatch separately, and make no machine-global synchronization claim.
- [x] 2.7 Obtain fresh independent C2 PM and Advisor review of the implementation and validation evidence, resolve all P0/P1, and close C2 lifecycles sequentially.

## 3. C3 Independent Review

- [x] 3.1 Start new runtime-proven C3 PM and Advisor lifecycles and dispatch an independent Reviewer with the exact implementation diff and fresh validation evidence.
- [x] 3.2 Have Reviewer check all release markers, no-target validator semantics, negative checks, English-only documentation, scope exclusions, and absence of unrelated edits.
- [x] 3.3 Obtain fresh independent PM and Advisor C3 decisions, resolve all P0/P1 and required P2 corrections, then rerun affected validation.
- [x] 3.4 Confirm the reviewed implementation target is stable and close Reviewer, PM, and Advisor lifecycles sequentially with required transition records.

## 4. C4 Sync And Archive Readiness

- [x] 4.1 Start new runtime-proven C4 PM and Advisor lifecycles with fresh decisions and verify the exact reviewed C3 target.
- [x] 4.2 Sync the `public-release-status` delta into main specs, validate the synchronized specs strictly, and obtain independent PM/Advisor checkpoint review.
- [x] 4.3 Run fresh active-change repository validation as `./scripts/validate-local.sh --skip-global-skill`, strict validation of the active change and all specs, and the staged-diff secret scan; confirm no unresolved P0/P1 without requiring no-active-change mode, and keep any plain `./scripts/validate-local.sh` result as separate machine-global comparison evidence only.
- [x] 4.4 Obtain required Reviewer plus fresh PM/Advisor pre-commit approval and create the normal English four-section release-status commit without rewriting history.
- [ ] 4.5 Have PM and Advisor review the actual release-status commit, rerun required validation, then obtain fresh pre-push decisions and push normally.
- [ ] 4.6 Verify post-push HEAD equals origin/main, clean worktree, remote commit identity, and repository status; if `.github` is absent, record truthfully that no GitHub Actions workflows exist.
- [ ] 4.7 Obtain fresh PM/Advisor post-push review and verify the exact synchronized delta, archive destination, expected archive diff, and archive validation commands.
- [ ] 4.8 Obtain required Reviewer plus fresh PM/Advisor archive-readiness approval with no unresolved P0/P1 and confirm no OpenSpec checklist work remains after this item.
- [ ] 4.9 Record the durable external-evidence locations that will track the archive action, archive commit/push reviews, no-active-change validation, exact tag target, Release payload, publication metadata, and sequential closeout without editing archived tasks.
- [ ] 4.10 Confirm every preceding checkbox is complete and authorize the archive boundary; checking this final item completes the OpenSpec checklist, after which the post-archive runbook executes without mutating the archived checklist.

## Post-Archive Operational Runbook (Durable External Evidence, Not OpenSpec Checkboxes)

The following operations occur only after all OpenSpec checkboxes are complete. Record each gate and result in durable external lifecycle, review, validation, Git, and GitHub metadata evidence. Do not edit the archived tasks file to mark these operations complete.

1. Archive `publish-v0-4-18-release-status`; run strict OpenSpec validation and `./scripts/validate-local.sh --require-no-active-changes --skip-global-skill`; keep any plain `./scripts/validate-local.sh` result as separate machine-global comparison evidence only; review the exact archive diff.
2. Run the archive staged-diff secret scan, obtain required Reviewer and fresh PM/Advisor pre-commit approval, and create the normal English four-section archive commit.
3. Have PM and Advisor review the actual archive commit, rerun fresh validation, obtain pre-push decisions, push normally, and verify post-push HEAD/origin/main, clean state, and truthful status/CI metadata.
4. Obtain fresh PM/Advisor post-push review and record the exact pushed C4 archive commit SHA as the only eligible v0.4.18 tag target.
5. Open fresh independent tag-gate PM and Claude Advisor reviews for that exact commit; verify Owner authorization, clean synchronized main, no unresolved P0/P1, fresh validation, and tag absence.
6. Create and push annotated tag `v0.4.18` at exactly the reviewed C4 archive commit; verify local and remote annotation/object metadata and peeled targets.
7. Obtain fresh independent PM and Advisor post-tag review; stop on any target or metadata mismatch.
8. Render a deterministic GitHub Release payload whose title is exactly `v0.4.18` and whose body is exactly the reviewed v0.4.18 section of `CHANGELOG.md`; obtain fresh independent PM and Claude Advisor release-gate review of the rendered payload and verified tag target.
9. Create the formal GitHub Release with `draft=false` and `prerelease=false`; do not publish to another channel or deploy.
10. Verify URL, `publishedAt`, tag, target commit, draft state, and prerelease state; obtain fresh independent PM and Advisor publication closeout.
11. Verify final HEAD equals origin/main, the worktree is clean, local and remote tags peel to the exact archive commit, public docs align, and no deployment occurred. HEAD must not advance after the tagged archive commit.
12. Close remaining Worker, Reviewer, PM, and Advisor roles sequentially only after their evidence is no longer required.
