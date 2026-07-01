## Context

The skill is documentation-first and currently defines roles, git gates, Advisor model diversity, and bounded Advisor context. The next gap is lifecycle precision: a CLI agent may be usable but blocked by workspace trust, the main app may incorrectly treat an Owner-specified Advisor as an untrusted third party, and OpenSpec work needs a named pre-analysis step before proposal artifacts are created.

The Owner also clarified that completion of a stated goal should mean the related work is carried through all normal closeout steps, including archive where applicable, unless an Owner decision or blocker is reached.

## Goals / Non-Goals

**Goals:**

- Add rule-level guidance for CLI agent workspace trust without adding automation.
- Preserve the trusted Advisor role boundary while keeping secrets and unrelated context excluded.
- Make PM/Advisor model separation stricter than the general Advisor model-diversity rule.
- Make OpenSpec C0-C4 lifecycle closure explicit for workstreams that use both this skill and OpenSpec.
- Keep validation and examples aligned with the rule changes.

**Non-Goals:**

- Do not implement automatic CLI workspace trust commands.
- Do not add a CLI wrapper, subprocess orchestration, CI, release automation, or packaging.
- Do not broaden Advisor access to secrets, unrelated projects, or irrelevant data.
- Do not change product runtime behavior; this is a skill protocol change only.

## Decisions

### Decision 1: Treat workspace trust as a preflight, not automation

The skill will require the Leader to confirm or run a minimal current-project trust preflight before relying on a CLI agent. If trust is blocked, the Leader reports `workspace-trust-blocked` instead of marking the role unavailable or silently switching models.

Alternative considered: add exact trust commands for Claude CLI and Codex CLI. Rejected for now because trust commands and prompts vary by tool version, and automated trust changes are a higher-risk local setup behavior.

### Decision 2: Keep trusted Advisor context bounded

The skill will explicitly say that the main AI Agent App must not treat an Owner-specified Advisor as an ordinary third-party service for the current workstream. Necessary bounded context may be sent to the Advisor role.

Alternative considered: keep the existing v0.4.1 language only. Rejected because the Owner specifically identified the main-app classification problem as a recurring failure mode.

### Decision 3: Separate PM/Advisor model pairing from generic Advisor diversity

The skill will require PM and Advisor to default to different AI models when model selection is available. Same-model PM/Advisor pairing is allowed only by explicit Owner approval and must be recorded as an override.

Alternative considered: allow automatic degradation when only one model appears available. Rejected because the Owner identified silent same-model PM/Advisor use as an actual v0.3 failure.

### Decision 4: Add C0 before OpenSpec C1

When this skill and OpenSpec are used together, C0 becomes the mandatory goal/task analysis stage before C1 proposal work. C0 records goal, risk, active changes, model routing, CLI trust needs, Advisor trust/model state, and completion target including archive.

Alternative considered: keep C1 as the first stage and add a checklist inside proposal. Rejected because it hides the pre-analysis work that determines whether proposal work is safe to start.

## Risks / Trade-offs

- [Risk] More lifecycle rules can make the skill feel heavier. → Mitigation: keep the new rules compact and show one concrete example.
- [Risk] Workspace trust wording could imply broad trust of all directories. → Mitigation: scope trust to the exact current project workspace only.
- [Risk] Trusted Advisor wording could be mistaken as secret-sharing approval. → Mitigation: repeat the existing no-secrets, no-unrelated-context boundary.
- [Risk] C0-C4 could be read as mandatory for every small task. → Mitigation: scope it to workstreams using both this skill and OpenSpec.

## Migration Plan

1. Update OpenSpec artifacts and validation.
2. Update `SKILL.md` with the rule changes.
3. Update project docs and example.
4. Sync the local skill to the global installed skill after validation.
5. Complete normal commit/push review.
6. Archive the OpenSpec change as part of the same goal if validation and review pass.

Rollback is documentation-only: revert the docs/spec changes if they prove too strict.
