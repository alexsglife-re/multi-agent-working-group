# Successor Opportunity Skeleton

Version: v1.0.0 development template.

Use only at `Rollover Opportunity` when lightweight preparation is useful.
Refresh the canonical active state and evidence index first. This skeleton is
not the complete successor packet and does not itself request or create a
handoff. Use `successor-startup-packet.md` at Recommended, Strongly
Recommended, Required, actual handoff, or an explicit Owner handoff request.

This skeleton is continuity evidence only. It transfers no authority,
approval, validation freshness, profile decision, role continuity, gate
decision, or permission to continue. Absence is not approval.

Successor, profile, authority, validation, role, and gate decisions are not inherited.
The complete applicable retention floor wins; do not truncate facts.
Physical size warnings are non-blocking and never select a profile.

## Opportunity Snapshot

```text
Prepared at: <ISO-8601 time with timezone>
Current goal / stage: <goal>; <stage or C-stage>
Canonical active-state pointer: <Compact or Standard instance>
Evidence-index pointer: <stable location>
Leader state profile: Compact | Standard | hierarchical-required
Profile selection basis pointer: <measurement source and record>
Profile measurement freshness: fresh | stale | unknown
ContextBudget state: Rollover Opportunity
Compression count: <value / source / confidence>
Opportunity reason: <clean boundary plus heavier next step or other trigger>
Next safe rollover boundary: <boundary>
Current first next action: <one action and dependencies>
```

## Safety Snapshot

```text
Unresolved P0/P1 or owner decisions: <none verified | items and pointers>
Git / OpenSpec state pointer: <stable current evidence>
Validation freshness pointer: <stable current evidence>
PM/Advisor/Reviewer/Worker state pointer: <stable current evidence>
Authorization state: not inherited; successor must freshly verify
Changed / do-not-touch pointer: <stable current evidence>
Stop conditions: <conditions>
```

## Handoff Escalation

```text
Complete packet required now: no
Escalate when: Recommended | Strongly Recommended | Required | actual handoff | Owner request
Complete packet template: templates/successor-startup-packet.md
Facts to refresh before escalation: <profile, authority, git, OpenSpec, validation, roles, findings, Worker state>
```

## Opportunity Evidence

| Claim ID | Claim | Evidence location | Freshness | Leader verification |
| --- | --- | --- | --- | --- |
| C-01 | Opportunity state and boundary |  | current / stale | verified / inferred / unverified |

Do not append logs, diffs, transcripts, or historical handoffs here. Preserve
them at stable evidence or archive-note locations and point to them from the
canonical active-state evidence index.
