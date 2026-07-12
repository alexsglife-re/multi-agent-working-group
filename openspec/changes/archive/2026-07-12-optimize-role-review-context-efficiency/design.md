## Context

The workflow already requires independent PM and Advisor review, provider separation, evidence-based lifecycle patience, original project evidence, and multiple review gates. Today, however, callers can repeatedly transmit unchanged history or shorten prompts without a common safety contract. The discussion draft proposes an indexed packet that restores continuity from immutable anchors and current incremental evidence while leaving the full approved evidence scope available to each role.

This is cross-cutting documentation-first workflow work: the always-loaded skill router, a detailed reference, role templates, lifecycle records, examples, validation anchors, accepted specs, and v0.4.17 development documentation must agree. The current public version remains v0.4.16 throughout this work unless the Owner separately authorizes tag/release/publication. PM and Advisor remain independent reviewers; Advisor remains Claude/Claude CLI by default under current routing and its output remains unverified evidence until Leader verification.

## Goals / Non-Goals

**Goals:**

- Reduce repeated PM and Advisor input by referencing stable, reproducible baselines and sending only current incremental evidence by default.
- Default each distinct review checkpoint to a fresh short-lived role session while preserving continuity through artifacts rather than chat history.
- Preserve review capability, required frequency, provider/model routing, no-peek independence, original-evidence access, gates, and lifecycle patience.
- Give every invocation a durable identity and state so delayed or ambiguous results do not cause blind duplicate calls.
- Make compact review behavior testable through templates, examples, accepted requirements, and deterministic validation markers.

**Non-Goals:**

- Changing Claude Advisor routing, PM routing, or provider-separation requirements.
- Setting hard token ceilings, reducing review scope, skipping required calls, or forbidding original-file inspection.
- Automating role invocation, retries, cleanup, commits, pushes, tags, releases, publication, or any Owner-only/default-exclusion action.
- Treating packet summaries, role conclusions, prior consensus, or invocation records as authorization.
- Claiming measured token savings or runtime compliance from documentation-marker validation alone.
- Claiming v0.4.17 is published, moving or creating a tag, creating a release, or publishing without explicit Owner authorization.

## Decisions

### 1. Use a factual manifest plus role-specific packets

The Leader will prepare one conclusion-free factual evidence manifest and derive separate PM and Advisor packets from it. Each packet carries the same verified facts but with role-specific focus and an explicit list of withheld conclusions.

This is preferred over one shared post-review packet because a shared packet can leak one role's first-pass conclusion to the other. It is preferred over independently reconstructing all facts twice because duplicate reconstruction wastes context and increases drift.

### 2. Treat compact packets as evidence indexes, not evidence boundaries

Each packet will contain stable baseline anchors, current deltas, validation freshness, known risks, and direct evidence pointers. It will state that the role may inspect any task-relevant original file or read-only evidence within the approved scope and must request or inspect original evidence when the packet is insufficient.

This is preferred over summary-only review because reliable review sometimes requires surrounding code, complete documents, or raw command output. Unchanged content is omitted from the prompt only when a reproducible anchor lets the role retrieve or verify it.

### 3. Default distinct checkpoints to fresh short-lived sessions

A new first-pass, scope, pre-commit, post-commit, pre-push, post-push, or closeout target defaults to a fresh role session. A narrow clarification or missing-file request for the unchanged target may continue in the same session. A changed commit, diff, gate, decision request, or materially changed packet requires a new Review ID or linked attempt.

This is preferred over indefinitely resumed conversations because accumulated chat history is costly and can contain stale conclusions. It is preferred over unconditional one-shot sessions because evidence gaps often require a bounded follow-up in the same review.

### 4. Separate review identity from invocation attempts

`Review ID` identifies the decision target. `Attempt ID` identifies one invocation. A deterministic packet fingerprint identifies the role-visible input and stable anchors. Invocation state is one of `prepared`, `running`, `completed`, `failed-confirmed`, `result-unknown`, or `superseded`; retries receive a new Attempt ID and link to the parent.

The Leader must not repeat the same Review ID and fingerprint while the prior attempt is `running` or `result-unknown`. Process, output, and CLI status evidence must be inspected first. This is preferred over timeout-only retries because delayed output is already protected by lifecycle patience requirements.

### 5. Preserve the complete decision surface

Role output will use `GO`, `NO-GO`, or `BLOCKED-EVIDENCE`, plus P0/P1/P2, inspected evidence, evidence gaps, validation freshness, corrections, Owner-decision needs, next action, and concise rationale. `BLOCKED-EVIDENCE` distinguishes insufficient evidence from a substantive rejection.

This is preferred over a minimal GO/NO-GO response because a concise binary answer can hide non-blocking findings, stale validation, or authorization gaps.

### 6. Keep the hard boundary in SKILL.md and details in a routed reference

`SKILL.md` will retain a concise fail-closed summary: context efficiency may remove repeated material but must not reduce review scope, frequency, no-peek independence, original-evidence access, routing, gates, or lifecycle patience. A mandatory routed reference will hold packet construction, identity, state, and retry details.

This follows the existing progressive-reference architecture and prevents an unread reference from silently weakening the always-loaded safety boundary.

