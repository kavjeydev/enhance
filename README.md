# enhance

**Type a rough request. Get a structured, high-signal prompt — reviewed before it runs.**

`/enhance` is a personal prompt-enhancer for Claude Code. You give it a half-formed ask; it rewrites that into a precise, structured prompt using your **live session** and your **actual codebase**, shows you the result, and only executes once you reply `go`.

## What makes it different

Generic "improve my prompt" tools rewrite text in a vacuum and fire immediately. `enhance` is:

- **Session-aware** — it reads the current conversation for context.
- **Codebase-aware** — it globs, greps, reads files, and checks live git state to ground the prompt in reality.
- **Review-before-run** — it prints the rewritten prompt and stops. Nothing executes until you confirm. (Append `--go` to skip the review when you're in a hurry.)

## Install (20 seconds)

**Option A — Claude Code plugin marketplace**

```
/plugin marketplace add kavjeydev/enhance
/plugin install enhance@enhance
```

**Option B — install script**

```
git clone https://github.com/kavjeydev/enhance.git
cd enhance
./install.sh
```

**Option C — manual copy**

```
cp -R skills/enhance ~/.claude/skills/enhance
```

Then type `/enhance` in Claude Code.

## Usage

```
/enhance fix the flaky test in the checkout flow
```

`enhance` inspects your session and repo, prints an enhanced prompt in a delimited block, and **stops**. Review it, then reply `go` — or edit any section first.

One-shot (skip the review, run immediately):

```
/enhance fix the flaky test in the checkout flow --go
```

## Auto-mode (optional)

`enhance` ships **disabled from auto-invocation** (`disable-model-invocation: true` in `SKILL.md`). That's the safe default: type a vague prompt and Claude just answers it — no rewrite, no interruption. The skill runs only when you type `/enhance` yourself.

Even disabled, Claude may still *suggest* it in passing (*"this looks underspecified — want to run `/enhance` on it?"*). That's a suggestion you can ignore, not an auto-invocation — nothing is rewritten or delayed unless you actually type the command. To silence even that nudge, add one line to your `CLAUDE.md`:

```
Never suggest /enhance; I'll invoke it myself.
```

**Prefer it to auto-catch lazy prompts?** Flip the flag in `skills/enhance/SKILL.md`:

```yaml
disable-model-invocation: false
```

Now Claude decides on its own when a prompt is vague enough to enhance. Off is the safer default (no surprise rewrites); on is for people who'd rather have their rough prompts caught automatically.

## Before / after

### Bug fix

**Before** — `/enhance fix the login bug`

**After**

```
===== ENHANCED PROMPT =====
# Title
Fix session cookie not persisting after login on Safari

## Task
Users on Safari are logged out on the request right after signing in. Find why the session
cookie isn't persisting and fix it.

## Context
- Auth flow lives in src/auth/session.ts; cookie is set in createSession().
- Reported on Safari only — points at SameSite / Secure attributes.

## Constraints / Do-nots
- Do not weaken cookie security (keep Secure, keep HttpOnly).
===========================
```

### Tests

**Before** — `/enhance write tests for the parser`

**After**

```
===== ENHANCED PROMPT =====
# Title
Add unit tests for the CSV parser

## Task
Write unit tests for parseCsv() in src/parser/csv.ts.

## Context
- Existing tests use Vitest and live in src/parser/__tests__/.
- No tests currently cover empty input or malformed rows.

## Execution checklist
- [ ] Quoted fields, embedded commas, CRLF covered
- [ ] npm test passes
===========================
```

### Docs

**Before** — `/enhance make the readme better`

**After**

```
===== ENHANCED PROMPT =====
# Title
Rewrite README to be skimmable and install-first

## Task
Rewrite README.md so a new user understands the project and installs it within a minute.

## Output requirements
- Sections: one-line pitch, install, usage, examples, license.
===========================
```

Full versions live in [`examples/before-after.md`](examples/before-after.md).

## Pair it with a shortcut

Bind a key to type the command for you. In your Ghostty config (`~/.config/ghostty/config`):

```
keybind = cmd+e=text:/enhance 
```

Now `⌘E` drops `/enhance ` into the prompt with the cursor ready — start typing your rough ask.

## Works beyond Claude Code

`enhance` follows the open [Agent Skills](https://www.anthropic.com/engineering/skills) standard — a plain `SKILL.md` with YAML frontmatter. The same skill works in **Codex**, **Cursor**, and **claude.ai**. Write it once, use it everywhere.

## License

MIT — see [LICENSE](LICENSE).
