## Context

The progressive Leader-state implementation and its accepted specifications are
complete at commit `bc5ffc5a6b50d1ecaeaeba931f293449d8ceaf7b`, while public status remains
`v0.4.18`. The Owner has now explicitly authorized a v1.0.0 public conversion,
annotated tag, formal non-draft/non-prerelease GitHub Release, and publication
through that Release only. Deployment is excluded.

The current validator intentionally rejects any claim that v1.0.0 is public.
Its version-state checks include literal v1.0.0 development assumptions, so a
constant-only update would leave a fail-closed guard contradicting the release.
The current limitation checks also depend on a non-empty development target;
they must remain enforced after v1.0.0 becomes public with no successor target.

## Goals / Non-Goals

**Goals:**

- Make v1.0.0 the current public version on every release-facing surface,
  including README, and preserve v0.4.18 as historical release evidence.
- Keep the provisional-threshold, warning-only size, interim
  `hierarchical-required`, and unimplemented Hierarchical-storage disclosures
  mandatory after the development target is cleared.
- Produce one deterministic Release payload from the reviewed v1.0.0 changelog
  section and bind tag, Release, and metadata verification to one frozen C4
  archive commit.
- Preserve stage-scoped role lifecycles, fresh validation, secret scanning,
  actual-commit review, post-push review, and post-publication closeout.

**Non-Goals:**

- Declaring a next development target.
- Implementing Hierarchical storage or calibrating/enforcing thresholds.
- Deployment, package-registry publication, social/community publication, or
  mutation of GitHub repository description, topics, settings, or visibility.
- Force-push, history rewrite, protected-branch bypass, credential/auth/
  permission changes, schema changes, destructive actions, or unrelated work.

## Decisions

### Treat v1.0.0 as a bounded stable protocol release

The release promises the documented protocol, role/gate behavior, Compact and
Standard profiles, deterministic classification, and honest
`hierarchical-required` detection. It does not promise completed Hierarchical
storage, calibrated blocking thresholds, runtime enforcement, measured token
or storage savings, or validated support for every named runtime. These limits
remain visible in README, CHANGELOG, ROADMAP, VALIDATION, traceability, and the
Release body.

Alternative: publish v0.5.0. Rejected because the Owner explicitly selected and
authorized v1.0.0 with the bounded promise above.

### Clear the development target without clearing limitation checks

Set the public version to v1.0.0 and represent no next development target. Move
the progressive-profile limitation assertions outside any conditional that
only runs when `DEVELOPMENT_VERSION` is non-empty. Rotate contradiction tests
so stale v1.0.0-development and v0.4.18-current-public claims fail, while valid
v1.0.0-public/no-next-target text passes.

Alternative: keep `DEVELOPMENT_VERSION=v1.0.0` after publication. Rejected
because the same version cannot truthfully be both the current public release
and the active development target.

Every current README version/status passage is in scope, including prose in
which the version precedes the phrase “development target.” Deterministic
negative fixtures use that real prose shape so colon-anchored declarations are
not the only rejected form. The three progressive-profile template labels
become exactly `Version: v1.0.0 release template.` and their validator checks
use that release literal rather than an empty development-version variable.
The v0.4.18 review-packet template and its literal remain historical evidence.

The changelog's inaccurate `## [Unreleased]` container becomes exactly
`## Releases` because no successor development target is authorized.

### Bind the documented date to annotated-tag creation

Release-facing files use the actual `America/Los_Angeles` calendar date on
which the local annotated tag is created. The GitHub Release `publishedAt`
timestamp is recorded independently and is not required to share that calendar
date. The date is rechecked immediately before the release-status commit and
immediately before local tag creation.

If the date changes before local tag creation, stop, correct the allowlisted
repository files, repeat validation and all affected commit/push/archive
reviews, and create the tag only from the newly frozen target. Once the local
tag exists, its documented date is frozen; a later remote push or Release may
occur on another date. Neither the local nor remote v1.0.0 tag may be moved or
deleted under this authorization. If Release creation fails, publication
remains incomplete and may only be retried against the same tag, frozen commit,
title, and reviewed body; it is never reported as success until the formal
Release verifies.

