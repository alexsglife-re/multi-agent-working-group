#!/usr/bin/env bash
set -euo pipefail

VERSION="v0.4.8"
REQUIRED_ACCEPTED_SPECS=(
  "advisor-model-diversity"
  "cli-trust-and-openspec-lifecycle"
  "copyable-role-templates"
  "leader-state-compaction"
  "local-validation-tool"
  "role-boundary-stabilization"
)
ROLLOVER_SPEC="leader-rollover-protocol"
ROLLOVER_CHANGE="openspec/changes/add-rollover-opportunity-protocol/specs/leader-rollover-protocol/spec.md"
REQUIRED_TEMPLATES=(
  "templates/README.md"
  "templates/advisor-review.md"
  "templates/blocked-report.md"
  "templates/c0-goal-analysis.md"
  "templates/compact-handoff.md"
  "templates/git-gate.md"
  "templates/pm-review.md"
  "templates/reviewer-report.md"
  "templates/successor-startup-packet.md"
  "templates/worker-assignment.md"
  "templates/worker-return.md"
)

require_no_active_changes=0
skip_global_skill=0
failures=0

usage() {
  cat <<'USAGE'
Usage: ./scripts/validate-local.sh [--require-no-active-changes] [--skip-global-skill]

Runs lightweight read-only checks for the multi-agent-working-group repository.

Options:
  --require-no-active-changes  Fail if OpenSpec has active changes.
  --skip-global-skill          Skip comparing repo SKILL.md with the installed global skill.
  -h, --help                   Show this help.
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --require-no-active-changes)
      require_no_active_changes=1
      ;;
    --skip-global-skill)
      skip_global_skill=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

pass() {
  printf 'PASS %s\n' "$1"
}

warn() {
  printf 'WARN %s\n' "$1"
}

fail() {
  printf 'FAIL %s\n' "$1" >&2
  failures=$((failures + 1))
}

contains() {
  local file="$1"
  local needle="$2"
  grep -Fq -- "$needle" "$file"
}

template_contains() {
  local file="$1"
  local needle="$2"
  local label="$3"

  if [[ -f "$file" ]] && contains "$file" "$needle"; then
    pass "$label"
  else
    fail "$label"
  fi
}

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "$repo_root" ]]; then
  echo "FAIL not inside a git repository" >&2
  exit 1
fi

cd "$repo_root"

if [[ ! -f "SKILL.md" || ! -d "openspec" ]]; then
  fail "repository root does not look like multi-agent-working-group"
else
  pass "repository root detected"
fi

if [[ "$(sed -n '1p' SKILL.md)" == "---" ]] \
  && contains "SKILL.md" "name: multi-agent-working-group" \
  && contains "SKILL.md" "description:"; then
  pass "SKILL.md frontmatter"
else
  fail "SKILL.md frontmatter"
fi

version_files=(
  "README.md"
  "CHANGELOG.md"
  "docs/TODO.md"
  "docs/ROADMAP.md"
  "docs/VALIDATION.md"
  "SKILL.md"
)

for file in "${version_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    fail "$file exists"
  fi
done

if [[ -f "README.md" ]] && contains "README.md" "Current local version: \`$VERSION\`"; then
  pass "README.md current version marker"
else
  fail "README.md current version marker"
fi

if [[ -f "CHANGELOG.md" ]] && contains "CHANGELOG.md" "Completed local upgrade for $VERSION"; then
  pass "CHANGELOG.md current upgrade marker"
else
  fail "CHANGELOG.md current upgrade marker"
fi

if [[ -f "docs/TODO.md" ]] && contains "docs/TODO.md" "## $VERSION: Leader Rollover Opportunity Protocol"; then
  pass "docs/TODO.md current version section"
else
  fail "docs/TODO.md current version section"
fi

if [[ -f "docs/ROADMAP.md" ]] && contains "docs/ROADMAP.md" "\`$VERSION\` Leader Rollover Opportunity Protocol"; then
  pass "docs/ROADMAP.md current version marker"
else
  fail "docs/ROADMAP.md current version marker"
fi

if [[ -f "docs/VALIDATION.md" ]] && contains "docs/VALIDATION.md" "## $VERSION Leader Rollover Opportunity Protocol Checks"; then
  pass "docs/VALIDATION.md current validation section"
else
  fail "docs/VALIDATION.md current validation section"
fi

if [[ -f "SKILL.md" ]] && contains "SKILL.md" "Rollover Opportunity"; then
  pass "SKILL.md current rollover opportunity marker"
else
  fail "SKILL.md current rollover opportunity marker"
fi

