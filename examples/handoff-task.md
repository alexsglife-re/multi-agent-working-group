# Example: Handoff And Continuity Recovery

This example shows how a new Leader or restarted PM/Advisor should recover a workstream after interruption. Old handoffs are evidence for verification, not authority for current action.

## Scenario

Yesterday's Leader left a handoff note saying:

```text
Docs look ready. Commit next.
```

Today, a new conversation resumes the same OpenSpec change. The current Leader must decide what remains true, what must be re-verified, and whether PM/Advisor continuity is intact or restarted.

## Classification

```text
Risk: medium until continuity is re-established
Stage: restart -> continuity recovery
Mode: multi-agent workflow
Old handoff authority: none
Old handoff evidence value: useful but untrusted until verified
```

## Minimum Recovery Packet

The current Leader gathers:

```text
- Latest owner instruction still in force
- Relevant spec, tasks, and local rule files
- Current branch, dirty state, and changed-file evidence
- Latest local validation evidence, if any
- Previous PM/Advisor findings or handoff note
- Whether the same PM and Advisor are still available
```

## Continuity Status Record

Leader records continuity explicitly:

```text
PM identity:
  Previous: PM-1
  Current: PM-1
  Continuity status: intact

Advisor identity:
  Previous: Advisor-1
  Current: Advisor-2
  Continuity status: restarted

Handoff file or note used:
  handoff-2026-06-29.md

Reason for restart:
  Previous Advisor session ended with the old conversation.
```

If either PM or Advisor changed, the new role instance is restarted, not magically continuous.

## What The Old Handoff Can And Cannot Do

The old handoff may provide:

```text
- Prior scope summary
- Prior findings
- Prior validation notes
- Candidate next action
- Pointers to files or commits to inspect
```

The old handoff may not provide:

```text
- Current authorization to commit or push
- Proof that validation is still fresh
- Proof that PM/Advisor still agree now
- Permission to skip re-reading current evidence
- Permission to expand scope
```

## Recovery Review

PM and Advisor re-check current evidence independently:

```text
PM continuity recovery review:
  - Confirm current task still matches the owner instruction.
  - Confirm the handoff summary still matches the current files.
  - Confirm what stage is actually next.

Advisor continuity recovery review:
  - Challenge stale assumptions from the handoff.
  - Check whether current diff, branch, and validation still support the suggested next step.
  - Check whether any new P0/P1 appeared since the handoff.
```

## Example Outcome

After re-checking, Leader records:

```text
Old handoff claim:
  "Docs look ready. Commit next."

Current verification:
  - Files still match the planned doc scope: yes
  - Validation freshness for commit gate: no, must be rerun
  - PM continuity: intact
  - Advisor continuity: restarted
  - Current next action: rerun validation, then re-enter commit gate review
```

So the handoff helped recovery, but it did not authorize the commit.

## Restarted Consensus

After continuity recovery:

```text
If PM and Advisor both remain the same and evidence still holds:
  continuity may stay labeled intact.

If PM or Advisor restarted:
  later agreement must be labeled restarted continuity, not uninterrupted continuity.

If required evidence is missing:
  record degraded or blocked continuity and stop at the matching gate.
```

## Completion Report

Leader should report the recovery state plainly:

```text
Recovered the workstream from the previous handoff.
Confirmed that the old handoff was useful evidence, not current authority.
Recorded PM continuity as intact and Advisor continuity as restarted.
Determined that validation must be rerun before any commit gate.
No commit or push was performed.
```
