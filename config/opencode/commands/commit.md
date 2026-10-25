---
description: Create a conventional commit from staged changes.
---

Inspect `git status` and `git diff --cached`. If nothing is staged, ask which
files to stage — never blanket-add. Write a concise conventional-commit
message matching the repo's existing style (`git log --oneline -10`), commit
once, report the hash. Never push unless explicitly asked. $ARGUMENTS
