#!/usr/bin/env bash
set -euo pipefail

PUBLIC_VERSION="v1.0.0"
PUBLIC_UPGRADE_TITLE="Progressive Leader State Profiles"
PUBLICATION_DATE="July 16, 2026"
PUBLICATION_TIMEZONE="America/Los_Angeles"
CURRENT_VALIDATION_TITLE="Progressive Leader State Profile Checks"
SKILL_ANCHOR_BASELINE=59
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
  "role-review-context-efficiency"
)
REQUIRED_REFERENCES=(
  "references/TRACEABILITY.md"
  "references/cli-trust.md"
  "references/context-rollover.md"
  "references/git-exit-rules.md"
  "references/leader-state-profiles.md"
  "references/openspec-lifecycle.md"
  "references/role-templates-and-output.md"
  "references/review-context-efficiency.md"
)
ROLLOVER_SPEC="leader-rollover-protocol"
ROLLOVER_CHANGE="openspec/changes/add-rollover-opportunity-protocol/specs/leader-rollover-protocol/spec.md"
AGENT_CLEANUP_SPEC="agent-cleanup-discipline"
AGENT_CLEANUP_CHANGE="openspec/changes/add-leader-delegation-and-cleanup-discipline/specs/agent-cleanup-discipline/spec.md"
ROLE_REVIEW_CONTEXT_SPEC="role-review-context-efficiency"
ROLE_REVIEW_CONTEXT_CHANGE="openspec/changes/optimize-role-review-context-efficiency/specs/role-review-context-efficiency/spec.md"
ADOPTION_GUIDANCE_SPEC="adoption-guidance"
ADOPTION_GUIDANCE_CHANGE="openspec/changes/add-adoption-scenarios-and-adapter-guardrails/specs/adoption-guidance/spec.md"
REQUIRED_TEMPLATES=(
  "templates/README.md"
  "templates/advisor-review.md"
  "templates/blocked-report.md"
  "templates/c0-goal-analysis.md"
  "templates/compact-handoff.md"
  "templates/compact-leader-state.md"
  "templates/git-gate.md"
  "templates/pm-review.md"
  "templates/reviewer-report.md"
  "templates/review-factual-manifest.md"
  "templates/review-invocation-record.md"
  "templates/review-packet-cleanup-checklist.md"
  "templates/successor-startup-packet.md"
  "templates/successor-opportunity-skeleton.md"
  "templates/standard-leader-state.md"
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

release_status_contradiction() {
  local content="$1"
  local normalized publication_date_normalized
  normalized="$(printf '%s' "$content" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
  publication_date_normalized="$(printf '%s' "$PUBLICATION_DATE" | tr '[:upper:]' '[:lower:]')"
  normalized="${normalized//\`/}"
  RELEASE_STATUS_REASON=""

  if [[ "$normalized" =~ (current[[:space:]]+public[[:space:]]+(version|release)([[:space:]]+is|:)|public[[:space:]]+version[[:space:]]+remains)[[:space:]]*v0\.4\.18 ]] \
    || [[ "$normalized" =~ v0\.4\.18[[:space:]]+(is|remains)[[:space:]]+the[[:space:]]+current[[:space:]]+public[[:space:]]+(version|release) ]]; then
    RELEASE_STATUS_REASON="v0.4.18 is still described as current public"
    return 0
  fi
  if [[ "$normalized" =~ development[[:space:]]+target:[[:space:]]*v1\.0\.0 ]] \
    || [[ "$normalized" =~ v1\.0\.0[[:space:]]+development[[:space:]]+target ]] \
    || [[ "$normalized" =~ v1\.0\.0[[:space:]]+remains[[:space:]]+the[[:space:]]+development[[:space:]]+target ]] \
    || [[ "$normalized" =~ v1\.0\.0[[:space:]]+is[[:space:]]+the[[:space:]]+next[[:space:]]+development[[:space:]]+version ]] \
    || [[ "$normalized" =~ next[[:space:]]+development[[:space:]]+version([[:space:]]+is|:)[[:space:]]*v1\.0\.0 ]]; then
    RELEASE_STATUS_REASON="v1.0.0 is still described as development"
    return 0
  fi
  if [[ "$normalized" =~ (active[[:space:]]+)?development[[:space:]]+target([[:space:]]+is|:)[[:space:]]*v[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    RELEASE_STATUS_REASON="an unconfigured development target is declared"
    return 0
  fi
  if [[ "$normalized" =~ v[0-9]+\.[0-9]+\.[0-9]+[[:space:]]+remains[[:space:]]+the[[:space:]]+development[[:space:]]+target ]]; then
    RELEASE_STATUS_REASON="an unconfigured development target is declared"
    return 0
  fi
  if [[ "$normalized" =~ (no[[:space:]]+v1\.0\.0[[:space:]]+tag[[:space:]]+exists|v1\.0\.0[[:space:]]+tag[[:space:]]+(does[[:space:]]+not[[:space:]]+exist|has[[:space:]]+not[[:space:]]+been[[:space:]]+created|was[[:space:]]+not[[:space:]]+created)) ]] \
    || [[ "$normalized" =~ (no[[:space:]]+github[[:space:]]+release[[:space:]]+v1\.0\.0[[:space:]]+exists|no[[:space:]]+github[[:space:]]+release[[:space:]]+exists[[:space:]]+for[[:space:]]+v1\.0\.0|github[[:space:]]+release[[:space:]]+v1\.0\.0[[:space:]]+(does[[:space:]]+not[[:space:]]+exist|has[[:space:]]+not[[:space:]]+been[[:space:]]+published)) ]] \
    || [[ "$normalized" =~ (v1\.0\.0[[:space:]]+(has[[:space:]]+not[[:space:]]+been|remains)[[:space:]]+(published|released|unpublished)|no[[:space:]]+v1\.0\.0[[:space:]]+public[[:space:]]+publication[[:space:]]+exists) ]]; then
    RELEASE_STATUS_REASON="v1.0.0 is still described as unpublished"
    return 0
  fi
  if [[ "$normalized" =~ v1\.0\.0[[:space:]]+(is[[:space:]]+|has[[:space:]]+been[[:space:]]+|was[[:space:]]+)?deployed ]] \
    || [[ "$normalized" =~ (deployment[[:space:]]+(of|for)[[:space:]]+v1\.0\.0|v1\.0\.0[[:space:]]+deployment)[[:space:]]+exists ]] \
    || { [[ "$normalized" =~ deployment[[:space:]]+was[[:space:]]+performed ]] \
      && [[ ! "$normalized" =~ (no[[:space:]]+deployment[[:space:]]+was[[:space:]]+performed|deployment[[:space:]]+was[[:space:]]+not[[:space:]]+performed|does[[:space:]]+not[[:space:]]+claim[[:space:]]+deployment[[:space:]]+was[[:space:]]+performed|no[[:space:]]+claim[[:space:]]+is[[:space:]]+made[[:space:]]+that[[:space:]]+deployment[[:space:]]+was[[:space:]]+performed) ]]; }; then
    RELEASE_STATUS_REASON="v1.0.0 is incorrectly described as deployed"
    return 0
  fi
  if [[ "$normalized" =~ v1\.0\.0.*published[[:space:]]+(to|through)[[:space:]]+(a[[:space:]]+)?(package[[:space:]]+registry|social[[:space:]]+channel|community[[:space:]]+post|website) ]]; then
    RELEASE_STATUS_REASON="v1.0.0 uses an unsupported publication channel"
    return 0
  fi
  if [[ "$normalized" =~ publication[[:space:]]+was[[:space:]]+made[[:space:]]+through[[:space:]]+(a[[:space:]]+)?(package[[:space:]]+registry|social[[:space:]]+channel|community[[:space:]]+post|website) ]] \
    && [[ ! "$normalized" =~ (does[[:space:]]+not[[:space:]]+claim[[:space:]]+publication[[:space:]]+was[[:space:]]+made|no[[:space:]]+claim[[:space:]]+is[[:space:]]+made[[:space:]]+that[[:space:]]+publication[[:space:]]+was[[:space:]]+made) ]]; then
    RELEASE_STATUS_REASON="v1.0.0 uses an unsupported publication channel"
    return 0
  fi
  if { [[ "$normalized" =~ (published|released)[[:space:]]+v1\.0\.0[[:space:]]+on[[:space:]]+ ]] \
      || [[ "$normalized" =~ v1\.0\.0.*(published|released)[[:space:]]+on[[:space:]]+ ]]; } \
    && [[ "$normalized" != *"$publication_date_normalized"* ]]; then
    RELEASE_STATUS_REASON="v1.0.0 has an incorrect annotated-tag date"
    return 0
  fi
  return 1
}

declares_unconfigured_development_version() {
  local input="${1:--}"

  perl -0ne '
    $normalized = lc $_;
    $normalized =~ s/`//g;
    $normalized =~ s/\s+/ /g;
    $found = 1 if
      $normalized =~ /(?:active )?development target(?: is|:) *v[0-9]+\.[0-9]+\.[0-9]+/ ||
      $normalized =~ /v[0-9]+\.[0-9]+\.[0-9]+ development target/ ||
      $normalized =~ /v[0-9]+\.[0-9]+\.[0-9]+ remains the development target/ ||
      $normalized =~ /next development version(?: is|:) *v[0-9]+\.[0-9]+\.[0-9]+/;
    END { exit($found ? 0 : 1) }
  ' "$input"
}

expect_development_version_scanner_accept() {
  local label="$1" content="$2"
  if printf '%s' "$content" | declares_unconfigured_development_version -; then
    fail "$label"
  else
    pass "$label"
  fi
}

expect_development_version_scanner_reject() {
  local label="$1" content="$2"
  if printf '%s' "$content" | declares_unconfigured_development_version -; then
    pass "$label"
  else
    fail "$label"
  fi
}

expect_release_status_accept() {
  local label="$1" content="$2"
  if release_status_contradiction "$content"; then
    fail "$label ($RELEASE_STATUS_REASON)"
  else
    pass "$label"
  fi
}

expect_release_status_reject() {
  local label="$1" expected_reason="$2" content="$3"
  if release_status_contradiction "$content"; then
    if [[ "$RELEASE_STATUS_REASON" == "$expected_reason" ]]; then
      pass "$label ($RELEASE_STATUS_REASON)"
    else
      fail "$label expected $expected_reason, got $RELEASE_STATUS_REASON"
    fi
  else
    fail "$label expected contradiction"
  fi
}

profile_manifest_edge_dimensions_valid() {
  local manifest="$1"

  awk -F '\t' '
    function normalized_edge_identity(token,    value, separator, pair, suffix, endpoints, swap) {
      if (token !~ /^(conflict|overlap):/) return token
      value = token
      sub(/^(conflict|overlap):/, "", value)
      separator = index(value, ":")
      pair = substr(value, 1, separator - 1)
      suffix = substr(value, separator + 1)
      split(pair, endpoints, /[+]/)
      if (endpoints[1] > endpoints[2]) { swap = endpoints[1]; endpoints[1] = endpoints[2]; endpoints[2] = swap }
      return substr(token, 1, index(token, ":")) endpoints[1] "+" endpoints[2] ":" suffix
    }
    function edge_dimensions_valid(    n, parts, i, token, identity, value, dep_count, overlap_count) {
      if ($16 == "none") return $10 == 0 && $11 == 0
      n = split($16, parts, /[,;]/)
      dep_count = overlap_count = 0
      for (i = 1; i <= n; i++) {
        token = parts[i]
        identity = normalized_edge_identity(token)
        if (typed_edge_seen[NR SUBSEP identity]++) return 0
        if (token == "dep:@standard-size-warning.md#dependency-and-conflict-edges") dep_count += 30
        else if (token == "overlap:@standard-size-warning.md#overlap-edges") overlap_count += 20
        else if (token ~ /^gen:dep:[0-9]+$/) {
          value = token
          sub(/^gen:dep:/, "", value)
          dep_count += value + 0
        } else if (token ~ /^gen:overlap:[0-9]+$/) {
          value = token
          sub(/^gen:overlap:/, "", value)
          overlap_count += value + 0
        } else if (token ~ /^dep:[a-z0-9][-a-z0-9._\/]*>[a-z0-9][-a-z0-9._\/]*:[a-z0-9][-a-z0-9._\/+>:]*$/) {
          dep_count++
        } else if (token ~ /^conflict:[a-z0-9][-a-z0-9._\/]*[+][a-z0-9][-a-z0-9._\/]*:[a-z0-9][-a-z0-9._\/+>:]*$/) {
          dep_count++
        } else if (token ~ /^overlap:[a-z0-9][-a-z0-9._\/]*[+][a-z0-9][-a-z0-9._\/]*:[a-z0-9][-a-z0-9._\/+>:]*$/) {
          overlap_count++
        } else {
          return 0
        }
      }
      return dep_count == $10 && overlap_count == $11
    }
    NR == 1 { next }
    !edge_dimensions_valid() {
      print $1 ": typed edge_keys do not match dependency/conflict and overlap dimensions independently" > "/dev/stderr"
      bad = 1
    }
    END { exit bad ? 1 : 0 }
  ' "$manifest"
}

validate_profile_manifest_edge_rejection_probes() {
  local manifest="examples/leader-state-profiles/cases.tsv"

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-MEDIUM-REPO" { $10 = $10 + 1; $11 = $11 - 1 }
      { print }
    ' "$manifest" | profile_manifest_edge_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects dependency/overlap redistribution with unchanged total"
  else
    pass "Profile manifest rejects dependency/overlap redistribution with unchanged total"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-EDGE-DEDUP" { $16 = $16 "," $16 }
      { print }
    ' "$manifest" | profile_manifest_edge_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects duplicate typed explicit edge tokens"
  else
    pass "Profile manifest rejects duplicate typed explicit edge tokens"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-EDGE-DEDUP" { sub(/^dep:/, "", $16) }
      { print }
    ' "$manifest" | profile_manifest_edge_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects ambiguous untyped explicit edge tokens"
  else
    pass "Profile manifest rejects ambiguous untyped explicit edge tokens"
  fi
}

profile_manifest_authorization_dimensions_valid() {
  local manifest="$1"

  awk -F '\t' '
    function normalized_key(value) {
      return value ~ /^[a-z0-9]+(-[a-z0-9]+)*$/
    }
    function authorization_dimensions_valid(    n, tokens, i, token, fields, generated, count) {
      if ($21 == "none") return $13 == 0
      if ($13 == 0) return 0
      n = split($21, tokens, /,/)
      count = 0
      for (i = 1; i <= n; i++) {
        token = tokens[i]
        if (authorization_seen[NR SUBSEP token]++) return 0
        if (token ~ /^gen:auth:[0-9]+$/) {
          if ($5 !~ /^synthetic:/) return 0
          generated = token
          sub(/^gen:auth:/, "", generated)
          count += generated + 0
        } else if (token == "@standard-size-warning.md#authorization-and-gate-state") {
          if ($1 != "FX-SIZE-WARNING" || $5 != "synthetic:standard-structural-ceilings") return 0
          count += 3
        } else {
          if (split(token, fields, /:/) != 7 || fields[1] != "auth") return 0
          if (!normalized_key(fields[2]) || fields[2] == "none" || !normalized_key(fields[3]) || \
              !normalized_key(fields[4]) || fields[4] ~ /-and-/ || !normalized_key(fields[5]) || \
              !normalized_key(fields[6]) || !normalized_key(fields[7])) return 0
          if (fields[6] != "requested" && fields[6] != "pending" && fields[6] != "granted" && \
              fields[6] != "denied" && fields[6] != "revoked" && fields[6] != "expired") return 0
          count++
        }
      }
      return count == $13
    }
    NR == 1 { next }
    !authorization_dimensions_valid() {
      print $1 ": authorization_keys do not match the active authorization-domain count and grammar" > "/dev/stderr"
      bad = 1
    }
    END { exit bad ? 1 : 0 }
  ' "$manifest"
}

validate_profile_manifest_authorization_rejection_probes() {
  local manifest="examples/leader-state-profiles/cases.tsv"

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { sub(/:pending:/, ":denied:", $21) }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    pass "Profile manifest counts current denied authorization as active fail-closed state"
  else
    fail "Profile manifest counts current denied authorization as active fail-closed state"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { sub(/:pending:/, ":unknown:", $21) }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects unknown as an active authorization status"
  else
    pass "Profile manifest rejects unknown as an active authorization status"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { $13 = 2; $21 = $21 "," $21 }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects duplicate authorization keys"
  else
    pass "Profile manifest rejects duplicate authorization keys"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { $13 = 2 }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects authorization count mismatch"
  else
    pass "Profile manifest rejects authorization count mismatch"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { sub(/^auth:/, "", $21) }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects untyped authorization keys"
  else
    pass "Profile manifest rejects untyped authorization keys"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { sub(/:commit:/, ":commit-and-push:", $21) }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects merged authorization actions"
  else
    pass "Profile manifest rejects merged authorization actions"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-TAKEOVER-STANDARD" { sub(/^auth:owner:/, "auth:none:", $21) }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest rejects actor none in an active authorization key"
  else
    pass "Profile manifest rejects actor none in an active authorization key"
  fi

  if awk -F '\t' 'BEGIN { OFS = "\t" }
      NR > 1 && $1 == "FX-SIZE-WARNING" { $13 = $13 + 1 }
      { print }
    ' "$manifest" | profile_manifest_authorization_dimensions_valid - 2>/dev/null; then
    fail "Profile manifest excludes standing unrequested publication from the active authorization count"
  else
    pass "Profile manifest excludes standing unrequested publication from the active authorization count"
  fi
}

validate_profile_manifest() {
  local manifest="examples/leader-state-profiles/cases.tsv"
  local expected_header
  expected_header="case_id\tsequence_id\tstep\tscenario\tsource\tworkstreams\tblockers\trole_lifecycles\tvalidation_groups\tdependency_conflict_edges\toverlap_edges\thigh_risk_gates\tauthorization_domains\tprojection\tselection_basis\tedge_keys\texpected_profile\texpected_result\treason_code\texpectation\tauthorization_keys"

  if [[ ! -f "$manifest" ]]; then
    fail "Leader-state profile case manifest exists"
    return
  fi

  if awk -F '\t' -v expected_header="$expected_header" '
    function compact_ok() {
      return $6 <= 2 && $7 <= 5 && $8 <= 8 && $9 <= 8 && $10 <= 10 && $11 <= 5 && $12 <= 2 && $13 <= 2
    }
    function standard_ok() {
      return $6 <= 5 && $7 <= 10 && $8 <= 15 && $9 <= 15 && $10 <= 30 && $11 <= 20 && $12 <= 3 && $13 <= 3
    }
    function compact_exit_ok() {
      return $6 <= 1 && $7 <= 4 && $8 <= 6 && $9 <= 6 && $10 <= 8 && $11 <= 4 && $12 <= 1 && $13 <= 1
    }
    function hierarchical_exit_ok() {
      return $14 == "reliable-single-file" && $6 <= 4 && $7 <= 8 && $8 <= 12 && $9 <= 12 && $10 <= 24 && $11 <= 16 && $12 <= 2 && $13 <= 2
    }
    function classified_profile() {
      if ($14 == "projection-failed") return "hierarchical-required"
      if (compact_ok()) return "Compact"
      if (standard_ok()) return "Standard"
      return "hierarchical-required"
    }
    function expected_result_for_reason(reason) {
      if (reason ~ /^ERR-/) return "fail"
      if (reason == "WARN-LINES-NONBLOCKING") return "pass-with-warning"
      return "pass"
    }
    function valid_reason(reason) {
      return reason == "OK-CLASSIFIED" || reason == "OK-PROMOTED" || reason == "OK-RETAIN-HYSTERESIS" || \
        reason == "OK-DEMOTION-ELIGIBLE" || reason == "OK-DEMOTED-BY-DECISION" || reason == "WARN-LINES-NONBLOCKING" || \
        reason == "ERR-MISSING-APPLICABLE-FIELD" || reason == "ERR-STALE-POINTER" || reason == "ERR-ORPHAN-POINTER" || \
        reason == "ERR-CONFLICTING-CANONICAL-SOURCE" || reason == "ERR-INVALID-SELECTION-BASIS"
    }
    NR == 1 {
      if ($0 != expected_header || NF != 21) {
        print "manifest header must contain the exact 21-column schema with the original 20 columns stable" > "/dev/stderr"
        bad = 1
      }
      next
    }
    {
      if (NF != 21) {
        print "manifest row " NR " does not have 21 columns" > "/dev/stderr"
        bad = 1
        next
      }
      if ($1 !~ /^FX-[A-Z0-9-]+$/ || seen[$1]++) {
        print "manifest row " NR " has an invalid or duplicate case_id: " $1 > "/dev/stderr"
        bad = 1
      }
      if ($3 !~ /^[0-9]+$/ || $3 < 1) {
        print $1 ": step must be a positive integer" > "/dev/stderr"
        bad = 1
      }
      if ($6 < 1) {
        print $1 ": an active-state fixture requires at least one workstream" > "/dev/stderr"
        bad = 1
      }
      for (i = 6; i <= 13; i++) {
        if ($i !~ /^[0-9]+$/) {
          print $1 ": count column " i " must be a base-10 non-negative integer" > "/dev/stderr"
          bad = 1
        }
      }
      if ($14 != "reliable-single-file" && $14 != "projection-failed") {
        print $1 ": invalid projection enum" > "/dev/stderr"
        bad = 1
      }
      if ($15 != "fixture-measurement-full-counts" && $15 != "takeover-verification-full-counts" && $15 != "transition-measurement-full-counts" && $15 != "line-count-only") {
        print $1 ": invalid selection_basis enum" > "/dev/stderr"
        bad = 1
      }
      if ($17 != "Compact" && $17 != "Standard" && $17 != "hierarchical-required") {
        print $1 ": invalid expected_profile enum" > "/dev/stderr"
        bad = 1
      }
      if ($18 != "pass" && $18 != "fail" && $18 != "pass-with-warning") {
        print $1 ": invalid expected_result enum" > "/dev/stderr"
        bad = 1
      }
      if ($18 != expected_result_for_reason($19)) {
        print $1 ": expected_result does not follow reason_code" > "/dev/stderr"
        bad = 1
      }
      if (!valid_reason($19)) {
        print $1 ": invalid reason_code" > "/dev/stderr"
        bad = 1
      }
      calculated = classified_profile()
      if ($2 == "seq-demote") {
        if ($3 == 1 && $19 == "OK-RETAIN-HYSTERESIS" && $17 == "Standard" && compact_exit_ok()) demote_step = 1
        else if ($3 == 2 && demote_step == 1 && $19 == "OK-DEMOTION-ELIGIBLE" && $17 == "Standard" && compact_exit_ok()) demote_step = 2
        else if ($3 == 3 && demote_step == 2 && $19 == "OK-DEMOTED-BY-DECISION" && $17 == "Compact" && compact_exit_ok()) demote_step = 3
        else {
          print $1 ": invalid two-checkpoint demotion sequence" > "/dev/stderr"
          bad = 1
        }
      } else if ($2 == "seq-hierarchical-demote") {
        if ($3 == 1 && $19 == "OK-RETAIN-HYSTERESIS" && $17 == "hierarchical-required" && hierarchical_exit_ok()) hierarchical_demote_step = 1
        else if ($3 == 2 && hierarchical_demote_step == 1 && $19 == "OK-DEMOTION-ELIGIBLE" && $17 == "hierarchical-required" && hierarchical_exit_ok()) hierarchical_demote_step = 2
        else if ($3 == 3 && hierarchical_demote_step == 2 && $19 == "OK-DEMOTED-BY-DECISION" && $17 == "Standard" && hierarchical_exit_ok()) hierarchical_demote_step = 3
        else {
          print $1 ": invalid hierarchical-required to Standard demotion sequence" > "/dev/stderr"
          bad = 1
        }
      } else if ($19 == "OK-PROMOTED") {
        if ($2 != "seq-promote" || $3 != 1 || calculated != $17 || $17 == "Compact") {
          print $1 ": invalid promotion transition" > "/dev/stderr"
          bad = 1
        }
      } else if (calculated != $17) {
        print $1 ": expected_profile " $17 " does not match structural classification " calculated > "/dev/stderr"
        bad = 1
      }

      if ($19 == "ERR-MISSING-APPLICABLE-FIELD" && $4 != "missing-applicable-field") bad = 1
      else if ($19 == "ERR-STALE-POINTER" && $4 != "stale-required-pointer") bad = 1
      else if ($19 == "ERR-ORPHAN-POINTER" && ($4 != "orphan-current-pointer" || $14 != "projection-failed")) bad = 1
      else if ($19 == "ERR-CONFLICTING-CANONICAL-SOURCE" && ($4 != "conflicting-canonical-source" || $14 != "projection-failed")) bad = 1
      else if ($19 == "ERR-INVALID-SELECTION-BASIS" && ($4 != "invalid-selection-basis" || $15 != "line-count-only")) bad = 1
      else if ($19 !~ /^ERR-/ && $15 == "line-count-only") bad = 1
      if ($4 == "takeover-direct-to-standard" && $15 != "takeover-verification-full-counts") bad = 1
      else if (($19 == "OK-PROMOTED" || $2 == "seq-demote" || $2 == "seq-hierarchical-demote") && $15 != "transition-measurement-full-counts") bad = 1
      else if ($4 != "takeover-direct-to-standard" && $19 != "OK-PROMOTED" && $2 != "seq-demote" && $2 != "seq-hierarchical-demote" && $19 != "ERR-INVALID-SELECTION-BASIS" && $15 != "fixture-measurement-full-counts") bad = 1
      if ($5 == "" || $20 == "") bad = 1
    }
    END {
      if (NR < 2) {
        print "manifest has no cases" > "/dev/stderr"
        bad = 1
      }
      if (demote_step != 3) {
        print "manifest lacks the complete ordered demotion sequence" > "/dev/stderr"
        bad = 1
      }
      if (hierarchical_demote_step != 3) {
        print "manifest lacks the complete ordered hierarchical-required demotion sequence" > "/dev/stderr"
        bad = 1
      }
      exit bad ? 1 : 0
    }
  ' "$manifest" && profile_manifest_edge_dimensions_valid "$manifest" && \
      profile_manifest_authorization_dimensions_valid "$manifest"; then
    pass "Leader-state profile case manifest structure and classifications"
  else
    fail "Leader-state profile case manifest structure and classifications"
  fi
}

manifest_fixture_matches() {
  local case_id="$1" source="$2" expected_profile="$3" expected_result="$4" reason_code="$5" label="$6"
  local manifest="examples/leader-state-profiles/cases.tsv"

  if awk -F '\t' -v case_id="$case_id" -v source="$source" -v profile="$expected_profile" \
      -v result="$expected_result" -v reason="$reason_code" '
    NR > 1 && $1 == case_id {
      matches++
      if ($5 == source && $17 == profile && $18 == result && $19 == reason) valid++
    }
    END { exit !(matches == 1 && valid == 1) }
  ' "$manifest"; then
    pass "$label manifest linkage"
  else
    fail "$label manifest linkage"
  fi
}

validate_missing_field_fixture() {
  local file="examples/leader-state-profiles/negative-missing-applicable-field.md"
  local derived_reason=""

  if [[ -f "$file" ]] && awk '
    function trim(value) {
      sub(/^[[:space:]]+/, "", value)
      sub(/[[:space:]]+$/, "", value)
      return value
    }
    /^Schema required keys:/ {
      value = $0
      sub(/^Schema required keys:[[:space:]]*/, "", value)
      n = split(value, items, /,/)
      for (i = 1; i <= n; i++) required[trim(items[i])] = 1
    }
    /^Present keys:/ {
      value = $0
      sub(/^Present keys:[[:space:]]*/, "", value)
      n = split(value, items, /,/)
      for (i = 1; i <= n; i++) present[trim(items[i])] = 1
    }
    END {
      for (key in required) {
        required_count++
        if (!(key in present)) missing_count++
      }
      exit !(required_count > 0 && missing_count > 0)
    }
  ' "$file"; then
    derived_reason="ERR-MISSING-APPLICABLE-FIELD"
    pass "Missing applicable field fixture derives set difference"
  else
    fail "Missing applicable field fixture derives set difference"
  fi

  [[ "$derived_reason" == "ERR-MISSING-APPLICABLE-FIELD" ]] && \
    manifest_fixture_matches "FX-NEG-MISSING-FIELD" "$file" "Compact" "fail" "$derived_reason" "Missing applicable field fixture"
}

validate_stale_pointer_fixture() {
  local file="examples/leader-state-profiles/negative-stale-pointer.md"
  local required freshness allowed derived_reason=""

  if [[ ! -f "$file" ]]; then
    fail "Stale required pointer fixture exists"
    return
  fi

  required="$(sed -n 's/^Pointer required for current action:[[:space:]]*//p' "$file")"
  freshness="$(sed -n 's/^Pointer freshness:[[:space:]]*//p' "$file")"
  allowed="$(sed -n 's/^Allowed freshness for current action:[[:space:]]*//p' "$file")"
  if [[ "$required" == "yes" && -n "$freshness" && -n "$allowed" && "$freshness" != "$allowed" ]]; then
    derived_reason="ERR-STALE-POINTER"
    pass "Stale required pointer fixture derives freshness mismatch"
  else
    fail "Stale required pointer fixture derives freshness mismatch"
  fi

  [[ "$derived_reason" == "ERR-STALE-POINTER" ]] && \
    manifest_fixture_matches "FX-NEG-STALE-POINTER" "$file" "Compact" "fail" "$derived_reason" "Stale required pointer fixture"
}

validate_orphan_pointer_fixture() {
  local file="examples/leader-state-profiles/negative-orphan-pointer.md"
  local required target target_path derived_reason=""

  if [[ ! -f "$file" ]]; then
    fail "Orphan pointer fixture exists"
    return
  fi

  required="$(sed -n 's/^Pointer required for current action:[[:space:]]*//p' "$file")"
  target="$(sed -n 's/^Pointer target:[[:space:]]*//p' "$file")"
  target_path="${target%%#*}"
  if [[ "$required" == "yes" && -n "$target_path" && "$target_path" != /* \
      && "$target_path" != ".." && "$target_path" != ../* && "$target_path" != */../* \
      && "$target_path" != */.. && "$target_path" =~ ^[A-Za-z0-9._/-]+$ \
      && ! -e "$target_path" ]]; then
    derived_reason="ERR-ORPHAN-POINTER"
    pass "Orphan pointer fixture derives missing safe repository-relative target"
  else
    fail "Orphan pointer fixture derives missing safe repository-relative target"
  fi

  [[ "$derived_reason" == "ERR-ORPHAN-POINTER" ]] && \
    manifest_fixture_matches "FX-NEG-ORPHAN-POINTER" "$file" "hierarchical-required" "fail" "$derived_reason" "Orphan pointer fixture"
}

validate_conflicting_canonical_source_fixture() {
  local file="examples/leader-state-profiles/negative-conflicting-canonical-source.md"
  local derived_reason=""

  if [[ -f "$file" ]] && awk '
    /^Canonical record:/ {
      key = value = freshness = ""
      if (match($0, /key=[^;]+/)) key = substr($0, RSTART + 4, RLENGTH - 4)
      if (match($0, /value=[^;]+/)) value = substr($0, RSTART + 6, RLENGTH - 6)
      if (match($0, /freshness=[^;[:space:]]+/)) freshness = substr($0, RSTART + 10, RLENGTH - 10)
      if (key == "" || value == "" || freshness != "fresh") malformed = 1
      pair = key SUBSEP value
      if (!seen_pair[pair]++) distinct[key]++
      records++
    }
    END {
      for (key in distinct) if (distinct[key] > 1) conflicts++
      exit !(records > 1 && conflicts > 0 && !malformed)
    }
  ' "$file"; then
    derived_reason="ERR-CONFLICTING-CANONICAL-SOURCE"
    pass "Conflicting canonical source fixture derives distinct current values"
  else
    fail "Conflicting canonical source fixture derives distinct current values"
  fi

  [[ "$derived_reason" == "ERR-CONFLICTING-CANONICAL-SOURCE" ]] && \
    manifest_fixture_matches "FX-NEG-CONFLICT-SOURCE" "$file" "hierarchical-required" "fail" "$derived_reason" "Conflicting canonical source fixture"
}

validate_conflicting_authorization_binding() {
  local file="examples/leader-state-profiles/negative-conflicting-canonical-source.md"
  local manifest="examples/leader-state-profiles/cases.tsv"

  if [[ ! -f "$file" ]]; then
    fail "Conflicting canonical source authorization fixture exists"
    return
  fi

  if bound_authorization_key_count_valid "$file" && awk -F '\t' -v rendered="$file" '
    function normalized_key(value) { return value ~ /^[a-z0-9]+(-[a-z0-9]+)*$/ }
    function valid_authorization(token,    fields) {
      if (split(token, fields, /:/) != 7 || fields[1] != "auth") return 0
      if (!normalized_key(fields[2]) || fields[2] == "none" || !normalized_key(fields[3]) || \
          !normalized_key(fields[4]) || fields[4] ~ /-and-/ || !normalized_key(fields[5]) || \
          !normalized_key(fields[6]) || !normalized_key(fields[7])) return 0
      if (fields[6] == "revoked") revoked++
      else if (fields[6] == "granted") granted++
      return fields[6] == "requested" || fields[6] == "pending" || fields[6] == "granted" || \
        fields[6] == "denied" || fields[6] == "revoked" || fields[6] == "expired"
    }
    FNR == NR {
      if ($0 ~ /^Bound authorization keys:[[:space:]]*[0-9]+$/) {
        declared = $0
        sub(/^Bound authorization keys:[[:space:]]*/, "", declared)
      } else if ($0 ~ /^Authorization key:[[:space:]]*auth:/) {
        token = $0
        sub(/^Authorization key:[[:space:]]*/, "", token)
        if (!valid_authorization(token) || source_keys[token]++) malformed = 1
        source_count++
      }
      next
    }
    FNR == 1 { next }
    $1 == "FX-NEG-CONFLICT-SOURCE" {
      matches++
      manifest_count = split($21, manifest_tokens, /,/)
      for (i = 1; i <= manifest_count; i++) {
        if (manifest_keys[manifest_tokens[i]]++ || !(manifest_tokens[i] in source_keys)) malformed = 1
      }
      for (key in source_keys) if (!(key in manifest_keys)) malformed = 1
      if ($5 == rendered && $13 == declared && declared == source_count && source_count == 2 && \
          manifest_count == source_count && $18 == "fail" && $19 == "ERR-CONFLICTING-CANONICAL-SOURCE") valid++
    }
    END {
      exit !(matches == 1 && valid == 1 && revoked == 1 && granted == 1 && !malformed)
    }
  ' "$file" "$manifest"; then
    pass "Conflicting canonical source fixture binds revoked and granted active authorization keys to the manifest"
  else
    fail "Conflicting canonical source fixture binds revoked and granted active authorization keys to the manifest"
  fi
}

validate_invalid_selection_basis_fixture() {
  local file="examples/leader-state-profiles/negative-invalid-selection-basis.md"
  local method structural derived_reason=""

  if [[ ! -f "$file" ]]; then
    fail "Invalid selection basis fixture exists"
    return
  fi

  method="$(sed -n 's/^Selection basis method:[[:space:]]*//p' "$file")"
  structural="$(sed -n 's/^Structural inventory used for selection:[[:space:]]*//p' "$file")"
  if [[ "$method" == "line-count-only" && "$structural" == "no" ]]; then
    derived_reason="ERR-INVALID-SELECTION-BASIS"
    pass "Invalid selection basis fixture derives non-structural selection"
  else
    fail "Invalid selection basis fixture derives non-structural selection"
  fi

  [[ "$derived_reason" == "ERR-INVALID-SELECTION-BASIS" ]] && \
    manifest_fixture_matches "FX-NEG-SELECTION-BASIS" "$file" "Compact" "fail" "$derived_reason" "Invalid selection basis fixture"
}

validate_duplicate_edge_fixture() {
  local file="examples/leader-state-profiles/duplicate-edge-deduplication.md"

  if [[ -f "$file" ]] && awk -F ';[[:space:]]*' '
    function trim(value) {
      sub(/^[[:space:]]+/, "", value)
      sub(/[[:space:]]+$/, "", value)
      return value
    }
    /^Edge report:/ {
      type = from = to = key = ""
      first = $1
      sub(/^Edge report:[[:space:]]*type=/, "", first)
      type = tolower(trim(first))
      for (i = 2; i <= NF; i++) {
        field = $i
        if (field ~ /^from=/) { sub(/^from=/, "", field); from = tolower(trim(field)) }
        else if (field ~ /^to=/) { sub(/^to=/, "", field); to = tolower(trim(field)) }
        else if (field ~ /^normalized-key=/) { sub(/^normalized-key=/, "", field); key = tolower(trim(field)) }
      }
      if (type == "" || from == "" || to == "" || key == "") malformed = 1
      tuple = type SUBSEP from SUBSEP to SUBSEP key
      rows++
      if (!seen[tuple]++) unique++
    }
    END {
      expected = "dependency" SUBSEP "ws-a" SUBSEP "ws-b" SUBSEP "build-before-test"
      exit !(rows == 3 && unique == 1 && seen[expected] == 3 && !malformed)
    }
  ' "$file" \
    && awk -F '\t' -v source="$file" '
      NR > 1 && $1 == "FX-EDGE-DEDUP" {
        matches++
        if ($5 == source && $10 == 1 && $11 == 0 && $16 == "dep:ws-a>ws-b:build-before-test" && \
            $17 == "Compact" && $18 == "pass" && $19 == "OK-CLASSIFIED") valid++
      }
      END { exit !(matches == 1 && valid == 1) }
    ' examples/leader-state-profiles/cases.tsv; then
    pass "Duplicate edge fixture derives three reports as one normalized tuple and Compact manifest count"
  else
    fail "Duplicate edge fixture derives three reports as one normalized tuple and Compact manifest count"
  fi
}

validate_hierarchical_demotion_fixture() {
  local file="examples/leader-state-profiles/hierarchical-demotion-sequence.md"
  local manifest="examples/leader-state-profiles/cases.tsv"

  if [[ -f "$file" ]] && awk '
    function value_after_colon(line) {
      sub(/^[^:]+:[[:space:]]*/, "", line)
      return line
    }
    /^## Step [123]/ { step++; next }
    step > 0 && /^Fixture ID:/ { id[step] = value_after_colon($0); next }
    step > 0 && /^Step:/ { sequence_step[step] = value_after_colon($0); next }
    step > 0 && /^Checkpoint event:/ { event[step] = value_after_colon($0); next }
    step > 0 && /^Checkpoint evidence:/ { checkpoint_evidence[step] = value_after_colon($0); next }
    step > 0 && /^Measurement freshness:/ { freshness[step] = value_after_colon($0); next }
    step > 0 && /^Decision evidence:/ { decision_evidence[step] = value_after_colon($0); next }
    step > 0 && /^Decision actor:/ { decision_actor[step] = value_after_colon($0); next }
    step > 0 && /^Decision freshness:/ { decision_freshness[step] = value_after_colon($0); next }
    step > 0 && /^Projection assessment:/ { projection[step] = value_after_colon($0); next }
    step > 0 && /^Projection recovery:/ { recovery[step] = value_after_colon($0); next }
    step > 0 && /^Observable projection failures:/ { failures[step] = value_after_colon($0); next }
    step > 0 && /^Active workstreams:/ { workstreams[step] = value_after_colon($0); next }
    step > 0 && /^Blockers:/ { blockers[step] = value_after_colon($0); next }
    step > 0 && /^Live role lifecycles:/ { roles[step] = value_after_colon($0); next }
    step > 0 && /^Validation-freshness groups:/ { validation[step] = value_after_colon($0); next }
    step > 0 && /^Dependency\/conflict edges:/ { dependencies[step] = value_after_colon($0); next }
    step > 0 && /^Overlap edges:/ { overlaps[step] = value_after_colon($0); next }
    step > 0 && /^High-risk gates:/ { gates[step] = value_after_colon($0); next }
    step > 0 && /^Active authorization domains:/ { authorizations[step] = value_after_colon($0); next }
    step > 0 && /^Prior profile:/ { prior[step] = value_after_colon($0); next }
    step > 0 && /^Expected profile:/ { profile[step] = value_after_colon($0); next }
    step > 0 && /^Transition direction:/ { transition[step] = value_after_colon($0); next }
    step > 0 && /^Demotion eligibility:/ { eligibility[step] = value_after_colon($0); next }
    END {
      if (step != 3) bad = 1
      for (i = 1; i <= 3; i++) {
        expected_id[1] = "FX-HIER-DEMOTE-CP1"
        expected_id[2] = "FX-HIER-DEMOTE-CP2"
        expected_id[3] = "FX-HIER-DEMOTE-DECISION"
        if (id[i] != expected_id[i] || sequence_step[i] != i || projection[i] != "reliable-single-file" || \
            recovery[i] != "verified" || failures[i] != "none" || prior[i] != "hierarchical-required") bad = 1
        if (workstreams[i] !~ /^[0-9]+$/ || workstreams[i] > 4 || blockers[i] !~ /^[0-9]+$/ || blockers[i] > 8 || \
            roles[i] !~ /^[0-9]+$/ || roles[i] > 12 || validation[i] !~ /^[0-9]+$/ || validation[i] > 12 || \
            dependencies[i] !~ /^[0-9]+$/ || dependencies[i] > 24 || overlaps[i] !~ /^[0-9]+$/ || overlaps[i] > 16 || \
            gates[i] !~ /^[0-9]+$/ || gates[i] > 2 || authorizations[i] !~ /^[0-9]+$/ || authorizations[i] > 2) bad = 1
      }
      if (event[1] == "" || event[2] == "" || event[1] == event[2] || checkpoint_evidence[1] == "" || \
          checkpoint_evidence[2] == "" || freshness[1] != "fresh" || freshness[2] != "fresh") bad = 1
      if (profile[1] != "hierarchical-required" || transition[1] != "retain" || eligibility[1] != "") bad = 1
      if (profile[2] != "hierarchical-required" || transition[2] != "retain" || eligibility[2] != "eligible") bad = 1
      if (profile[3] != "Standard" || transition[3] != "demote" || eligibility[3] != "eligible" || \
          decision_evidence[3] == "" || decision_actor[3] != "Leader" || decision_freshness[3] != "fresh") bad = 1
      exit bad ? 1 : 0
    }
  ' "$file" \
    && awk -F '\t' -v source="$file" '
      NR > 1 && $2 == "seq-hierarchical-demote" {
        matches++
        if ($5 != source || $3 != matches || $14 != "reliable-single-file" || $15 != "transition-measurement-full-counts") bad = 1
        if (matches == 1 && ($1 != "FX-HIER-DEMOTE-CP1" || $17 != "hierarchical-required" || $19 != "OK-RETAIN-HYSTERESIS")) bad = 1
        if (matches == 2 && ($1 != "FX-HIER-DEMOTE-CP2" || $17 != "hierarchical-required" || $19 != "OK-DEMOTION-ELIGIBLE")) bad = 1
        if (matches == 3 && ($1 != "FX-HIER-DEMOTE-DECISION" || $17 != "Standard" || $19 != "OK-DEMOTED-BY-DECISION")) bad = 1
      }
      END { exit !(matches == 3 && !bad) }
    ' "$manifest"; then
    pass "Hierarchical demotion fixture derives fresh recovered projection sequence and explicit Leader transition"
  else
    fail "Hierarchical demotion fixture derives fresh recovered projection sequence and explicit Leader transition"
  fi
}

rendered_authorization_count_source_valid() {
  local file="$1"

  awk '
    function trim(value) {
      sub(/^[[:space:]]+/, "", value)
      sub(/[[:space:]]+$/, "", value)
      return value
    }
    {
      line = trim($0)
      if (line ~ /^Active authorization domains:[[:space:]]*[0-9]+$/) {
        value = line
        sub(/^Active authorization domains:[[:space:]]*/, "", value)
        sources++
      } else if (line ~ /^\| Active authorization domains \|[[:space:]]*[0-9]+[[:space:]]*\|/) {
        split(line, table, /\|/)
        value = trim(table[3])
        sources++
      }
      if (sources > 0 && value !~ /^[0-9]+$/) malformed = 1
    }
    END { exit !(sources == 1 && !malformed) }
  ' "$file"
}

bound_authorization_key_count_valid() {
  local file="$1"

  awk '
    {
      if ($0 ~ /^[[:space:]]*Bound authorization keys:[[:space:]]*[0-9]+$/) {
        value = $0
        sub(/^[[:space:]]*Bound authorization keys:[[:space:]]*/, "", value)
        bound_sources++
        bound_count = value + 0
      } else if ($0 ~ /^[[:space:]]*Authorization key:[[:space:]]*auth:/) {
        token = $0
        sub(/^[[:space:]]*Authorization key:[[:space:]]*/, "", token)
        sub(/;.*/, "", token)
        if (seen[token]++) malformed = 1
        key_count++
      }
    }
    END { exit !(bound_sources == 1 && bound_count == key_count && !malformed) }
  ' "$file"
}

detailed_authorization_contract_valid() {
  local file="$1"
  local expected_case="$2"
  local manifest="examples/leader-state-profiles/cases.tsv"

  awk -F '\t' -v expected_case="$expected_case" '
    function trim(value) {
      sub(/^[[:space:]]+/, "", value)
      sub(/[[:space:]]+$/, "", value)
      return value
    }
    function normalized_key(value) { return value ~ /^[a-z0-9]+(-[a-z0-9]+)*$/ }
    function valid_authorization(token,    fields) {
      if (split(token, fields, /:/) != 7 || fields[1] != "auth") return 0
      if (!normalized_key(fields[2]) || fields[2] == "none" || !normalized_key(fields[3]) || \
          !normalized_key(fields[4]) || fields[4] ~ /-and-/ || !normalized_key(fields[5]) || \
          !normalized_key(fields[6]) || !normalized_key(fields[7])) return 0
      return fields[6] == "requested" || fields[6] == "pending" || fields[6] == "granted" || \
        fields[6] == "denied" || fields[6] == "revoked" || fields[6] == "expired"
    }
    FNR == NR {
      line = trim($0)
      if (line ~ /^Active authorization domains:[[:space:]]*[0-9]+$/) {
        value = line
        sub(/^Active authorization domains:[[:space:]]*/, "", value)
        active = value + 0
        active_sources++
      } else if (line ~ /^\| Active authorization domains \|[[:space:]]*[0-9]+[[:space:]]*\|/) {
        split(line, table, /\|/)
        active = trim(table[3]) + 0
        active_sources++
      } else if (line ~ /^Bound authorization keys:[[:space:]]*[0-9]+$/) {
        value = line
        sub(/^Bound authorization keys:[[:space:]]*/, "", value)
        bound = value + 0
        bound_sources++
      } else if (line ~ /^Authorization key:[[:space:]]*auth:/) {
        token = line
        sub(/^Authorization key:[[:space:]]*/, "", token)
        sub(/;.*/, "", token)
        if (!valid_authorization(token) || source_keys[token]++) malformed = 1
        key_count++
      }
      next
    }
    FNR == 1 { next }
    $1 == expected_case {
      matches++
      if ($21 == "none") {
        manifest_key_count = 0
        if (key_count != 0) malformed = 1
      } else if ($21 == "@standard-size-warning.md#authorization-and-gate-state" && \
          expected_case == "FX-SIZE-WARNING") {
        manifest_key_count = 3
      } else {
        if ($21 ~ /^gen:auth:/ || $21 ~ /^@/) malformed = 1
        manifest_key_count = split($21, manifest_tokens, /,/)
        for (i = 1; i <= manifest_key_count; i++) {
          if (manifest_keys[manifest_tokens[i]]++ || !(manifest_tokens[i] in source_keys)) malformed = 1
        }
        for (key in source_keys) if (!(key in manifest_keys)) malformed = 1
      }
      if ($13 == active && active == bound && bound == key_count && manifest_key_count == key_count) valid++
    }
    END {
      exit !(active_sources == 1 && bound_sources == 1 && matches == 1 && valid == 1 && !malformed)
    }
  ' "$file" "$manifest"
}

validate_detailed_authorization_contract() {
  local file="$1" case_id="$2" label="$3"

  if detailed_authorization_contract_valid "$file" "$case_id"; then
    pass "$label binds one Active count, one Bound count, and the exact authorization key set"
  else
    fail "$label binds one Active count, one Bound count, and the exact authorization key set"
  fi
}

hierarchical_authorization_contract_valid() {
  local file="$1"
  local manifest="examples/leader-state-profiles/cases.tsv"

  awk -F '\t' '
    function trim(value) {
      sub(/^[[:space:]]+/, "", value)
      sub(/[[:space:]]+$/, "", value)
      return value
    }
    function value_after_colon(value) {
      sub(/^[^:]+:[[:space:]]*/, "", value)
      return trim(value)
    }
    function normalized_key(value) { return value ~ /^[a-z0-9]+(-[a-z0-9]+)*$/ }
    function valid_authorization(token,    fields) {
      if (split(token, fields, /:/) != 7 || fields[1] != "auth") return 0
      if (!normalized_key(fields[2]) || fields[2] == "none" || !normalized_key(fields[3]) || \
          !normalized_key(fields[4]) || fields[4] ~ /-and-/ || !normalized_key(fields[5]) || \
          !normalized_key(fields[6]) || !normalized_key(fields[7])) return 0
      return fields[6] == "requested" || fields[6] == "pending" || fields[6] == "granted" || \
        fields[6] == "denied" || fields[6] == "revoked" || fields[6] == "expired"
    }
    FNR == NR {
      line = trim($0)
      if (line ~ /^## Step [123]/) { step++; next }
      if (step > 0 && line ~ /^Fixture ID:/) { id[step] = value_after_colon(line); next }
      if (step > 0 && line ~ /^Active authorization domains:[[:space:]]*[0-9]+$/) {
        active[step] = value_after_colon(line) + 0
        active_sources[step]++
        next
      }
      if (step > 0 && line ~ /^Bound authorization keys:[[:space:]]*[0-9]+$/) {
        bound[step] = value_after_colon(line) + 0
        bound_sources[step]++
        next
      }
      if (step > 0 && line ~ /^Authorization key:[[:space:]]*auth:/) {
        token = line
        sub(/^Authorization key:[[:space:]]*/, "", token)
        if (!valid_authorization(token) || source_keys[id[step] SUBSEP token]++) malformed = 1
        key_count[step]++
      }
      next
    }
    FNR == 1 { next }
    {
      for (s = 1; s <= 3; s++) if ($1 == id[s]) {
        matches[s]++
        manifest_count = split($21, manifest_tokens, /,/)
        for (i = 1; i <= manifest_count; i++) {
          identity = id[s] SUBSEP manifest_tokens[i]
          if (manifest_keys[identity]++ || !(identity in source_keys)) malformed = 1
        }
        for (identity in source_keys) {
          split(identity, identity_parts, SUBSEP)
          if (identity_parts[1] == id[s] && !(identity in manifest_keys)) malformed = 1
        }
        if ($13 == active[s] && active[s] == bound[s] && bound[s] == key_count[s] && \
            manifest_count == key_count[s]) valid[s]++
      }
    }
    END {
      expected[1] = "FX-HIER-DEMOTE-CP1"
      expected[2] = "FX-HIER-DEMOTE-CP2"
      expected[3] = "FX-HIER-DEMOTE-DECISION"
      for (s = 1; s <= 3; s++) {
        if (id[s] != expected[s] || active_sources[s] != 1 || bound_sources[s] != 1 || \
            matches[s] != 1 || valid[s] != 1) malformed = 1
      }
      exit malformed ? 1 : 0
    }
  ' "$file" "$manifest"
}

validate_hierarchical_authorization_contract() {
  local file="examples/leader-state-profiles/hierarchical-demotion-sequence.md"

  if hierarchical_authorization_contract_valid "$file"; then
    pass "Hierarchical demotion binds independent Active and Bound counts plus exact keys for every step"
  else
    fail "Hierarchical demotion binds independent Active and Bound counts plus exact keys for every step"
  fi
}

validate_authorization_count_source_probes() {
  local compact_file="examples/leader-state-profiles/compact-feasibility.md"
  local size_file="examples/leader-state-profiles/standard-size-warning.md"
  local auxiliary_file="examples/leader-state-profiles/duplicate-edge-deduplication.md"
  local hierarchical_file="examples/leader-state-profiles/hierarchical-demotion-sequence.md"

  if awk '{ print } END { print "Active authorization domains: 0" }' "$compact_file" | \
      rendered_authorization_count_source_valid - 2>/dev/null; then
    fail "Rendered profile rejects a duplicate identical authorization count source"
  else
    pass "Rendered profile rejects a duplicate identical authorization count source"
  fi

  if awk '{ if ($0 ~ /^Bound authorization keys:[[:space:]]*3$/) print "Bound authorization keys: 4"; else print }' \
      "$size_file" | bound_authorization_key_count_valid - 2>/dev/null; then
    fail "Authorization binding rejects a bound-key count mismatch"
  else
    pass "Authorization binding rejects a bound-key count mismatch"
  fi

  if awk '{ if ($0 == "Active authorization domains: 1") print "Active authorization domains: 2"; else print }' \
      "$auxiliary_file" | detailed_authorization_contract_valid - "FX-EDGE-DEDUP" 2>/dev/null; then
    fail "Auxiliary authorization contract rejects an Active-only count change"
  else
    pass "Auxiliary authorization contract rejects an Active-only count change"
  fi

  if awk '{ if ($0 == "Bound authorization keys: 1") print "Bound authorization keys: 2"; else print }' \
      "$auxiliary_file" | detailed_authorization_contract_valid - "FX-EDGE-DEDUP" 2>/dev/null; then
    fail "Auxiliary authorization contract rejects a Bound-only count change"
  else
    pass "Auxiliary authorization contract rejects a Bound-only count change"
  fi

  if awk 'BEGIN { changed = 0 }
      !changed && $0 == "Active authorization domains: 2" { print "Active authorization domains: 1"; changed = 1; next }
      { print }
    ' "$hierarchical_file" | hierarchical_authorization_contract_valid - 2>/dev/null; then
    fail "Hierarchical authorization contract rejects an Active-only count change"
  else
    pass "Hierarchical authorization contract rejects an Active-only count change"
  fi

  if awk 'BEGIN { changed = 0 }
      !changed && $0 == "Bound authorization keys: 2" { print "Bound authorization keys: 1"; changed = 1; next }
      { print }
    ' "$hierarchical_file" | hierarchical_authorization_contract_valid - 2>/dev/null; then
    fail "Hierarchical authorization contract rejects a Bound-only count change"
  else
    pass "Hierarchical authorization contract rejects a Bound-only count change"
  fi
}

validate_rendered_profile_fixture() {
  local file="$1" expected_warning="$2" label="$3"
  local embedded_lines embedded_bytes actual_lines actual_bytes warning_state computed_warning declared_profile

  if [[ ! -f "$file" ]]; then
    fail "$label exists"
    return
  fi

  embedded_lines="$(sed -n 's/^[[:space:]]*Physical lines:[[:space:]]*//p' "$file")"
  embedded_bytes="$(sed -n 's/^[[:space:]]*UTF-8 bytes:[[:space:]]*//p' "$file")"
  warning_state="$(sed -n 's/^[[:space:]]*Size warning state:[[:space:]]*//p' "$file" | sed 's/[.;].*$//')"
  declared_profile="$(sed -n 's/^[[:space:]]*Leader state profile:[[:space:]]*//p' "$file")"
  actual_lines="$(wc -l < "$file" | tr -d '[:space:]')"
  actual_bytes="$(LC_ALL=C wc -c < "$file" | tr -d '[:space:]')"

  computed_warning="within-warning"
  if [[ "$declared_profile" == "Compact" ]]; then
    if [[ "$actual_lines" -gt 140 && "$actual_bytes" -gt 16384 ]]; then computed_warning="line-and-byte-warning"
    elif [[ "$actual_lines" -gt 140 ]]; then computed_warning="line-warning"
    elif [[ "$actual_bytes" -gt 16384 ]]; then computed_warning="byte-warning"
    fi
  else
    if [[ "$actual_lines" -gt 200 && "$actual_bytes" -gt 24576 ]]; then computed_warning="line-and-byte-warning"
    elif [[ "$actual_lines" -gt 200 ]]; then computed_warning="line-warning"
    elif [[ "$actual_bytes" -gt 24576 ]]; then computed_warning="byte-warning"
    fi
  fi

  if [[ "$embedded_lines" =~ ^[0-9]+$ && "$embedded_lines" == "$actual_lines" ]]; then
    pass "$label physical-line measurement"
  else
    fail "$label physical-line measurement"
  fi
  if [[ "$embedded_bytes" =~ ^[0-9]+$ && "$embedded_bytes" == "$actual_bytes" ]]; then
    pass "$label UTF-8-byte measurement"
  else
    fail "$label UTF-8-byte measurement"
  fi
  template_contains "$file" "Inventory scope: current-active-only" "$label current-active-only scope"
  template_contains "$file" "Measurement source kind: fixture-measurement" "$label measurement source kind"
  template_contains "$file" "Measurement freshness: fresh" "$label measurement freshness"
  template_contains "$file" "Selection detail: full-counts" "$label full deterministic counts"
  template_contains "$file" "Profile selection basis:" "$label selection basis"
  template_contains "$file" "Projection assessment: reliable-single-file" "$label projection assessment"
  template_contains "$file" "Checkpoint event: validation-fixture" "$label checkpoint event"
  template_contains "$file" "Authorization" "$label authorization state"
  template_contains "$file" "Role" "$label role continuity state"
  template_contains "$file" "Validation" "$label validation state"
  template_contains "$file" "Claim-" "$label claim-indexed evidence"
  template_contains "$file" "Archive" "$label archive-note capability"

  if rendered_authorization_count_source_valid "$file"; then
    pass "$label has exactly one active authorization-domain count source"
  else
    fail "$label has exactly one active authorization-domain count source"
  fi

  if awk -F '\t' -v rendered="$file" '
    function trim(value) {
      sub(/^[[:space:]]+/, "", value)
      sub(/[[:space:]]+$/, "", value)
      return value
    }
    function clean(value) {
      value = trim(value)
      gsub(/`/, "", value)
      return value
    }
    function value_after_colon(value) {
      sub(/^[^:]+:[[:space:]]*/, "", value)
      return clean(value)
    }
    function set_count(key, value) {
      value = clean(value)
      if (value !~ /^[0-9]+$/ || count_seen[key]++) malformed = 1
      counts[key] = value + 0
    }
    function add_contract_keys(value, kind,    n, parts, i, key, identity) {
      n = split(clean(value), parts, /,/)
      for (i = 1; i <= n; i++) {
        key = trim(parts[i])
        if (key !~ /^[a-z0-9]+(-[a-z0-9]+)*$/) malformed = 1
        identity = kind SUBSEP key
        if (contract_seen[identity]++) malformed = 1
        if (kind == "required") required[key] = 1
        else present[key] = 1
      }
    }
    function normalized_edge_identity(token,    value, separator, pair, suffix, endpoints, swap) {
      if (token !~ /^(conflict|overlap):/) return token
      value = token
      sub(/^(conflict|overlap):/, "", value)
      separator = index(value, ":")
      pair = substr(value, 1, separator - 1)
      suffix = substr(value, separator + 1)
      split(pair, endpoints, /[+]/)
      if (endpoints[1] > endpoints[2]) { swap = endpoints[1]; endpoints[1] = endpoints[2]; endpoints[2] = swap }
      return substr(token, 1, index(token, ":")) endpoints[1] "+" endpoints[2] ":" suffix
    }
    function add_edge(value, kind,    token, identity) {
      token = value
      if (kind == "dep") sub(/^Dependency edge[: ]+/, "", token)
      else if (kind == "conflict") sub(/^Conflict edge[: ]+/, "", token)
      else sub(/^Overlap edge[: ]+/, "", token)
      sub(/:[[:space:]]+unique normalized tuple.*$/, "", token)
      token = clean(token)
      if (kind == "dep" && token !~ /^dep:[a-z0-9][-a-z0-9._\/]*>[a-z0-9][-a-z0-9._\/]*:[a-z0-9][-a-z0-9._\/+>:]*$/) malformed = 1
      else if (kind == "conflict" && token !~ /^conflict:[a-z0-9][-a-z0-9._\/]*[+][a-z0-9][-a-z0-9._\/]*:[a-z0-9][-a-z0-9._\/+>:]*$/) malformed = 1
      else if (kind == "overlap" && token !~ /^overlap:[a-z0-9][-a-z0-9._\/]*[+][a-z0-9][-a-z0-9._\/]*:[a-z0-9][-a-z0-9._\/+>:]*$/) malformed = 1
      identity = normalized_edge_identity(token)
      if (edge_seen[identity]++) malformed = 1
      if (kind == "overlap") rendered_overlap++
      else rendered_dep_conflict++
    }
    function compact_ok() {
      return counts["workstreams"] <= 2 && counts["blockers"] <= 5 && counts["roles"] <= 8 && \
        counts["validation"] <= 8 && counts["dep-conflict"] <= 10 && counts["overlap"] <= 5 && \
        counts["gates"] <= 2 && counts["authorizations"] <= 2
    }
    function standard_ok() {
      return counts["workstreams"] <= 5 && counts["blockers"] <= 10 && counts["roles"] <= 15 && \
        counts["validation"] <= 15 && counts["dep-conflict"] <= 30 && counts["overlap"] <= 20 && \
        counts["gates"] <= 3 && counts["authorizations"] <= 3
    }
    FNR == NR {
      line = trim($0)
      if (line ~ /^Fixture ID:/) fixture_id = value_after_colon(line)
      else if (line ~ /^Expected result:/) expected_result = value_after_colon(line)
      else if (line ~ /^Expected reason:/) expected_reason = value_after_colon(line)
      else if (line ~ /^Schema required keys:/) { value = line; sub(/^Schema required keys:[[:space:]]*/, "", value); add_contract_keys(value, "required") }
      else if (line ~ /^Present keys:/) { value = line; sub(/^Present keys:[[:space:]]*/, "", value); add_contract_keys(value, "present") }
      else if (line ~ /^Scenario source:/) source = value_after_colon(line)
      else if (line ~ /^Measurement source:/ && source == "") source = value_after_colon(line)
      else if (line ~ /^Leader state profile:/) declared_profile = value_after_colon(line)
      else if (line ~ /^Projection assessment:/) projection = value_after_colon(line)
      else if (line ~ /^Active workstreams:[[:space:]]*[0-9]+$/) set_count("workstreams", value_after_colon(line))
      else if (line ~ /^Blockers:[[:space:]]*[0-9]+$/) set_count("blockers", value_after_colon(line))
      else if (line ~ /^Live role lifecycles:[[:space:]]*[0-9]+$/) set_count("roles", value_after_colon(line))
      else if (line ~ /^Validation-freshness groups:[[:space:]]*[0-9]+$/) set_count("validation", value_after_colon(line))
      else if (line ~ /^Dependency\/conflict edges:[[:space:]]*[0-9]+$/) set_count("dep-conflict", value_after_colon(line))
      else if (line ~ /^Overlap edges:[[:space:]]*[0-9]+$/) set_count("overlap", value_after_colon(line))
      else if (line ~ /^High-risk gates:[[:space:]]*[0-9]+$/) set_count("gates", value_after_colon(line))
      else if (line ~ /^Active authorization domains:[[:space:]]*[0-9]+$/) set_count("authorizations", value_after_colon(line))
      else if (line ~ /^\| (Active workstreams|Blockers|Live role lifecycles|Validation-freshness groups|Dependency\/conflict edges|Overlap edges|High-risk gates|Active authorization domains) \|[[:space:]]*[0-9]+[[:space:]]*\|/) {
        split(line, table, /\|/)
        dimension = trim(table[2])
        value = trim(table[3])
        if (dimension == "Active workstreams") set_count("workstreams", value)
        else if (dimension == "Blockers") set_count("blockers", value)
        else if (dimension == "Live role lifecycles") set_count("roles", value)
        else if (dimension == "Validation-freshness groups") set_count("validation", value)
        else if (dimension == "Dependency/conflict edges") set_count("dep-conflict", value)
        else if (dimension == "Overlap edges") set_count("overlap", value)
        else if (dimension == "High-risk gates") set_count("gates", value)
        else if (dimension == "Active authorization domains") set_count("authorizations", value)
      }
      if (line ~ /^Dependency edge[: ]/) add_edge(line, "dep")
      else if (line ~ /^Conflict edge[: ]/) add_edge(line, "conflict")
      else if (line ~ /^Overlap edge[: ]/) add_edge(line, "overlap")
      next
    }
    FNR == 1 { next }
    $1 == fixture_id {
      manifest_matches++
      if ($5 == source && $6 == counts["workstreams"] && $7 == counts["blockers"] && \
          $8 == counts["roles"] && $9 == counts["validation"] && $10 == counts["dep-conflict"] && \
          $11 == counts["overlap"] && $12 == counts["gates"] && $13 == counts["authorizations"] && \
          $14 == projection && $17 == declared_profile && $18 == expected_result && $19 == expected_reason) manifest_valid++
    }
    END {
      expected_dimensions[1] = "workstreams"
      expected_dimensions[2] = "blockers"
      expected_dimensions[3] = "roles"
      expected_dimensions[4] = "validation"
      expected_dimensions[5] = "dep-conflict"
      expected_dimensions[6] = "overlap"
      expected_dimensions[7] = "gates"
      expected_dimensions[8] = "authorizations"
      for (i = 1; i <= 8; i++) if (count_seen[expected_dimensions[i]] != 1) malformed = 1
      for (key in required) { required_count++; if (!(key in present)) malformed = 1 }
      for (key in present) { present_count++; if (!(key in required)) malformed = 1 }
      if (required_count == 0 || required_count != present_count) malformed = 1
      if (projection == "projection-failed") derived_profile = "hierarchical-required"
      else if (projection == "reliable-single-file" && compact_ok()) derived_profile = "Compact"
      else if (projection == "reliable-single-file" && standard_ok()) derived_profile = "Standard"
      else if (projection == "reliable-single-file") derived_profile = "hierarchical-required"
      else malformed = 1
      if (fixture_id == "" || source == "" || expected_result == "" || expected_reason == "" || declared_profile != derived_profile) malformed = 1
      if (rendered_dep_conflict != counts["dep-conflict"] || rendered_overlap != counts["overlap"]) malformed = 1
      if (manifest_matches != 1 || manifest_valid != 1) malformed = 1
      exit malformed ? 1 : 0
    }
  ' "$file" examples/leader-state-profiles/cases.tsv; then
    pass "$label derives all dimensions, profile, applicable fields, typed relationships, and exact manifest linkage"
  else
    fail "$label derives all dimensions, profile, applicable fields, typed relationships, and exact manifest linkage"
  fi

  if [[ "$warning_state" == "$expected_warning" && "$warning_state" == "$computed_warning" ]]; then
    if [[ "$expected_warning" == "within-warning" ]]; then
      pass "$label size warning state"
    else
      warn "$label size warning state: $warning_state (non-blocking)"
    fi
  else
    fail "$label size warning state"
  fi
}

validate_profile_rendered_enumerations() {
  local file="examples/leader-state-profiles/standard-size-warning.md"
  local count record prefix remainder expected description
  for record in \
    "| ws-:5:active workstreams" \
    "Dependency edge :30:dependency/conflict edges" \
    "Overlap edge :20:overlap edges" \
    "Blocker blocker-:10:blockers" \
    "Role role-:15:role lifecycles" \
    "Validation group vg-:15:validation groups" \
    "High-risk gate gate-:3:high-risk gates" \
    "Authorization key:3:authorization domains"; do
    prefix="${record%%:*}"
    remainder="${record#*:}"
    expected="${remainder%%:*}"
    description="${remainder#*:}"
    count="$(grep -c "^${prefix}" "$file" || true)"
    if [[ "$count" == "$expected" ]]; then
      pass "Standard warning fixture enumerates $description"
    else
      fail "Standard warning fixture enumerates $description"
    fi
  done

  for required_gate in \
    "High-risk gate gate-01: tag and release decision" \
    "High-risk gate gate-02: production deployment decision" \
    "High-risk gate gate-03: primary schema migration decision"; do
    if contains "$file" "$required_gate"; then
      pass "Standard warning fixture uses a genuine high-risk gate: $required_gate"
    else
      fail "Standard warning fixture uses a genuine high-risk gate: $required_gate"
    fi
  done

  if grep -Eq '^High-risk gate gate-[0-9]+: (commit|push) decision' "$file"; then
    fail "Standard warning fixture does not classify normal commit or push as high-risk"
  else
    pass "Standard warning fixture does not classify normal commit or push as high-risk"
  fi
}

validate_rendered_authorization_bindings() {
  local manifest="examples/leader-state-profiles/cases.tsv"
  local size_file="examples/leader-state-profiles/standard-size-warning.md"
  local handoff_file="examples/handoff-task.md"

  if bound_authorization_key_count_valid "$size_file" && awk -F '\t' '
    function normalized_key(value) { return value ~ /^[a-z0-9]+(-[a-z0-9]+)*$/ }
    function valid_authorization(token,    fields) {
      if (split(token, fields, /:/) != 7 || fields[1] != "auth") return 0
      if (!normalized_key(fields[2]) || fields[2] == "none" || !normalized_key(fields[3]) || \
          !normalized_key(fields[4]) || fields[4] ~ /-and-/ || !normalized_key(fields[5]) || \
          !normalized_key(fields[6]) || !normalized_key(fields[7])) return 0
      return fields[6] == "requested" || fields[6] == "pending" || fields[6] == "granted" || \
        fields[6] == "denied" || fields[6] == "revoked" || fields[6] == "expired"
    }
    FNR == NR {
      if ($0 ~ /^Bound authorization keys:[[:space:]]*[0-9]+$/) {
        declared = $0
        sub(/^Bound authorization keys:[[:space:]]*/, "", declared)
      } else if ($0 ~ /^Authorization key:[[:space:]]*auth:/) {
        token = $0
        sub(/^Authorization key:[[:space:]]*/, "", token)
        sub(/;.*/, "", token)
        if (!valid_authorization(token) || seen[token]++) malformed = 1
        split(token, fields, /:/)
        if (fields[4] == "publication") active_publication = 1
        active_count++
      } else if ($0 ~ /^Standing unrequested exclusion: publication .*not counted as an active authorization domain[.]$/) {
        standing_publication++
      }
      next
    }
    FNR == 1 { next }
    $1 == "FX-SIZE-WARNING" {
      matches++
      if ($5 == "synthetic:standard-structural-ceilings" && $13 == declared && declared == active_count && active_count == 3 && \
          $21 == "@standard-size-warning.md#authorization-and-gate-state") valid++
    }
    END {
      exit !(matches == 1 && valid == 1 && declared == 3 && active_count == 3 && standing_publication == 1 && \
        !active_publication && !malformed)
    }
  ' "$size_file" "$manifest"; then
    pass "Standard warning fixture derives three unique active authorization tuples and excludes standing publication"
  else
    fail "Standard warning fixture derives three unique active authorization tuples and excludes standing publication"
  fi

  if bound_authorization_key_count_valid "$handoff_file" && awk -F '\t' '
    function normalized_key(value) { return value ~ /^[a-z0-9]+(-[a-z0-9]+)*$/ }
    function valid_authorization(token,    fields) {
      if (split(token, fields, /:/) != 7 || fields[1] != "auth") return 0
      if (!normalized_key(fields[2]) || fields[2] == "none" || !normalized_key(fields[3]) || \
          !normalized_key(fields[4]) || fields[4] ~ /-and-/ || !normalized_key(fields[5]) || \
          !normalized_key(fields[6]) || !normalized_key(fields[7])) return 0
      return fields[6] == "requested" || fields[6] == "pending" || fields[6] == "granted" || \
        fields[6] == "denied" || fields[6] == "revoked" || fields[6] == "expired"
    }
    FNR == NR {
      if ($0 ~ /^Bound authorization keys:[[:space:]]*[0-9]+$/) {
        declared = $0
        sub(/^Bound authorization keys:[[:space:]]*/, "", declared)
      } else if ($0 ~ /^Authorization key:[[:space:]]*auth:/) {
        token = $0
        sub(/^Authorization key:[[:space:]]*/, "", token)
        if (!valid_authorization(token) || seen[token]++) malformed = 1
        split(token, fields, /:/)
        if (fields[4] == "push") active_push = 1
        active_count++
      } else if ($0 ~ /^Standing exclusions not counted:/ && $0 ~ /(^|[ ,])push([, ]|$)/) {
        standing_push++
      }
      next
    }
    FNR == 1 { next }
    $1 == "FX-TAKEOVER-STANDARD" {
      matches++
      if ($5 == "examples/handoff-task.md" && $13 == declared && declared == active_count && active_count == 1 && \
          $21 == token) valid++
    }
    END {
      exit !(matches == 1 && valid == 1 && declared == 1 && active_count == 1 && standing_push == 1 && \
        !active_push && !malformed)
    }
  ' "$handoff_file" "$manifest"; then
    pass "Takeover fixture binds the current commit authorization tuple and excludes standing push"
  else
    fail "Takeover fixture binds the current commit authorization tuple and excludes standing push"
  fi
}

cleanup_case_eligible() {
  local state="$1"
  local p0_p1_clear="$2"
  local blocked_evidence_clear="$3"
  local evidence_gap_clear="$4"
  local required_correction_clear="$5"
  local owner_decision_clear="$6"
  local required_reviews_and_later_gates_complete="$7"
  local target_class="$8"
  local audit_complete="$9"
  local retry_lineage_complete="${10}"
  local cleanup_impact_known="${11}"

  CLEANUP_CASE_REASON="eligible"

  case "$state" in
    prepared) CLEANUP_CASE_REASON="prepared-invocation"; return 1 ;;
    running) CLEANUP_CASE_REASON="running-invocation"; return 1 ;;
    result-unknown) CLEANUP_CASE_REASON="result-unknown-invocation"; return 1 ;;
    completed|failed-confirmed|superseded) ;;
    *) CLEANUP_CASE_REASON="invalid-invocation-state"; return 1 ;;
  esac
  [[ "$p0_p1_clear" == "yes" ]] || { CLEANUP_CASE_REASON="unresolved-p0-p1"; return 1; }
  [[ "$blocked_evidence_clear" == "yes" ]] || { CLEANUP_CASE_REASON="blocked-evidence"; return 1; }
  [[ "$evidence_gap_clear" == "yes" ]] || { CLEANUP_CASE_REASON="evidence-gap"; return 1; }
  [[ "$required_correction_clear" == "yes" ]] || { CLEANUP_CASE_REASON="required-correction"; return 1; }
  [[ "$owner_decision_clear" == "yes" ]] || { CLEANUP_CASE_REASON="owner-decision"; return 1; }
  [[ "$required_reviews_and_later_gates_complete" == "yes" ]] || { CLEANUP_CASE_REASON="required-review-or-later-gate"; return 1; }
  [[ "$target_class" == "lifecycle-bound working material" ]] || { CLEANUP_CASE_REASON="permanent-or-ineligible-target"; return 1; }
  [[ "$audit_complete" == "yes" ]] || { CLEANUP_CASE_REASON="incomplete-audit"; return 1; }
  [[ "$retry_lineage_complete" == "yes" ]] || { CLEANUP_CASE_REASON="incomplete-retry-lineage"; return 1; }
  [[ "$cleanup_impact_known" == "yes" ]] || { CLEANUP_CASE_REASON="unknown-cleanup-impact"; return 1; }
}