for spec in "${REQUIRED_ACCEPTED_SPECS[@]}"; do
  if [[ -f "openspec/specs/$spec/spec.md" ]]; then
    pass "accepted spec exists: $spec"
  else
    fail "accepted spec exists: $spec"
  fi
done

if [[ -f "openspec/specs/$ROLLOVER_SPEC/spec.md" ]]; then
  pass "accepted spec exists: $ROLLOVER_SPEC"
elif [[ "$require_no_active_changes" -eq 0 && -f "$ROLLOVER_CHANGE" ]]; then
  pass "active spec delta exists: $ROLLOVER_SPEC"
else
  fail "accepted spec exists: $ROLLOVER_SPEC"
fi

for template in "${REQUIRED_TEMPLATES[@]}"; do
  if [[ "$template" == "templates/README.md" ]]; then
    version_marker="Version: $VERSION recommended templates."
  else
    version_marker="Version: $VERSION recommended template."
  fi

  if [[ -f "$template" ]] && contains "$template" "$version_marker"; then
    pass "template exists with version marker: $template"
  else
    fail "template exists with version marker: $template"
  fi
done

template_contains "templates/README.md" "A filled template is evidence, not authority." "templates README states evidence not authority"
template_contains "templates/README.md" "successor startup packet != automatic thread creation" "templates README blocks automatic thread creation"
template_contains "templates/README.md" "one active current-state card" "templates README keeps single active state card"
template_contains "templates/README.md" "Do not bulk-rewrite old v0.3 or earlier handoffs" "templates README preserves legacy documents"
template_contains "templates/README.md" "stale until re-verified" "templates README uses stale freshness label"
template_contains "templates/README.md" "historical only" "templates README uses historical freshness label"
template_contains "templates/README.md" "Do not use it as authorization for commit, push, scope expansion, gate bypass, or external effects." "templates README blocks legacy authorization"
template_contains "templates/pm-review.md" "P0:" "PM template preserves P0"
template_contains "templates/pm-review.md" "P1:" "PM template preserves P1"
template_contains "templates/pm-review.md" "Owner-recorded role authorization source:" "PM template records trust authorization source"
template_contains "templates/pm-review.md" "owner-recorded-role-authorized" "PM template records trust state vocabulary"
template_contains "templates/pm-review.md" "owner-confirmation-needed" "PM template records owner confirmation trust state"
template_contains "templates/advisor-review.md" "Reviewed before PM conclusions" "Advisor template records independence"
template_contains "templates/advisor-review.md" "P0:" "Advisor template preserves P0"
template_contains "templates/advisor-review.md" "P1:" "Advisor template preserves P1"
template_contains "templates/advisor-review.md" "Read-only probe passed before relying on CLI output:" "Advisor template records trust probe challenge"
template_contains "templates/advisor-review.md" "dangerous permission bypass" "Advisor template checks dangerous permission bypass"
template_contains "templates/advisor-review.md" "owner-confirmation-needed" "Advisor template records owner confirmation trust state"
template_contains "templates/worker-assignment.md" "Do not expand scope." "Worker assignment blocks scope expansion"
template_contains "templates/worker-assignment.md" "Do not self-approve." "Worker assignment blocks self approval"
template_contains "templates/worker-assignment.md" "Do not commit or push." "Worker assignment blocks git actions"
template_contains "templates/reviewer-report.md" "block; Reviewer must not review their own implementation" "Reviewer template blocks self review"
template_contains "templates/blocked-report.md" "Do not bypass PM/Advisor/Reviewer, validation, secret-scan, CI/status, or git gates." "Blocked template blocks gate bypass"
template_contains "templates/blocked-report.md" "owner-confirmation-needed" "Blocked template records owner confirmation need"
template_contains "templates/blocked-report.md" "trusted-verified | owner-confirmation-needed | blocked" "Blocked template records owner confirmation trust state"
template_contains "templates/blocked-report.md" "Why current authorization is insufficient:" "Blocked template records insufficient authorization reason"
template_contains "templates/c0-goal-analysis.md" "Owner-recorded role authorization source:" "C0 template records trust authorization source"
template_contains "templates/c0-goal-analysis.md" "Post-setup read-only probe:" "C0 template records trust probe"
template_contains "templates/compact-handoff.md" "current | stale until re-verified | historical only" "Compact handoff uses freshness labels"
template_contains "templates/compact-handoff.md" "verified | inferred | unverified" "Compact handoff uses verification labels"
template_contains "templates/compact-handoff.md" "Rollover Opportunity" "Compact handoff includes rollover opportunity state"
template_contains "templates/compact-handoff.md" "Compression count value:" "Compact handoff includes compression count value"
template_contains "templates/compact-handoff.md" "Compression count source:" "Compact handoff includes compression count source"
template_contains "templates/compact-handoff.md" "Compression count confidence:" "Compact handoff includes compression count confidence"
template_contains "templates/compact-handoff.md" "exactly one state; highest applicable state wins" "Compact handoff includes canonical state rule"
template_contains "templates/compact-handoff.md" "not a separate state machine" "Compact handoff blocks dashboard state machine"
template_contains "templates/compact-handoff.md" "Rollover Strongly Recommended" "Compact handoff includes strong recommendation state"
template_contains "templates/compact-handoff.md" "Frozen active current-state card:" "Compact handoff keeps single active state card"
template_contains "templates/compact-handoff.md" "Task status dashboard:" "Compact handoff includes task status dashboard"
template_contains "templates/compact-handoff.md" "Pending messages, conflicts, and overlaps:" "Compact handoff includes pending messages and conflicts"
template_contains "templates/successor-startup-packet.md" "successor startup packet != automatic thread creation" "Successor packet blocks automatic thread creation"
template_contains "templates/successor-startup-packet.md" "Rollover Opportunity" "Successor packet includes rollover opportunity state"
template_contains "templates/successor-startup-packet.md" "Compression count value:" "Successor packet includes compression count value"
template_contains "templates/successor-startup-packet.md" "Compression count source:" "Successor packet includes compression count source"
template_contains "templates/successor-startup-packet.md" "not inherited; successor must re-verify before acting" "Successor packet blocks inherited authorization action"
template_contains "templates/successor-startup-packet.md" "Successor Verification Checklist" "Successor packet includes verification checklist"
template_contains "templates/successor-startup-packet.md" "Commit/push/CI/archive authorization state is not inherited" "Successor packet blocks inherited authorization"
template_contains "templates/successor-startup-packet.md" "Lightweight Handoff Dashboard" "Successor packet includes dashboard"
template_contains "templates/successor-startup-packet.md" "Pending messages:" "Successor packet includes pending messages"
template_contains "templates/successor-startup-packet.md" "Conflicts and overlaps:" "Successor packet includes conflicts and overlaps"
template_contains "templates/git-gate.md" "Secret/credential scan:" "Git gate template includes secret scan"
template_contains "templates/git-gate.md" "CI/status:" "Git gate template includes CI status"

