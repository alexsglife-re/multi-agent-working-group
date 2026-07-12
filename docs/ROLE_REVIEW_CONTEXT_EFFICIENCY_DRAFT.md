# Role Review Context Efficiency Draft

Status: Adopted non-normative overview for the v0.4.17 development target. The authoritative implemented rule lives in `SKILL.md` and `references/review-context-efficiency.md`; this historical filename is retained for traceability. This overview never grants authorization.

## Purpose

Reduce repeated PM and Advisor context without reducing review quality, independence, model capability, required review frequency, or access to task-relevant original evidence.

The governing boundary is:

> Repeated material may be referenced instead of resent. Access to task-relevant original evidence must not be restricted.

## Non-Negotiable Guarantees

Context-efficiency measures must not:

- change the required PM or Advisor provider/model routing;
- reduce required review frequency or skip a required gate;
- weaken independent first-pass and no-peek review;
- narrow the assigned review scope;
- prevent a role from reading task-relevant original files and read-only evidence within the approved project scope;
- replace original evidence with summaries when the original evidence is needed;
- impose a hard token limit that forces an incomplete review or a false `GO` conclusion;
- convert PM or Advisor output into authority; or
- bypass Leader verification, Reviewer requirements, validation, secret scanning, CI/status checks, or Owner-only gates.

## Implemented Operating Model

### Short-Lived Review Sessions

Each independent review checkpoint defaults to a fresh, short-lived model session. Role continuity is restored from a verified stable baseline, current state card, Review ID, and prior accepted anchor instead of automatically resuming the full model conversation history.

Review checkpoints include:

- first-pass review;
- scope review;
- pre-commit gate;
- post-commit review;
- pre-push gate;
- post-push review; and
- closeout.

A role may remain in the same short-lived session when requesting a missing file or asking a narrow clarification for the same review target. A changed target, commit, diff, gate, or materially changed packet requires a new Review ID or a new linked attempt.

A fresh model session does not erase role continuity. The review record must state whether continuity is intact, restarted from artifacts, degraded, or unavailable.

### Stable Baseline And Incremental Evidence

Each review packet contains or references:

- the current Owner goal and authorization boundary;
- stable project rules;
- acceptance criteria;
- the applicable OpenSpec change and stage, if any;
- the previous accepted commit, diff, or review anchor;
- the current commit or diff range;
- changed files and behavioral changes;
- fresh tests and validation evidence;
- known risks, unresolved questions, and P0/P1 findings; and
- direct paths or commands for inspecting original evidence.

Unchanged material is referenced by a stable, verifiable anchor instead of being copied into every prompt. Useful anchors include an exact commit, an immutable artifact version, an exact file path at a commit, or another reproducible evidence pointer.

The packet is an index and starting point. It is not a restriction on task-relevant evidence inspection.

### PM And Advisor Independence

PM and Advisor may use the same packet structure, but their independent first-pass inputs must remain isolated.

- The PM packet must not expose Advisor first-pass conclusions before the PM first pass is complete.
- The Advisor packet must not expose PM first-pass conclusions before the Advisor first pass is complete.
- A shared factual evidence manifest may be used when it contains no role conclusion.
- The Leader may generate separate PM and Advisor packets from the same factual manifest.

PM focuses on goal alignment, scope, acceptance criteria, completion state, and the next action. Advisor focuses on challenging assumptions, counterexamples, underestimated risk, and evidence gaps.

## Implemented Review Identity And Retry Rules

Every review invocation records:

```text
Review ID:
Attempt ID:
Role:
Review type:
Target commit or diff:
Stable baseline anchor:
Packet fingerprint:
State:
  prepared | running | completed |
  failed-confirmed | result-unknown | superseded
Started at:
Completed at:
Result location:
Retry decision:
Parent Attempt ID, if retried:
```

The same `Review ID` and packet fingerprint must not be blindly invoked again while its state is `running` or `result-unknown`. The Leader first inspects available process, output, or CLI status evidence. A retry uses a new Attempt ID linked to the previous attempt and occurs only after failure is confirmed or the ambiguity is explicitly recorded and safely resolved.

Short silence or delayed output is not evidence of failure and must not trigger automatic retry or role cleanup.

## Implemented Role Review Packet

