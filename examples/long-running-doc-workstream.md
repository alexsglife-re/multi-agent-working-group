# Long-Running Documentation Workstream Example

Use this shape when documentation work spans several files, OpenSpec stages,
PM/Advisor review, validation, git gates, and archive.

## Owner Request

```text
Use the multi-agent-working-group skill to complete the next documentation
upgrade and carry it through validation, commit, push, and OpenSpec archive.
```

## C0 Goal Analysis

```text
Goal:
  Complete the named documentation upgrade.
Risk tier:
  Medium, because multiple public docs and git gates are involved.
OpenSpec:
  Required. Start at C0, then C1 proposal, C2 implementation, C3 closeout,
  and C4 archive.
PM/Advisor:
  Required. Advisor output is evidence, not authority.
Default exclusions:
  Tag, release, publication, deployment, force-push, destructive operations,
  secrets, auth, and permission changes require explicit Owner authorization.
```

## Handoff Discipline

Keep the active state short:

```text
Current stage:
  C2 implementation.
Changed files:
  README.md, docs/ADOPTION.md, docs/VALIDATION.md.
Validation:
  Pending after implementation.
Role evidence:
  PM proposal review complete; Advisor proposal review complete.
Unresolved P0/P1:
  None currently known.
Authorization:
  Normal commit/push may proceed only after required gates pass.
Next safe action:
  Finish implementation task 2.1 and update tasks.md.
```

Long logs, full diffs, and old handoffs should be summarized and referenced
through evidence instead of appended into the active handoff.

## Closeout Discipline

Do not report completion at C3 when C4 archive still applies. Completion for
OpenSpec-backed documentation work includes implementation, validation,
required PM/Advisor review, normal git gates when applicable, post-push status,
archive, archive validation, and archive git closeout.
