---
name: fix-build
description: Diagnoses and fixes failing builds, tests, CI, or deploys. Use when a build fails, tests fail, CI is red, a deploy errors, or the user says fix it. Triggers on build failed, failing tests, CI failure, deploy error, red pipeline.
---

# Fix Build

1. Reproduce first: run the exact failing command and capture the FULL
   output (never truncate diagnostics; re-read saved output if needed).
2. Read the error top-to-bottom. Separate: user code vs upstream/version
   drift vs environment (missing tool, wrong toolchain, network, state).
3. State hypotheses explicitly, then test the cheapest one first.
4. Web-search the exact error text plus tool versions before changing any
   version.
5. Make the minimal fix, then re-run the same command to verify green.
6. If pinned versions changed, update the lockfile/catalog and say so.
