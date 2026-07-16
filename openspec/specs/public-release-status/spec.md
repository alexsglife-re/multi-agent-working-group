# public-release-status Specification

## Purpose

Define the authoritative current public release state, validation, lifecycle gates, exact release target, GitHub-Release-only publication boundary, and closeout requirements for v1.0.0 while preserving v0.4.18 as historical evidence.

## Requirements

### Requirement: Public documentation represents the released v1.0.0 state
Release-facing documentation SHALL identify `v1.0.0 — Progressive Leader State Profiles` as the current public version using the documented annotated-tag date, SHALL preserve v0.4.18 as historical release evidence from July 12, 2026, and MUST state that no next development target is declared unless the Owner separately authorizes one.

#### Scenario: Release markers are aligned
- **WHEN** the v1.0.0 release-status implementation is reviewed
- **THEN** README, changelog, roadmap, TODO, validation, traceability, installation, adapter, template, and validation-script surfaces identify v1.0.0 consistently as public and v0.4.18 as historical
- **AND** no surface claims an active development target or completed deployment

### Requirement: Validation supports no active development target
The local validation workflow SHALL represent v1.0.0 as the public version and SHALL support a valid state with no active development target while rejecting stale v1.0.0-development, v0.4.18-current-public, release-date, tag, Release, publication, deployment, and progressive-profile limitation contradictions.

#### Scenario: Released state has no successor target
- **WHEN** local validation runs after v1.0.0 documentation alignment and no successor development target has been authorized
- **THEN** its positive assertions verify public v1.0.0, the annotated-tag Los Angeles date, no next development target, and the retained progressive-profile limitations
- **AND** negative fixtures fail for stale v1.0.0-development, v0.4.18-current-public, false tag or Release state, unsupported publication, or deployment claims

#### Scenario: Stale development prose is rejected
- **WHEN** a release-facing surface uses either a `Development target: v1.0.0` declaration or version-before-phrase prose such as `The v1.0.0 development target ...`
- **THEN** deterministic validation fails before commit, tag, or Release

#### Scenario: Active OpenSpec state is validated
- **WHEN** implementation gates are evaluated while `publish-v1-0-0-release-status` remains active
- **THEN** repository-only local validation runs as `./scripts/validate-local.sh --skip-global-skill` and strict validation of the current change and all specs pass
- **AND** skipping the installed global-skill comparison does not skip or weaken any repository documentation, fixture, shell-syntax, or OpenSpec check
- **AND** plain local validation, when run, is separate machine-global comparison evidence and does not imply machine-global synchronization
- **AND** the no-active-change mode is not required at that checkpoint

#### Scenario: Archived OpenSpec state is validated
- **WHEN** the change has been archived
- **THEN** strict OpenSpec validation and `./scripts/validate-local.sh --require-no-active-changes --skip-global-skill` both pass on the archived target
- **AND** plain local validation remains separate machine-global comparison evidence only and does not imply machine-global synchronization

### Requirement: C1-C4 gates remain independent and stage-scoped
The change SHALL complete C1 through C4 with one runtime-proven PM lifecycle and one runtime-proven Advisor lifecycle per stage, fresh checkpoint decisions, required Reviewer participation, and no unresolved P0 or P1 finding before advancing.

#### Scenario: Same-stage checkpoint continues
- **WHEN** PM or Advisor reviews another checkpoint within the same C-stage and no canonical restart trigger applies
- **THEN** the role retains the same Stage Session ID and exact Runtime Session ID while using a new Review ID, Attempt ID, target fingerprint, and fresh decision state
- **AND** Claude Advisor continuity uses exact `--resume` without `--no-session-persistence`, `--max-budget-usd`, or another artificial budget limit

#### Scenario: Stage boundary is crossed
- **WHEN** the change advances to another C-stage
- **THEN** PM and Advisor lifecycles restart by default with the required transition evidence
- **AND** earlier GO decisions, validation freshness, and authorization are not inherited