expect_cleanup_case_pass() {
  local label="$1"
  shift
  if cleanup_case_eligible "$@"; then
    pass "$label"
  else
    fail "$label"
  fi
}

expect_cleanup_case_reject() {
  local label="$1"
  local expected_reason="$2"
  shift 2
  if cleanup_case_eligible "$@"; then
    fail "$label"
  elif [[ "$CLEANUP_CASE_REASON" == "$expected_reason" ]]; then
    pass "$label ($expected_reason)"
  else
    fail "$label expected $expected_reason, got $CLEANUP_CASE_REASON"
  fi
}

lifecycle_case_valid() {
  # Positional fixture schema: current/prior C-stage and Stage Session IDs,
  # runtime identity, checkpoint states, lifecycle trigger/reason, invocation
  # concurrency, lifecycle event, transition flag, and transition actor/time.
  local c_stage="$1" prior_stage="$2" stage_id="$3" prior_stage_id="$4" runtime_kind="$5" runtime_id="$6"
  local runtime_evidence="$7" resume_evidence="$8" inherited="$9" fresh_decision="${10}" no_peek="${11}"
  local validation_freshness="${12}" authorization="${13}" continuity="${14}" trigger="${15}" restart_reason="${16}"
  local old_attempt_state="${17}" concurrency_resolved="${18}" lifecycle_event="${19}" transition="${20}" actor="${21}" decision_time="${22}"
  LIFECYCLE_CASE_REASON="eligible"

  case "$c_stage" in C0-bootstrap|C1|C2|C3|C4|non-openspec) ;; *) LIFECYCLE_CASE_REASON="invalid-c-stage"; return 1 ;; esac
  case "$prior_stage" in none|C0-bootstrap|C1|C2|C3|C4|non-openspec) ;; *) LIFECYCLE_CASE_REASON="invalid-prior-c-stage"; return 1 ;; esac
  [[ -n "$stage_id" ]] || { LIFECYCLE_CASE_REASON="missing-stage-session-id"; return 1; }
  [[ -n "$prior_stage_id" ]] || { LIFECYCLE_CASE_REASON="missing-prior-stage-session-id"; return 1; }
  case "$runtime_kind" in claude|other) ;; *) LIFECYCLE_CASE_REASON="invalid-runtime-kind"; return 1 ;; esac
  [[ -n "$runtime_id" ]] || { LIFECYCLE_CASE_REASON="missing-runtime-identity"; return 1; }
  case "$runtime_evidence" in exact-supported|unavailable|contradictory) ;; *) LIFECYCLE_CASE_REASON="invalid-runtime-evidence"; return 1 ;; esac
  case "$inherited" in none|verified-same-stage|verified-restart-packet) ;; *) LIFECYCLE_CASE_REASON="invalid-inherited-context"; return 1 ;; esac
  case "$fresh_decision" in confirmed|blocked) ;; *) LIFECYCLE_CASE_REASON="invalid-fresh-decision"; return 1 ;; esac
  case "$no_peek" in isolated-current-first-pass|consensus-open|contaminated) ;; *) LIFECYCLE_CASE_REASON="invalid-no-peek"; return 1 ;; esac
  case "$validation_freshness" in fresh-current-target|stale|not-applicable) ;; *) LIFECYCLE_CASE_REASON="invalid-validation-freshness"; return 1 ;; esac
  case "$authorization" in not-granted|owner-explicit-current-scope|normal-git-gate-current|blocked) ;; *) LIFECYCLE_CASE_REASON="invalid-authorization"; return 1 ;; esac
  case "$continuity" in intact-runtime-proven|restarted|degraded|unavailable) ;; *) LIFECYCLE_CASE_REASON="invalid-continuity"; return 1 ;; esac
  case "$trigger" in none|context-reliability|context-pressure|independence-contamination|provider-change|model-change|tool-change|trust-loss|state-ambiguity|failed-recovery|owner-instruction) ;; *) LIFECYCLE_CASE_REASON="invalid-trigger"; return 1 ;; esac
  case "$restart_reason" in cross-stage|context-reliability|context-pressure|independence-contamination|provider-change|model-change|tool-change|trust-loss|state-ambiguity|failed-recovery|owner-instruction|not-applicable) ;; *) LIFECYCLE_CASE_REASON="invalid-restart-reason"; return 1 ;; esac
  case "$old_attempt_state" in prepared|running|completed|failed-confirmed|result-unknown|superseded) ;; *) LIFECYCLE_CASE_REASON="invalid-invocation-state"; return 1 ;; esac
  case "$concurrency_resolved" in yes|no) ;; *) LIFECYCLE_CASE_REASON="invalid-concurrency-state"; return 1 ;; esac
  case "$lifecycle_event" in routine|close|restart) ;; *) LIFECYCLE_CASE_REASON="invalid-lifecycle-event"; return 1 ;; esac
  case "$transition" in yes|no) ;; *) LIFECYCLE_CASE_REASON="invalid-transition-state"; return 1 ;; esac

  [[ "$resume_evidence" != *"--continue"* ]] || { LIFECYCLE_CASE_REASON="ambiguous-continue"; return 1; }
  if [[ "$continuity" == "intact-runtime-proven" ]]; then
    [[ "$runtime_evidence" == "exact-supported" && "$runtime_id" != "unavailable" ]] || { LIFECYCLE_CASE_REASON="false-intact-continuity"; return 1; }
    if [[ "$runtime_kind" == "claude" ]]; then
      [[ "$resume_evidence" == "--resume $runtime_id" ]] || { LIFECYCLE_CASE_REASON="claude-resume-runtime-mismatch"; return 1; }
    else
      [[ "$resume_evidence" == "exact-runtime:$runtime_id" ]] || { LIFECYCLE_CASE_REASON="other-runtime-mechanism-mismatch"; return 1; }
    fi
  fi
  [[ "$fresh_decision" == "confirmed" ]] || { LIFECYCLE_CASE_REASON="inherited-or-blocked-decision"; return 1; }
  [[ "$no_peek" == "isolated-current-first-pass" || "$no_peek" == "consensus-open" ]] || { LIFECYCLE_CASE_REASON="current-first-pass-contamination"; return 1; }
  [[ "$validation_freshness" == "fresh-current-target" || "$validation_freshness" == "not-applicable" ]] || { LIFECYCLE_CASE_REASON="stale-validation"; return 1; }
  [[ "$authorization" != "blocked" ]] || { LIFECYCLE_CASE_REASON="inherited-or-blocked-authorization"; return 1; }

  if [[ "$prior_stage" != "none" && "$prior_stage" != "$c_stage" ]]; then
    [[ "$stage_id" != "$prior_stage_id" ]] || { LIFECYCLE_CASE_REASON="cross-stage-reused-stage-session-id"; return 1; }
    [[ "$continuity" != "intact-runtime-proven" ]] || { LIFECYCLE_CASE_REASON="cross-stage-intact-continuity"; return 1; }
    [[ "$restart_reason" == "cross-stage" ]] || { LIFECYCLE_CASE_REASON="cross-stage-reason-mismatch"; return 1; }
    [[ "$lifecycle_event" == "restart" || "$lifecycle_event" == "close" ]] || { LIFECYCLE_CASE_REASON="cross-stage-missing-lifecycle-event"; return 1; }
    [[ "$transition" == "yes" ]] || { LIFECYCLE_CASE_REASON="cross-stage-missing-transition"; return 1; }
  fi
  if [[ "$trigger" != "none" ]]; then
    [[ "$restart_reason" == "$trigger" ]] || { LIFECYCLE_CASE_REASON="trigger-reason-mismatch"; return 1; }
    [[ "$stage_id" != "$prior_stage_id" ]] || { LIFECYCLE_CASE_REASON="mandatory-restart-reused-stage-session-id"; return 1; }
    [[ "$continuity" != "intact-runtime-proven" ]] || { LIFECYCLE_CASE_REASON="mandatory-restart-intact-continuity"; return 1; }
    [[ "$lifecycle_event" == "restart" || "$lifecycle_event" == "close" ]] || { LIFECYCLE_CASE_REASON="mandatory-trigger-missing-restart-or-close"; return 1; }
    [[ "$transition" == "yes" ]] || { LIFECYCLE_CASE_REASON="mandatory-trigger-missing-transition"; return 1; }
  fi
  if [[ "$old_attempt_state" == "running" || "$old_attempt_state" == "result-unknown" ]]; then
    [[ "$concurrency_resolved" == "yes" ]] || { LIFECYCLE_CASE_REASON="blind-restart-concurrency"; return 1; }
  fi
  if [[ "$c_stage" == "C0-bootstrap" && "$lifecycle_event" == "close" ]]; then
    [[ "$transition" == "yes" ]] || { LIFECYCLE_CASE_REASON="c0-close-missing-transition"; return 1; }
  fi
  if [[ "$lifecycle_event" == "routine" ]]; then
    [[ "$prior_stage" == "$c_stage" ]] || { LIFECYCLE_CASE_REASON="routine-not-same-stage"; return 1; }
    [[ "$stage_id" == "$prior_stage_id" ]] || { LIFECYCLE_CASE_REASON="routine-same-stage-changed-stage-session-id"; return 1; }
    [[ "$continuity" == "intact-runtime-proven" ]] || { LIFECYCLE_CASE_REASON="routine-non-intact-continuity"; return 1; }
    [[ "$trigger" == "none" ]] || { LIFECYCLE_CASE_REASON="routine-has-restart-trigger"; return 1; }
    [[ "$restart_reason" == "not-applicable" ]] || { LIFECYCLE_CASE_REASON="routine-has-restart-reason"; return 1; }
    [[ "$transition" == "no" ]] || { LIFECYCLE_CASE_REASON="routine-has-transition"; return 1; }
  fi
  if [[ "$lifecycle_event" == "restart" || "$lifecycle_event" == "close" ]]; then
    local precise_cross_stage="no" precise_c0_close="no"
    [[ "$prior_stage" != "none" && "$prior_stage" != "$c_stage" ]] && precise_cross_stage="yes"
    [[ "$c_stage" == "C0-bootstrap" && "$lifecycle_event" == "close" ]] && precise_c0_close="yes"
    if [[ "$precise_cross_stage" == "no" && "$precise_c0_close" == "no" ]]; then
      [[ "$trigger" != "none" ]] || { LIFECYCLE_CASE_REASON="unexplained-restart-or-close"; return 1; }
      [[ "$restart_reason" == "$trigger" ]] || { LIFECYCLE_CASE_REASON="restart-or-close-reason-mismatch"; return 1; }
    fi
    [[ "$stage_id" != "$prior_stage_id" ]] || { LIFECYCLE_CASE_REASON="transition-reused-stage-session-id"; return 1; }
    [[ "$continuity" != "intact-runtime-proven" ]] || { LIFECYCLE_CASE_REASON="transition-intact-continuity"; return 1; }
    [[ "$transition" == "yes" ]] || { LIFECYCLE_CASE_REASON="restart-or-close-missing-transition"; return 1; }
  fi
  if [[ "$continuity" == "restarted" || "$continuity" == "degraded" || "$continuity" == "unavailable" ]]; then
    [[ "$lifecycle_event" == "restart" || "$lifecycle_event" == "close" ]] || { LIFECYCLE_CASE_REASON="non-intact-without-transition-event"; return 1; }
    [[ "$stage_id" != "$prior_stage_id" ]] || { LIFECYCLE_CASE_REASON="non-intact-reused-stage-session-id"; return 1; }
    if [[ ! ( "$c_stage" == "C0-bootstrap" && "$lifecycle_event" == "close" ) ]]; then
      [[ "$restart_reason" != "not-applicable" ]] || { LIFECYCLE_CASE_REASON="non-intact-missing-restart-reason"; return 1; }
    fi
    [[ "$transition" == "yes" ]] || { LIFECYCLE_CASE_REASON="non-intact-missing-transition"; return 1; }
  fi
  if [[ "$transition" == "yes" ]]; then
    case "$actor" in leader|owner) ;; *) LIFECYCLE_CASE_REASON="missing-lifecycle-decision-actor"; return 1 ;; esac
    [[ "$decision_time" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(Z|[+-][0-9]{2}:[0-9]{2})$ ]] || { LIFECYCLE_CASE_REASON="invalid-lifecycle-decision-time"; return 1; }
  else
    [[ -z "$actor" && -z "$decision_time" ]] || { LIFECYCLE_CASE_REASON="routine-record-has-transition-fields"; return 1; }
  fi
}

