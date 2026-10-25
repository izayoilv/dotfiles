# Code style (global)

Write code that does not need comments, then comment only what code cannot
say.

Forbidden:

- comments that restate the code (`i++ // increment i`)
- commented-out code (delete it; git remembers)
- noise headers, banners, and docstrings that only repeat the signature
- placeholder TODO/FIXME with no owner, reason, or follow-up
- thinking traces or chain-of-thought inside comments

Allowed, sparingly:

- WHY: non-obvious intent, business rules, invariants
- workarounds and hacks — always with a link (issue, docs) and a removal
  condition
- public API contracts the type system cannot express

When editing, match the file's existing style; when in doubt, delete the
comment instead of adding one.
