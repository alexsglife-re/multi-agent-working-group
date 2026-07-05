#!/usr/bin/env bash
set -euo pipefail

VERSION="v0.4.15"
CURRENT_UPGRADE_TITLE="Fast Path And Anchor Guardrails"
CURRENT_VALIDATION_TITLE="Fast Path And Anchor Guardrail Checks"
SKILL_ANCHOR_BASELINE=55
TEMPLATE_VERSION="v0.4.13"
REQUIRED_ACCEPTED_SPECS=(
  "adoption-guidance"
  "advisor-model-diversity"
  "cli-trust-and-openspec-lifecycle"
  "copyable-role-templates"
  "leader-state-compaction"
  "local-validation-tool"
  "platform-adapter-guidance"
  "role-boundary-stabilization"
)
REQUIRED_REFERENCES=(
  "references/TRACEABILITY.md"
  "references/cli-trust.md"
  "references/context-rollover.md"
  "references/git-exit-rules.md"
  "references/openspec-lifecycle.md"
  "references/role-templates-and-output.md"
)
ROLLOVER_SPEC="leader-rollover-protocol"
ROLLOVER_CHANGE="openspec/changes/add-rollover-opportunity-protocol/specs/leader-rollover-protocol/spec.md"
AGENT_CLEANUP_SPEC="agent-cleanup-discipline"
AGENT_CLEANUP_CHANGE="openspec/changes/add-leader-delegation-and-cleanup-discipline/specs/agent-cleanup-discipline/spec.md"
ADOPTION_GUIDANCE_SPEC="adoption-guidance"
ADOPTION_GUIDANCE_CHANGE="openspec/changes/add-adoption-scenarios-and-adapter-guardrails/specs/adoption-guidance/spec.md"
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
  "docs/INSTALLATION.md"
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

if [[ -f "docs/TODO.md" ]] && contains "docs/TODO.md" "## $VERSION: $CURRENT_UPGRADE_TITLE"; then
  pass "docs/TODO.md current version section"
else
  fail "docs/TODO.md current version section"
fi

if [[ -f "docs/ROADMAP.md" ]] && contains "docs/ROADMAP.md" "\`$VERSION\` $CURRENT_UPGRADE_TITLE"; then
  pass "docs/ROADMAP.md current version marker"
else
  fail "docs/ROADMAP.md current version marker"
fi

if [[ -f "docs/VALIDATION.md" ]] && contains "docs/VALIDATION.md" "## $VERSION $CURRENT_VALIDATION_TITLE"; then
  pass "docs/VALIDATION.md current validation section"
else
  fail "docs/VALIDATION.md current validation section"
fi

if [[ -f "SKILL.md" ]] && contains "SKILL.md" "provider-level separation"; then
  pass "SKILL.md current provider separation marker"
else
  fail "SKILL.md current provider separation marker"
fi

for spec in "${REQUIRED_ACCEPTED_SPECS[@]}"; do
  if [[ "$spec" == "$ADOPTION_GUIDANCE_SPEC" && "$require_no_active_changes" -eq 0 && -f "$ADOPTION_GUIDANCE_CHANGE" ]]; then
    pass "active spec delta exists: $spec"
  elif [[ -f "openspec/specs/$spec/spec.md" ]]; then
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

if [[ -f "openspec/specs/$AGENT_CLEANUP_SPEC/spec.md" ]]; then
  pass "accepted spec exists: $AGENT_CLEANUP_SPEC"
elif [[ "$require_no_active_changes" -eq 0 && -f "$AGENT_CLEANUP_CHANGE" ]]; then
  pass "active spec delta exists: $AGENT_CLEANUP_SPEC"
else
  fail "accepted spec exists: $AGENT_CLEANUP_SPEC"
fi

for template in "${REQUIRED_TEMPLATES[@]}"; do
  if [[ "$template" == "templates/README.md" ]]; then
    version_marker="Version: $TEMPLATE_VERSION recommended templates."
  else
    version_marker="Version: $TEMPLATE_VERSION recommended template."
  fi

  if [[ -f "$template" ]] && contains "$template" "$version_marker"; then
    pass "template exists with version marker: $template"
  else
    fail "template exists with version marker: $template"
  fi
done

for reference in "${REQUIRED_REFERENCES[@]}"; do
  if [[ -f "$reference" ]]; then
    pass "reference exists: $reference"
  else
    fail "reference exists: $reference"
  fi
done

if ! command -v perl >/dev/null 2>&1; then
  fail "perl available for English-only docs check"
