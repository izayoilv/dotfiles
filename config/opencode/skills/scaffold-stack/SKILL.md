---
name: scaffold-stack
description: Scaffolds a new project in any language or stack, familiar or not. Use when starting a new project, creating a starter template, or initializing a blank repo. Triggers on new project, scaffold, starter, init repo, greenfield.
---

# Scaffold Stack

For greenfield work in ANY ecosystem — familiar or brand-new:

1. Confirm current best practice via real-time web search first, even for
   familiar stacks: official scaffolder (if any), canonical layout,
   toolchain manager (rustup, sdkman, mise, bun, composer, tofuenv),
   lockfile, and LTS versions. Familiarity is not a substitute for
   verification.
2. Prefer the ecosystem's own declarative version pinning: lockfiles,
   version catalogs, `.tool-versions` / `.sdkmanrc`, `required_version`.
3. Always include: stack `.gitignore`, README with setup/run/test, formatter
   + linter config, minimal CI workflow.
4. Commit lockfiles and wrapper scripts; prefer toolchains over system
   packages; never `latest` tags for prod inputs.
5. Verify by running the project's own build/test/validate command before
   handing over.
6. Verify-first rule applies — never invent versions or layouts.
