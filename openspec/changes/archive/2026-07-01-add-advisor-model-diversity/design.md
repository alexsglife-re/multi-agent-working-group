## Context

The repository just completed the v0.4.0 local stabilization pass for role boundaries, examples, validation, and normal git gates. That work remains in the active OpenSpec change directory until a separate archive step is requested or performed.

The v0.4.1 upgrade addresses Advisor model diversity. The Owner clarified that when they explicitly assign Claude or another model/tool as Advisor, that Advisor is a trusted collaboration role for bounded task context, not an ordinary third-party disclosure. Advisor output still remains unverified until Leader checks current evidence.

## Goals / Non-Goals

**Goals:**
- Make different-model Advisor review the default when model selection is available.
- Prompt for and record Advisor model/provider at workstream or session startup when no record exists.
- Preserve existing Advisor context boundaries, independence, validation, and failure behavior.
- Keep v0.4.1 documentation-only and rule-level.
- Resolve version wording by presenting v0.4.0 as completed local stabilization and v0.4.1 as the current planned upgrade.

**Non-Goals:**
- Do not add automatic model routing or selection code.
- Do not add a persistent local config file or storage format.
- Do not archive the v0.4.0 OpenSpec change in this update.
- Do not expand Advisor access to secrets, credentials, unrelated projects, or broad context dumps.
- Do not change commit, push, release, deployment, or Owner-only high-risk gates.

## Decisions

### Decision 1: Use a soft default, not an absolute requirement

Advisor should default to a different AI model, preferably a different provider or model family, but single-model environments must be handled as recorded degradation rather than automatic failure. This avoids breaking local use while still making the weaker review posture visible.

Alternative considered: require a different Advisor model for all multi-agent work. Rejected because it would make the skill unusable in single-model environments and would conflict with existing Advisor-unavailable handling.

### Decision 2: Reframe "first local use" as startup prompt when unspecified

The skill has no runtime state or config mechanism, so it cannot automatically detect the first historical local use. Instead, Leader must ask for the Advisor model/provider at workstream or session startup when no project, session, continuity, or handoff record exists.

Alternative considered: add a config file. Rejected for v0.4.1 because the project is still documentation-first and avoids automation until the manual workflow has been tested.

### Decision 3: Keep context sharing bounded even for trusted Advisors

An explicitly assigned Advisor is trusted for the role, but this does not authorize broad or irrelevant context sharing. The existing minimum-necessary Advisor context rule remains the limit, and secrets still require explicit Owner authorization.

Alternative considered: remove external Advisor disclosure warnings entirely. Rejected because trust and scope are separate: the Advisor role can be trusted while still receiving only the context needed for the assigned review.

### Decision 4: Keep model diversity separate from correctness

Different-model review improves critique diversity but does not prove correctness. Leader still verifies Advisor output, PM and Advisor still work independently, and unresolved P0/P1 still blocks affected gates.

## Risks / Trade-offs

- Different-model language could be read as a hard gate -> Mitigate with explicit precedence and recorded-degradation wording.
- Same-model Owner override could be hidden -> Mitigate by requiring explicit same-model override records.
- Trusted Advisor wording could be read as broad disclosure -> Mitigate by reaffirming minimum necessary context and secret restrictions.
- Version wording could conflict with v0.4.0 active OpenSpec state -> Mitigate by saying v0.4.0 local stabilization is complete while archive remains separate.
