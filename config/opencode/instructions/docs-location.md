# Workflow docs location (global)

Specs, implementation plans, design docs, and any other AI/dev workflow
documents live OUTSIDE repos, under:

- `~/.config/opencode/specs/<project>/` — design docs / specs
- `~/.config/opencode/plans/<project>/` — implementation plans
- `~/.config/opencode/memory/<project>.md` — durable decisions (separate
  memory convention)

Rules:

1. This user preference overrides skill defaults. Superpowers'
   brainstorming and writing-plans skills default to `docs/superpowers/...`
   inside the repo — save to the paths above instead.
2. `<project>` is the repo directory name (e.g. `kotlin-starter`).
3. Never create `docs/`, `specs/`, `plans/`, or AI-notes directories inside
   a project repo. Repos stay clean of workflow artifacts.
4. When a plan references its spec, use the full path under
   `~/.config/opencode/specs/<project>/`.
