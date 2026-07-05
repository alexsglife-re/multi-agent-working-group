# Release Preparation Task Example

Use this shape when the Owner asks for release preparation, launch copy, or
public promotion planning without explicitly authorizing a tag, GitHub Release,
or external publication.

## Owner Request

```text
Use the multi-agent-working-group skill to prepare release material for the
next version. Do not publish anything yet.
```

## Recommended Workflow

1. Leader confirms the release-preparation scope and default exclusions.
2. PM reviews target audience, acceptance criteria, and release-readiness risks.
3. Advisor independently challenges claims, unsupported support statements, and
   public-facing wording.
4. Worker may draft bounded assets such as changelog text, release notes, or
   channel-specific copy.
5. Leader verifies claims against repository evidence and validation results.
6. Commit/push gates run only if the task includes repository changes and the
   applicable PM plus Advisor gate passes.

## Boundary Record

```text
Local drafting: allowed by current task.
Commit/push: requires normal git gate if repository files change.
Tag/release: not authorized.
External publication: not authorized.
GitHub metadata changes: not authorized.
Claims requiring evidence: users, benchmarks, integrations, runtime support,
validated adapters, CI, deployment, and security posture.
```

## Safe Closeout

```text
What changed:
  Release-preparation drafts and readiness notes were prepared locally.
What was verified:
  Claims were checked against current repository docs and validation evidence.
What remains uncertain or was not checked:
  Public posting, tag creation, and GitHub Release creation were not performed.
Recommended next goal:
  Owner reviews the release packet and explicitly names any publication action.
Authorization state:
  Drafting complete; tag/release/publication remain unauthorized.
```