### Derive one byte-deterministic Release payload

The GitHub Release title is exactly `v1.0.0`. Its body is exactly the reviewed
v1.0.0 CHANGELOG section from the frozen commit. Extraction includes the exact
published v1.0.0 heading, excludes the next v0.4.18 heading, normalizes input
line endings to LF, removes all trailing blank lines from the selected section,
and appends exactly one final LF byte. The payload is materialized at a unique
path under `/tmp`, SHA-256 hashed, and reviewed before publication. After
publication, the GitHub API body is encoded as UTF-8 and compared byte-for-byte
and by SHA-256 with that same file. The annotated-tag message is exactly
`v1.0.0 - Progressive Leader State Profiles`.

Alternative: author independent GitHub copy. Rejected because it can drift from
the repository's durable release record.

### Freeze the C4 archive commit before external publication

Complete C1-C4, including both normal commit/push chains and post-push reviews.
The final reviewed C4 archive commit becomes immutable release target evidence;
HEAD must not advance between that freeze, tag creation, and Release creation.
Tag target exactness is verified through both local and remote annotated-tag
objects and their peeled commit.

All OpenSpec checklist items are pre-archive readiness assertions. Actual
archive execution, archived validation, archive commit/push, tag, Release, and
post-publication results are durable external command, role-review, Git, and
GitHub metadata evidence; the archived checklist is never edited afterward.

Fresh short-lived PM, Advisor, and Reviewer sessions are mandatory for each
distinct non-OpenSpec checkpoint: annotated-tag action/verification; rendered
payload plus formal-Release action/verification; and post-publication
metadata/content/target/no-deployment closeout. Each group closes sequentially
before the next starts. The remote annotated tag's peeled commit, rather than
GitHub `targetCommitish`, is the authoritative target proof.

### Restrict implementation to an exact tracked-path allowlist

The only implementation paths are `README.md`, `CHANGELOG.md`,
`docs/ROADMAP.md`, `docs/TODO.md`, `docs/VALIDATION.md`,
`docs/INSTALLATION.md`, `docs/ADAPTERS.md`, `references/TRACEABILITY.md`,
`templates/compact-leader-state.md`, `templates/standard-leader-state.md`,
`templates/successor-opportunity-skeleton.md`, `scripts/validate-local.sh`,
this active OpenSpec change, the accepted
`openspec/specs/public-release-status/spec.md` sync target, and the eventual
dated archive of this change. All other tracked files are forbidden without a
new reviewed scope decision. In particular,
`templates/review-packet-cleanup-checklist.md` remains historical v0.4.18
evidence.

At C4 sync, replace the accepted capability Purpose exactly with: “Define the
authoritative current public release state, validation, lifecycle gates, exact
release target, GitHub-Release-only publication boundary, and closeout
requirements for v1.0.0 while preserving v0.4.18 as historical evidence.”

## Risks / Trade-offs

- **Major-version overclaim** → keep stable-vs-pilot boundaries explicit on
  every primary public surface and in the exact Release body.
- **Validator weakened merely to pass** → add positive and negative fixtures
  that rotate version roles while preserving contradiction detection and
  limitation enforcement.
- **Release date crosses midnight** → rebuild only if it changes before local
  tag creation; after creation the tag-bound date is frozen, neither local nor
  remote tag may move, and an incomplete Release retries unchanged.
- **Tag or Release points at the wrong commit** → freeze one reviewed C4 SHA and
  verify annotated tag object plus peeled target locally and remotely.
- **GitHub combined status reports pending with zero contexts** → report the
  repository's absence of `.github`, statuses, and check runs truthfully; do
  not call it CI success or failure.
- **Post-publication correction would advance HEAD** → block publication on any
  unresolved docs, validation, payload, metadata, or target discrepancy.
- **No repository CI exists** → verify `.github` absence plus zero status/check
  contexts and report “no GitHub Actions configured,” never CI success.