### Requirement: Git commits and pushes satisfy repository gates
Every release-status or archive commit and push SHALL have fresh validation, independent PM and Advisor agreement, required Reviewer approval, no unresolved P0/P1, an applicable secret scan, actual-commit review, and post-push repository/status review.

#### Scenario: Commit and push complete
- **WHEN** a release-status or C4 archive commit is ready for normal push
- **THEN** the staged or outgoing diff passes the applicable secret scan and fresh pre-action gates
- **AND** PM and Advisor review the actual commit after creation
- **AND** HEAD equals origin/main and the worktree is clean after push and post-push review

#### Scenario: Repository has no GitHub Actions
- **WHEN** post-push status inspection confirms `.github` and GitHub Actions workflows are absent
- **THEN** the evidence truthfully states that no GitHub Actions checks exist
- **AND** does not fabricate or imply a CI success result

### Requirement: Public v1.0.0 preserves progressive-profile limitations
The v1.0.0 public release SHALL continue to state that structural thresholds are provisional mandatory classification baselines that do not block work by themselves, physical line and UTF-8-byte bands are warning-only, `hierarchical-required` is an interim detection state, and Hierarchical root/card/shard storage is not implemented. The release MUST NOT claim runtime enforcement, calibrated blocking thresholds, measured token or storage savings, guaranteed review quality, universal runtime support, or deployment.

#### Scenario: No successor development target exists
- **WHEN** v1.0.0 is public and no next development target is authorized
- **THEN** README, changelog, roadmap, validation, traceability, and deterministic checks retain the progressive-profile limitations independently of any development-version marker

#### Scenario: Major-version scope is reviewed
- **WHEN** a reader evaluates what v1.0.0 makes stable
- **THEN** public text distinguishes the released protocol, roles, gates, profile templates, and classification behavior from the deferred Hierarchical storage and threshold-calibration follow-ons

### Requirement: Release date uses action-time Los Angeles semantics
The documented v1.0.0 public date SHALL equal the actual `America/Los_Angeles` calendar date when the local annotated tag is created, while the formal GitHub Release `publishedAt` timestamp SHALL be recorded independently. A date change before local tag creation MUST invalidate stale release-facing documentation and require correction and fresh review before publication.

#### Scenario: Work crosses local midnight
- **WHEN** the Los Angeles calendar date differs from the date recorded in the frozen release tree before the local tag is created
- **THEN** tag and Release actions stop until documentation, validation, commit, push, archive, and applicable reviews are refreshed on a corrected target

#### Scenario: Release is incomplete after remote tag publication
- **WHEN** the remote annotated tag exists but Release creation fails or resumes on a later Los Angeles calendar date
- **THEN** the remote tag MUST NOT be moved or deleted and publication remains incomplete
- **AND** Release creation may only retry with the unchanged tag, peeled commit, title, and reviewed payload

#### Scenario: Local tag freezes the documented date
- **WHEN** the local annotated v1.0.0 tag has been created on the reviewed date
- **THEN** a later remote push or Release date does not invalidate the frozen repository date
- **AND** neither the local nor remote tag may be moved or deleted under this authorization

### Requirement: Tag and GitHub Release use an exact reviewed target
The annotated `v1.0.0` tag SHALL be created and pushed only after the C4 archive commit is pushed and post-push reviewed, and the formal GitHub Release SHALL use that exact tag and peeled commit target.

#### Scenario: Annotated tag is created
- **WHEN** fresh short-lived independent PM, Advisor, and Reviewer tag-gate sessions confirm the final C4 archive commit SHA, current annotated-tag Los Angeles date, authorization, and all required evidence
- **THEN** annotated tag `v1.0.0` is created at exactly that SHA with message `v1.0.0 - Progressive Leader State Profiles` and pushed normally
- **AND** local and remote tag objects and peeled commit targets are verified after the action
- **AND** the tag-gate sessions close sequentially before Release-gate sessions start

