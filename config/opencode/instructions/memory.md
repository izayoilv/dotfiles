# Memory convention (global)

Memory lives outside repos at `~/.config/opencode/memory/<project>.md` —
one file per project. Each file is an append-only log of durable knowledge:
decisions made, repo conventions discovered, fixes that worked (with
versions), and things that failed. No secrets, no transcripts, no one-off
task progress. Repos stay clean; memory never shows in `git status`.

Rules:

1. At the start of a session in a project, read its memory file if it
   exists. Derive `<project>` from the repo directory name.
2. When a decision is made or a verified fix lands, append a dated entry.
   Keep entries to 1–3 lines: what, why, and the verified version/command.
3. Update an entry instead of duplicating it when facts change.
4. Never invent past decisions — if it is not in the memory file, it did
   not happen.
