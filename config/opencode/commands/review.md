---
description: Review the working-tree diff for bugs, convention drift, and unsafe ops.
agent: reviewer
subagent: true
---

Review `git status` plus `git diff` in the current repo and report findings
ordered by severity: bugs introduced, drift from the repo's own conventions
(AGENTS.md, linters, recent commit style), unsafe operations (destructive
commands, secrets, unpinned versions), and anything the verify-first rule
should have caught. Do not edit files — findings only.
