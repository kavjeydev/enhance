# Changelog

All notable changes to `enhance` are documented here.

## [Unreleased]

### Changed
- **Inverted the default.** `/enhance` now rewrites *and runs* the prompt by default. Pass the new `--check` flag (at the start or end of the request) to review and approve the prompt before it runs. Replaces the old `--go` one-shot flag.

## [0.0.1] - 2026-06-30

### Added
- `enhance` skill: rewrites a rough request into a structured, session- and codebase-aware prompt.
- Review-before-run by default; append `--go` for one-shot execution.
- `TEMPLATE.md` prompt structure, referenced (not inlined) from `SKILL.md`.
- Plugin marketplace support: `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
- `install.sh` and manual-copy install paths.
- Three before/after examples.
