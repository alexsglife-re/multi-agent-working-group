# public-release-status Specification

## Purpose

Define the authoritative public-release state, validation, lifecycle gates, exact release target, publication boundary, and closeout requirements for v0.4.18.

## Requirements

### Requirement: Public documentation represents the released v0.4.18 state
Release-facing documentation SHALL identify v0.4.18 as the current public version released on July 12, 2026 under `America/Los_Angeles` release-date semantics, SHALL remove claims that v0.4.18 is an unpublished development target, and MUST NOT invent a next development target. OpenSpec scaffold metadata dated July 13, 2026 SHALL remain distinct from the public release date.

#### Scenario: Release markers are aligned
- **WHEN** the v0.4.18 release-status implementation is reviewed
- **THEN** every actual stale marker in README, changelog, roadmap, validation, TODO, and validation-script surfaces identifies v0.4.18 consistently as public or completed
- **AND** no surface claims an active development target unless a separately authorized target exists

### Requirement: Validation supports no active development target
The local validation workflow SHALL represent v0.4.18 as the public version and SHALL support a valid state with no active development target while continuing to reject contradictory public-version or development-target markers.

#### Scenario: Released state has no successor target
- **WHEN** local validation runs after v0.4.18 documentation alignment and no successor development target has been authorized
- **THEN** its positive assertion verifies public version v0.4.18, release date July 12, 2026, and `America/Los_Angeles` release-date semantics without requiring a placeholder development version
- **AND** still fails if v0.4.17 is described as current public or v0.4.18 as unpublished development

#### Scenario: Active OpenSpec state is validated
- **WHEN** implementation gates are evaluated while `publish-v0-4-18-release-status` remains active
- **THEN** repository-only local validation runs as `./scripts/validate-local.sh --skip-global-skill` and strict validation of the current change and all specs pass
- **AND** skipping the installed global-skill comparison does not skip or weaken any repository documentation, fixture, shell-syntax, or OpenSpec check
- **AND** plain local validation, when run, is recorded separately as a machine-global comparison without claiming that the installed global copy is synchronized
- **AND** the no-active-change validation mode is not required at that checkpoint

#### Scenario: Archived OpenSpec state is validated
- **WHEN** the change has been archived
- **THEN** strict OpenSpec validation and `./scripts/validate-local.sh --require-no-active-changes --skip-global-skill` both pass on the archived target
- **AND** plain `./scripts/validate-local.sh`, when run, remains separate machine-global comparison evidence only and does not imply machine-global synchronization

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

### Requirement: Tag and GitHub Release use an exact reviewed target
The annotated `v0.4.18` tag SHALL be created and pushed only after the C4 archive commit is pushed and post-push reviewed, and the formal GitHub Release SHALL use that exact tag and commit target.

#### Scenario: Annotated tag is created
- **WHEN** fresh independent tag-gate reviews confirm the final C4 archive commit SHA and all required evidence passes
- **THEN** annotated tag `v0.4.18` is created at exactly that SHA and pushed normally
- **AND** local and remote tag metadata and peeled commit target are verified after the action

#### Scenario: Formal GitHub Release is published
- **WHEN** fresh independent release-gate reviews confirm the verified v0.4.18 tag target
- **THEN** the rendered payload uses title exactly `v0.4.18` and body exactly from the reviewed v0.4.18 section of `CHANGELOG.md`
- **AND** PM and Advisor review that rendered payload before a GitHub Release is created with `draft=false` and `prerelease=false`
- **AND** post-action evidence verifies its URL, `publishedAt`, tag and commit target, draft state, and prerelease state

### Requirement: Archive and post-archive evidence do not mutate the tagged target
Every OpenSpec checklist item SHALL be complete before archive. Archive, archive-commit review/push, tag, Release, publication, and closeout SHALL be tracked as durable external operational evidence and MUST NOT require editing the archived task checklist or advancing HEAD after the exact archive commit is tagged.

#### Scenario: OpenSpec checklist reaches archive boundary
- **WHEN** C4 confirms sync, fresh review, validation, and archive readiness
- **THEN** all OpenSpec checklist items are complete before the archive command runs

#### Scenario: Post-archive operations are recorded
- **WHEN** archive, tag, or Release actions occur after checklist completion
- **THEN** their gates and results are recorded in durable external review and metadata evidence
- **AND** no archived task file is edited to record completion
- **AND** HEAD does not advance after the reviewed archive commit becomes the v0.4.18 tag target

### Requirement: Publication and cleanup stay within the authorized boundary
Publication SHALL occur only through the formal GitHub Release, SHALL NOT perform deployment or any excluded high-risk operation, and SHALL end with independent PM and Advisor closeout followed by sequential role cleanup.

#### Scenario: Release work closes successfully
- **WHEN** tag and GitHub Release metadata verification passes
- **THEN** PM and Advisor independently confirm public documentation alignment, exact target state, clean synchronized repository state, and absence of deployment
- **AND** required role lifecycles are closed sequentially rather than concurrently

#### Scenario: Excluded operation is encountered
- **WHEN** completion would require deployment, force-push, history rewrite, protected-branch bypass, secret or credential access/change, auth or permission change, schema change, destructive action, or a publication channel other than GitHub Release
- **THEN** the workflow stops at the gate because that operation is outside this change's authorization

### Requirement: v1.0.0 development status remains separate from public v0.4.18
Release-facing documentation SHALL identify `v1.0.0 — Progressive Leader State Profiles` as the Owner-authorized development target and SHALL continue to identify `v0.4.18` as the current public version until a separately reviewed public release-status change is completed.

#### Scenario: Feature implementation is active
- **WHEN** the progressive Leader-state profile change is under implementation or archive closeout
- **THEN** README, changelog, roadmap, TODO, validation documentation, and deterministic version checks distinguish development v1.0.0 from public v0.4.18

#### Scenario: Development target is declared
- **WHEN** documentation records the v1.0.0 development target
- **THEN** it MUST NOT claim that the v1.0.0 tag, GitHub Release, public publication, or deployment already exists

#### Scenario: Public release conversion is considered
- **WHEN** implementation and archive are complete and v1.0.0 is ready for public release consideration
- **THEN** a separately gated public release-status closeout verifies the exact commit, tag, release metadata, release content, publication authorization, and post-action state before v1.0.0 replaces v0.4.18 as current public
