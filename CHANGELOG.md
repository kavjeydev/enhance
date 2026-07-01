# Changelog

All notable changes to `enhance` are documented here.

## [Unreleased]

### Changed
- `--go` one-shot flag is now position-independent (start or end of the request), so a keyboard shortcut can prefill it.

## [0.0.1] - 2026-06-30

### Added
- `enhance` skill: rewrites a rough request into a structured, session- and codebase-aware prompt.
- Review-before-run by default; append `--go` for one-shot execution.
- `TEMPLATE.md` prompt structure, referenced (not inlined) from `SKILL.md`.
- Plugin marketplace support: `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
- `install.sh` and manual-copy install paths.
- Three before/after examples.
