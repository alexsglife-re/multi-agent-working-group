## ADDED Requirements

### Requirement: Short-lived role sessions preserve lifecycle and provider state
The workflow SHALL treat a fresh short-lived PM or Advisor session as a context-management boundary, not as permission to change provider/model routing, erase role continuity, skip a required review, or reset gate evidence without verification.

#### Scenario: Advisor starts a fresh review session
- **WHEN** the current checkpoint requires a fresh Advisor session
- **THEN** the Advisor uses the required provider/model routing and receives verified baseline, continuity, target, and incremental evidence without inheriting full chat history

#### Scenario: Provider route is unavailable
- **WHEN** the required fresh Advisor session cannot use the required provider/model
- **THEN** the workflow follows the existing blocked or Owner-approved degradation rule and MUST NOT silently substitute another provider to save context

### Requirement: Ambiguous invocation state follows evidence-based patience
The workflow SHALL treat delayed output and `result-unknown` invocation state as lifecycle evidence requiring inspection and patience, not as confirmed failure, cleanup work, or permission for blind retry.

#### Scenario: Role output is delayed
- **WHEN** a PM or Advisor attempt is still `running` and no concrete failure evidence exists
- **THEN** the Leader preserves the attempt, applies the recorded patience window, and MUST NOT duplicate or close it solely because of short silence

#### Scenario: Result remains unknown
- **WHEN** available process, output, and CLI status checks cannot resolve whether an attempt completed
- **THEN** the Leader records `result-unknown`, preserves the gate as unresolved, and does not downgrade the condition into cleanup