else
  pass "perl available for English-only docs check"
  cjk_docs="$(
    while IFS= read -r -d '' file; do
      [[ -f "$file" ]] || continue
      perl -CSD -ne 'print "$ARGV:$.:$_" if /[\x{3000}-\x{303F}\x{3040}-\x{30FF}\x{3400}-\x{4DBF}\x{4E00}-\x{9FFF}\x{AC00}-\x{D7AF}\x{F900}-\x{FAFF}]/' "$file"
    done < <(git ls-files -z '*.md')
  )"
  if [[ -z "$cjk_docs" ]]; then
    pass "tracked Markdown docs are English-only"
  else
    fail "tracked Markdown docs are English-only"
    printf '%s\n' "$cjk_docs" >&2
  fi
fi

template_contains "templates/README.md" "A filled template is evidence, not authority." "templates README states evidence not authority"
template_contains "templates/README.md" "successor startup packet != automatic thread creation" "templates README blocks automatic thread creation"
template_contains "templates/README.md" "one active current-state card" "templates README keeps single active state card"
template_contains "templates/README.md" "Do not bulk-rewrite old v0.3 or earlier handoffs" "templates README preserves legacy documents"
template_contains "templates/README.md" "stale until re-verified" "templates README uses stale freshness label"
template_contains "templates/README.md" "historical only" "templates README uses historical freshness label"
template_contains "templates/README.md" "Do not use it as authorization for commit, push, scope expansion, gate bypass, or external effects." "templates README blocks legacy authorization"
template_contains "templates/README.md" "model preferences as hints to verify" "templates README treats model preferences as hints"
template_contains "templates/README.md" "provider-separated" "templates README records provider-separated status"
template_contains "templates/README.md" "same-provider model/version variants are degraded or partial separation" "templates README degrades same-provider variants"
template_contains "templates/README.md" "Do not treat short silence as failure" "templates README preserves lifecycle patience"
template_contains "templates/README.md" "Role-agent cleanup status fields are evidence only." "templates README treats cleanup status as evidence"
template_contains "templates/README.md" "Worker-first context control fields" "templates README documents Worker-first fields"
template_contains "templates/pm-review.md" "P0:" "PM template preserves P0"
template_contains "templates/pm-review.md" "P1:" "PM template preserves P1"
template_contains "templates/pm-review.md" "Owner-recorded role authorization source:" "PM template records trust authorization source"
template_contains "templates/pm-review.md" "owner-recorded-role-authorized" "PM template records trust state vocabulary"
template_contains "templates/pm-review.md" "owner-confirmation-needed" "PM template records owner confirmation trust state"
template_contains "templates/pm-review.md" "Provider/model:" "PM template records provider/model"
template_contains "templates/pm-review.md" "Model source:" "PM template records model source"
template_contains "templates/pm-review.md" "Lifecycle patience:" "PM template records lifecycle patience"
template_contains "templates/pm-review.md" "Expected wait/recheck behavior:" "PM template records wait behavior"
template_contains "templates/advisor-review.md" "Reviewed before PM conclusions" "Advisor template records independence"
template_contains "templates/advisor-review.md" "P0:" "Advisor template preserves P0"
template_contains "templates/advisor-review.md" "P1:" "Advisor template preserves P1"
template_contains "templates/advisor-review.md" "Provider/model:" "Advisor template records provider/model"
template_contains "templates/advisor-review.md" "Model diversity/separation status:" "Advisor template records separation status"
template_contains "templates/advisor-review.md" "same-provider-variant degraded" "Advisor template degrades same-provider variants"
template_contains "templates/advisor-review.md" "Lifecycle patience:" "Advisor template records lifecycle patience"
template_contains "templates/advisor-review.md" "Expected wait/recheck behavior:" "Advisor template records wait behavior"
template_contains "templates/advisor-review.md" "Read-only probe passed before relying on CLI output:" "Advisor template records trust probe challenge"
template_contains "templates/advisor-review.md" "dangerous permission bypass" "Advisor template checks dangerous permission bypass"
template_contains "templates/advisor-review.md" "owner-confirmation-needed" "Advisor template records owner confirmation trust state"
template_contains "templates/worker-assignment.md" "Do not expand scope." "Worker assignment blocks scope expansion"
template_contains "templates/worker-assignment.md" "Do not self-approve." "Worker assignment blocks self approval"
template_contains "templates/worker-assignment.md" "Do not commit or push." "Worker assignment blocks git actions"
template_contains "templates/worker-assignment.md" "Do not treat short silence as failure" "Worker assignment preserves lifecycle patience"
template_contains "templates/worker-assignment.md" "Expected wait/recheck behavior:" "Worker assignment records wait behavior"
template_contains "templates/worker-assignment.md" "Delegation trigger:" "Worker assignment records delegation trigger"
template_contains "templates/worker-assignment.md" "Worker-first context control | Leader work-budget self-check" "Worker assignment records budget-triggered Worker dispatch"
template_contains "templates/worker-assignment.md" "Stop conditions:" "Worker assignment records stop conditions"
template_contains "templates/worker-assignment.md" "Cleanup or handoff expectations:" "Worker assignment records cleanup or handoff expectations"
template_contains "templates/worker-assignment.md" "Raw output summarized and evidence referenced:" "Worker assignment records raw-output summary state"
template_contains "templates/worker-return.md" "Lifecycle patience:" "Worker return records lifecycle patience"
template_contains "templates/worker-return.md" "Cleanup or handoff issues remaining:" "Worker return records cleanup or handoff issues"
template_contains "templates/worker-return.md" "Raw output summarized and evidence referenced:" "Worker return records raw-output summary state"
template_contains "templates/reviewer-report.md" "block; Reviewer must not review their own implementation" "Reviewer template blocks self review"
template_contains "templates/blocked-report.md" "Do not bypass PM/Advisor/Reviewer, validation, secret-scan, CI/status, or git gates." "Blocked template blocks gate bypass"
template_contains "templates/blocked-report.md" "owner-confirmation-needed" "Blocked template records owner confirmation need"
template_contains "templates/blocked-report.md" "trusted-verified | owner-confirmation-needed | blocked" "Blocked template records owner confirmation trust state"
template_contains "templates/blocked-report.md" "Why current authorization is insufficient:" "Blocked template records insufficient authorization reason"
template_contains "templates/blocked-report.md" "Lifecycle patience blocker" "Blocked template records lifecycle patience blocker"
template_contains "templates/c0-goal-analysis.md" "Owner-recorded role authorization source:" "C0 template records trust authorization source"
template_contains "templates/c0-goal-analysis.md" "Post-setup read-only probe:" "C0 template records trust probe"
template_contains "templates/c0-goal-analysis.md" "Provider/model:" "C0 template records provider/model"
template_contains "templates/c0-goal-analysis.md" "Model source:" "C0 template records model source"
template_contains "templates/c0-goal-analysis.md" "Source freshness/current verification:" "C0 template records model source freshness"
template_contains "templates/c0-goal-analysis.md" "same-provider-variant degraded" "C0 template degrades same-provider variants"
template_contains "templates/c0-goal-analysis.md" "Current verified model record:" "C0 template records current verified model record"
template_contains "templates/c0-goal-analysis.md" "PM/Advisor lifecycle patience:" "C0 template records PM Advisor lifecycle patience"
template_contains "templates/c0-goal-analysis.md" "do not close for short silence" "C0 template blocks short-silence closure"
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
template_contains "templates/compact-handoff.md" "Provider/model per role:" "Compact handoff records provider/model per role"
template_contains "templates/compact-handoff.md" "Model source per role:" "Compact handoff records model source per role"
template_contains "templates/compact-handoff.md" "Source freshness/current verification:" "Compact handoff records source freshness"
template_contains "templates/compact-handoff.md" "same-provider-variant degraded" "Compact handoff degrades same-provider variants"
template_contains "templates/compact-handoff.md" "Current verified model record:" "Compact handoff records current verified model record"
template_contains "templates/compact-handoff.md" "Lifecycle patience:" "Compact handoff records PM Advisor lifecycle patience"
template_contains "templates/compact-handoff.md" "Worker lifecycle patience:" "Compact handoff records Worker lifecycle patience"
template_contains "templates/compact-handoff.md" "Role cleanup status:" "Compact handoff records cleanup status"
template_contains "templates/compact-handoff.md" "Cleanup result by role:" "Compact handoff records cleanup result by role"
template_contains "templates/compact-handoff.md" "Delivery-evidence impact:" "Compact handoff records cleanup delivery impact"
template_contains "templates/compact-handoff.md" "If non-blocking cleanup failure:" "Compact handoff records non-blocking cleanup rationale"
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
template_contains "templates/successor-startup-packet.md" "Provider/model per role:" "Successor packet records provider/model per role"
template_contains "templates/successor-startup-packet.md" "Model source per role:" "Successor packet records model source per role"
template_contains "templates/successor-startup-packet.md" "Source freshness/current verification:" "Successor packet records source freshness"
template_contains "templates/successor-startup-packet.md" "same-provider-variant degraded" "Successor packet degrades same-provider variants"
template_contains "templates/successor-startup-packet.md" "Current verified model record:" "Successor packet records current verified model record"
template_contains "templates/successor-startup-packet.md" "Lifecycle patience:" "Successor packet records PM Advisor lifecycle patience"
template_contains "templates/successor-startup-packet.md" "Worker lifecycle patience:" "Successor packet records Worker lifecycle patience"
template_contains "templates/successor-startup-packet.md" "Role cleanup status:" "Successor packet records cleanup status"
template_contains "templates/successor-startup-packet.md" "Cleanup result by role:" "Successor packet records cleanup result by role"
template_contains "templates/successor-startup-packet.md" "Delivery-evidence impact:" "Successor packet records cleanup delivery impact"
template_contains "templates/successor-startup-packet.md" "If non-blocking cleanup failure:" "Successor packet records non-blocking cleanup rationale"
template_contains "templates/git-gate.md" "Secret/credential scan:" "Git gate template includes secret scan"
template_contains "templates/git-gate.md" "CI/status:" "Git gate template includes CI status"
template_contains "templates/git-gate.md" "Provider/model:" "Git gate template records provider/model"
template_contains "templates/git-gate.md" "Separation/diversity status:" "Git gate template records separation status"