expect_lifecycle_case_pass() {
  local label="$1"; shift
  if lifecycle_case_valid "$@"; then pass "$label"; else fail "$label ($LIFECYCLE_CASE_REASON)"; fi
}

expect_lifecycle_case_reject() {
  local label="$1" expected_reason="$2"; shift 2
  if lifecycle_case_valid "$@"; then fail "$label"; elif [[ "$LIFECYCLE_CASE_REASON" == "$expected_reason" ]]; then pass "$label ($expected_reason)"; else fail "$label expected $expected_reason, got $LIFECYCLE_CASE_REASON"; fi
}

checkpoint_pair_valid() {
  local first_stage="$1" second_stage="$2" first_session="$3" second_session="$4"
  local first_review="$5" second_review="$6" first_fingerprint="$7" second_fingerprint="$8"
  local fresh_decision="$9" validation_freshness="${10}" authorization="${11}" no_peek="${12}"
  CHECKPOINT_PAIR_REASON="eligible"
  [[ "$first_stage" == "$second_stage" ]] || { CHECKPOINT_PAIR_REASON="not-same-stage"; return 1; }
  [[ "$first_session" == "$second_session" ]] || { CHECKPOINT_PAIR_REASON="not-same-stage-session"; return 1; }
  [[ "$first_review" != "$second_review" ]] || { CHECKPOINT_PAIR_REASON="reused-review-id"; return 1; }
  [[ -n "$first_fingerprint" && -n "$second_fingerprint" && "$first_fingerprint" != "$second_fingerprint" ]] || { CHECKPOINT_PAIR_REASON="missing-or-reused-target-fingerprint"; return 1; }
  case "$fresh_decision" in confirmed|blocked) ;; *) CHECKPOINT_PAIR_REASON="invalid-fresh-decision"; return 1 ;; esac
  case "$validation_freshness" in fresh-current-target|stale|not-applicable) ;; *) CHECKPOINT_PAIR_REASON="invalid-validation-freshness"; return 1 ;; esac
  case "$authorization" in not-granted|owner-explicit-current-scope|normal-git-gate-current|blocked) ;; *) CHECKPOINT_PAIR_REASON="invalid-authorization"; return 1 ;; esac
  case "$no_peek" in isolated-current-first-pass|consensus-open|contaminated) ;; *) CHECKPOINT_PAIR_REASON="invalid-no-peek"; return 1 ;; esac
  [[ "$fresh_decision" == "confirmed" ]] || { CHECKPOINT_PAIR_REASON="decision-not-fresh"; return 1; }
  [[ "$validation_freshness" == "fresh-current-target" ]] || { CHECKPOINT_PAIR_REASON="validation-not-fresh"; return 1; }
  [[ "$authorization" != "blocked" ]] || { CHECKPOINT_PAIR_REASON="authorization-not-current"; return 1; }
  [[ "$no_peek" == "isolated-current-first-pass" ]] || { CHECKPOINT_PAIR_REASON="no-peek-not-isolated"; return 1; }
}

