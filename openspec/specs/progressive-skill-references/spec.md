# progressive-skill-references Specification

## Purpose
TBD - created by archiving change split-skill-into-progressive-references. Update Purpose after archive.
## Requirements
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

### Requirement: Fast Path preserves mandatory routing
The skill SHALL describe Fast Path as a reading-order optimization only, while preserving action-triggered mandatory reference routing as the controlling rule.

#### Scenario: Narrow low-risk task starts on the fast path
- **WHEN** a task is narrow, low-risk, read-only, and does not touch a routed domain
- **THEN** `SKILL.md` may let the Leader begin with the main skill file, project instructions, and only the references that become relevant

#### Scenario: Fast Path reaches a routed domain
- **WHEN** a task using the Fast Path reaches commit, push, tag, release, publication, deployment, OpenSpec, CLI trust, role dispatch or output, rollover, handoff, secret, auth, security, permission, schema, destructive, irreversible, or other default-exclusion work
- **THEN** the matching mandatory reference read becomes required before acting in that domain
- **AND** Fast Path does not reduce or bypass that reference read

#### Scenario: Fast Path is not Small Task Mode
- **WHEN** a task is described as using the Fast Path
- **THEN** Fast Path controls reading order only
- **AND** it does not grant Small Task Mode, remove PM/Advisor/Reviewer requirements, or change git-gate Advisor review requirements

### Requirement: Skill-load optimization preserves anchors
The skill SHALL NOT treat `SKILL.md` load reduction as a reason to remove current always-loaded hard-boundary anchors.

#### Scenario: Contributor edits SKILL.md for readability
- **WHEN** a contributor edits `SKILL.md` to clarify reading order or reduce noise
- **THEN** current hard-boundary anchors remain in `SKILL.md`
- **AND** any future movement of a hard-boundary anchor out of `SKILL.md` is treated as an explicit boundary demotion, not a mechanical cleanup

#### Scenario: Reference contains detailed rule text
- **WHEN** a reference contains detailed rule text for a domain
- **THEN** `SKILL.md` still retains the routed-domain summary and current validation anchors needed to fail closed before action

### Requirement: Skill routes context-efficient review work to a dedicated reference
`SKILL.md` SHALL retain an always-loaded fail-closed summary of the role-review context-efficiency boundary and SHALL require the Leader to read the dedicated reference before preparing, dispatching, retrying, or accepting a context-efficient PM or Advisor review.

#### Scenario: Leader prepares an incremental role packet
- **WHEN** a Leader uses a stable baseline and incremental evidence for PM or Advisor review
- **THEN** `SKILL.md` requires the dedicated context-efficiency reference to be read before dispatch

#### Scenario: Dedicated reference is unavailable
- **WHEN** the role-review context-efficiency reference is missing, unreadable, or has not been read
- **THEN** the Leader does not claim or apply the context-efficient packet protocol and continues only under the existing full review rules without weakening any gate

### Requirement: Progressive routing preserves review guarantees
The always-loaded skill summary and dedicated reference SHALL state that reducing repeated material cannot reduce provider/model routing, review frequency, no-peek independence, original-evidence access, gate coverage, lifecycle patience, or Leader verification.

#### Scenario: Contributor moves packet details into a reference
- **WHEN** implementation places packet identity and retry details in the dedicated reference
- **THEN** `SKILL.md` still retains the fail-closed quality-preservation boundary and mandatory routing marker
