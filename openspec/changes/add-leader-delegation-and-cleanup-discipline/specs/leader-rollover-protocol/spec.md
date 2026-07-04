## ADDED Requirements

### Requirement: Worker-first context control precedes rollover pressure
The protocol SHALL direct the Leader to dispatch bounded Worker slices earlier
for Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or
context-heavy work when doing so would reduce Leader context growth. Worker-first
context control SHALL NOT require Worker dispatch for narrow low-risk edits or
gate commands.

#### Scenario: Task is likely to grow Leader context
- **WHEN** a task is Medium, Complex, OpenSpec-backed, multi-file, implementation-heavy, or context-heavy
- **AND** a bounded Worker slice can own a coherent part of the work
- **THEN** the Leader dispatches a Worker before Leader context grows toward rollover pressure, or records why direct Leader execution is safer

#### Scenario: Task is narrow and low risk
- **WHEN** the task is a narrow low-risk edit or a gate-required command
- **THEN** Worker-first context control does not require Worker dispatch by itself

### Requirement: Worker outputs are summarized and referenced
The protocol SHALL require the Leader to summarize Worker returns and reference
evidence instead of pasting or reprocessing long raw outputs in the Leader
context when safe local evidence storage exists.

#### Scenario: Worker returns long output
- **WHEN** a Worker returns long logs, large diffs, long analysis, or repeated command output
- **THEN** the Leader summarizes the result, preserves key error details and findings, and references evidence instead of copying raw bulk into the active Leader context

#### Scenario: Worker result includes required blocker details
- **WHEN** Worker output includes blockers, unresolved P0/P1, validation failures, or key error details
- **THEN** the Leader preserves those details in the active state or evidence index rather than discarding them as bulk
