# Verify-first rule (global — every project, every stack)

Applies to everything: Rust, PHP/Laravel, JS/TS, Kotlin/Android, infra,
containers, CI, configs. Never answer version- or API-sensitive questions
from memory.

Before writing or updating ANY of these, run a real-time web search for the
official latest documentation and use exactly what it says:

- dependency versions, plugin IDs, and version catalogs (any ecosystem:
  cargo, composer, pnpm/npm, gradle, tofu providers, GH actions, images)
- API schemas, SDK versions, and client libraries
- config / manifest / deploy file layouts (compose, CI, Docker, K8s, tofu)
- CLI flags, DSL blocks, migration guides, and required/minimum tool versions

Rules:

1. NEVER invent a version number, flag, or schema field from memory. If it
   cannot be verified by search right now, say so explicitly instead of
   guessing.
2. Default to the latest STABLE major versions unless the user pins otherwise.
3. When a build or command fails on a version or unknown field, re-search
   before retrying — do not bump versions or guess fields blindly.
4. Prefer primary sources (official docs, registries, GitHub releases) over
   blogs and cached knowledge.
5. After a fix is verified by a real run, state the correct value and where
   it was verified.
6. When touching a package/library API, prefer the Context7 MCP docs tools
   (`resolve-library-id`, then doc query) over plain web search.