expect_checkpoint_pair_pass() {
  local label="$1"; shift
  if checkpoint_pair_valid "$@"; then pass "$label"; else fail "$label ($CHECKPOINT_PAIR_REASON)"; fi
}

expect_checkpoint_pair_reject() {
  local label="$1" expected_reason="$2"; shift 2
  if checkpoint_pair_valid "$@"; then fail "$label"; elif [[ "$CHECKPOINT_PAIR_REASON" == "$expected_reason" ]]; then pass "$label ($expected_reason)"; else fail "$label expected $expected_reason, got $CHECKPOINT_PAIR_REASON"; fi
}

non_openspec_pair_valid() {
  local first_session="$1" second_session="$2" first_review="$3" second_review="$4"
  local target_relation="$5" attempt_relation="$6"
  NON_OPENSPEC_PAIR_REASON="eligible"
  case "$target_relation" in changed|unchanged-clarification) ;; *) NON_OPENSPEC_PAIR_REASON="invalid-target-relation"; return 1 ;; esac
  case "$attempt_relation" in new-review|linked-attempt) ;; *) NON_OPENSPEC_PAIR_REASON="invalid-attempt-relation"; return 1 ;; esac
  if [[ "$target_relation" == "changed" ]]; then
    [[ "$first_session" != "$second_session" ]] || { NON_OPENSPEC_PAIR_REASON="changed-target-reused-session"; return 1; }
    [[ "$first_review" != "$second_review" ]] || { NON_OPENSPEC_PAIR_REASON="changed-target-reused-review-id"; return 1; }
    [[ "$attempt_relation" == "new-review" ]] || { NON_OPENSPEC_PAIR_REASON="changed-target-used-linked-attempt"; return 1; }
  else
    [[ "$first_session" == "$second_session" ]] || { NON_OPENSPEC_PAIR_REASON="clarification-changed-session"; return 1; }
    [[ "$first_review" == "$second_review" ]] || { NON_OPENSPEC_PAIR_REASON="clarification-changed-review-id"; return 1; }
    [[ "$attempt_relation" == "linked-attempt" ]] || { NON_OPENSPEC_PAIR_REASON="clarification-not-linked-attempt"; return 1; }
  fi
}

