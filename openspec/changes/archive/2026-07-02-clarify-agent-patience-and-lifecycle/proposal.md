# Proposal: Clarify Agent Patience And Lifecycle

## Why

In real use, PM and Advisor agents often receive large review packets and may need more time than a short interactive pause. A short period without visible output should not be treated as task failure, role unavailability, or a reason to close the PM/Advisor session.

Complex Worker slices can have the same issue. If a Worker has a bounded but substantive implementation, validation, or analysis slice, the Leader should not close or replace that Worker merely because the Worker is quiet briefly.

## What Changes

- Define agent waiting as evidence-based lifecycle management, not a short silence timeout.
- Require PM and Advisor to get longer patience windows by default for substantive review, OpenSpec, commit/push/archive gates, and large evidence packets.
- Apply the same principle to complex, implementation-heavy, or validation-heavy Workers with bounded assignments.
- Require prompts and handoffs to record expected wait window, last contact, progress evidence, and closure/restart reason when relevant.
- Preserve real stop conditions: explicit failure, blocked state, tool/session death, stale evidence, role drift, context overload, unresolved P0/P1, owner decision, or exceeded agreed wait window.

## Non-Goals

- No automatic timers, process supervisors, polling loops, or agent session registry.
- No guarantee that any external agent remains alive.
- No weakening of PM/Advisor/Reviewer gates, validation, git gates, or Owner authorization.
- No permission to wait indefinitely when the next safe action requires current evidence.

## Impact

This makes long PM/Advisor reviews and complex Worker slices less brittle while preserving explicit lifecycle state and safe closure conditions.
