## 1. Skill And Traceability

- [x] 1.1 Add Fast Path / Slow Path reading-order language to `SKILL.md` without removing current hard-boundary anchors.
- [x] 1.2 Update `references/TRACEABILITY.md` to record v0.4.15 no-anchor-loss and boundary-demotion guardrails.
- [x] 1.3 Confirm PM and Advisor C1 proposal review completed with no unresolved P0/P1 before C2 implementation.

## 2. Documentation And Validation

- [x] 2.1 Update `docs/VALIDATION.md` with v0.4.15 checks for Fast Path, mandatory routing, and no silent anchor demotion.
- [x] 2.2 Update `scripts/validate-local.sh` with v0.4.15 validation markers.
- [x] 2.3 Update `CHANGELOG.md`, `docs/TODO.md`, and `docs/ROADMAP.md` with the v0.4.15 scope.

## 3. Verification And Closeout

- [x] 3.1 Run `openspec validate --all`.
- [x] 3.2 Run `./scripts/validate-local.sh`.
- [x] 3.3 Confirm current `template_contains "SKILL.md"` check count did not decrease and current `SKILL.md` hard-boundary anchors remain anchored to `SKILL.md`.
- [x] 3.4 Complete PM, Advisor, and Reviewer review before commit/push gates.
