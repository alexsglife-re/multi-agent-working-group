#!/usr/bin/env bash
set -euo pipefail

VERSION="v0.4.5"
REQUIRED_ACCEPTED_SPECS=(
  "advisor-model-diversity"
  "cli-trust-and-openspec-lifecycle"
  "leader-state-compaction"
  "local-validation-tool"
  "role-boundary-stabilization"
)
COPYABLE_TEMPLATES_SPEC="copyable-role-templates"
COPYABLE_TEMPLATES_CHANGE="openspec/changes/add-copyable-role-templates/specs/copyable-role-templates/spec.md"
REQUIRED_TEMPLATES=(
  "templates/README.md"
  "templates/advisor-review.md"
  "templates/blocked-report.md"
  "templates/c0-goal-analysis.md"
  "templates/compact-handoff.md"
  "templates/git-gate.md"
  "templates/pm-review.md"
  "templates/reviewer-report.md"
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

if [[ -f "docs/TODO.md" ]] && contains "docs/TODO.md" "## $VERSION: Copyable Role Templates"; then
  pass "docs/TODO.md current version section"
else
  fail "docs/TODO.md current version section"
fi

if [[ -f "docs/ROADMAP.md" ]] && contains "docs/ROADMAP.md" "\`$VERSION\` copyable role templates are complete"; then
  pass "docs/ROADMAP.md current version marker"
else
  fail "docs/ROADMAP.md current version marker"
fi

if [[ -f "docs/VALIDATION.md" ]] && contains "docs/VALIDATION.md" "## $VERSION Copyable Role Template Checks"; then
  pass "docs/VALIDATION.md current validation section"
else
  fail "docs/VALIDATION.md current validation section"
fi

if [[ -f "SKILL.md" ]] && contains "SKILL.md" "$VERSION adds copyable templates"; then
  pass "SKILL.md current template marker"
else
  fail "SKILL.md current template marker"
fi

for spec in "${REQUIRED_ACCEPTED_SPECS[@]}"; do
  if [[ -f "openspec/specs/$spec/spec.md" ]]; then
    pass "accepted spec exists: $spec"
  else
    fail "accepted spec exists: $spec"
  fi
done

if [[ -f "openspec/specs/$COPYABLE_TEMPLATES_SPEC/spec.md" ]]; then
  pass "accepted spec exists: $COPYABLE_TEMPLATES_SPEC"
elif [[ "$require_no_active_changes" -eq 0 && -f "$COPYABLE_TEMPLATES_CHANGE" ]]; then
  pass "active spec delta exists: $COPYABLE_TEMPLATES_SPEC"
else
  fail "accepted spec exists: $COPYABLE_TEMPLATES_SPEC"
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
template_contains "templates/README.md" "Do not bulk-rewrite old v0.3 or earlier handoffs" "templates README preserves legacy documents"
template_contains "templates/README.md" "stale until re-verified" "templates README uses stale freshness label"
template_contains "templates/README.md" "historical only" "templates README uses historical freshness label"
template_contains "templates/README.md" "Do not use it as authorization for commit, push, scope expansion, gate bypass, or external effects." "templates README blocks legacy authorization"
template_contains "templates/pm-review.md" "P0:" "PM template preserves P0"
template_contains "templates/pm-review.md" "P1:" "PM template preserves P1"
template_contains "templates/advisor-review.md" "Reviewed before PM conclusions" "Advisor template records independence"
template_contains "templates/advisor-review.md" "P0:" "Advisor template preserves P0"
template_contains "templates/advisor-review.md" "P1:" "Advisor template preserves P1"
template_contains "templates/worker-assignment.md" "Do not expand scope." "Worker assignment blocks scope expansion"
template_contains "templates/worker-assignment.md" "Do not self-approve." "Worker assignment blocks self approval"
template_contains "templates/worker-assignment.md" "Do not commit or push." "Worker assignment blocks git actions"
template_contains "templates/reviewer-report.md" "block; Reviewer must not review their own implementation" "Reviewer template blocks self review"
template_contains "templates/blocked-report.md" "Do not bypass PM/Advisor/Reviewer, validation, secret-scan, CI/status, or git gates." "Blocked template blocks gate bypass"
template_contains "templates/compact-handoff.md" "current | stale until re-verified | historical only" "Compact handoff uses freshness labels"
template_contains "templates/compact-handoff.md" "verified | inferred | unverified" "Compact handoff uses verification labels"
template_contains "templates/git-gate.md" "Secret/credential scan:" "Git gate template includes secret scan"
template_contains "templates/git-gate.md" "CI/status:" "Git gate template includes CI status"

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