### 7. Validate durable markers and representative scenarios

The local validator will check the skill router, dedicated reference, role templates, identity/retry states, evidence-access statement, and documentation boundaries. Validation documentation will explicitly say these checks prove required text and structure exist, not that a runtime invocation complied or saved a particular number of tokens.

### 8. Separate public and development version semantics

The validator and release-facing documentation will use two explicit meanings: `PUBLIC_VERSION=v0.4.16` identifies the latest Owner-authorized published release, while `DEVELOPMENT_VERSION=v0.4.17` identifies the current local upgrade target. An equally clear minimal naming convention is acceptable, but a single overloaded `VERSION` marker is not.

README's current public-version statement and published changelog facts must remain v0.4.16 during development. Roadmap, TODO, draft implementation notes, validation anchors, and the unreleased changelog section may identify v0.4.17 as in development. Local validation must check both values independently and must fail if development-only edits imply that v0.4.17 is already tagged, released, or public.

This is preferred over changing every version marker to v0.4.17 because tag/release/publication are default exclusions and the repository must remain truthful while development is pushed ahead of a public release.

### 9. Register every new governed artifact in local and global validation

The accepted `role-review-context-efficiency` spec will be added to `REQUIRED_ACCEPTED_SPECS`, with an explicit active-change delta fallback during implementation and the accepted path required in no-active-change/archive mode. `references/review-context-efficiency.md` will be added to `REQUIRED_REFERENCES`; the existing loop will therefore verify both repository presence and byte-for-byte global installed-reference sync. Two new reusable template files will be created and registered in `REQUIRED_TEMPLATES`: `templates/review-factual-manifest.md` and `templates/review-invocation-record.md`. Existing `templates/pm-review.md` and `templates/advisor-review.md` will carry the role-specific packet fields.

All new and modified templates will retain `Version: v0.4.13 recommended template.` unless a separate, intentional template-version migration is proposed. Adding v0.4.17 workflow behavior does not silently change the current template marker convention.

### 10. Increase the SKILL anchor floor for new fail-closed boundaries

Implementation will add at least two distinct `template_contains "SKILL.md"` checks: one for mandatory routing to the context-efficiency reference and one for the fail-closed rule that context reduction cannot weaken capability, frequency, no-peek independence, original-evidence access, gates, or lifecycle patience. Therefore `SKILL_ANCHOR_BASELINE` will increase from 55 to at least 57. If implementation adds more than two new SKILL anchors, the baseline will be set to the verified resulting count rather than left at 57.

This explicitly treats the new rules as hard-boundary anchors, not reference-only details, and avoids leaving the old floor unchanged after expanding the required anchor set.

## Risks / Trade-offs

- [A compact packet omits decisive context] -> Keep task-relevant original evidence readable, include direct evidence pointers, and require `BLOCKED-EVIDENCE` or further inspection instead of guessing.
- [No-peek conclusions leak through a shared manifest] -> Restrict the manifest to verified facts and generate role-specific packets with explicit withheld-conclusion fields.
- [Fresh sessions lose role continuity] -> Restore continuity from exact baseline anchors, current state, prior accepted anchor, Review ID, and linked attempt records.
- [Fingerprinting creates false equivalence] -> Define the fingerprint over all role-visible packet content and anchors; materially changed inputs require a new fingerprint.
- [Ambiguous state stalls forever] -> Use evidence-based lifecycle checks and explicit `result-unknown`; escalate a real unresolved blocker rather than silently retrying.
- [Extra record fields create process overhead] -> Keep the record small, reusable across PM and Advisor, and limited to fields needed for reproducibility and retry safety.
- [Marker validation gives false confidence] -> Document that validation is structural and retain independent PM/Advisor review plus fresh evidence-based gates.

## Migration Plan

1. Add the new accepted-behavior reference and role packet/invocation templates behind the existing workflow gates.
2. Add the concise `SKILL.md` router and extend existing PM, Advisor, git-gate, handoff, lifecycle, and example surfaces.
3. Add deterministic local validation anchors and update validation documentation.
4. Update development markers to v0.4.17 while keeping public markers at v0.4.16; implement separate public/development validator variables or equally explicit semantics.
5. Register the accepted spec, reference, and new templates in validator arrays; verify the reference through the existing global sync loop and preserve the v0.4.13 template marker convention.
6. Add the two new SKILL hard-boundary anchors and raise `SKILL_ANCHOR_BASELINE` from 55 to at least 57 based on the actual resulting anchor count.
7. Validate the active change, local package, diff hygiene, secret patterns, and installed-skill sync as applicable.
8. After implementation push and post-push review, synchronize delta specs and archive the change through its own archive validation, archive commit/push gate, post-push repository/CI status check, and fresh PM plus Advisor review when applicable.
9. Preserve rollback by reverting the v0.4.17 development commits; no data or API migration is required.

## Open Questions

- The implementation should select the simplest deterministic packet fingerprint representation supported by the documentation-first workflow; cryptographic enforcement is not required.
- Runtime token measurements may be added later as observational evidence, but they must not become a quality-affecting budget or a prerequisite for this documentation-first release.
