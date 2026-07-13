## Context

The v0.4.18 implementation and accepted specs are already present and archived, while the repository's public-facing status remains v0.4.17 with v0.4.18 labeled as a development target. This change is a bounded release-status transition: update only markers proven stale by repository search, teach the validator that a public release can have no active development target, complete the OpenSpec C1-C4 lifecycle, and then perform the separately gated GitHub tag and Release actions authorized by the Owner.

The work must preserve one runtime-proven PM lifecycle and one runtime-proven Advisor lifecycle per C1-C4 stage, with fresh decisions at each checkpoint. Claude Advisor continuity within a stage uses exact `--resume`; cross-stage work starts new lifecycles by default. Development documentation and commit messages remain English-only.

## Goals / Non-Goals

**Goals:**

- Represent v0.4.18 as the current public version dated July 12, 2026 under `America/Los_Angeles` release-date semantics.
- Remove the active-development-target claim without inventing a successor version.
- Preserve strict validation while supporting the no-active-development-target state.
- Complete reviewed normal commits/pushes, an annotated exact-target tag, and a formal GitHub Release/publication with post-action verification.
- Leave a reproducible evidence chain for C1-C4 and release closeout.

**Non-Goals:**

- No runtime feature, API, dependency, schema, auth, permission, secret, or credential change.
- No deployment or publication outside GitHub Release.
- No force-push, history rewrite, protected-branch bypass, destructive action, or old-commit rewriting.
- No speculative next development version or roadmap target.

## Decisions

1. **Use actual stale-marker discovery as the exact edit allowlist.** Fresh repository-wide discovery identified ten tracked current release surfaces: `README.md`, `CHANGELOG.md`, `docs/ADAPTERS.md`, `docs/INSTALLATION.md`, `docs/ROADMAP.md`, `docs/TODO.md`, `docs/VALIDATION.md`, `references/TRACEABILITY.md`, `scripts/validate-local.sh`, and `templates/review-packet-cleanup-checklist.md`. The adapter and installation guides expose the current packaged version, traceability records the release-level validation contract, and the cleanup checklist is the v0.4.18 release template; therefore their additive v0.4.18 notes are formally in scope. No other implementation file may be edited without a new discovery finding and artifact correction. This minimizes drift and avoids unrelated cleanup. The rejected alternative is a broad release-document rewrite.

2. **Model the released state explicitly rather than with a placeholder next version.** `PUBLIC_VERSION` becomes v0.4.18 and development-target validation becomes optional/absent. Validation must still reject contradictory stale markers. The rejected alternative is inventing v0.4.19 solely to satisfy the previous validator shape.

3. **Keep C-stage and post-archive operational gates separate.** C2 implements and validates while the change is active. For this Owner-authorized repository-only release, active-change repository validation is exactly `./scripts/validate-local.sh --skip-global-skill`, including at C4, while archived-state repository validation is exactly `./scripts/validate-local.sh --require-no-active-changes --skip-global-skill`. The installed machine-global skill copy is outside the authorized scope and is not claimed to be synchronized. Any result from plain `./scripts/validate-local.sh` is recorded separately as machine-global comparison evidence, not used to weaken or replace repository checks. C2 also runs strict validation of the change/all specs and does not require the no-active-change mode. C3 performs required code/repository review. C4 syncs the delta, completes every OpenSpec checklist item, and reaches archive readiness. The archive action and its commit/push reviews, annotated tag, and GitHub Release are then tracked in durable external evidence rather than by editing archived tasks. This keeps the tagged HEAD fixed at the reviewed archive commit.

4. **Use GitHub Release as the sole publication channel with a deterministic payload.** The Release title is exactly `v0.4.18`. Its body is the exact reviewed v0.4.18 section from `CHANGELOG.md`, and the fully rendered payload is independently reviewed at the release gate. The Release must be formal (`draft=false`, `prerelease=false`) and point to the exact v0.4.18 tag/target. Verification records URL, `publishedAt`, draft/prerelease state, and target. The rejected alternative is adding deployment, package publication, social announcements, or other channels.

5. **Report CI capability truthfully.** After each push, inspect repository status and `.github`; if GitHub Actions is absent, record that no workflow checks exist rather than fabricating CI success. Repository and GitHub metadata checks still apply.

6. **Close roles sequentially.** PM, Advisor, Worker, and Reviewer lifecycle cleanup is performed one role at a time after its evidence is no longer required, preserving auditability and avoiding ambiguous concurrent close state.

7. **Separate planning metadata dates from release dates.** The scaffold's `.openspec.yaml` `created: 2026-07-13` is OpenSpec CLI/local-timezone metadata. It does not alter the authorized public release date of July 12, 2026 under `America/Los_Angeles` semantics.

## Risks / Trade-offs

- **[Stale release wording survives outside the initial allowlist]** → Re-run repository-wide targeted searches before review and require Reviewer confirmation of public-version consistency.
- **[Optional development-target logic weakens validation]** → Add positive no-target checks and negative contradiction checks; run `./scripts/validate-local.sh --skip-global-skill` plus strict OpenSpec validation while active, then run `./scripts/validate-local.sh --require-no-active-changes --skip-global-skill` only after archive. Treat plain validation solely as separate machine-global comparison evidence.
- **[Tag points at a pre-archive or unreviewed commit]** → Resolve and record the final pushed C4 archive commit SHA immediately before tag creation, create an annotated tag only at that SHA, and independently verify local and remote peeled targets.
- **[GitHub Release metadata differs from intent]** → Verify URL, publication timestamp, target/tag, draft=false, and prerelease=false after creation before closeout.
- **[Owner authorization is mistaken for gate completion]** → Require fresh PM/Advisor decisions, required Reviewer evidence, validation, secret scan, actual-commit/post-push reviews, and no unresolved P0/P1 at each applicable gate.
- **[No GitHub Actions is reported as a successful CI run]** → Record absence of `.github` and say explicitly that no GitHub Actions workflows were available.
