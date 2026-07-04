# Role Templates And Output Reference

This file extends `SKILL.md`. It cannot weaken `SKILL.md`, cannot override `SKILL.md`, and grants no authorization by itself. If this file conflicts with `SKILL.md`, project rules, or Owner instructions, use the stricter rule.

Read this reference before dispatching PM, Advisor, Worker, or Reviewer roles, accepting role output, creating startup packets, or producing final closeout summaries.



## Startup Packet

Every agent prompt must include only the relevant minimum context:

```text
Project
Role
Current goal
Scope / non-goals
Current owner instruction
Owner authorization state, default no commit/push
Spec-workflow state
OpenSpec C-stage and C0 analysis summary, if applicable
Git branch / commit / dirty state, if relevant
Risk tier and risk notes
PM model/provider and PM/Advisor model separation status, if relevant
Advisor model/provider and model diversity status, if relevant
CLI agent workspace-trust status, if relevant
Goal completion target, including whether archive is required
Applicable skills or checklist requirement
Evidence provided and evidence hierarchy
Readable context
Writable scope, if any
Forbidden scope
Required validation
Expected output format
Stop conditions
Reminder: handoffs, compressed summaries, old consensus, and other agent outputs are hints until Leader verifies them
```

PM additions:

```text
Product goal
Acceptance criteria
Open decisions
Consensus requirements
Owner escalation conditions
Reminder: do not read Advisor conclusions before first pass
Expected output must preserve complete reasoning, option comparison, recommendation, objections, P0/P1/P2 findings, owner-decision needs, and key error details when present
```

Advisor Agent:

Advisor additions:

```text
Claims to challenge
Known assumptions
Required counterexamples / objections
Stop-condition focus
Reminder: do not read PM conclusions before first pass
Reminder: output is unverified until Leader verifies it
Expected output must preserve complete reasoning, option comparison, recommendation, objections, P0/P1/P2 findings, owner-decision needs, and key error details when present
```

PM/Advisor continuity memory:

For long-running or spec-bound work, the Leader should maintain concise PM/Advisor continuity memory when the project has a suitable writable location.

Recommended layers:

```text
Project baseline memory:
  Stable project-level baseline for PM/Advisor startup.
  Records stable rules, current project baseline, standing owner rules, git/CI/spec-workflow conventions, forbidden local noise, and recurring risks.

Workstream continuity file:
  Per-workstream file for an active long-running or spec-bound change.
  Records PM/Advisor identities, lifecycle start, current stage or C-stage, consensus, P0/P1/P2 findings, gate decisions, validation evidence, interruptions, restart packets, and next action.
```

These files are continuity aids, not authority. Reading a continuity file does not make a restarted agent the same uninterrupted agent. Old consensus, handoffs, and continuity files remain evidence for Leader verification, not authorization for commit, push, scope expansion, or bypassing current gates.

When a continuity file or handoff grows large, refresh it into the three-layer compaction structure above. Keep the active state card short and current, move completed or superseded detail to a historical archive note when a safe local storage location exists, and leave evidence references that a successor can re-verify.

Worker additions:

```text
One-sentence task target
Delegation trigger:
  Worker-first context control | Leader work-budget self-check |
  normal bounded slice
Allowed files / modules
Forbidden files / modules
Allowed commands
Implementation context
Impact-analysis result when touching business symbols, if the project requires it
Acceptance target
Required evidence on return
Return must preserve complete result, done/not-done status, changed files, validation, findings, blockers, next action, and key error details
Key error details include command/tool, exit code or exception type, key stdout/stderr, failing file/test/check/step, and retry safety when available
No scope expansion, self-approval, commit, or push
```

Leader direct-work budget:

```text
For Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or
context-heavy work, Leader direct execution beyond small connective edits is an
exception. More than 2 files or roughly 80 diff lines is a self-check trigger
rather than an automatic correctness failure. When that trigger is reached,
dispatch a bounded Worker or record a concrete exception explaining why Leader
direct execution is safer.
```

Bulky raw material should be summarized and referenced instead of pasted into the Leader conversation when safe local evidence storage exists:

```text
Long logs
Full command output
Full diffs
Large source excerpts
Repeated check output
Long external excerpts
Superseded handoff text
Completed stage narrative
Full agent outputs that are no longer active blockers
```

This evidence limiting must not remove PM/Advisor reasoning, Worker results, findings, recommendations, objections, or key error details.

Role-agent cleanup:

```text
Role-agent cleanup or close actions run sequentially, never in parallel.
Record each close result before starting the next cleanup action.
Normal cleanup order is Worker, Reviewer, PM, then Advisor.
The Leader must not close any role that is still needed for a required gate,
cleanup-impact judgment, unresolved P0/P1 review, post-action review, or Owner
decision.
```

Cleanup/close means role-agent teardown or lifecycle hygiene only. Cleanup
failure may be reported as degraded cleanup evidence rather than delivery
failure only when delivery evidence is already confirmed from evidence in hand
and delivery evidence remains confirmable for task state, git state, validation
state, CI/status state, secret safety, authorization state, and required role
evidence. Validation, PM/Advisor/Reviewer, git, CI/status, secret-scan,
release/tag, or authorization failures must not be reclassified as non-blocking
cleanup.