template_contains "docs/VALIDATION.md" "successor packet != automatic thread creation" "Validation blocks successor thread automation creep"
template_contains "docs/VALIDATION.md" "Rollover Opportunity" "Validation checks rollover opportunity"
template_contains "docs/VALIDATION.md" "exactly one canonical ContextBudget state" "Validation checks canonical state rule"
template_contains "docs/VALIDATION.md" "Platform-visible summaries are not described as actual total compaction counts" "Validation blocks visible-summary actual count claim"
template_contains "docs/VALIDATION.md" "clean boundary plus a heavier next step" "Validation checks opportunity combination trigger"
template_contains "docs/VALIDATION.md" "Same-workstream PM plus Advisor gate automation" "Validation preserves PM Advisor gate automation"
template_contains "docs/VALIDATION.md" "Historical gate state is recorded as evidence only" "Validation blocks successor authorization inheritance"
template_contains "docs/VALIDATION.md" "Dashboard fields remain evidence inputs" "Validation blocks dashboard state machine"
template_contains "docs/VALIDATION.md" "hidden Worker execution" "Validation checks Leader delegation discipline"
template_contains "docs/VALIDATION.md" "Provider Separation, Agent Patience, And Migration Guidance Checks" "Validation checks v0.4.9 provider separation section"
template_contains "docs/VALIDATION.md" "provider-level separation" "Validation checks provider-level separation"
template_contains "docs/VALIDATION.md" "same-provider model names, versions, families, or capability tiers" "Validation degrades same-provider variants"
template_contains "docs/VALIDATION.md" "current verified model record" "Validation checks current verified model record"
template_contains "docs/VALIDATION.md" "does not hard-code concrete model names" "Validation keeps skill model-agnostic"
template_contains "docs/VALIDATION.md" "short silence during substantive review" "Validation preserves PM Advisor patience"
template_contains "docs/VALIDATION.md" "substantive bounded Worker slices use the same evidence-based patience principle" "Validation preserves Worker patience"
template_contains "docs/VALIDATION.md" "automatic timers, polling loops" "Validation blocks patience automation creep"
template_contains "docs/VALIDATION.md" "Installation and migration guidance covers local checkout use" "Validation checks installation guide coverage"
template_contains "docs/VALIDATION.md" "does not imply packaging automation" "Validation blocks migration automation creep"
template_contains "docs/VALIDATION.md" "Invocation, Migration, And Plain-Language Closeout Guidance Checks" "Validation checks v0.4.10 invocation section"
template_contains "docs/VALIDATION.md" "Automatic invocation is described as workflow/checklist reasoning only." "Validation checks automatic invocation boundary"
template_contains "docs/VALIDATION.md" "never creates external effects or transfers authority" "Validation blocks invocation authority transfer"
template_contains "docs/VALIDATION.md" "Remaining uncertainty or skipped checks are mandatory closeout fields" "Validation checks mandatory skipped-check closeout"
template_contains "docs/VALIDATION.md" "explicit current-session authorization" "Validation checks current-session next-goal authorization"
template_contains "docs/VALIDATION.md" "Platform-Neutral Protocol Positioning Checks" "Validation checks v0.4.11 platform-neutral section"
template_contains "docs/VALIDATION.md" "portable workflow protocol for" "Validation checks protocol positioning"
template_contains "docs/VALIDATION.md" "reference packaged adapter" "Validation checks reference adapter wording"
template_contains "docs/VALIDATION.md" "planned adapter guidance or compatible patterns until validated" "Validation blocks unvalidated adapter support claims"
template_contains "docs/VALIDATION.md" "Adapter maturity labels distinguish" "Validation checks adapter maturity labels"
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
template_contains "SKILL.md" "Provider-level separation means different service providers" "SKILL.md defines provider-level separation"
template_contains "SKILL.md" "same-provider-variant" "SKILL.md defines same-provider variant status"
template_contains "SKILL.md" "hints to verify against the current workstream" "SKILL.md treats model records as hints to verify"
template_contains "SKILL.md" "A current verified model record applies to the exact current project" "SKILL.md defines current verified model record"
template_contains "SKILL.md" "Do not claim PM/Advisor independence was strengthened" "SKILL.md blocks same-provider diversity overclaim"
template_contains "SKILL.md" "Do not treat short silence or a brief lack of visible output as task failure" "SKILL.md preserves PM Advisor patience"
template_contains "SKILL.md" "Worker lifecycle uses the same evidence-based patience principle" "SKILL.md preserves Worker patience"
template_contains "SKILL.md" "Close, restart, or replace PM/Advisor only when there is a recorded lifecycle reason" "SKILL.md requires lifecycle closure reason"
template_contains "SKILL.md" "Role-agent cleanup or close actions run sequentially" "SKILL.md requires sequential role-agent cleanup"
template_contains "SKILL.md" "Cleanup/close means role-agent teardown or lifecycle hygiene only" "SKILL.md defines cleanup narrowly"
template_contains "SKILL.md" "delivery evidence is already confirmed from evidence in hand" "SKILL.md requires cleanup evidence already in hand"
template_contains "SKILL.md" "Do not classify validation, PM/Advisor/Reviewer, git, CI/status, secret-scan, release/tag, or authorization failure as non-blocking cleanup." "SKILL.md blocks cleanup gate mislabel"
template_contains "SKILL.md" "Cleanup failure is blocking when it prevents confirming task state, git state, validation state, CI/status state, secret safety, authorization state, or required role evidence." "SKILL.md escalates cleanup evidence blockers"
template_contains "SKILL.md" "More than 2 files or roughly 80 diff lines is a self-check trigger rather than an automatic correctness failure" "SKILL.md defines Leader budget as self-check"
template_contains "SKILL.md" "dispatch a bounded Worker or record a concrete exception" "SKILL.md requires Worker dispatch or exception"
template_contains "SKILL.md" "Worker-first context control" "SKILL.md defines Worker-first context control"
template_contains "SKILL.md" "Use or explicitly consider \`multi-agent-working-group\`" "SKILL.md defines invocation triggers"
template_contains "SKILL.md" "Automatic invocation means applying this workflow and checklist" "SKILL.md defines automatic invocation as checklist"
template_contains "SKILL.md" "never creates external effects or transfers authority" "SKILL.md blocks invocation authority transfer"
template_contains "SKILL.md" "Scale the workflow to the task size" "SKILL.md scales workflow to task size"
template_contains "SKILL.md" "What remains uncertain or was not checked:" "SKILL.md requires uncertainty closeout"
template_contains "SKILL.md" "explicit current-session authorization" "SKILL.md requires current-session next-goal authorization"
template_contains "SKILL.md" "independent first-pass / no-peek review" "SKILL.md preserves PM Advisor no-peek independence"
template_contains "SKILL.md" "Missing required PM or Advisor evidence fails closed" "SKILL.md preserves missing PM Advisor fail-closed behavior"
template_contains "SKILL.md" "Advisor output is unverified evidence rather than authority" "SKILL.md preserves Advisor evidence boundary"
template_contains "SKILL.md" "old handoff, successor packet, template, memory, or previous consensus is evidence for Leader verification, not authorization by itself" "SKILL.md preserves handoff evidence boundary"
template_contains "SKILL.md" "MUST read \`references/git-exit-rules.md\` before commit, push, tag, release" "SKILL.md routes git and release reference"
template_contains "SKILL.md" "MUST read \`references/openspec-lifecycle.md\` before OpenSpec proposal" "SKILL.md routes OpenSpec reference"
template_contains "SKILL.md" "MUST read \`references/cli-trust.md\` before relying on Claude CLI" "SKILL.md routes CLI trust reference"
template_contains "SKILL.md" "MUST read \`references/context-rollover.md\` before context rollover" "SKILL.md routes rollover reference"
template_contains "SKILL.md" "MUST read \`references/role-templates-and-output.md\` before dispatching PM" "SKILL.md routes role output reference"
template_contains "SKILL.md" "Reference files extend this file; they cannot weaken it" "SKILL.md blocks reference authority weakening"
template_contains "SKILL.md" "If a required reference is missing or unread for an affected domain, stop before acting in that domain." "SKILL.md fails closed when reference missing"
template_contains "references/TRACEABILITY.md" "All current \`template_contains \"SKILL.md\"\` hard-boundary anchor phrases remain in \`SKILL.md\`" "Traceability preserves SKILL anchors"
template_contains "references/TRACEABILITY.md" "PM and Advisor expected output is independent first-pass / no-peek review before consensus." "Traceability records PM Advisor independence anchor"
template_contains "references/TRACEABILITY.md" "Advisor output is unverified evidence rather than authority." "Traceability records Advisor evidence anchor"
template_contains "references/TRACEABILITY.md" "Handoff or prior agent output is evidence rather than authorization." "Traceability records handoff evidence anchor"
template_contains "references/TRACEABILITY.md" "Role-agent cleanup or close actions run sequentially, never in parallel." "Traceability records sequential cleanup anchor"
template_contains "references/TRACEABILITY.md" "More than 2 files or roughly 80 diff lines is a self-check trigger" "Traceability records Leader work-budget anchor"
template_contains "references/TRACEABILITY.md" "Local validation checks anchor presence and template consistency, not runtime" "Traceability records validation anchor limits"
template_contains "references/git-exit-rules.md" "Default exclusions unless owner explicitly names the exception" "Git reference preserves default exclusions"
template_contains "references/git-exit-rules.md" "Normal non-high-risk push may proceed after PM + Advisor consensus" "Git reference preserves push gate"
template_contains "references/openspec-lifecycle.md" "Use this sequence whenever this skill and OpenSpec are both active" "OpenSpec reference preserves C0-C4 lifecycle"
template_contains "references/cli-trust.md" "Do not use dangerous permission-bypass flags" "CLI trust reference preserves dangerous flag ban"
template_contains "references/context-rollover.md" "Rollover or successor packets do not carry that authorization into a successor context" "Rollover reference preserves non-inherited authorization"
template_contains "references/context-rollover.md" "dispatch bounded Worker slices earlier" "Rollover reference adds Worker-first context control"
template_contains "references/context-rollover.md" "before Leader context grows toward rollover pressure" "Rollover reference prevents Leader context growth"
template_contains "references/context-rollover.md" "Worker-first context control does not require Worker dispatch for narrow" "Rollover reference preserves narrow direct work"
template_contains "references/context-rollover.md" "summarizes Worker returns and references evidence" "Rollover reference summarizes Worker output"
template_contains "references/role-templates-and-output.md" "Advisor Agent:" "Role reference preserves Advisor role"
template_contains "references/role-templates-and-output.md" "Expected output must preserve complete reasoning" "Role reference preserves output requirements"
template_contains "references/role-templates-and-output.md" "Normal cleanup order is Worker, Reviewer, PM, then Advisor" "Role reference records cleanup order"
template_contains "references/role-templates-and-output.md" "must not close any role that is still needed for a required gate" "Role reference keeps gate-bearing roles open"
template_contains "references/role-templates-and-output.md" "degraded cleanup evidence rather than delivery" "Role reference records degraded cleanup evidence"
template_contains "references/role-templates-and-output.md" "delivery evidence remains confirmable" "Role reference records delivery evidence confirmation"
template_contains "references/role-templates-and-output.md" "More than 2 files or roughly 80 diff lines is a self-check trigger" "Role reference records Leader budget trigger"
template_contains "README.md" "docs/INSTALLATION.md" "README links installation guide"
template_contains "README.md" "portable workflow protocol for AI-assisted work" "README states portable protocol positioning"
template_contains "README.md" "Codex as the reference packaged adapter" "README states Codex reference adapter"
template_contains "README.md" "adapter guidance or compatible patterns" "README avoids overclaiming non-Codex support"
template_contains "README.md" "docs/ADAPTERS.md" "README links adapter guide"
template_contains "SKILL.md" "Automatic invocation means applying this workflow and checklist" "SKILL.md defines automatic invocation boundary"
template_contains "README.md" "Completion summaries and next-goal recommendations are reporting aids only" "README blocks closeout authorization"
template_contains "SKILL.md" "Role-agent cleanup or close actions run sequentially" "SKILL.md describes sequential cleanup"
template_contains "SKILL.md" "More than 2 files or roughly 80 diff lines is a self-check" "SKILL.md describes Leader budget self-check"
template_contains "README.md" "automatically create successor conversations, spawn Workers, measure diff" "README blocks automation creep"
skill_anchor_count="$(grep -cE '^[[:space:]]*template_contains "SKILL[.]md"' scripts/validate-local.sh)"
if [[ "$skill_anchor_count" -ge "$SKILL_ANCHOR_BASELINE" ]]; then
  pass "SKILL.md anchor check count not reduced"
