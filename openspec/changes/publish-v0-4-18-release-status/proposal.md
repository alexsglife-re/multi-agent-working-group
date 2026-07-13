## Why

The accepted v0.4.18 lifecycle work is complete, but release-facing documentation and validation still describe v0.4.17 as public and v0.4.18 as a development target. The Owner has explicitly authorized the bounded tag, GitHub Release, and publication actions needed to make v0.4.18 the truthful public state on July 12, 2026.

## What Changes

- Align the actual stale public-version and development-target markers with public v0.4.18, dated July 12, 2026, without inventing a next development target.
- Make local validation accept a released state with no active development target while preserving strict and no-active-change checks.
- Require the normal documentation commit/push gates, including independent PM and Advisor review, required Reviewer review, fresh validation, no unresolved P0/P1 findings, secret scanning, actual-commit review, and post-push status review.
- Require the annotated `v0.4.18` tag to target only the reviewed and pushed C4 archive commit, followed by exact tag-target verification.
- Require a non-draft, non-prerelease GitHub Release and matching GitHub publication, followed by metadata/state verification and independent PM/Advisor closeout.
- Truthfully report the absence of GitHub Actions when `.github` is absent, and close role lifecycles sequentially.
- Exclude deployment, force-push, history rewrite, protected-branch bypass, secret or credential access/change, auth or permission changes, schema changes, destructive operations, and publication to any channel other than GitHub Release.

## Capabilities

### New Capabilities
- `public-release-status`: Defines truthful public-version documentation, a no-development-target validation state, and the gated tag, GitHub Release, publication, and closeout contract for v0.4.18.

### Modified Capabilities

None.

## Impact

Fresh repository-wide discovery established an exact ten-file implementation allowlist: `README.md`, `CHANGELOG.md`, `docs/ADAPTERS.md`, `docs/INSTALLATION.md`, `docs/ROADMAP.md`, `docs/TODO.md`, `docs/VALIDATION.md`, `references/TRACEABILITY.md`, `scripts/validate-local.sh`, and `templates/review-packet-cleanup-checklist.md`. These are the current top-level release, installation/adapter, traceability, validation, and v0.4.18 template surfaces that contained directly related public-release wording or assertions. The implementation changes documentation and validation semantics only; it does not change runtime APIs, dependencies, schemas, permissions, authentication, secrets, or deployment behavior. External effects are limited to the Owner-authorized normal push, annotated tag, and formal GitHub Release/publication after all required gates pass.