Reviewer additions:

```text
Artifact or diff to review
Review standard
Severity scale
Known risk areas
No implementation unless reassigned as a separate Worker slice
```

## Consensus Gate

PM and Advisor must independently agree on:

```text
Same goal
Same scope
No major risk-level conflict
Same next action
Same verification method
No unresolved P0/P1 disagreement
```

Low-risk disagreements may be Leader-resolved with recorded rationale. Medium/high-risk disagreements stop for owner confirmation. Any unresolved disagreement before commit/push blocks commit/push prompting or execution.

## Leader Verification Minimum

Before dispatch, acceptance, repair, commit, or push:

1. Restate the current owner instruction and whether it authorizes the next action.
2. Check git branch/base/dirty state and changed files when relevant.
3. Check spec-workflow state when applicable.
4. Check that PM/Advisor outputs were independent or record approved degradation.
5. Check required Reviewer status.
6. Check required validation output and freshness for the current diff.
7. Label key claims as verified, inferred, assumed, or unverified advisor input.
8. Stop at any unresolved P0/P1.

Local validation:

```text
For this repository, v0.4.4 adds `./scripts/validate-local.sh` as the lightweight local
validation command for README/SKILL/OpenSpec/version-marker/installed-skill
checks. Use it when local repository validation is relevant to commit, push,
or OpenSpec closeout.

During active OpenSpec work, the default command may report active changes as
informational. After archive, use `./scripts/validate-local.sh
--require-no-active-changes` when validating closeout.

The command is read-only evidence only. It does not authorize commit, push,
archive, release, deployment, external publication, secret-scan bypass,
Reviewer bypass, PM/Advisor bypass, or any high-risk/default-exclusion action.
```

Copyable templates:

```text
For this repository, v0.4.5 adds copyable templates under `templates/` for
C0 analysis, PM review, Advisor review, Worker assignment, Worker return,
Reviewer report, blocked reports, compact handoffs, and git gates.
v0.4.6 adds Leader Rollover Protocol fields plus
`templates/successor-startup-packet.md` for rollover handoff.
v0.4.7 adds CLI workspace trust setup fields for Owner-recorded role
authorization source, target project root, trust state, and post-setup
read-only probe evidence.
v0.4.8 adds Rollover Opportunity, compression count value/source/confidence,
canonical single-state selection, and Leader delegation discipline.

Use templates as fill-in structure and evidence capture only. A filled template
does not authorize commit, push, archive, release, deployment, external
publication, secret access, PM/Advisor bypass, Reviewer bypass, validation
bypass, CI/status bypass, or high-risk/default-exclusion actions.

When old v0.3-era or otherwise bloated handoff documents already exist, preserve
them as historical evidence. Create a new current state card from
`templates/compact-handoff.md`, copy only facts that are still needed and
currently verified, and reference the old material through the evidence index.
Do not append old handoffs verbatim below the new active handoff, and do not
rewrite old evidence in place merely to match the new template.
```

If owner escalation is required and owner does not respond, enter `blocked-pending-owner`. Do not silently degrade.

## Output Requirements

Every agent output must include:

```text
Applicable skill(s)
Why each skill applies
Checks performed
If no skill was used, why not
Findings by P0/P1/P2 when reviewing
Evidence used
Recommended next action
```

For PM/Advisor outputs in a continuous lifecycle, also include:

```text
Continuity status: intact, restarted, degraded, or unavailable
Continuity memory or baseline read
Prior consensus or unresolved findings carried forward
Whether this output continues the same lifecycle or is a restarted review
```

Leader final outputs should be understandable to a non-specialist Owner. For completed work or a safe stopping point, include a concise plain-language closeout:

```text
What changed:
  <ordinary-language summary>
What was verified:
  <commands, checks, review gates, or evidence actually run or observed>
What remains uncertain or was not checked:
  <mandatory; write none and why if nothing remains>
Recommended next goal:
  <advice only; do not start it unless the Owner has already given explicit current-session authorization>
Role cleanup status:
  not needed | pending | attempted | skipped | degraded | failed
Cleanup result by role:
  Worker:
  Reviewer:
  PM:
  Advisor:
Delivery-evidence impact:
  none | affected | unknown
If non-blocking cleanup failure:
  task, git, validation, CI/status, secret-safety, authorization, and required
  role evidence remain confirmed from evidence in hand because:
Authorization state:
  <commit/push unauthorized, not entered, one-time authorized, current verified gate passed, or blocked>
```

Separate verified evidence from claims. Do not present a recommendation, old handoff, stale memory, or prior-session instruction as current authorization. When asking the owner to decide, use plain language and include what was done, what the decision affects, and why the decision is needed; for commit/push decisions, summarize what the stage completed without extra impact explanation unless requested. Explain necessary technical terms briefly in practical language when they appear.