else
  fail "SKILL.md anchor check count not reduced"
fi
template_contains "SKILL.md" "Fast Path is a reading-order shortcut only" "SKILL.md defines Fast Path as reading-order only"
template_contains "SKILL.md" "Fast Path is not Small Task Mode" "SKILL.md separates Fast Path from Small Task Mode"
template_contains "SKILL.md" "never skips a mandatory reference once a routed domain is touched" "SKILL.md blocks Fast Path reference bypass"
template_contains "SKILL.md" "Slow Path applies as soon as the task reaches git exits, OpenSpec, CLI trust or model routing" "SKILL.md defines Slow Path routed domains"
template_contains "SKILL.md" "secrets, auth, security, permission, schema, destructive, irreversible" "SKILL.md includes security routed domains"
template_contains "references/TRACEABILITY.md" "v0.4.15 adds Fast Path / Slow Path reading-order guidance without demoting any" "Traceability records v0.4.15 no anchor demotion"
template_contains "references/TRACEABILITY.md" "Anchor demotion is not a validation-maintenance shortcut" "Traceability blocks silent anchor demotion"
template_contains "docs/VALIDATION.md" "Fast Path is documented as a reading-order shortcut only" "Validation checks Fast Path reading order"
template_contains "docs/VALIDATION.md" "Fast Path is explicitly not Small Task Mode" "Validation checks Fast Path not Small Task Mode"
template_contains "docs/VALIDATION.md" "Current \`SKILL.md\` hard-boundary anchors remain in \`SKILL.md\`" "Validation checks no SKILL anchor demotion"
template_contains "docs/VALIDATION.md" "template_contains \"SKILL.md\" anchor count" "Validation records SKILL anchor count"
template_contains "README.md" "## Quick Start" "README includes Quick Start"
template_contains "README.md" "## Use Cases" "README includes Use Cases"
template_contains "README.md" "## Safety Boundaries" "README includes Safety Boundaries"
template_contains "README.md" "docs/ADOPTION.md" "README links adoption guide"
template_contains "docs/ADOPTION.md" "Documentation Tasks" "Adoption guide covers documentation tasks"
template_contains "docs/ADOPTION.md" "Release Preparation" "Adoption guide covers release preparation"
template_contains "docs/ADOPTION.md" "Long-Running Project Work" "Adoption guide covers long-running project work"
template_contains "docs/ADOPTION.md" "Cross-Conversation Handoff" "Adoption guide covers handoff"
template_contains "docs/ADOPTION.md" "Ordinary Small Tasks" "Adoption guide covers small tasks"
template_contains "docs/ADOPTION.md" "transfers only the workflow/checklist structure" "Adoption guide blocks authority transfer"
template_contains "docs/INSTALLATION.md" "Adopting the protocol means using its workflow rules" "Installation distinguishes protocol adoption"
template_contains "docs/INSTALLATION.md" "Installing the Codex reference adapter means copying the Codex skill entry" "Installation distinguishes Codex adapter install"
template_contains "docs/ADAPTERS.md" "Adapter Guide Template" "Adapter guide includes template"
template_contains "docs/ADAPTERS.md" "Validation evidence:" "Adapter guide template records validation evidence"
template_contains "docs/ADAPTERS.md" "Unsupported actions:" "Adapter guide template records unsupported actions"
template_contains "docs/ADAPTERS.md" "Adapter Review Checklist" "Adapter guide includes review checklist"
template_contains "docs/VALIDATION.md" "Adoption Scenarios And Adapter Guardrails Checks" "Validation checks v0.4.14 adoption section"
template_contains "docs/VALIDATION.md" "README stays moderately concise" "Validation checks README length discipline"
template_contains "docs/VALIDATION.md" "does not create runtime-specific Claude, OpenClaw, Hermes" "Validation blocks misleading runtime guide skeletons"
template_contains "examples/release-prep-task.md" "Tag/release: not authorized." "Release prep example blocks tag release"
template_contains "examples/release-prep-task.md" "External publication: not authorized." "Release prep example blocks publication"
template_contains "examples/long-running-doc-workstream.md" "C0, then C1 proposal, C2 implementation" "Long-running doc example covers C stages"
template_contains "examples/long-running-doc-workstream.md" "Default exclusions:" "Long-running doc example records default exclusions"
template_contains "docs/VALIDATION.md" "## v0.4.13 Leader Delegation And Cleanup Discipline Checks" "Validation checks v0.4.13 delegation cleanup section"
template_contains "docs/VALIDATION.md" "Validation checks anchor presence and template consistency, not runtime" "Validation documents anchor limits"
template_contains "docs/VALIDATION.md" "Cleanup failure cannot weaken validation, PM/Advisor/Reviewer, git" "Validation blocks cleanup gate weakening"
template_contains "docs/VALIDATION.md" "More than 2 files or roughly 80 diff lines is a self-check trigger" "Validation checks Leader budget trigger"
template_contains "docs/VALIDATION.md" "Documentation does not add automatic cleanup, automatic spawning" "Validation blocks cleanup automation creep"
template_contains "docs/INSTALLATION.md" "Optional Codex Global Skill Sync" "Installation guide covers global skill sync"
template_contains "docs/INSTALLATION.md" "Adopt The Protocol" "Installation guide covers generic protocol adoption"
template_contains "docs/INSTALLATION.md" "Install The Codex Reference Adapter" "Installation guide covers Codex reference adapter"
template_contains "docs/INSTALLATION.md" "docs/ADAPTERS.md" "Installation guide links adapter guidance"
template_contains "docs/INSTALLATION.md" "Migrate To Another Machine" "Installation guide covers machine migration"
template_contains "docs/INSTALLATION.md" "Adopt In Another Project" "Installation guide covers project adoption"
template_contains "docs/INSTALLATION.md" "What Does Not Transfer" "Installation guide documents non-transferable state"
template_contains "docs/INSTALLATION.md" "Do not hard-code a concrete" "Installation guide keeps model selection generic"
template_contains "docs/INSTALLATION.md" "Migration does not transfer" "Installation guide blocks authorization transfer"
template_contains "docs/INSTALLATION.md" "workflow/checklist" "Installation guide frames invocation as checklist"
template_contains "docs/INSTALLATION.md" "Global sync is a file-sync step, not an authority-sync step." "Installation guide blocks global sync authority"
template_contains "docs/INSTALLATION.md" "stale handoff authority" "Installation guide blocks stale handoff authority"
template_contains "docs/INSTALLATION.md" "prior session, another current session" "Installation guide blocks session assumption transfer"
template_contains "docs/INSTALLATION.md" "./scripts/validate-local.sh" "Installation guide includes validation command"
template_contains "docs/ADAPTERS.md" "reference adapter" "Adapter guide defines reference adapter"
template_contains "docs/ADAPTERS.md" "adapter guide planned" "Adapter guide defines planned adapter"
template_contains "docs/ADAPTERS.md" "compatible pattern" "Adapter guide defines compatible pattern"
template_contains "docs/ADAPTERS.md" "Claude / Claude Code" "Adapter guide lists Claude status"
template_contains "docs/ADAPTERS.md" "OpenClaw" "Adapter guide lists OpenClaw status"
template_contains "docs/ADAPTERS.md" "Hermes Agent" "Adapter guide lists Hermes status"
template_contains "docs/ADAPTERS.md" "Adapter Mapping Checklist" "Adapter guide includes mapping checklist"
template_contains "docs/ADAPTERS.md" "Non-Transferable State" "Adapter guide preserves non-transferable state"
template_contains "templates/README.md" "plain-language closeout" "Templates README requires closeout summary"
template_contains "templates/README.md" "Recommended next goals are advice only" "Templates README blocks next-goal authorization"
template_contains "templates/compact-handoff.md" "Plain-language closeout" "Compact handoff includes closeout fields"
template_contains "templates/compact-handoff.md" "What remains uncertain or was not checked:" "Compact handoff requires uncertainty closeout"
template_contains "templates/successor-startup-packet.md" "Plain-language closeout or handoff summary:" "Successor packet includes closeout summary"
template_contains "templates/blocked-report.md" "Plain-language closeout:" "Blocked report includes closeout summary"
template_contains "examples/skill-invocation.md" "Calling the skill automatically means" "Skill invocation example defines automatic invocation"
template_contains "examples/skill-invocation.md" "What Does Not Happen Automatically" "Skill invocation example blocks automatic authority transfer"

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

global_skill_dir="${HOME}/.codex/skills/multi-agent-working-group"
global_skill="${global_skill_dir}/SKILL.md"
if [[ "$skip_global_skill" -eq 1 ]]; then
  warn "global SKILL.md comparison skipped"
elif [[ -f "$global_skill" ]]; then
  if cmp -s "SKILL.md" "$global_skill"; then
    pass "global SKILL.md matches repo SKILL.md"
  else
    fail "global SKILL.md matches repo SKILL.md"
  fi

  for reference in "${REQUIRED_REFERENCES[@]}"; do
    global_reference="${global_skill_dir}/${reference}"
    if [[ -f "$global_reference" ]] && cmp -s "$reference" "$global_reference"; then
      pass "global reference matches repo: $reference"
    else
      fail "global reference matches repo: $reference"
    fi
  done
else
  warn "global SKILL.md not found at $global_skill"
fi

if [[ "$failures" -gt 0 ]]; then
  printf '\n%d local validation check(s) failed.\n' "$failures" >&2
  exit 1
fi

printf '\nLocal validation passed.\n'
