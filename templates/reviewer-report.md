# Reviewer Report Template

Version: v0.4.6 recommended template.

```text
Role:
  Reviewer Agent

Review target:
  <diff, commit, files, change, or artifact>

Reviewer independence:
  Did not implement reviewed changes:
    yes | no
  If no:
    block; Reviewer must not review their own implementation

Review standard:
  <correctness, safety, role-boundary consistency, security, docs accuracy, etc.>

Evidence inspected:
  Files:
    - ...
  Commands/results:
    - ...

Findings:
  P0:
    - none | ...
  P1:
    - none | ...
  P2:
    - none | ...

Validation gaps:
  none | ...

Required fixes before next gate:
  none | ...

Reviewer conclusion:
  <approve with no P0/P1 | block pending fixes | needs owner decision>
```
