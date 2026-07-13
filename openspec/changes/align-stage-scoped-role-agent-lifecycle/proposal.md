## Why

The current fresh-session-per-checkpoint rule protects review independence, but it discards useful verified context within a single OpenSpec stage and can cause repeated evidence loading. PM and Advisor should retain stage-local understanding without allowing an earlier decision, validation result, or authorization to leak into a later checkpoint.

## What Changes

- Default each PM and Advisor to one runtime-proven persistent role-agent lifecycle within an OpenSpec C-stage (C1, C2, C3, or C4), while treating C0 as short-lived bootstrap and restarting both roles by default at a cross-C-stage boundary.
- Treat every checkpoint inside the stage as a fresh decision transaction with a new Review ID, Attempt ID, target fingerprint, validation freshness state, and authorization state.
- Permit a same-stage role to retain verified project context and its own prior reasoning, but prohibit inheritance of an earlier `GO`, validation freshness, git/archive authorization, or the other role's current first-pass conclusion.
- Ground Stage Session ID in exact runtime/session evidence when supported, including Runtime Session ID, evidence source, and exact resume evidence; unavailable persistence is restarted or degraded rather than intact continuity.
- Define canonical values for C-stage, inherited-context, fresh-decision, no-peek, validation-freshness, authorization, continuity, restart reason, runtime evidence, and transition-only lifecycle decision actor, with an ISO-8601 lifecycle decision time including timezone.
- Require restart when context reliability is lost or pressured, role independence is contaminated, provider/model/tool routing changes, trust is lost, state is ambiguous, recovery fails, or the Owner instructs restart.
- Preserve the existing narrow same-target clarification and linked-attempt rules.
- Preserve fresh short-lived sessions per distinct checkpoint for non-OpenSpec work and prohibit ambiguous CLI continuation or silent provider substitution.
- Quarantine an ambiguous old attempt and resolve concurrent-execution risk before any successor may satisfy the same gate.
- Add deterministic validation for stage continuity, cross-stage restart, fresh checkpoint decisions, no-peek isolation, and restart triggers.
- Migrate existing fresh-per-checkpoint guidance without changing any version number, review capability, evidence access, validation, git/archive gate, tag, release, or publication rule.

## Capabilities

### New Capabilities

None.

### Modified Capabilities

- `role-review-context-efficiency`: Use stage-scoped PM and Advisor lifecycles for OpenSpec C1-C4 while preserving checkpoint-level decision freshness, non-OpenSpec short sessions, runtime identity, ambiguity quarantine, and independence.
- `cli-trust-and-openspec-lifecycle`: Align OpenSpec and CLI lifecycle requirements with default cross-stage restart and mandatory restart triggers.

## Impact

Affected areas are the multi-agent workflow skill and review-context references, role packet and invocation templates, OpenSpec lifecycle guidance, documentation examples, and deterministic local validation. This is a workflow-governance correction only; it changes no public version marker and authorizes no commit, push, archive, tag, release, publication, or deployment action.