expect_non_openspec_pair_pass() {
  local label="$1"; shift
  if non_openspec_pair_valid "$@"; then pass "$label"; else fail "$label ($NON_OPENSPEC_PAIR_REASON)"; fi
}

expect_non_openspec_pair_reject() {
  local label="$1" expected_reason="$2"; shift 2
  if non_openspec_pair_valid "$@"; then fail "$label"; elif [[ "$NON_OPENSPEC_PAIR_REASON" == "$expected_reason" ]]; then pass "$label ($expected_reason)"; else fail "$label expected $expected_reason, got $NON_OPENSPEC_PAIR_REASON"; fi
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

template_contains_normalized_whitespace() {
  local file="$1"
  local needle="$2"
  local label="$3"
  local normalized_file normalized_needle

  if [[ ! -f "$file" ]]; then
    fail "$label"
    return
  fi
  normalized_file="$(perl -0pe 's/\s+/ /g; s/^ //; s/ $//' "$file")"
  normalized_needle="$(printf '%s' "$needle" | perl -0pe 's/\s+/ /g; s/^ //; s/ $//')"
  if [[ "$normalized_file" == *"$normalized_needle"* ]]; then
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
  "docs/RUNTIME_INSTALLATION.md"
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

if [[ -f "README.md" ]] && contains "README.md" "Current public version: \`$PUBLIC_VERSION\`"; then
  pass "README.md current version marker"
else
  fail "README.md current version marker"
fi

if [[ -f "CHANGELOG.md" ]] && contains "CHANGELOG.md" "Published $PUBLIC_VERSION on $PUBLICATION_DATE: $PUBLIC_UPGRADE_TITLE"; then
  pass "CHANGELOG.md current upgrade marker"
else
  fail "CHANGELOG.md current upgrade marker"
fi

if [[ -f "docs/TODO.md" ]] && contains "docs/TODO.md" "## $PUBLIC_VERSION: $PUBLIC_UPGRADE_TITLE (Published $PUBLICATION_DATE)"; then
  pass "docs/TODO.md current version section"
else
  fail "docs/TODO.md current version section"
fi

if [[ -f "docs/ROADMAP.md" ]] && contains "docs/ROADMAP.md" "\`$PUBLIC_VERSION\` $PUBLIC_UPGRADE_TITLE is the current public version"; then
  pass "docs/ROADMAP.md current version marker"
else
  fail "docs/ROADMAP.md current version marker"
fi

if [[ -f "docs/VALIDATION.md" ]] && contains "docs/VALIDATION.md" "## $PUBLIC_VERSION $CURRENT_VALIDATION_TITLE"; then
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
  if [[ "$spec" == "$ROLE_REVIEW_CONTEXT_SPEC" && "$require_no_active_changes" -eq 0 && -f "$ROLE_REVIEW_CONTEXT_CHANGE" ]]; then
    pass "active spec delta exists: $spec"
  elif [[ "$spec" == "$ADOPTION_GUIDANCE_SPEC" && "$require_no_active_changes" -eq 0 && -f "$ADOPTION_GUIDANCE_CHANGE" ]]; then
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
  elif [[ "$template" == "templates/review-packet-cleanup-checklist.md" ]]; then
    version_marker="Version: v0.4.18 release template."
  elif [[ "$template" == "templates/compact-leader-state.md" ||
          "$template" == "templates/standard-leader-state.md" ||
          "$template" == "templates/successor-opportunity-skeleton.md" ]]; then
    version_marker="Version: v1.0.0 release template."
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
for leader_state_template in \
  "templates/compact-leader-state.md" \
  "templates/standard-leader-state.md" \
  "templates/successor-opportunity-skeleton.md"; do
  template_contains "$leader_state_template" "Absence is not approval." "$leader_state_template blocks absence-as-approval"
  template_contains "$leader_state_template" "Successor, profile, authority, validation, role, and gate decisions are not inherited." "$leader_state_template blocks inherited control state"
  template_contains "$leader_state_template" "The complete applicable retention floor wins; do not truncate facts." "$leader_state_template preserves the retention floor"
  template_contains "$leader_state_template" "Physical size warnings are non-blocking and never select a profile." "$leader_state_template preserves the warning-only size boundary"
done
template_contains "templates/compact-leader-state.md" "Physical lines:" "Compact Leader-state template records physical lines separately"
template_contains "templates/compact-leader-state.md" "UTF-8 bytes:" "Compact Leader-state template records UTF-8 bytes separately"
template_contains "templates/compact-leader-state.md" "status=requested|pending|granted|denied|revoked|expired" "Compact Leader-state template defines the exact active authorization status enum"
template_contains "templates/compact-leader-state.md" "Standing default exclusions: <retained scope/stop conditions; not counted unless current action, current gate, or first next action triggers the active-domain rule>" "Compact Leader-state template separates standing exclusions from active domains"
template_contains "templates/compact-leader-state.md" "A current denial is active, fail-closed, and counted until its action, gate, or first next action is no longer current; an unrequested standing exclusion is retained but not counted." "Compact Leader-state template counts current denial and keeps it fail-closed"
template_contains "templates/standard-leader-state.md" "Physical lines:" "Standard Leader-state template records physical lines separately"
template_contains "templates/standard-leader-state.md" "UTF-8 bytes:" "Standard Leader-state template records UTF-8 bytes separately"
template_contains "templates/standard-leader-state.md" 'State enum: `requested|pending|granted|denied|revoked|expired`.' "Standard Leader-state template defines the exact active authorization status enum"
template_contains "templates/standard-leader-state.md" "Standing default exclusions: <retained scope/stop conditions; not counted unless current action, current gate, or first next action triggers the active-domain rule>" "Standard Leader-state template separates standing exclusions from active domains"
template_contains "templates/standard-leader-state.md" "A current denial is active, fail-closed, and counted until its action, gate, or first next action is no longer current; an unrequested standing exclusion is retained but not counted." "Standard Leader-state template counts current denial and keeps it fail-closed"
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
template_contains "SKILL.md" 'MUST read `references/leader-state-profiles.md` before selecting, refreshing, rendering, or transitioning' "SKILL.md routes Leader-state profile reference"
template_contains "SKILL.md" "Structural current-active inventory selects Compact, Standard, or \`hierarchical-required\`; provisional line and byte bands only warn." "SKILL.md preserves profile classification and warning boundary"
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
template_contains "README.md" "docs/RUNTIME_INSTALLATION.md" "README links runtime installation guide"
template_contains "SKILL.md" "Automatic invocation means applying this workflow and checklist" "SKILL.md defines automatic invocation boundary"
template_contains "README.md" "Completion summaries and next-goal recommendations are reporting aids only" "README blocks closeout authorization"
template_contains "SKILL.md" "Role-agent cleanup or close actions run sequentially" "SKILL.md describes sequential cleanup"
template_contains "SKILL.md" "More than 2 files or roughly 80 diff lines is a self-check" "SKILL.md describes Leader budget self-check"
template_contains "SKILL.md" 'MUST read `references/review-context-efficiency.md`' "SKILL.md routes context-efficient role review"
template_contains "SKILL.md" "Context efficiency may remove repeated material only" "SKILL.md preserves context-efficiency quality boundary"
template_contains "README.md" "automatically create successor conversations, spawn Workers, measure diff" "README blocks automation creep"
skill_anchor_count="$(grep -cE '^[[:space:]]*template_contains "SKILL[.]md"' scripts/validate-local.sh)"
if [[ "$skill_anchor_count" -ge "$SKILL_ANCHOR_BASELINE" ]]; then
  pass "SKILL.md anchor check count not reduced"
else
  fail "SKILL.md anchor check count not reduced"
fi
template_contains "references/leader-state-profiles.md" "Inventory scope: current-active-only" "Profile reference defines current-active-only inventory"
template_contains "references/leader-state-profiles.md" "hierarchical-required" "Profile reference defines above-Standard classification"
template_contains "references/leader-state-profiles.md" "Demotion requires all lower exit conditions at two consecutive" "Profile reference defines demotion hysteresis"
template_contains "references/leader-state-profiles.md" "warning-only and never select a" "Profile reference preserves warning-only size boundary"
template_contains "references/leader-state-profiles.md" "Semantic and control correctness" "Profile reference preserves fail-closed semantic boundary"
template_contains "references/leader-state-profiles.md" "A current denial remains an active fail-closed control fact and counted domain" "Profile reference counts current denial as fail-closed state"
validate_profile_manifest
validate_profile_manifest_edge_rejection_probes
validate_profile_manifest_authorization_rejection_probes
validate_missing_field_fixture
validate_stale_pointer_fixture
validate_orphan_pointer_fixture
validate_conflicting_canonical_source_fixture
validate_conflicting_authorization_binding
validate_invalid_selection_basis_fixture
validate_duplicate_edge_fixture
validate_hierarchical_demotion_fixture
validate_rendered_profile_fixture "examples/leader-state-profiles/compact-feasibility.md" "within-warning" "Compact feasibility fixture"
validate_rendered_profile_fixture "examples/leader-state-profiles/medium-standard.md" "within-warning" "Medium Standard fixture"
validate_rendered_profile_fixture "examples/leader-state-profiles/standard-size-warning.md" "line-warning" "Standard size-warning fixture"
validate_profile_rendered_enumerations
validate_rendered_authorization_bindings
validate_detailed_authorization_contract "examples/leader-state-profiles/compact-feasibility.md" "FX-SMALL-REPO" "Compact feasibility authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/medium-standard.md" "FX-MEDIUM-REPO" "Medium Standard authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/standard-size-warning.md" "FX-SIZE-WARNING" "Standard size-warning authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/duplicate-edge-deduplication.md" "FX-EDGE-DEDUP" "Duplicate-edge authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/negative-missing-applicable-field.md" "FX-NEG-MISSING-FIELD" "Missing-field authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/negative-stale-pointer.md" "FX-NEG-STALE-POINTER" "Stale-pointer authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/negative-orphan-pointer.md" "FX-NEG-ORPHAN-POINTER" "Orphan-pointer authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/negative-conflicting-canonical-source.md" "FX-NEG-CONFLICT-SOURCE" "Conflicting-source authorization contract"
validate_detailed_authorization_contract "examples/leader-state-profiles/negative-invalid-selection-basis.md" "FX-NEG-SELECTION-BASIS" "Invalid-selection authorization contract"
validate_detailed_authorization_contract "examples/handoff-task.md" "FX-TAKEOVER-STANDARD" "Takeover authorization contract"
validate_hierarchical_authorization_contract
validate_authorization_count_source_probes
template_contains "references/review-context-efficiency.md" "The packet is an index and starting point, not a restriction or substitute for original evidence" "Context-efficiency reference preserves original evidence access"
template_contains "references/review-context-efficiency.md" "one runtime-proven PM lifecycle and one runtime-proven Advisor lifecycle" "Context-efficiency reference requires OpenSpec stage-scoped lifecycles"
template_contains "references/review-context-efficiency.md" "For non-OpenSpec work, use a fresh short-lived session for each distinct checkpoint" "Context-efficiency reference preserves non-OpenSpec short sessions"
template_contains "references/review-context-efficiency.md" 'Claude continuity is proven only when exact `--resume <session-id>` matches the recorded Runtime Session ID' "Context-efficiency reference requires exact Claude resume"
template_contains "references/review-context-efficiency.md" 'Lifecycle Decision Actor `leader|owner`' "Context-efficiency reference defines transition actor"
template_contains "references/review-context-efficiency.md" "stable baseline and accepted anchor" "Context-efficiency reference records stable baseline"
template_contains "references/review-context-efficiency.md" "current delta" "Context-efficiency reference records incremental evidence"
template_contains "references/review-context-efficiency.md" "conclusion-free factual manifest" "Context-efficiency reference isolates factual manifest conclusions"
template_contains "references/review-context-efficiency.md" "derive separate PM and Advisor packets" "Context-efficiency reference separates PM Advisor packets"
template_contains "references/review-context-efficiency.md" 'prepared`, `running`, `completed`, `failed-confirmed`, `result-unknown`, and `superseded' "Context-efficiency reference lists invocation states"
template_contains "references/review-context-efficiency.md" "Do not blindly repeat the same Review ID and packet fingerprint" "Context-efficiency reference blocks blind retry"
template_contains "templates/review-factual-manifest.md" "Stable baseline anchor:" "Factual manifest records stable baseline"
template_contains "templates/review-factual-manifest.md" "Current commit or diff:" "Factual manifest records incremental target"
template_contains "templates/review-factual-manifest.md" "none; this manifest is conclusion-free" "Factual manifest excludes role conclusions"
template_contains "templates/pm-review.md" "Advisor conclusions | none" "PM packet withholds Advisor conclusions"
template_contains "templates/advisor-review.md" "PM conclusions | none" "Advisor packet withholds PM conclusions"
template_contains "templates/review-invocation-record.md" "Review ID:" "Invocation template records Review ID"
template_contains "templates/review-invocation-record.md" "Attempt ID:" "Invocation template records Attempt ID"
template_contains "templates/review-invocation-record.md" "Packet fingerprint:" "Invocation template records packet fingerprint"
template_contains "templates/review-invocation-record.md" "Stage Session ID:" "Invocation template records Stage Session ID"
template_contains "templates/review-invocation-record.md" "Runtime Session ID:" "Invocation template records runtime identity"
template_contains "templates/review-invocation-record.md" "Runtime/provider kind:" "Invocation template records runtime kind"
template_contains "templates/review-invocation-record.md" "Lifecycle Decision Actor:" "Invocation template records transition actor"
template_contains "templates/review-invocation-record.md" "Prior Stage Session ID:" "Invocation template records prior transition lifecycle ID"
template_contains "templates/review-invocation-record.md" "Successor Stage Session ID:" "Invocation template records successor transition lifecycle ID"
template_contains "templates/review-invocation-record.md" "Omit them from routine same-stage records" "Invocation template omits transition fields from routine records"
template_contains "templates/pm-review.md" "GO | NO-GO | BLOCKED-EVIDENCE" "PM template preserves complete decision status"
template_contains "templates/advisor-review.md" "GO | NO-GO | BLOCKED-EVIDENCE" "Advisor template preserves complete decision status"
template_contains "templates/pm-review.md" "P0:" "PM context-efficient output records P0"
template_contains "templates/pm-review.md" "P1:" "PM context-efficient output records P1"
template_contains "templates/pm-review.md" "P2:" "PM context-efficient output records P2"
template_contains "templates/advisor-review.md" "P0:" "Advisor context-efficient output records P0"
template_contains "templates/advisor-review.md" "P1:" "Advisor context-efficient output records P1"
template_contains "templates/advisor-review.md" "P2:" "Advisor context-efficient output records P2"
template_contains "templates/pm-review.md" "Evidence inspected:" "PM template records inspected evidence"
template_contains "templates/pm-review.md" "Evidence gaps:" "PM template records evidence gaps"
template_contains "templates/pm-review.md" "Validation freshness:" "PM template records validation freshness"
template_contains "templates/pm-review.md" "Required corrections:" "PM template records corrections"
template_contains "templates/pm-review.md" "Owner-decision needs:" "PM template records Owner decision needs"
template_contains "templates/pm-review.md" "Recommended next action:" "PM template records next action"
template_contains "templates/pm-review.md" "Concise rationale:" "PM template records rationale"
template_contains "templates/advisor-review.md" "Evidence inspected:" "Advisor template records inspected evidence"
template_contains "templates/advisor-review.md" "Evidence gaps:" "Advisor template records evidence gaps"
template_contains "templates/advisor-review.md" "Validation freshness:" "Advisor template records validation freshness"
template_contains "templates/advisor-review.md" "Required corrections:" "Advisor template records corrections"
template_contains "templates/advisor-review.md" "Owner-decision needs:" "Advisor template records Owner decision needs"
template_contains "templates/advisor-review.md" "Recommended next action:" "Advisor template records next action"
template_contains "templates/advisor-review.md" "Concise rationale:" "Advisor template records rationale"
template_contains "templates/review-invocation-record.md" "Parent Attempt ID" "Invocation template links retries"
template_contains "references/review-context-efficiency.md" "Permanent protocol material" "Retention reference defines permanent protocol material"
template_contains "references/review-context-efficiency.md" "Durable audit evidence" "Retention reference defines durable audit evidence"
template_contains "references/review-context-efficiency.md" "Lifecycle-bound working material" "Retention reference defines lifecycle-bound working material"
template_contains "references/review-context-efficiency.md" "A shared conclusion-free factual manifest is lifecycle-bound working material" "Retention reference classifies shared factual manifest"
template_contains "references/review-context-efficiency.md" '`failed-confirmed` means' "Retention reference defines failed-confirmed"
template_contains "references/review-context-efficiency.md" '`superseded` means' "Retention reference defines superseded"
template_contains "references/review-context-efficiency.md" "C1:" "Retention reference defines C1 checkpoint"
template_contains "references/review-context-efficiency.md" "C2:" "Retention reference defines C2 checkpoint"
template_contains "references/review-context-efficiency.md" "C3:" "Retention reference defines C3 retention"
template_contains "references/review-context-efficiency.md" "C4:" "Retention reference defines C4 final cleanup timing"
template_contains "references/review-context-efficiency.md" "required final review for no-git work" "Retention reference defines no-git final gate"
template_contains "references/review-context-efficiency.md" "actual-commit review for commit-only work" "Retention reference defines commit-only final gate"
template_contains "references/review-context-efficiency.md" "status or CI evidence plus post-push review" "Retention reference defines pushed final gate"
template_contains "references/review-context-efficiency.md" "post-action closeout review for Owner-authorized tag, release, publication, or deployment" "Retention reference defines publication final gate"
template_contains "references/review-context-efficiency.md" "without mutating or removing the original files" "Retention reference defines non-destructive compaction"
template_contains "references/review-context-efficiency.md" "Lifecycle eligibility permits non-destructive compaction only" "Retention reference blocks implicit deletion"
template_contains "references/review-context-efficiency.md" "Durable audit evidence intentionally grows linearly" "Retention reference states intentional audit growth"
template_contains "references/review-context-efficiency.md" "a terse decision summary alone is insufficient" "Retention reference preserves complete role reasoning"
template_contains "templates/review-invocation-record.md" "Retention class:" "Invocation template records retention class"
template_contains "templates/review-invocation-record.md" "Final applicable gate or OpenSpec checkpoint:" "Invocation template records final checkpoint"
template_contains "templates/review-invocation-record.md" "Cleanup blocker check:" "Invocation template records blocker check"
template_contains "templates/review-invocation-record.md" "Retained-record location:" "Invocation template records durable result"
template_contains "templates/review-packet-cleanup-checklist.md" "No prepared, running, or result-unknown invocation:" "Cleanup checklist rejects active ambiguous state"
template_contains "templates/review-packet-cleanup-checklist.md" "No unresolved P0/P1 or BLOCKED-EVIDENCE:" "Cleanup checklist rejects unresolved blockers"
template_contains "templates/review-packet-cleanup-checklist.md" "This checklist never authorizes deletion" "Cleanup checklist blocks destructive authorization"
template_contains "examples/review-packet-cleanup-openspec.md" "C2 completion is not final cleanup" "OpenSpec cleanup example retains later gate evidence"
template_contains "examples/review-packet-cleanup-small-task.md" "does not invent C1-C4 stages" "Small task cleanup example avoids invented OpenSpec"
template_contains "examples/review-packet-cleanup-negative.md" 'invocation is `running`' "Negative example rejects running invocation"
template_contains "examples/review-packet-cleanup-negative.md" 'invocation is `result-unknown`' "Negative example rejects unknown result"
template_contains "examples/review-packet-cleanup-negative.md" "P0 or P1 remains unresolved" "Negative example rejects unresolved P0 P1"
template_contains "examples/review-packet-cleanup-negative.md" '`BLOCKED-EVIDENCE` or an evidence gap' "Negative example rejects evidence gaps"
template_contains "examples/review-packet-cleanup-negative.md" "before status/CI evidence or post-push review" "Negative example rejects incomplete gate"
template_contains "examples/review-packet-cleanup-negative.md" 'Delete `templates/pm-review.md`' "Negative example rejects blank template deletion"
template_contains "examples/review-packet-cleanup-negative.md" "incomplete durable audit record" "Negative example rejects incomplete audit record"
template_contains "docs/VALIDATION.md" "Active and retransmitted review context is bounded" "Validation scopes context growth claim"
template_contains "docs/VALIDATION.md" "stored lifecycle-bound packet files may grow" "Validation rejects storage cap claim"

expect_checkpoint_pair_pass "Same-stage checkpoints reuse runtime lifecycle but refresh transaction identity" C2 C2 pm-c2-1 pm-c2-1 REV-C2-01 REV-C2-02 diff-sha256-a commit-sha256-b confirmed fresh-current-target normal-git-gate-current isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair with reused Review ID" reused-review-id C2 C2 pm-c2-1 pm-c2-1 REV-C2-01 REV-C2-01 diff-a diff-b confirmed fresh-current-target not-granted isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair with reused fingerprint" missing-or-reused-target-fingerprint C2 C2 pm-c2-1 pm-c2-1 REV-C2-01 REV-C2-02 diff-a diff-a confirmed fresh-current-target not-granted isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair invalid no-peek enum" invalid-no-peek C2 C2 pm-c2-1 pm-c2-1 REV-C2-01 REV-C2-02 diff-a diff-b confirmed fresh-current-target not-granted banana
expect_checkpoint_pair_reject "Reject checkpoint pair across stages" not-same-stage C2 C3 pm-c2-1 pm-c3-1 REV-1 REV-2 diff-a diff-b confirmed fresh-current-target not-granted isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair across sessions" not-same-stage-session C2 C2 pm-c2-1 pm-c2-2 REV-1 REV-2 diff-a diff-b confirmed fresh-current-target not-granted isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair blocked decision" decision-not-fresh C2 C2 pm-c2-1 pm-c2-1 REV-1 REV-2 diff-a diff-b blocked fresh-current-target not-granted isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair stale validation" validation-not-fresh C2 C2 pm-c2-1 pm-c2-1 REV-1 REV-2 diff-a diff-b confirmed stale not-granted isolated-current-first-pass
expect_checkpoint_pair_reject "Reject checkpoint pair blocked authorization" authorization-not-current C2 C2 pm-c2-1 pm-c2-1 REV-1 REV-2 diff-a diff-b confirmed fresh-current-target blocked isolated-current-first-pass
expect_non_openspec_pair_pass "Non-OpenSpec changed target starts new session and Review ID" short-1 short-2 REV-NO-1 REV-NO-2 changed new-review
expect_non_openspec_pair_pass "Non-OpenSpec unchanged clarification uses linked attempt" short-1 short-1 REV-NO-1 REV-NO-1 unchanged-clarification linked-attempt
expect_non_openspec_pair_reject "Reject non-OpenSpec changed target reusing session" changed-target-reused-session short-1 short-1 REV-NO-1 REV-NO-2 changed new-review
expect_non_openspec_pair_reject "Reject non-OpenSpec changed target reusing Review ID" changed-target-reused-review-id short-1 short-2 REV-NO-1 REV-NO-1 changed new-review
expect_non_openspec_pair_reject "Reject linked attempt for changed non-OpenSpec target" changed-target-used-linked-attempt short-1 short-2 REV-NO-1 REV-NO-2 changed linked-attempt
expect_non_openspec_pair_reject "Reject new Review ID for unchanged clarification" clarification-changed-review-id short-1 short-1 REV-NO-1 REV-NO-2 unchanged-clarification linked-attempt

expect_lifecycle_case_pass "Claude same-stage exact continuity" C2 C2 advisor-c2-1 advisor-c2-1 claude claude-runtime-1 exact-supported "--resume claude-runtime-1" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_pass "Other runtime same-stage exact continuity" C2 C2 pm-c2-1 pm-c2-1 other codex-runtime-1 exact-supported "exact-runtime:codex-runtime-1" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_pass "Cross-stage transition changes lifecycle ID" C3 C2 pm-c3-1 pm-c2-1 other codex-runtime-3 exact-supported "exact-runtime:codex-runtime-3" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted none cross-stage completed yes restart yes leader 2026-07-12T18:20:00-07:00
expect_lifecycle_case_pass "C0 close records transition evidence" C0-bootstrap none pm-c0-1 none other codex-c0 exact-supported "exact-runtime:codex-c0" none confirmed isolated-current-first-pass not-applicable not-granted restarted none not-applicable completed yes close yes leader 2026-07-12T18:21:00-07:00
expect_lifecycle_case_pass "Mandatory restart changes lifecycle ID" C2 C2 advisor-c2-2 advisor-c2-1 claude claude-runtime-2 exact-supported "--resume claude-runtime-2" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted context-pressure context-pressure completed yes restart yes leader 2026-07-12T18:22:00-07:00
expect_lifecycle_case_pass "Mandatory early close changes lifecycle ID" C2 C2 advisor-c2-4 advisor-c2-3 claude claude-runtime-4 exact-supported "--resume claude-runtime-4" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted degraded owner-instruction owner-instruction completed yes close yes owner 2026-07-12T18:22:30-07:00
expect_lifecycle_case_pass "Unavailable transition changes lifecycle ID" C2 C2 advisor-c2-3 advisor-c2-2 claude unavailable unavailable unavailable verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted unavailable tool-change tool-change failed-confirmed yes restart yes owner 2026-07-12T18:23:00Z
expect_lifecycle_case_reject "Reject missing current Stage Session ID" missing-stage-session-id C2 C2 "" pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject missing prior Stage Session ID" missing-prior-stage-session-id C2 C2 pm-c2-1 "" other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject Claude resume mismatch" claude-resume-runtime-mismatch C2 C2 advisor-c2-1 advisor-c2-1 claude claude-runtime-1 exact-supported "--resume another-runtime" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject other runtime using Claude syntax" other-runtime-mechanism-mismatch C2 C2 pm-c2-1 pm-c2-1 other codex-runtime-1 exact-supported "--resume codex-runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject ambiguous Claude continue" ambiguous-continue C2 C2 advisor-c2-1 advisor-c2-1 claude claude-runtime-1 exact-supported "--continue" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject cross-stage reused Stage Session ID" cross-stage-reused-stage-session-id C3 C2 pm-c2-1 pm-c2-1 other runtime-3 exact-supported "exact-runtime:runtime-3" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted none cross-stage completed yes restart yes leader 2026-07-12T18:25:00-07:00
expect_lifecycle_case_reject "Reject mandatory restart reused Stage Session ID" mandatory-restart-reused-stage-session-id C2 C2 advisor-c2-1 advisor-c2-1 claude runtime-2 exact-supported "--resume runtime-2" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted trust-loss trust-loss completed yes restart yes leader 2026-07-12T18:25:00-07:00
expect_lifecycle_case_reject "Reject trigger and restart reason mismatch" trigger-reason-mismatch C2 C2 advisor-c2-2 advisor-c2-1 claude runtime-2 exact-supported "--resume runtime-2" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted trust-loss context-pressure completed yes restart yes leader 2026-07-12T18:25:00-07:00
expect_lifecycle_case_reject "Reject blind restart while old attempt may run" blind-restart-concurrency C2 C2 advisor-c2-2 advisor-c2-1 claude runtime-2 exact-supported "--resume runtime-2" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted state-ambiguity state-ambiguity result-unknown no restart yes leader 2026-07-12T18:24:00-07:00
expect_lifecycle_case_reject "Reject cross-stage missing transition" cross-stage-missing-transition C3 C2 pm-c3-1 pm-c2-1 other runtime-3 exact-supported "exact-runtime:runtime-3" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted none cross-stage completed yes restart no "" ""
expect_lifecycle_case_reject "Reject C0 close missing transition" c0-close-missing-transition C0-bootstrap none pm-c0-1 none other runtime-c0 exact-supported "exact-runtime:runtime-c0" none confirmed isolated-current-first-pass not-applicable not-granted restarted none not-applicable completed yes close no "" ""
expect_lifecycle_case_reject "Reject unavailable continuity missing transition" mandatory-trigger-missing-transition C2 C2 pm-c2-2 pm-c2-1 other unavailable unavailable unavailable verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted unavailable tool-change tool-change failed-confirmed yes restart no "" ""
expect_lifecycle_case_reject "Reject transition without actor" missing-lifecycle-decision-actor C3 C2 pm-c3-1 pm-c2-1 other runtime-3 exact-supported "exact-runtime:runtime-3" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted none cross-stage completed yes restart yes "" 2026-07-12T18:25:00-07:00
expect_lifecycle_case_reject "Reject timezone-free lifecycle decision time" invalid-lifecycle-decision-time C3 C2 pm-c3-1 pm-c2-1 other runtime-3 exact-supported "exact-runtime:runtime-3" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted none cross-stage completed yes restart yes leader 2026-07-12T18:25:00
expect_lifecycle_case_reject "Reject transition fields on routine same-stage record" routine-record-has-transition-fields C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no leader 2026-07-12T18:25:00-07:00
expect_lifecycle_case_reject "Reject transition flag on routine same-stage record" routine-has-transition C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine yes leader 2026-07-12T18:25:00-07:00
expect_lifecycle_case_reject "Reject routine same-stage changed lifecycle ID" routine-same-stage-changed-stage-session-id C2 C2 pm-c2-2 pm-c2-1 other runtime-2 exact-supported "exact-runtime:runtime-2" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject routine non-intact continuity" routine-non-intact-continuity C2 C2 pm-c2-1 pm-c2-1 other runtime-2 exact-supported "exact-runtime:runtime-2" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted restarted none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject routine restart reason" routine-has-restart-reason C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" verified-same-stage confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none context-pressure completed yes routine no "" ""
expect_lifecycle_case_reject "Reject unexplained same-stage restart" unexplained-restart-or-close C2 C2 pm-c2-2 pm-c2-1 other runtime-2 exact-supported "exact-runtime:runtime-2" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted restarted none not-applicable completed yes restart yes leader 2026-07-12T18:26:00-07:00
expect_lifecycle_case_reject "Reject mandatory restart with intact continuity" mandatory-restart-intact-continuity C2 C2 pm-c2-2 pm-c2-1 other runtime-2 exact-supported "exact-runtime:runtime-2" verified-restart-packet confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven context-pressure context-pressure completed yes restart yes leader 2026-07-12T18:26:00-07:00
expect_lifecycle_case_reject "Reject invalid continuity enum" invalid-continuity C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted banana none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid trigger enum" invalid-trigger C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven banana not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid restart reason enum" invalid-restart-reason C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none banana completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid authorization enum" invalid-authorization C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target banana intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid C-stage enum" invalid-c-stage banana C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid prior C-stage enum" invalid-prior-c-stage C2 banana pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid runtime kind enum" invalid-runtime-kind C2 C2 pm-c2-1 pm-c2-1 banana runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid runtime evidence enum" invalid-runtime-evidence C2 C2 pm-c2-1 pm-c2-1 other runtime-1 banana "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid inherited context enum" invalid-inherited-context C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" banana confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid fresh-decision enum" invalid-fresh-decision C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none banana isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid no-peek enum" invalid-no-peek C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed banana fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid validation freshness enum" invalid-validation-freshness C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass banana not-granted intact-runtime-proven none not-applicable completed yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid invocation state enum" invalid-invocation-state C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable banana yes routine no "" ""
expect_lifecycle_case_reject "Reject invalid concurrency state enum" invalid-concurrency-state C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed banana routine no "" ""
expect_lifecycle_case_reject "Reject invalid lifecycle event enum" invalid-lifecycle-event C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes banana no "" ""
expect_lifecycle_case_reject "Reject invalid transition state enum" invalid-transition-state C2 C2 pm-c2-1 pm-c2-1 other runtime-1 exact-supported "exact-runtime:runtime-1" none confirmed isolated-current-first-pass fresh-current-target not-granted intact-runtime-proven none not-applicable completed yes routine banana "" ""

expect_cleanup_case_pass "Valid OpenSpec C4 cleanup predicate case" completed yes yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_pass "Valid small-task final-review cleanup predicate case" completed yes yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_pass "Valid superseded attempt with retry lineage predicate case" superseded yes yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject prepared invocation predicate case" prepared-invocation prepared yes yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject running invocation predicate case" running-invocation running yes yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject result-unknown invocation predicate case" result-unknown-invocation result-unknown yes yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject unresolved P0/P1 predicate case" unresolved-p0-p1 completed no yes yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject BLOCKED-EVIDENCE predicate case" blocked-evidence completed yes no yes yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject evidence-gap predicate case" evidence-gap completed yes yes no yes yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject required-correction predicate case" required-correction completed yes yes yes no yes yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject Owner-decision predicate case" owner-decision completed yes yes yes yes no yes "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject required-review or later-gate predicate case" required-review-or-later-gate completed yes yes yes yes yes no "lifecycle-bound working material" yes yes yes
expect_cleanup_case_reject "Reject permanent blank-template target predicate case" permanent-or-ineligible-target completed yes yes yes yes yes yes "permanent protocol material" yes yes yes
expect_cleanup_case_reject "Reject incomplete retained audit predicate case" incomplete-audit completed yes yes yes yes yes yes "lifecycle-bound working material" no yes yes
expect_cleanup_case_reject "Reject superseded attempt without retry lineage predicate case" incomplete-retry-lineage superseded yes yes yes yes yes yes "lifecycle-bound working material" yes no yes
expect_cleanup_case_reject "Reject unknown cleanup-impact predicate case" unknown-cleanup-impact completed yes yes yes yes yes yes "lifecycle-bound working material" yes yes no
template_contains "README.md" "Current public version: \`$PUBLIC_VERSION\`" "README states current public version"
template_contains "README.md" "\`$PUBLIC_VERSION\` is the current public version, released on $PUBLICATION_DATE" "README states public release date"
template_contains "README.md" "\`$PUBLICATION_TIMEZONE\` annotated-tag date semantics" "README states annotated-tag date semantics"
template_contains "CHANGELOG.md" "Published $PUBLIC_VERSION on $PUBLICATION_DATE: $PUBLIC_UPGRADE_TITLE" "CHANGELOG states current publication"
template_contains "CHANGELOG.md" "The public release date uses \`$PUBLICATION_TIMEZONE\` annotated-tag date semantics." "CHANGELOG states annotated-tag date semantics"
if grep -Fxq -- '## Releases' "CHANGELOG.md"; then
  pass "CHANGELOG uses the exact releases container"
else
  fail "CHANGELOG uses the exact releases container"
fi
if grep -Fq '## [Unreleased]' "CHANGELOG.md"; then
  fail "CHANGELOG removes the stale unreleased container"
else
  pass "CHANGELOG removes the stale unreleased container"
fi
template_contains "docs/ROADMAP.md" "\`$PUBLIC_VERSION\` $PUBLIC_UPGRADE_TITLE is the current public version" "ROADMAP states current public version"
template_contains "docs/ROADMAP.md" "$PUBLICATION_DATE under \`$PUBLICATION_TIMEZONE\` annotated-tag date semantics." "ROADMAP states annotated-tag release date"
template_contains "docs/TODO.md" "## $PUBLIC_VERSION: $PUBLIC_UPGRADE_TITLE (Published $PUBLICATION_DATE)" "TODO states public version and date"
template_contains "docs/VALIDATION.md" "$PUBLICATION_DATE under \`$PUBLICATION_TIMEZONE\` annotated-tag date semantics." "VALIDATION states annotated-tag release date"
template_contains "docs/VALIDATION.md" "Public version is \`$PUBLIC_VERSION\`, published on $PUBLICATION_DATE" "VALIDATION states public version and date"
release_limitation_surfaces=(
  "README.md"
  "CHANGELOG.md"
  "docs/ROADMAP.md"
  "docs/TODO.md"
  "docs/VALIDATION.md"
)
for release_limitation_surface in "${release_limitation_surfaces[@]}"; do
  template_contains "$release_limitation_surface" "Structural thresholds are mandatory classification pilot baselines" "$release_limitation_surface states mandatory structural classification"
  template_contains "$release_limitation_surface" "exceeding them alone never blocks work" "$release_limitation_surface states structural thresholds are non-blocking by themselves"
  template_contains "$release_limitation_surface" "Physical line and UTF-8-byte size bands are" "$release_limitation_surface identifies physical size diagnostics"
  template_contains "$release_limitation_surface" "warning-only pilot baselines" "$release_limitation_surface states physical size bands are warning-only"
  template_contains "$release_limitation_surface" "Hierarchical root/card/shard storage" "$release_limitation_surface names the Hierarchical limitation"
  template_contains "$release_limitation_surface" "not implemented in this target" "$release_limitation_surface states Hierarchical is not implemented"
done

undeclared_development_marker=0
for version_file in README.md CHANGELOG.md docs/ROADMAP.md docs/TODO.md docs/VALIDATION.md; do
  if declares_unconfigured_development_version "$version_file"; then
    fail "$version_file does not declare an unconfigured development version"
    undeclared_development_marker=1
  fi
done
if [[ "$undeclared_development_marker" -eq 0 ]]; then
  pass "No next development version declared"
fi

expect_development_version_scanner_accept "Whole-file scanner accepts no-development-target fixture" 'v1.0.0 is public; no next development target is currently declared.'
expect_development_version_scanner_reject "Whole-file scanner rejects wrapped development-target fixture" $'The v1.0.0 development\ntarget remains active.'
expect_development_version_scanner_reject "Whole-file scanner rejects backticked wrapped development-target fixture" $'The `v1.0.0` development\ntarget remains active.'
expect_development_version_scanner_reject "Whole-file scanner rejects wrapped active-target fixture" $'Active development target:\n`v1.1.0`.'

expect_release_status_accept "Accept public v1.0.0 fixture" 'Current public version: `v1.0.0` Progressive Leader State Profiles.'
expect_release_status_accept "Accept annotated v1.0.0 tag fixture" 'The annotated v1.0.0 tag exists at the reviewed commit.'
expect_release_status_accept "Accept formal v1.0.0 GitHub Release fixture" 'GitHub Release v1.0.0 was published as a formal non-draft, non-prerelease Release.'
expect_release_status_accept "Accept GitHub-Release-only publication fixture" 'Publication is limited to the formal GitHub Release.'
expect_release_status_accept "Accept v1-not-deployed fixture" 'v1.0.0 has not been deployed.'
expect_release_status_accept "Accept generic no-deployment fixture" 'No deployment was performed.'
expect_release_status_accept "Accept no-deployment-claim fixture" 'This entry does not claim deployment was performed.'
expect_release_status_accept "Accept no-deployment-claim passive fixture" 'No claim is made that deployment was performed.'
expect_release_status_accept "Accept no-website-publication-claim fixture" 'This entry does not claim publication was made through a website.'
expect_release_status_accept "Accept no-website-publication-claim passive fixture" 'No claim is made that publication was made through a website.'
expect_release_status_accept "Accept historical v0.4.18 fixture" 'v0.4.18 remains historical release evidence from July 12, 2026.'
expect_release_status_accept "Accept no-development-target fixture" 'v1.0.0 is public; no next development target is currently declared.'
expect_release_status_accept "Accept annotated-tag date fixture" 'v1.0.0 was released on July 16, 2026 under America/Los_Angeles annotated-tag date semantics.'
expect_release_status_reject "Reject v0.4.18 current-public fixture" "v0.4.18 is still described as current public" 'Current public version: `v0.4.18`.'
expect_release_status_reject "Reject v0.4.18 reverse current-public fixture" "v0.4.18 is still described as current public" 'v0.4.18 is the current public release.'
expect_release_status_reject "Reject v0.4.18 remains current-public fixture" "v0.4.18 is still described as current public" 'v0.4.18 remains the current public version.'
expect_release_status_reject "Reject v1.0.0 development declaration fixture" "v1.0.0 is still described as development" 'Development target: `v1.0.0` Progressive Leader State Profiles.'
expect_release_status_reject "Reject multiline v1.0.0 development declaration fixture" "v1.0.0 is still described as development" $'Development target:\n`v1.0.0` Progressive Leader State Profiles.'
expect_release_status_reject "Reject actual former README sentence fixture" "v1.0.0 is still described as development" 'The v1.0.0 development target replaces a universal line cap with progressive active-state profiles.'
expect_release_status_reject "Reject multiline former README sentence fixture" "v1.0.0 is still described as development" $'The v1.0.0 development\ntarget replaces a universal line cap with progressive active-state profiles.'
expect_release_status_reject "Reject backticked multiline former README sentence fixture" "v1.0.0 is still described as development" $'The `v1.0.0` development\ntarget remains active.'
expect_release_status_reject "Reject v1.0.0 next-development fixture" "v1.0.0 is still described as development" 'v1.0.0 is the next development version.'
expect_release_status_reject "Reject v1.0.0 remains-development fixture" "v1.0.0 is still described as development" 'v1.0.0 remains the development target.'
expect_release_status_reject "Reject unconfigured active-development fixture" "an unconfigured development target is declared" 'Active development target is v1.1.0.'
expect_release_status_reject "Reject unconfigured remains-development fixture" "an unconfigured development target is declared" 'v1.1.0 remains the development target.'
expect_release_status_reject "Reject absent v1.0.0 tag fixture" "v1.0.0 is still described as unpublished" 'No v1.0.0 tag exists.'
expect_release_status_reject "Reject absent v1.0.0 GitHub Release fixture" "v1.0.0 is still described as unpublished" 'GitHub Release v1.0.0 does not exist.'
expect_release_status_reject "Reject reverse absent v1.0.0 GitHub Release fixture" "v1.0.0 is still described as unpublished" 'No GitHub Release exists for v1.0.0.'
expect_release_status_reject "Reject unpublished v1.0.0 fixture" "v1.0.0 is still described as unpublished" 'v1.0.0 has not been published.'
expect_release_status_reject "Reject no-v1-public-publication fixture" "v1.0.0 is still described as unpublished" 'No v1.0.0 public publication exists.'
expect_release_status_reject "Reject v1.0.0 deployed fixture" "v1.0.0 is incorrectly described as deployed" 'v1.0.0 has been deployed.'
expect_release_status_reject "Reject v1.0.0 deployment-exists fixture" "v1.0.0 is incorrectly described as deployed" 'Deployment for v1.0.0 exists.'
expect_release_status_reject "Reject generic deployment-performed fixture" "v1.0.0 is incorrectly described as deployed" 'Deployment was performed.'
expect_release_status_reject "Reject reverse deployment-performed fixture" "v1.0.0 is incorrectly described as deployed" 'Deployment was performed for v1.0.0.'
expect_release_status_reject "Reject Markdown deployment-performed fixture" "v1.0.0 is incorrectly described as deployed" '- Deployment was performed.'
expect_release_status_reject "Reject compound Changelog deployment fixture" "v1.0.0 is incorrectly described as deployed" '- Publish through the formal GitHub Release only. Deployment was performed.'
expect_release_status_reject "Reject compound publication-boundary deployment fixture" "v1.0.0 is incorrectly described as deployed" 'Publication is limited to the formal GitHub Release; deployment was performed.'
expect_release_status_reject "Reject unsupported publication fixture" "v1.0.0 uses an unsupported publication channel" 'v1.0.0 was published through a package registry.'
expect_release_status_reject "Reject generic unsupported publication fixture" "v1.0.0 uses an unsupported publication channel" 'Publication was made through a website.'
expect_release_status_reject "Reject Markdown unsupported publication fixture" "v1.0.0 uses an unsupported publication channel" '- Publication was made through a website.'
expect_release_status_reject "Reject wrong annotated-tag date fixture" "v1.0.0 has an incorrect annotated-tag date" 'Published v1.0.0 on July 17, 2026: Progressive Leader State Profiles.'

template_contains_normalized_whitespace "README.md" "Publication is limited to the formal GitHub Release; deployment was not performed." "README preserves publication and no-deployment boundary"
template_contains_normalized_whitespace "CHANGELOG.md" "Publish through the formal GitHub Release only. Deployment was not performed." "CHANGELOG preserves publication and no-deployment boundary"
template_contains_normalized_whitespace "docs/ROADMAP.md" "Publication is limited to the formal GitHub Release. Deployment was not performed." "ROADMAP preserves publication and no-deployment boundary"
template_contains_normalized_whitespace "docs/TODO.md" "Publication is limited to the formal GitHub Release. Deployment was not performed." "TODO preserves publication and no-deployment boundary"
template_contains_normalized_whitespace "docs/VALIDATION.md" "Publication is limited to the formal GitHub Release; deployment was not performed." "VALIDATION preserves publication and no-deployment boundary"

stale_current_state_marker=0
current_release_surfaces=(
  README.md
  CHANGELOG.md
  docs/ADAPTERS.md
  docs/INSTALLATION.md
  docs/ROADMAP.md
  docs/TODO.md
  docs/VALIDATION.md
  references/TRACEABILITY.md
  templates/review-packet-cleanup-checklist.md
)
for current_state_file in "${current_release_surfaces[@]}"; do
  while IFS= read -r current_state_content || [[ -n "$current_state_content" ]]; do
    if release_status_contradiction "$current_state_content"; then
      fail "$current_state_file $RELEASE_STATUS_REASON"
      stale_current_state_marker=1
    fi
  done < "$current_state_file"
done
if [[ "$stale_current_state_marker" -eq 0 ]]; then
  pass "No contradictory current public, development, unpublished, or not-published markers"
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
template_contains "docs/VALIDATION.md" "Runtime installation commands are distinct from validated runtime adapter" "Validation distinguishes runtime install commands"
template_contains "docs/VALIDATION.md" "runtime adapter guide skeletons" "Validation blocks misleading runtime guide skeletons"
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
template_contains "docs/INSTALLATION.md" "Runtime Installation" "Installation guide covers runtime installation"
template_contains "docs/INSTALLATION.md" "docs/RUNTIME_INSTALLATION.md" "Installation guide links runtime installation"
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
template_contains "docs/ADAPTERS.md" "install guidance available; validation pending" "Adapter guide records Claude install qualifier"
template_contains "docs/ADAPTERS.md" "full adapter validation is still pending" "Adapter guide blocks Claude full-support overclaim"
template_contains "docs/RUNTIME_INSTALLATION.md" "bare skill folder shape" "Runtime installation defines bare skill folder"
template_contains "docs/RUNTIME_INSTALLATION.md" "It is not a plugin package." "Runtime installation blocks plugin-package claim"
template_contains "docs/RUNTIME_INSTALLATION.md" "~/.codex/skills/multi-agent-working-group" "Runtime installation includes Codex global path"
template_contains "docs/RUNTIME_INSTALLATION.md" ".codex/skills/multi-agent-working-group" "Runtime installation includes Codex project path"
template_contains "docs/RUNTIME_INSTALLATION.md" "~/.claude/skills/multi-agent-working-group" "Runtime installation includes Claude personal path"
template_contains "docs/RUNTIME_INSTALLATION.md" ".claude/skills/multi-agent-working-group" "Runtime installation includes Claude project path"
template_contains "docs/RUNTIME_INSTALLATION.md" "Status: \`adapter guide planned\`; install guidance is available and validation" "Runtime installation labels Claude as planned"
template_contains "docs/RUNTIME_INSTALLATION.md" "This install path does not mean Claude Code is fully supported." "Runtime installation blocks Claude full-support overclaim"
template_contains "docs/RUNTIME_INSTALLATION.md" "Status: \`adapter guide planned\`." "Runtime installation labels OpenClaw Hermes planned"
template_contains "docs/RUNTIME_INSTALLATION.md" "Do not copy Codex or Claude Code install commands into OpenClaw or Hermes Agent" "Runtime installation blocks unvalidated runtime commands"
template_contains "docs/RUNTIME_INSTALLATION.md" "Copying this skill folder transfers only workflow instructions" "Runtime installation blocks authority transfer"
template_contains "docs/RUNTIME_INSTALLATION.md" "workspace trust" "Runtime installation blocks workspace trust transfer"
template_contains "docs/RUNTIME_INSTALLATION.md" "validation freshness" "Runtime installation blocks validation freshness transfer"
template_contains "docs/RUNTIME_INSTALLATION.md" "role continuity" "Runtime installation blocks role continuity transfer"
template_contains "docs/RUNTIME_INSTALLATION.md" "secret, credential, Keychain, browser, or unrelated-project access" "Runtime installation blocks secret access transfer"
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
