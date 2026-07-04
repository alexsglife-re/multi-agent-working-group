## ADDED Requirements

### Requirement: Leader direct work has a budget trigger
The protocol SHALL require the Leader to treat substantive direct execution in
Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or
context-heavy work as an exception rather than the default. The protocol SHALL
provide a Leader work-budget self-check trigger and require the Leader to
dispatch a bounded Worker or record a concrete exception when direct work grows
beyond small connective edits.

#### Scenario: Leader direct edits exceed the self-check trigger
- **WHEN** Leader direct edits in a Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or context-heavy task exceed the documented self-check trigger
- **THEN** the Leader either dispatches a bounded Worker before continuing substantive execution or records a concrete exception explaining why Leader direct execution is safer

#### Scenario: Leader performs small connective work
- **WHEN** Leader work is limited to small connective edits, checklist updates, tiny validation-anchor fixes, or gate-required commands
- **THEN** the Leader may perform that work directly while preserving role and gate boundaries

### Requirement: Leader work-budget trigger is guidance, not automatic failure
The protocol SHALL describe numeric Leader work-budget values, such as more
than 2 files or roughly 80 diff lines, as a self-check trigger rather than an
automatic correctness failure.

#### Scenario: Mechanical edit exceeds the numeric trigger
- **WHEN** a mechanical or safer Leader-owned edit exceeds the numeric self-check trigger
- **THEN** the Leader may continue only after recording the exception and why Worker dispatch would add more risk or overhead than it removes

#### Scenario: Dense edit stays below the numeric trigger
- **WHEN** a dense or interpretive edit stays below the numeric self-check trigger but is substantively Worker-suitable
- **THEN** the Leader still treats Worker dispatch as the default unless a concrete exception is recorded
