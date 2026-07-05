## ADDED Requirements

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
