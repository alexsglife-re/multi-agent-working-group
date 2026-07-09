## 1. Planning And Review

- [x] 1.1 Complete OpenSpec proposal, design, specs, and tasks for v0.4.16.
- [x] 1.2 Complete C1 PM and Advisor review with no unresolved P0/P1 before implementation.

## 2. Documentation

- [x] 2.1 Update README with concise v0.4.16 status and runtime installation pointers without adding long install commands.
- [x] 2.2 Update `docs/INSTALLATION.md` to point to cross-runtime installation guidance and preserve non-transferable authority boundaries.
- [x] 2.3 Add `docs/RUNTIME_INSTALLATION.md` with Codex and Claude Code install commands plus OpenClaw and Hermes Agent guardrails.
- [x] 2.4 Update `docs/ADAPTERS.md` with maturity labels for Codex, Claude Code, OpenClaw, Hermes Agent, and other runtimes.
- [x] 2.5 Reconcile existing v0.4.14 validation wording so Claude Code runtime install commands are allowed without creating a runtime adapter guide skeleton or full-support claim.
- [x] 2.6 Update `docs/ROADMAP.md`, `docs/TODO.md`, `docs/VALIDATION.md`, and `CHANGELOG.md` for the v0.4.16 scope.

## 3. Validation

- [x] 3.1 Update `scripts/validate-local.sh` with v0.4.16 runtime installation and adapter-label checks.
- [x] 3.2 Update validation anchors that currently require only "planned guidance or compatible patterns" so "Claude Code install guidance available; validation pending" remains a qualifier under `adapter guide planned`.
- [x] 3.3 Run `openspec validate --all`.
- [x] 3.4 Run `./scripts/validate-local.sh`.
- [x] 3.5 Confirm tracked Markdown remains English-only and runtime support claims are not overclaimed.

## 4. Closeout

- [ ] 4.1 Complete PM, Advisor, and Reviewer review before commit/push gates.
- [ ] 4.2 Commit and push the implementation when gates pass.
- [ ] 4.3 Archive the OpenSpec change, validate closeout, and commit/push the archive when gates pass.
