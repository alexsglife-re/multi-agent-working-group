## Why

Repeated full-history prompts consume PM and Advisor context without adding review evidence, while ad hoc prompt shortening can accidentally weaken no-peek independence, lifecycle patience, provider separation, or access to original evidence. The development target v0.4.17 should make compact, reproducible review packets the default without reducing role capability, review frequency, gate coverage, or decision reliability; the current public version remains v0.4.16 unless the Owner separately authorizes and completes tag/release/publication.

## What Changes

- Add a role-review context-efficiency protocol based on fresh short-lived review sessions, stable baseline anchors, and incremental evidence packets.
- Add Review ID, Attempt ID, packet fingerprint, invocation-state, and linked-retry records so ambiguous or delayed role calls are not blindly repeated.
- Preserve PM and Advisor independent first passes by deriving separate no-peek packets from a shared factual manifest that excludes the other role's conclusions.
- Preserve task-relevant original-evidence access and require roles to inspect or request original evidence whenever a compact packet is insufficient.
- Extend role templates and lifecycle records with review identity, evidence access, validation freshness, evidence gaps, and `GO`, `NO-GO`, or `BLOCKED-EVIDENCE` outcomes while retaining P0/P1/P2 and Owner-decision fields.
- Route the new protocol through the progressive skill reference structure and protect its non-regression anchors with local validation.
- Prepare development documentation and local version metadata for the v0.4.17 target, named **Role Review Context Efficiency**, while preserving v0.4.16 as the current public version.
- Transition the discussion draft into implemented workflow documentation only after the corresponding rules, templates, validation, and review gates pass; until then it remains non-authoritative draft evidence.
- Do not change PM or Advisor provider/model routing, required invocation frequency, independent review authority, git/release/default-exclusion gates, lifecycle patience, or the rule that Advisor output is evidence rather than authority.

## Capabilities

### New Capabilities

- `role-review-context-efficiency`: Defines stable-baseline and incremental review packets, short-lived review sessions, review identity, evidence-access guarantees, no-peek separation, and safe retry behavior.

### Modified Capabilities

- `copyable-role-templates`: Extends PM, Advisor, git-gate, handoff, and state-carrying templates with context-efficient review packet and invocation-record fields.
- `progressive-skill-references`: Adds routing and non-regression requirements for the dedicated role-review context-efficiency reference.
- `cli-trust-and-openspec-lifecycle`: Clarifies how short-lived role sessions, delayed results, ambiguous invocation state, and linked retries preserve lifecycle patience and provider separation.
- `local-validation-tool`: Adds validation anchors for context-efficiency guarantees, no-peek packet isolation, original-evidence access, and no-blind-retry behavior.

## Impact

- Affected workflow surfaces: `SKILL.md`, a new dedicated reference, role-review and git/handoff templates, examples, and validation documentation.
- Affected validation surface: `scripts/validate-local.sh` and its expected markers or representative scenarios.
- Affected release-facing documentation: README, roadmap, TODO, validation notes, changelog, and version metadata must distinguish `PUBLIC_VERSION=v0.4.16` from `DEVELOPMENT_VERSION=v0.4.17` (or an equally clear minimal convention).
- No runtime dependency, public API, secret-handling, authorization, provider-routing, tag, release, or publication behavior changes are introduced by the protocol itself.
- This change does not claim v0.4.17 is public and does not authorize moving a tag, creating a release, or publishing the development version.
