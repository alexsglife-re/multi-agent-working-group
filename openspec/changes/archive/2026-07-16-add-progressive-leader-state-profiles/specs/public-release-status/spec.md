## ADDED Requirements

### Requirement: v1.0.0 development status remains separate from public v0.4.18
Release-facing documentation SHALL identify `v1.0.0 — Progressive Leader State Profiles` as the Owner-authorized development target and SHALL continue to identify `v0.4.18` as the current public version until a separately reviewed public release-status change is completed.

#### Scenario: Feature implementation is active
- **WHEN** the progressive Leader-state profile change is under implementation or archive closeout
- **THEN** README, changelog, roadmap, TODO, validation documentation, and deterministic version checks distinguish development v1.0.0 from public v0.4.18

#### Scenario: Development target is declared
- **WHEN** documentation records the v1.0.0 development target
- **THEN** it MUST NOT claim that the v1.0.0 tag, GitHub Release, public publication, or deployment already exists

#### Scenario: Public release conversion is considered
- **WHEN** implementation and archive are complete and v1.0.0 is ready for public release consideration
- **THEN** a separately gated public release-status closeout verifies the exact commit, tag, release metadata, release content, publication authorization, and post-action state before v1.0.0 replaces v0.4.18 as current public
