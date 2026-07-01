## Why

Recent real use showed five recurring workflow gaps: CLI-based agents can stop on workspace trust, trusted Advisors can be misclassified as ordinary third parties, PM and Advisor can silently collapse onto the same model, goal completion can stop before archive, and OpenSpec work needs an explicit pre-analysis stage before proposal work begins.

This change makes those gaps explicit rule-level behavior for the skill before any automation is added.

## What Changes

- Add current-project workspace-trust preflight rules for CLI agents such as Claude CLI, Codex CLI, or similar tools when they are used as PM, Advisor, Worker, or Reviewer.
- Clarify that an Owner-specified Advisor using another model or tool is a trusted bounded collaboration role, not an ordinary third-party disclosure target.
- Require PM and Advisor to default to different AI models when model selection is available, and block silent same-model degradation unless the Owner explicitly approves it.
- Define Owner goal completion as including validation, git exit checks, push/status review, and OpenSpec archive when applicable.
- Add OpenSpec C0 goal/task analysis before C1 proposal work, then continue through C2 implementation, C3 closeout, and C4 archive.
- Add validation and example documentation for the new lifecycle rules.

## Capabilities

### New Capabilities

- `cli-trust-and-openspec-lifecycle`: Rules for CLI agent workspace trust, trusted Advisor context, PM/Advisor model separation, goal completion, and OpenSpec C0-C4 lifecycle closure.

### Modified Capabilities

- `advisor-model-diversity`: Tighten the model-diversity behavior so PM and Advisor cannot silently degrade to the same model unless the Owner explicitly approves the same-model pairing.

## Impact

- Affected files: `SKILL.md`, README, changelog, roadmap, TODO, validation checklist, examples, and OpenSpec artifacts.
- No runtime code, dependencies, CLI configuration mutation, automated workspace trust, CI, packaging, release, tag, deployment, or public publication is introduced.