template_contains "docs/VALIDATION.md" "successor packet != automatic thread creation" "Validation blocks successor thread automation creep"
template_contains "docs/VALIDATION.md" "Rollover Opportunity" "Validation checks rollover opportunity"
template_contains "docs/VALIDATION.md" "exactly one canonical ContextBudget state" "Validation checks canonical state rule"
template_contains "docs/VALIDATION.md" "Platform-visible summaries are not described as actual total compaction counts" "Validation blocks visible-summary actual count claim"
template_contains "docs/VALIDATION.md" "clean boundary plus a heavier next step" "Validation checks opportunity combination trigger"
template_contains "docs/VALIDATION.md" "Same-workstream PM plus Advisor gate automation" "Validation preserves PM Advisor gate automation"
template_contains "docs/VALIDATION.md" "Historical gate state is recorded as evidence only" "Validation blocks successor authorization inheritance"
template_contains "docs/VALIDATION.md" "Dashboard fields remain evidence inputs" "Validation blocks dashboard state machine"
template_contains "docs/VALIDATION.md" "hidden Worker execution" "Validation checks Leader delegation discipline"
template_contains "docs/VALIDATION.md" "0-1, 2, 3-4, 5-6, 7, 8+" "Validation checks rollover thresholds"
template_contains "docs/VALIDATION.md" "Owner-recorded CLI role assignment is described as current-project workspace trust setup authorization" "Validation checks owner-recorded trust authorization"
template_contains "docs/VALIDATION.md" "Stale, historical-only, superseded, or mismatched role records do not authorize trust setup." "Validation blocks stale trust authorization"
template_contains "docs/VALIDATION.md" "A workspace-trust failure first checks whether applicable Owner-recorded role authorization permits current-project trust setup" "Validation blocks old direct trust-blocked wording"
template_contains "docs/VALIDATION.md" "Trust-state template fields also include \`owner-confirmation-needed\`" "Validation checks owner confirmation trust state templates"
template_contains "docs/VALIDATION.md" "Examples do not teach the old behavior" "Validation checks examples for stale trust flow"
template_contains "examples/openspec-c0-c4-task.md" "first check whether an Owner-recorded role assignment applies" "Example checks Owner-recorded trust before blocking"
template_contains "examples/openspec-c0-c4-task.md" "Blocked by:" "Example uses blocked report structure"
template_contains "examples/openspec-c0-c4-task.md" "Trust state:" "Example records trust state"
template_contains "examples/openspec-c0-c4-task.md" "owner-recorded-role-authorized" "Example includes authorized trust setup state"
template_contains "examples/rollover-opportunity.md" "Owner-reported actual compression count:" "Rollover opportunity example includes owner-reported undercount"
template_contains "examples/rollover-opportunity.md" "state is Rollover Required, not Rollover Opportunity" "Rollover opportunity example escalates threshold conflict"
template_contains "examples/rollover-opportunity.md" "Platform-visible summary count: 1" "Rollover opportunity example includes platform-visible count"
template_contains "examples/rollover-opportunity.md" "exactly one state; highest applicable state wins" "Rollover opportunity example includes canonical state rule"
template_contains "examples/rollover-opportunity.md" "not a separate state machine" "Rollover opportunity example blocks dashboard state machine"
template_contains "examples/rollover-opportunity.md" "no commit/push/CI/archive authorization is inherited" "Rollover opportunity example blocks inherited authorization"
template_contains "examples/compact-handoff.md" "Compression count value:" "Compact handoff example uses compression count value"
template_contains "examples/compact-handoff.md" "Compression count source:" "Compact handoff example uses compression count source"
template_contains "SKILL.md" "current Owner instruction, global memory, project rule, project memory, handoff, startup packet, continuity record, ledger, template, or verified OpenSpec evidence" "SKILL.md defines trust authorization sources"
template_contains "SKILL.md" "owner-recorded-role-authorized" "SKILL.md defines trust setup state"
template_contains "SKILL.md" "post-setup read-only probe succeeds" "SKILL.md requires trust probe before verified state"
template_contains "SKILL.md" "Do not use dangerous permission-bypass flags" "SKILL.md blocks dangerous permission bypass"
template_contains "SKILL.md" "Every context-budget check must record exactly one canonical ContextBudget state" "SKILL.md defines canonical state rule"
template_contains "SKILL.md" "Platform-visible summaries are evidence of what the Leader can see" "SKILL.md blocks visible summary actual count claim"
template_contains "SKILL.md" "Owner-reported threshold evidence" "SKILL.md treats owner-reported concrete counts as threshold evidence"
template_contains "SKILL.md" "Clean boundary plus heavier next step" "SKILL.md defines opportunity combination trigger"
template_contains "SKILL.md" "normal non-high-risk commit, push, CI/status, and archive progression may continue" "SKILL.md preserves PM Advisor gate automation"
template_contains "SKILL.md" "Rollover or successor packets do not carry that authorization into a successor context" "SKILL.md blocks successor authorization inheritance"
template_contains "SKILL.md" "For Medium, Complex, High-risk, implementation-heavy, or substantively" "SKILL.md defines Leader delegation discipline"
template_contains "SKILL.md" "6 or more observed compressions/summaries plus a next action of Worker" "SKILL.md defines gate rollover threshold"
template_contains "SKILL.md" "3-4 observed compressions/summaries" "SKILL.md replaces ambiguous multiple compression wording"
template_contains "SKILL.md" "5-6 observed compressions/summaries" "SKILL.md defines recommended threshold"

