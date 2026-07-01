# Before / after

Three realistic rewrites. The **before** is what you'd normally type. The **after** is what `/enhance` produces after reading your session and codebase — then it stops and waits for `go`.

---

## 1. Bug fix

**Before**

```
/enhance fix the login bug
```

**After**

```
===== ENHANCED PROMPT =====
# Title
Fix session cookie not persisting after login on Safari

## Role & stance
Senior backend engineer. Diagnose the root cause before editing; make the smallest correct change.

## Task
Users on Safari are logged out on the request right after signing in. Find why the session
cookie isn't persisting and fix it.

## Context
- Auth flow lives in `src/auth/session.ts`; the cookie is set in `createSession()`.
- Session store is Redis (`src/lib/redis.ts`).
- Reported on Safari only; Chrome and Firefox are unaffected — points at SameSite / Secure attributes.

## Inputs available
- src/auth/session.ts
- src/lib/redis.ts
- src/middleware/auth.ts
- Current branch: fix/login (git status: clean)

## Output requirements
- A diff-ready fix plus a one-paragraph explanation of the root cause.

## Constraints / Do-nots
- Do not change the session-store backend.
- Do not weaken cookie security (keep `Secure`, keep `HttpOnly`).

## Execution checklist
- [ ] Root cause identified and stated
- [ ] Cookie attributes correct for cross-site Safari behavior
- [ ] Existing auth tests still pass
===========================
```

Reply `go` to run it, or edit any section first.

---

## 2. Tests

**Before**

```
/enhance write tests for the parser
```

**After**

```
===== ENHANCED PROMPT =====
# Title
Add unit tests for the CSV parser

## Role & stance
Test engineer. Cover behavior and edge cases, not just the happy path. Match the existing test style.

## Task
Write unit tests for `parseCsv()` in `src/parser/csv.ts`.

## Context
- Existing tests use Vitest and live in `src/parser/__tests__/`.
- `parseCsv()` handles quoted fields, embedded commas, and CRLF line endings.
- There are currently no tests for empty input or malformed rows.

## Inputs available
- src/parser/csv.ts
- src/parser/__tests__/tokenizer.test.ts (style reference)
- package.json (test runner: vitest)

## Output requirements
- A new file `src/parser/__tests__/csv.test.ts` following the existing style.

## Constraints / Do-nots
- Do not modify the parser implementation.
- No new dependencies.

## Execution checklist
- [ ] Happy path covered
- [ ] Quoted fields, embedded commas, CRLF covered
- [ ] Empty input and malformed rows covered
- [ ] `npm test` passes
===========================
```

Reply `go` to run it, or edit any section first.

---

## 3. Docs

**Before**

```
/enhance make the readme better
```

**After**

```
===== ENHANCED PROMPT =====
# Title
Rewrite README to be skimmable and install-first

## Role & stance
Technical writer. Lead with what the project does and how to run it. Cut fluff.

## Task
Rewrite `README.md` so a new user understands the project and installs it within a minute.

## Context
- Project is a CLI tool published to npm as `quickstamp`.
- Current README is a wall of prose with the install step buried near the bottom.
- Real usage examples exist in `examples/`.

## Inputs available
- README.md (current)
- package.json (name, bin, scripts)
- examples/basic.md

## Output requirements
- Sections: one-line pitch, install, usage, examples, license.
- Skimmable: short paragraphs, code blocks for every command.

## Constraints / Do-nots
- Do not invent features that aren't in the code.
- Keep it under ~120 lines.

## Execution checklist
- [ ] Pitch is one line
- [ ] Install command appears above the fold
- [ ] Every command shown in a copy-pasteable block
- [ ] Only real, existing features described
===========================
```

Reply `go` to run it, or edit any section first.
