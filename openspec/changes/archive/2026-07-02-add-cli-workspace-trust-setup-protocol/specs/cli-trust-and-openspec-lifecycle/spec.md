## MODIFIED Requirements

### Requirement: CLI agent workspace trust preflight
The skill SHALL require the Leader to confirm a current-project workspace-trust preflight before relying on a CLI-based PM, Advisor, Worker, or Reviewer. The skill SHALL treat an Owner-recorded assignment of Claude CLI, Codex CLI, or another CLI-based agent to a role as authorization to complete workspace trust setup for the exact current project root, after the Leader verifies that the assignment source applies to the current project and workstream.

#### Scenario: CLI agent reports untrusted workspace
- **WHEN** a CLI agent such as Claude CLI, Codex CLI, or a similar tool cannot operate because the current project workspace is untrusted
- **THEN** the Leader MUST check whether a current Owner instruction, global memory, project rule, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence records that the Owner assigned that CLI agent to the current role
- **AND** if no applicable Owner-recorded assignment exists, the Leader MUST stop that role path as `workspace-trust-blocked`, report the blocker, and avoid silently switching roles, models, or evidence sources

#### Scenario: Owner-recorded CLI role authorizes current-project trust setup
- **WHEN** an applicable Owner-recorded source assigns Claude CLI, Codex CLI, or another CLI-based agent as PM, Advisor, Worker, Reviewer, or another role for the current project and workstream
- **THEN** the Leader MAY perform or confirm workspace trust setup for the exact current project root without asking the Owner again
- **AND** the Leader MUST record the source, assigned role, target project root, and trust state as `owner-recorded-role-authorized` or `trust-setup-attempted`

#### Scenario: CLI trust is established for current project
- **WHEN** the Owner-assigned CLI agent can be trusted for the exact current project workspace
- **THEN** the Leader MUST keep the trust scope limited to the current project and rerun a minimal read-only probe before relying on that agent output
- **AND** the Leader MUST record `trusted-verified` only after the read-only probe succeeds

#### Scenario: Trust setup exceeds current-project scope
- **WHEN** trust setup would require trusting a parent directory, home directory, all repositories, unrelated project, dangerous permission-bypass flag, secret access, browser data, broad file access, global policy change, git action, CI, deployment, release, or other external effect
- **THEN** the Leader MUST NOT treat Owner-recorded CLI role assignment as sufficient authorization
- **AND** the Leader MUST stop for explicit Owner confirmation and record the state as `owner-confirmation-needed` or `blocked`

#### Scenario: Recorded assignment is stale or mismatched
- **WHEN** the only available CLI role assignment source is stale, historical-only, superseded, or not applicable to the current project or workstream
- **THEN** the Leader MUST NOT use it as authorization for workspace trust setup
- **AND** the Leader MUST report the missing current authorization instead of silently relying on old role state