if command -v openspec >/dev/null 2>&1; then
  if openspec_list="$(openspec list --json 2>&1)"; then
    pass "openspec list --json"

    if printf '%s\n' "$openspec_list" | grep -Eq '"changes"[[:space:]]*:[[:space:]]*\[\]'; then
      pass "no active OpenSpec changes"
    elif [[ "$require_no_active_changes" -eq 1 ]]; then
      fail "no active OpenSpec changes"
    else
      warn "active OpenSpec changes exist"
    fi
  else
    fail "openspec list --json"
  fi

  if openspec validate --all >/dev/null; then
    pass "openspec validate --all"
  else
    fail "openspec validate --all"
  fi
else
  fail "openspec CLI is available"
fi

global_skill="${HOME}/.codex/skills/multi-agent-working-group/SKILL.md"
if [[ "$skip_global_skill" -eq 1 ]]; then
  warn "global SKILL.md comparison skipped"
elif [[ -f "$global_skill" ]]; then
  if cmp -s "SKILL.md" "$global_skill"; then
    pass "global SKILL.md matches repo SKILL.md"
  else
    fail "global SKILL.md matches repo SKILL.md"
  fi
else
  warn "global SKILL.md not found at $global_skill"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\n%d local validation check(s) failed.\n' "$failures" >&2
  exit 1
fi

printf '\nLocal validation passed.\n'
