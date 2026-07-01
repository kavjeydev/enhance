# enhance

**Type a rough request. Get a structured, high-signal prompt built from your live session and codebase — then run it.**

`/enhance` is a personal prompt-enhancer for Claude Code. You give it a half-formed ask; it rewrites that into a precise, structured prompt using your **live session** and your **actual codebase**, then runs it. Want to eyeball the prompt first? Add `--check` and it waits for your `go`.

## What makes it different

Generic "improve my prompt" tools rewrite text in a vacuum. `enhance` is:

- **Session-aware** — it reads the current conversation for context.
- **Codebase-aware** — it globs, greps, reads files, and checks live git state to ground the prompt in reality.
- **Review on demand** — it runs the rewritten prompt by default, but add `--check` to inspect and approve it first. Most rewriters give you no gate at all.

## When to use it (and when not)

`enhance` doesn't make Claude smarter — it's the same model doing the same analysis. What it adds is a **structured rewrite** of your ask (grounded in your session and codebase), plus an optional **checkpoint** (`--check`) to approve that rewrite before any work starts.

**The default (rewrite-and-run) helps when:**

- Your ask is rough and a cleaner, structured version gets a better first result.
- You want the rewrite but trust it enough to just let it go.

**Reach for `--check` when:**

- The task is **expensive or hard to undo** — a big refactor, a migration, something touching many files. Approving the interpretation up front beats undoing a misread.
- You want the enhanced prompt as a **reusable artifact** before it runs.

**Skip `/enhance` entirely when:**

- The task is **small, cheap, or reversible** — just tell Claude directly; the rewrite is overhead.
- The prompt is only **ambiguous** — Claude already asks a clarifying question on its own when something is genuinely unclear.

The rewrite is a modest boost; the `--check` gate is where the real control is. On the right tasks it saves a correction round-trip; on trivial ones it's just friction.

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

`enhance` inspects your session and repo, shows the enhanced prompt, and **runs it**.

Want to approve the prompt first? Add `--check` (at the start or end) and it stops and waits for your `go`:

```
/enhance --check fix the flaky test in the checkout flow
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

Bind keys to type the command for you. In your Ghostty config (`~/.config/ghostty/config`):

```
keybind = cmd+e=text:/enhance 
keybind = cmd+shift+e=text:/enhance --check 
```

- `⌘E` → `/enhance ` (rewrite-and-run) — cursor ready, start typing.
- `⌘⇧E` → `/enhance --check ` (review) — same, but stops for your `go` first.

Keep the **trailing space** after `/enhance` and `--check` so your text doesn't run into the command. Reload Ghostty with `⌘⇧,` (or restart) to apply.

## Works beyond Claude Code

`enhance` follows the open [Agent Skills](https://www.anthropic.com/engineering/skills) standard — a plain `SKILL.md` with YAML frontmatter. The same skill works in **Codex**, **Cursor**, and **claude.ai**. Write it once, use it everywhere.

## Feedback & contributing

Questions, feedback, and change requests are welcome:

- **[Open an issue](https://github.com/kavjeydev/enhance/issues)** — bugs, ideas, or requests.
- **[Start a discussion](https://github.com/kavjeydev/enhance/discussions)** — questions and open-ended feedback.

PRs welcome too — it's a single `SKILL.md` plus a template, easy to fork and tweak.

## License

MIT — see [LICENSE](LICENSE).
