## MODIFIED Requirements

### Requirement: Repository provides copyable role templates
The project SHALL provide copyable templates for PM, Advisor, Worker assignment, Worker return, Reviewer report, blocked report, C0 analysis, compact handoff, successor startup, and git gate capture. Templates for PM, Advisor, Worker, C0, compact handoff, successor startup, and blocked reports SHALL record lifecycle patience state when substantive role work is expected, in progress, blocked, or restarted.

#### Scenario: Future agent captures long-running role state
- **WHEN** a PM, Advisor, or substantive Worker is still working or has been restarted
- **THEN** the relevant template provides fields for expected wait window, last contact, progress evidence, patience state, and closure or restart reason
