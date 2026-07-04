# Progressive References Traceability

This map supports v0.4.12. It is evidence for PM/Advisor/Leader review and does not create authorization.

## Current SKILL.md Validation Anchors

All current `template_contains "SKILL.md"` hard-boundary anchor phrases remain in `SKILL.md` and remain individually checked by `scripts/validate-local.sh`.

## Section Mapping

| Current area | New SKILL.md summary | Reference detail |
| --- | --- | --- |
| Advisor minimum permissions | Advisor Minimum Permissions | references/cli-trust.md |
| Invocation and startup | When To Use This Skill; Startup Checklist | references/role-templates-and-output.md |
| Model routing and CLI trust | CLI Trust And Model Routing | references/cli-trust.md |
| Agent lifecycle and patience | Agent Lifecycle And Delegation | references/role-templates-and-output.md |
| Context budget and rollover | Rollover And Handoff | references/context-rollover.md |
| Risk/severity/failure/git gates | Risk And Severity; Git Exit And Default Exclusions | references/git-exit-rules.md |
| OpenSpec C0-C4 and local validation | OpenSpec Lifecycle; Validation And Verification | references/openspec-lifecycle.md |
| Startup packets and role output templates | Output Requirements | references/role-templates-and-output.md |
| Handoff and successor startup | Rollover And Handoff | references/context-rollover.md |

## Explicit Hard Boundaries Added For v0.4.12

These boundaries remain in `SKILL.md` and have validation anchors:

- PM and Advisor expected output is independent first-pass / no-peek review before consensus.
- Advisor output is unverified evidence rather than authority.
- Handoff or prior agent output is evidence rather than authorization.
