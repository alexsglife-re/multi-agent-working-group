# Git Gate Template

Version: v0.4.7 recommended template.

```text
Gate:
  pre-commit | post-commit | pre-push | post-push

Target:
  Branch:
  Remote:
  Commit or range:

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
  Model/provider:
  P0:
  P1:
  Conclusion:

Advisor review:
  Model/provider:
  P0:
  P1:
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
