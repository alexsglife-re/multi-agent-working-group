## ADDED Requirements

### Requirement: Successor projection is profile-aware
The rollover protocol SHALL project Compact or Standard current state into successor material without changing accepted rollover triggers or transferring authorization, decision, validation freshness, approval, or role continuity.

#### Scenario: Rollover Opportunity applies
- **WHEN** the canonical state is at `Rollover Opportunity`
- **THEN** the Leader refreshes active state and the evidence index and updates only a lightweight successor skeleton when useful

#### Scenario: Complete packet is required
- **WHEN** rollover is Recommended, Strongly Recommended, Required, an actual handoff occurs, or the Owner explicitly requests handoff
- **THEN** the Leader prepares the complete accepted successor packet with every applicable retention-floor fact and the dependencies of the first next action

#### Scenario: Successor takes over from a profile-aware packet
- **WHEN** a new Leader reads a Compact or Standard successor projection
- **THEN** the successor freshly verifies authority, git and OpenSpec state, validation freshness, role continuity, unresolved findings, Worker state, and profile selection without inheriting any recorded gate decision

### Requirement: Above-Standard state preserves rollover safety
The protocol SHALL recognize `hierarchical-required` as an interim profile classification and MUST NOT treat it as a new rollover state or a completed Hierarchical storage design.

#### Scenario: Large active state requires Hierarchical design
- **WHEN** `hierarchical-required` is recorded before the Hierarchical follow-on exists
- **THEN** the Leader preserves all applicable facts, uses accepted qualitative rollover and handoff controls, and MUST NOT truncate state to fit Compact or Standard
