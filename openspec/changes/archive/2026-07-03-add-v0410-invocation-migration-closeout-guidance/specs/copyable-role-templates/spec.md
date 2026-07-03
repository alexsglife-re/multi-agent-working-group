## MODIFIED Requirements

### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for PM, Advisor, Worker assignment, Worker return, Reviewer report, blocked report, C0 analysis, compact handoff, successor startup, and git gate capture. Templates for PM, Advisor, Worker, C0, compact handoff, successor startup, and blocked reports SHALL record lifecycle patience state when substantive role work is expected, in progress, blocked, or restarted. State-carrying templates SHALL provide fields for a plain-language completion summary and recommended next goals when a work round closes or hands off.

#### Scenario: Future agent captures long-running role state
- **WHEN** a PM, Advisor, or substantive Worker is still working or has been restarted
- **THEN** the relevant template provides fields for expected wait window, last contact, progress evidence, patience state, and closure or restart reason

#### Scenario: Future agent closes a work round
- **WHEN** a work round completes or reaches a safe handoff boundary
- **THEN** the relevant template provides fields for what changed, what was verified, remaining uncertainty or skipped checks, and recommended next goals

### Requirement: Templates are structure only
The templates SHALL state or imply that they provide structure and evidence capture only, not authorization, approval, validation success, gate bypass, automatic next-goal execution, or automatic role spawning.

#### Scenario: Template is used before commit or push
- **WHEN** a role or gate template is filled in before commit or push
- **THEN** the filled template remains evidence for the applicable PM/Advisor/Reviewer and git gates, not a substitute for those gates

#### Scenario: Completion summary recommends a next goal
- **WHEN** a filled template recommends a next goal
- **THEN** the recommendation does not authorize starting that goal unless the Owner has already given that instruction
