# Git Gate Template

Version: v0.4.13 recommended template.

```text
Gate:
  pre-commit | post-commit | pre-push | post-push

Target:
  Branch:
  Remote:
  Commit or range:

Context-efficient review identity:
  Review ID:
  PM Attempt ID / packet fingerprint / state:
  Advisor Attempt ID / packet fingerprint / state:
  Stable baseline and incremental target:
  Any result-unknown attempt:
    none | <identity, available evidence, unresolved gate; do not blindly retry>

Owner authorization state:
  <owner-requested normal work | explicit owner approval | not authorized | high-risk owner approval required>

Risk/default-exclusion check:
  Risk tier:
  Default exclusions touched:
    yes | no
  Notes:

Changed files:
  - ...

Validation evidence:
  - Command:
    Result:
    Freshness:

PM review:
  Provider/model:
  Model source:
  Source freshness/current verification:
  P0:
  P1:
  P2:
  Evidence gaps:
  Conclusion:

Advisor review:
  Provider/model:
  Model source:
  Source freshness/current verification:
  Separation/diversity status:
  P0:
  P1:
  P2:
  Evidence gaps:
  Conclusion:

Reviewer status:
  not required | required and passed | required and blocked

Secret/credential scan:
  Required:
  Result:

CI/status:
  Required:
  Result:

Gate conclusion:
  <may proceed | blocked>

Post-action review required:
  yes | no
```
