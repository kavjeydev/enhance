---
name: enhance
description: Rewrite a rough request into a structured, high-signal prompt grounded in the live session and codebase, then run it. Add --check to review the prompt before it runs. Explicit-only (/enhance).
disable-model-invocation: true
argument-hint: [rough request] [--check]
---

# /enhance

Turn my rough ask into a precise, structured prompt — grounded in this session and this codebase — then run it. Add `--check` to see the rewritten prompt and approve it before it runs.

**Rough request:** $ARGUMENTS

## Mode

- **Default: rewrite-and-run.** Rewrite the prompt, show it, then execute it immediately — no confirmation step.
- **Review (`--check`):** if `$ARGUMENTS` includes a `--check` flag (at the start or the end), remove it, print the rewritten prompt, stop, and wait for `go` (or edits) before running.

## Steps

1. Treat `$ARGUMENTS` as my rough ask — first strip a `--check` flag if it appears at the start or end (it only selects review mode and is not part of the request).
2. Rewrite it into the structure defined in [TEMPLATE.md](TEMPLATE.md). To fill it in:
   - Pull **Context** and **Inputs available** from the current conversation.
   - Actively read the codebase — glob for relevant files, grep for symbols, read what matters.
   - Where useful, check live repo state: run !`git status` and !`git diff --stat`.
   - Include only the sections that apply. For a genuinely unknown field, leave a `[placeholder]` — never invent details.
3. Show the finished prompt in a clearly delimited block, exactly like this:

   ```
   ===== ENHANCED PROMPT =====
   <the rewritten prompt>
   ===========================
   ```

4. Then:
   - **Default (no `--check`):** proceed straight into executing the rewritten prompt as the actual task.
   - **Review mode (`--check`):** **STOP.** Say: *Reply `go` to run it, or edit any section first.* Do not execute or partially execute yet. On `go`, execute it.

## Rules

- Stay faithful to my intent — sharpen the ask, don't redirect it.
- Prefer evidence from the session and files over assumptions.
- Never fabricate file names, APIs, or requirements; use `[placeholder]` instead.
- In `--check` mode, output the prompt block and nothing else — no work starts until I confirm.