```markdown
# Role Review Packet

Review ID:
Attempt ID:
Role: PM | Advisor
Review type:
Review target:
Current commit / diff:
Decision requested:
Risk tier:
Default exclusions touched:

## Owner goal
- Current instruction:
- Authorized actions:
- Unauthorized or default-excluded actions:

## Stable baseline
- Baseline version:
- Baseline commit:
- Project rules:
- Acceptance criteria:
- OpenSpec change / stage:
- Previous accepted anchor:

## Changes since accepted anchor
- Commit or diff range:
- Changed files:
- Behavioral changes:
- Tests and validation:
- Validation freshness:

## Known risks and open questions
- Known P0/P1:
- P2:
- Unresolved questions:
- Assumptions requiring challenge:

## Independence boundary
- Independent first pass required: yes | no
- Conclusions intentionally withheld:
  - PM conclusions | Advisor conclusions | none

## Evidence access
The role may inspect any task-relevant original file and read-only evidence
within the approved project scope. This packet is an index and starting point,
not a restriction or substitute for original evidence.

## Context-efficiency declaration
- Unchanged material was referenced rather than repeated.
- Review scope was not reduced.
- Original evidence access was not reduced.
- Required review frequency was not reduced.
- No quality-affecting token limit was imposed.

## Required response
- Decision: GO | NO-GO | BLOCKED-EVIDENCE
- P0/P1/P2 findings
- Evidence inspected
- Evidence gaps
- Validation freshness
- Required corrections
- Owner-decision needs
- Recommended next action
- Concise rationale
```

`BLOCKED-EVIDENCE` distinguishes an insufficient evidence set from a substantive rejection. P2 findings, validation freshness, and Owner-decision needs remain required so a concise response does not discard important non-blocking or authorization information.

## Implemented Documentation Layers

### Stable Principle

Record the long-term principle in project memory for local development continuity. Project memory is a continuity aid, not a public workflow rule or authorization source by itself.

### Public Execution Rule

The portable workflow has a concise router rule in `SKILL.md` and the complete protocol in `references/review-context-efficiency.md`.

The reference defines short-lived sessions, stable baseline anchors, incremental packets, evidence access, no-peek separation, retry safety, and the quality-preservation boundary.

### Role Templates

Add or extend PM and Advisor review packet templates. The templates may share a factual structure, but must preserve role-specific focus and no-peek input isolation.

### Invocation Record

Use the Review ID and Attempt ID record to prevent ambiguous duplicate invocation, preserve lifecycle evidence, and measure context efficiency without creating automatic retry behavior.

## Implemented Validation Expectations

The implementation and validator demonstrate that:

- PM and Advisor can independently reach a decision from a stable baseline plus incremental evidence;
- either role can inspect task-relevant original evidence whenever the packet is insufficient;
- unchanged files are not repeatedly embedded by default;
- PM and Advisor first-pass conclusions remain isolated;
- an ambiguous invocation does not trigger a blind retry;
- delayed output does not trigger premature cleanup;
- all existing P0/P1/P2, validation, authorization, model-routing, trust, and post-action review fields remain available; and
- the local validation suite detects removal or weakening of these guarantees.

## Preliminary Risk Review

### P0

- None identified in the implementation-transition record.

### P1

- Treating a fresh session as permission to provide only a summary would weaken review reliability.
- Including the other role's first-pass conclusion would break independent no-peek review.
- A hard token ceiling could truncate review and create a false `GO` result.
- Ambiguous invocation state could cause duplicate calls and unnecessary token use.

### P2

- An output format limited to `GO/NO-GO` could omit P2 findings, evidence gaps, validation freshness, or Owner decisions.
- A rule stored only in local project memory would not reliably apply to installed copies of the portable skill.

## Active OpenSpec Change

The active implementation change is:

`optimize-role-review-context-efficiency`

Implemented scope:

1. Add an accepted requirement for role-review context efficiency.
2. Add a dedicated execution reference.
3. Add or extend PM and Advisor review packet templates.
4. Add Review ID, Attempt ID, packet fingerprint, and retry-state rules.
5. Update git gate and handoff templates where review identity is relevant.
6. Update validation documentation and local validation anchors.
7. Add examples proving that compact packets preserve original-evidence access and no-peek independence.

The OpenSpec change and workflow rules exist locally. This transition record does not authorize commit, push, archive, tag, release, or publication; those actions retain their existing gates.
