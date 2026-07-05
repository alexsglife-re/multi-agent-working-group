# Adoption Scenarios

Use Multi-Agent Working Group when a task needs more than a fast answer. The
protocol is most useful when independent review, evidence, handoff quality, or
safe git and release boundaries matter.

This guide explains how to choose the right workflow level. It is adoption
guidance only; it does not authorize commits, pushes, releases, publications,
workspace trust, secret access, or external effects.

## Scenario Guide

| Scenario | Use This Protocol When | Typical Shape |
| --- | --- | --- |
| Documentation task | The docs affect public positioning, adoption, safety rules, or project gates. | Leader reads current docs, uses PM/Advisor when scope is medium or gate-bound, validates docs before git exits. |
| Release preparation | You need release notes, launch copy, readiness checks, or publication order. | Draft locally, verify claims, keep tag/release/publication as explicit Owner-only actions. |
| Long-running project work | The task spans multiple files, agents, stages, or conversations. | Use C0-C4 for OpenSpec work, preserve compact handoff state, keep PM/Advisor evidence current. |
| Cross-conversation handoff | A successor agent needs to continue without trusting stale chat history. | Create or refresh current state, evidence index, unresolved findings, stop conditions, and authorization state. |
| Ordinary small task | The work is narrow, low-risk, and not gate-bound. | Consider Small Task Mode only when every condition in `SKILL.md` is met. |

## Documentation Tasks

Use the full workflow for documentation that changes how readers understand the
project, how maintainers operate it, or what safety boundaries apply. Good
examples include README positioning, installation guidance, validation docs,
adapter support labels, release checklists, and public contribution guidance.

For tiny wording fixes, Small Task Mode may be enough when the work is
low-risk, local, and not commit/push-bound. Small Task Mode still does not
authorize git exits by itself.

## Release Preparation

Release preparation can include readiness checks, changelog updates, release
note drafts, social copy, launch order, and claim review. Keep these separate:

- local drafting and review;
- normal commit and push gates;
- Owner-only tag, release, deployment, and publication actions.

Do not treat a release draft, PM/Advisor agreement, or a completed changelog as
permission to create a tag, GitHub Release, external post, or repository
metadata change.

## Long-Running Project Work

Use the full workflow when work spans stages or conversations. For
OpenSpec-backed work, start with C0 goal analysis, then proceed through C1
proposal, C2 implementation, C3 closeout, and C4 archive when archive applies.

Keep active state compact. A successor should be able to see the current goal,
stage, changed files, validation freshness, role evidence, unresolved P0/P1,
authorization state, and next safe action without reading a long transcript.

## Cross-Conversation Handoff

A handoff is evidence, not authority. The successor must re-check the current
project state before acting.

Minimum handoff content:

- current goal and scope;
- active OpenSpec change and C-stage, if any;
- git branch, HEAD, dirty state, and remote target;
- current validation evidence and freshness;
- PM, Advisor, Worker, and Reviewer status;
- unresolved findings and stop conditions;
- authorization state for commit, push, archive, tag, release, or publication.

## Ordinary Small Tasks

For narrow low-risk work, the protocol should scale down. The Leader can use
Small Task Mode only when the task is clearly small, project rules do not
require OpenSpec or full multi-agent flow, and no higher-risk area is touched.

If the task enters a commit, push, archive, release, deployment, secret, auth,
permission, destructive, or other default-exclusion gate, use the stricter
rules in `SKILL.md` and the relevant references.

## Adoption Checklist

- Read the target project's local instructions first.
- Decide whether the task is small, medium, complex, or high-risk.
- Check whether OpenSpec applies.
- Identify whether PM, Advisor, Worker, or Reviewer roles are required.
- Record what is verified now versus copied from memory or handoff.
- Run project validation before git exits.
- Keep release, tag, deployment, publication, and GitHub metadata changes
  behind explicit Owner authorization.

## What Adoption Does Not Transfer

Adopting, copying, installing, or invoking the protocol transfers only the workflow/checklist structure. It does not transfer:

- commit, push, archive, CI/status, tag, release, deployment, or publication
  authorization;
- validation freshness;
- workspace trust;
- PM, Advisor, Worker, Reviewer, or Leader continuity;
- secret or credential access;
- permission to read unrelated projects or personal data;
- stale handoff authority or prior-session approval.

Each project, runtime, session, and handoff must re-verify its own current
state before acting.
