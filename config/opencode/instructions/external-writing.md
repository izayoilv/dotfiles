# External writing (global)

Applies to anything that leaves the session: commit messages, PR/MR titles and
bodies, issue reports, review comments, changelogs, release notes, and
user-facing docs. Internal chat may use shorthand; public artifacts may not.

## Reader test

Assume the reader has the repository, the diff, and the public issue tracker.
They did not see this conversation, plan, spec, memory, or tool output. If a
sentence only makes sense with that context, rewrite it or add the missing
context.

## Do not leak internal framing

Avoid process narration and conversation-only labels, for example:

- "as discussed", "as requested", "per the plan", "phase N", "step N",
  "task N", "slice", "lane", "handoff", "brainstorm", "subagent", "session",
  "prompt", "tool call", "memory", "spec", "implementation plan"
- "the user asked", "the assistant", "the agent", "I decided"
- private paths (`~/.config/opencode/...`), session IDs, absolute local paths,
  private links, and internal ticket names

Use the project's public vocabulary from README, docs, and issue history. If a
term is only meaningful internally, replace it with plain language or define
it on first use. Describe the final state, not the sequence of steps taken to
reach it. Do not mention AI generation unless the repository requires
disclosure.

## Commits

Follow the repository's convention; otherwise use Conventional Commits.

- Subject: `type(scope): imperative summary`, at most 72 characters, no
  trailing period. State the change, not the process. Replace vague subjects
  (`update`, `fix stuff`, `misc`, `address review`) with the actual behavior
  changed.
- Body when non-trivial: why the change is needed, what changed, and how it was
  verified. Wrap at 72-100 characters.
- Reference public issues with `Closes #123` / `Refs #123` only when true.
- No WIP markers or agent attribution in the final message.

## PR / MR

- Title: a reviewer-facing summary of the change, not an internal phase or task
  name.
- Body sections: Summary (problem and outcome), Changes (behavior),
  Verification (exact commands/results), Risks/Notes (breaking changes,
  migrations, follow-ups), Related (public issues only).
- Add the minimum background a reviewer needs: the problem, why the change is
  needed, and any constraint that shaped it.
- Include reproduction steps or screenshots when they help review.
- Write for someone who will read the diff without asking you what it means.

## Issues, changelogs, docs

- Issue: environment, reproduction steps, expected vs actual, logs, workaround.
- Changelog/release notes: user-visible impact first; omit internal refactors
  unless they affect users.
- Docs/comments: define domain terms, expand acronyms on first use, and avoid
  private names.

## Before sending

Use absolute dates and versions, not "today", "currently", or "recently".
Remove anything that only makes sense because of this conversation. Prefer
concrete outcomes over process words.
