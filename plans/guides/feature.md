# Feature Implementation Guide

Follow this order exactly.

---

# 1. Implement

- Read the task file
- Search existing code/util first
- Reuse or extend before creating new code
- Implement full functionality (no placeholders)

---

# 2. Test

- Read `plans/guides/tests.md`
- Create/update tests for the feature
- Prefer integration tests
- Mock only external boundaries

Run:

- unit/integration tests
- `tsc --noEmit` on changed files

All must pass.

---

# 3. Fix

If tests/build fail:

- debug
- add missing functionality
- repeat until green

You may add temporary logging for debugging.

---

# 4. Task bookkeeping

Update the task file:

- attempts
- files created/changed
- notes (append-only)

---

# 5. Deduplicate

If duplication is introduced:

1. extract shared util in `src/util/{tool}.ts`
2. export via `src/util/index.ts`
3. migrate callers

---

# 6. Commit

Only when build + tests pass:

git add -A
git commit -m "<clear description>"
git push

Never commit broken builds.

---

# 7. Knowledge capture (optional but encouraged)

If you discover reusable patterns or rules:

- add/update docs in `plans/guides/`
- link from AGENTS.md when relevant

---

# 8. Versioning

When green:

- create git tag
- start at 0.0.0
- increment patch
