---
name: enhance
description: Rewrite a rough request into a structured, high-signal prompt grounded in the live session and codebase, then review-before-run. Explicit-only (/enhance).
disable-model-invocation: true
argument-hint: [rough request] [--go]
---

# /enhance

Turn my rough ask into a precise, structured prompt — grounded in this session and this codebase — then show it to me and wait for the go-ahead before running.

**Rough request:** $ARGUMENTS

## Mode

- **Default: review-then-run.** Rewrite, print, stop, wait for `go`.
- **One-shot:** if `$ARGUMENTS` includes a `--go` flag (at the start or the end), remove it, skip the review, and execute the rewritten prompt immediately.

## Steps

1. Treat `$ARGUMENTS` as my rough ask — first strip a `--go` flag if it appears at the start or end (it only selects one-shot mode and is not part of the request).
2. Rewrite it into the structure defined in [TEMPLATE.md](TEMPLATE.md). To fill it in:
   - Pull **Context** and **Inputs available** from the current conversation.
   - Actively read the codebase — glob for relevant files, grep for symbols, read what matters.
   - Where useful, check live repo state: run !`git status` and !`git diff --stat`.
   - Include only the sections that apply. For a genuinely unknown field, leave a `[placeholder]` — never invent details.
3. Print the finished prompt in a clearly delimited block, exactly like this:

   ```
   ===== ENHANCED PROMPT =====
   <the rewritten prompt>
   ===========================
   ```

   Then **STOP**. Say: *Reply `go` to run it, or edit any section first.* Do not execute or partially execute yet.
4. On `go` (or immediately, in one-shot mode), execute the rewritten prompt as the actual task.

## Rules

- Stay faithful to my intent — sharpen the ask, don't redirect it.
- Prefer evidence from the session and files over assumptions.
- Never fabricate file names, APIs, or requirements; use `[placeholder]` instead.
- In review mode, output the prompt block and nothing else — no work starts until I confirm.
