# Example: When To Use The Skill

This example is for a non-programmer Owner deciding whether to use the full `multi-agent-working-group` workflow or Small Task Mode.

It is intentionally non-exhaustive. It shows common cases, not every possible case.

## Plain-Language Rule

Use the full workflow when the work needs separate people or roles to think, challenge, implement, and verify.

Use Small Task Mode when the work is truly small, local, low-risk, and can be checked directly without hidden delegation.

Calling the skill automatically means "apply the workflow and checklist." It does not by itself commit code, push code, release anything, create outside effects, transfer authority, or grant permission.

## Example A: Use Small Task Mode

Owner request:

```text
Please fix one short sentence in docs/INSTALLATION.md so the wording is easier to understand.
```

Why this can stay small:

```text
- One local documentation file.
- No behavior change.
- No security, permission, approval, or deployment impact.
- No hidden Worker slice is needed.
- The result can be checked by rereading the file and checking the diff.
```

What the skill means here:

```text
- Use the checklist.
- Keep the scope narrow.
- Re-check the changed file.
- Do not assume commit or push is allowed.
```

## Example B: Use The Full Workflow

Owner request:

```text
Please update the docs so future teams know how to adopt this skill across projects and handoffs.
```

Why this should use the fuller workflow:

```text
- The wording affects future decisions by other people.
- Adoption guidance can accidentally sound like permission or authority if not reviewed carefully.
- One role may draft, but another role should challenge and verify the boundaries.
- The task may need a bounded Worker slice instead of Leader doing the whole thing directly.
```

What the skill means here:

```text
- Apply the workflow.
- Keep role boundaries explicit.
- Treat old handoffs as evidence, not authority.
- Re-check current validation, trust, and approval state in the current project/session.
```

## Quick Decision Aid

Ask these questions in plain language:

```text
1. Is this just a tiny local change?
2. Could the wording or change be misunderstood as permission to do more?
3. Does someone else need to challenge or verify the work independently?
4. Would it be risky if we assumed old approval, old validation, or an old handoff still counted?
```

If the answers are "yes, it is tiny" and "no" to the rest, Small Task Mode may fit.

If any answer points to broader risk, stale authority, or the need for separate review, use the fuller workflow.

## What Does Not Happen Automatically

Even when the skill is invoked correctly, it does not automatically transfer:

```text
- authorization
- role continuity
- validation freshness
- workspace trust
- handoff authority
- secret access
- permission for outside effects
- assumptions from another session or machine
```

That is why each new context still has to verify its own current state.