#### Scenario: Formal GitHub Release is published
- **WHEN** new fresh short-lived independent PM, Advisor, and Reviewer payload/Release sessions confirm the verified v1.0.0 tag target and rendered payload
- **THEN** the payload title is exactly `v1.0.0` and the body is extracted from the frozen commit's published v1.0.0 `CHANGELOG.md` section with LF line endings, all trailing blank lines removed, and exactly one final LF byte
- **AND** the Release is created with `draft=false` and `prerelease=false`
- **AND** post-action evidence verifies its URL, `publishedAt`, tag and peeled commit target independently of `targetCommitish`, draft state, prerelease state, byte-equal content and SHA-256, synchronized repository state, and absence of deployment before those sessions close sequentially

### Requirement: Archive and post-archive evidence do not mutate the tagged target
Every OpenSpec checklist item SHALL be a pre-archive readiness assertion and SHALL be complete before archive. Archive execution, archived validation, archive-commit review/push, tag, Release, publication, and closeout SHALL be tracked as durable external operational evidence and MUST NOT require editing the archived task checklist or advancing HEAD after the exact archive commit is tagged.

#### Scenario: OpenSpec checklist reaches archive boundary
- **WHEN** C4 confirms the reviewed accepted-spec sync, fresh review, active-state validation, external runbooks, and archive readiness
- **THEN** all OpenSpec checklist items are complete before the archive command runs

#### Scenario: Post-archive operations are recorded
- **WHEN** archive, tag, or Release actions occur after checklist completion
- **THEN** their gates and results are recorded in durable external review and metadata evidence
- **AND** no archived task file is edited and HEAD does not advance after the reviewed archive commit becomes the v1.0.0 tag target

### Requirement: Publication and cleanup stay within the authorized boundary
Publication SHALL occur only through the formal GitHub Release, SHALL NOT perform deployment or any excluded high-risk operation, and SHALL end with independent PM, Advisor, and Reviewer closeout followed by sequential role cleanup.

#### Scenario: Release work closes successfully
- **WHEN** tag and GitHub Release metadata and byte-content verification pass
- **THEN** a third fresh short-lived PM, Advisor, and Reviewer group independently confirms README and public-document alignment, exact peeled target, clean synchronized repository state, truthful no-GitHub-Actions evidence, and absence of deployment
- **AND** required role lifecycles are closed sequentially rather than concurrently

#### Scenario: Excluded operation is encountered
- **WHEN** completion would require deployment, force-push, history rewrite, protected-branch bypass, secret or credential access/change, auth or permission change, schema change, destructive action, or a publication channel other than GitHub Release
- **THEN** the workflow stops at the gate because that operation is outside this change's authorization

### Requirement: v1.0.0 public status supersedes public v0.4.18
Release-facing documentation SHALL identify `v1.0.0 — Progressive Leader State Profiles` as the current public version and SHALL preserve `v0.4.18` as historical release evidence. Unless the Owner separately authorizes a successor, the repository SHALL state that no next development target is declared and MUST NOT leave v1.0.0 described as development or unpublished.

#### Scenario: Release-facing surfaces are aligned
- **WHEN** v1.0.0 public conversion is reviewed before the release-status commit
- **THEN** README, changelog, roadmap, TODO, validation, traceability, installation, adapter, template, and deterministic version surfaces agree on public v1.0.0, historical v0.4.18, no next development target, and the actual Los Angeles release date

#### Scenario: Stale development text remains
- **WHEN** a current release-facing surface still calls v1.0.0 a development target, says its tag or Release does not exist, or calls v0.4.18 the current public version
- **THEN** deterministic validation fails before commit, tag, or Release

#### Scenario: Public release conversion is completed
- **WHEN** the exact reviewed v1.0.0 tag and formal GitHub Release have been verified
- **THEN** the repository reports v1.0.0 as public, records the Release as the only publication channel in scope, records deployment as not performed, and completes independent post-action closeout before sequential role cleanup
