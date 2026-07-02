## Context

v0.4.8 says Advisor and PM/Advisor model separation prefer different models, providers, or model families. That wording leaves room to count two adjacent same-provider models as full separation. The Owner clarified that PM/Advisor separation means provider-level separation by default, such as OpenAI PM plus Claude Advisor.

The Owner also has a global memory rule for the default Claude CLI Advisor model. That is a routing preference outside the portable skill. The skill must remain model-agnostic and must not hard-code the concrete model.

## Goals / Non-Goals

**Goals:**
- Make provider-level PM/Advisor separation the default full separation standard.
- Define explicit separation status vocabulary and which statuses are full, degraded, or blocked.
- Treat memory and handoff model records as evidence that must be verified for the current workstream.
- Add template fields so future handoffs can record the concrete provider/model and separation status.
- Keep validation lightweight and structural.

**Non-Goals:**
- Do not hard-code any concrete model into the skill.
- Do not add automatic provider selection.
- Do not weaken existing trusted Advisor context, no-secret, PM/Advisor consensus, Reviewer, validation, or git gates.

## Decisions

1. Full separation requires different providers when available.
   - Rationale: provider-level separation is the Owner's intended interpretation and gives a stronger independent critique boundary than adjacent model versions.
   - Alternative rejected: Treating different same-provider models as full separation. That already caused a bad Advisor routing decision.

2. Use explicit status values with tier semantics.
   - `provider-separated`: full separation.
   - `model-family-separated`: partial/degraded unless the families are also provider-separated; if provider-separated applies, use `provider-separated`.
   - `same-provider-variant`: degraded/partial separation.
   - `same-model-owner-override`: degraded with Owner override.
   - `degraded`: generic degradation when the specific cause is not represented.
   - `blocked`: required separation cannot be established and no valid override exists.

3. Memory is hint-to-verify, not model-routing authority.
   - Rationale: stale global or project memory can otherwise override the current Owner instruction or current tool availability.
   - Current Owner instruction wins. A current verified workstream/startup/handoff record may settle routing only when it applies to the current project, task, and available tooling.

4. State-carrying templates record model source and separation status.
   - C0 and successor startup packets are the authoritative places for startup/takeover state.
   - Compact handoff carries the current verified state across context boundaries.

## Risks / Trade-offs

- [Risk] Stronger provider separation can block work when only one provider is available. -> [Mitigation] Keep explicit Owner override and degradation paths.
- [Risk] Template fields add noise. -> [Mitigation] Update only state-carrying templates and keep PM/Advisor review templates minimal.
- [Risk] Validation could become brittle. -> [Mitigation] Check stable markers and fields, while semantic review remains in docs/examples and PM/Advisor review.
