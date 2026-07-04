## ADDED Requirements

### Requirement: Skill uses progressive references without weakening constraints
The skill SHALL allow long-form details to move into reference files only when
`SKILL.md` remains the always-loaded fail-closed authority for hard stops,
default exclusions, and mandatory reference routing.

#### Scenario: Leader reads only SKILL.md at startup
- **WHEN** a Leader reads `SKILL.md` before any reference file
- **THEN** the Leader can identify the skill purpose, project-rule precedence, hard stop conditions, default exclusions, required PM/Advisor gates, and mandatory reference routes before acting

#### Scenario: Leader applies agent evidence boundaries
- **WHEN** a Leader reads `SKILL.md` before any reference file
- **THEN** the Leader can identify that PM and Advisor require independent first-pass review, Advisor output is unverified evidence rather than authority, and handoff or prior agent output is evidence rather than authorization

#### Scenario: Reference expands a rule
- **WHEN** a reference file expands a git, OpenSpec, CLI trust, rollover, handoff, or role-output rule
- **THEN** `SKILL.md` still contains a fail-closed summary of the corresponding hard boundary

### Requirement: Reference routing is mandatory and domain-specific
`SKILL.md` SHALL state when a Leader MUST read each reference before acting in a
domain that depends on that reference.

#### Scenario: Task reaches git or release gate
- **WHEN** a task involves commit, push, tag, release, publication, deployment, force-push, destructive operation, secret, auth, permission, schema, or another default-exclusion action
- **THEN** `SKILL.md` requires the Leader to read the git/default-exclusion reference before acting

#### Scenario: Task is OpenSpec-backed
- **WHEN** a task is OpenSpec-backed
- **THEN** `SKILL.md` requires the Leader to read the OpenSpec lifecycle reference before proposal, implementation, closeout, or archive action

#### Scenario: Task uses rollover or handoff
- **WHEN** a task involves context rollover, handoff, continuity recovery, or successor startup
- **THEN** `SKILL.md` requires the Leader to read the rollover and handoff reference before relying on prior state or producing successor state

#### Scenario: Task uses CLI role trust
- **WHEN** a task involves Claude CLI, Codex CLI, or another CLI-based role with workspace trust requirements
- **THEN** `SKILL.md` requires the Leader to read the CLI trust reference before relying on that role

#### Scenario: Task dispatches or reviews roles
- **WHEN** a task dispatches PM, Advisor, Worker, or Reviewer roles or requires structured role output
- **THEN** `SKILL.md` requires the Leader to read the role templates and output reference before sending or accepting that role work

### Requirement: Structure-only refactor preserves behavior
The v0.4.12 progressive reference change SHALL be a structure-only refactor
unless a separate OpenSpec change explicitly proposes behavior changes.

#### Scenario: Implementation changes file layout
- **WHEN** rules move between `SKILL.md` and reference files
- **THEN** PM and Advisor review confirms that no capability, constraint, gate, default exclusion, fail-closed condition, or authorization boundary is weaker than before

#### Scenario: Line-count target conflicts with safety
- **WHEN** reducing `SKILL.md` line count would remove or weaken a hard-boundary summary
- **THEN** the hard-boundary summary remains in `SKILL.md` even if the advisory line-count target is exceeded

### Requirement: References do not become alternate authorities
Reference files SHALL extend `SKILL.md` and SHALL NOT override, loosen, or
replace constraints from `SKILL.md`.

#### Scenario: Reference file is opened
- **WHEN** a Leader reads a reference file
- **THEN** the reference states that it extends `SKILL.md`, cannot weaken `SKILL.md`, and does not create authorization by itself

#### Scenario: Reference is missing or unread
- **WHEN** a required reference is missing, unavailable, or has not been read for an affected domain
- **THEN** the Leader stops before acting in that domain rather than proceeding with a degraded gate

### Requirement: Traceability proves no hard boundary was lost
The change SHALL include a traceability map from the current `SKILL.md` hard
boundary sections and validation anchors to their new locations.

#### Scenario: Reviewer checks the restructure
- **WHEN** PM, Advisor, or Leader reviews the implementation
- **THEN** they can verify where each hard boundary remains in `SKILL.md` and where detailed expansion lives in references
- **AND** they can verify that PM/Advisor independence, no-peek review, Advisor evidence-not-authority, and handoff or agent output evidence-not-authorization remain in `SKILL.md`

#### Scenario: Hard boundary is not mapped
- **WHEN** a hard boundary from the current `SKILL.md` has no traceability entry
- **THEN** the implementation is incomplete and cannot proceed to closeout

#### Scenario: Hard boundary lacks validation anchor
- **WHEN** implementation summarizes a hard boundary in `SKILL.md` and that boundary is not covered by the current validation anchor set
- **THEN** the implementation adds a new `SKILL.md` validation anchor for that hard boundary before closeout
