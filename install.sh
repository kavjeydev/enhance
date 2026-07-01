#!/usr/bin/env bash
set -euo pipefail

# Install the `enhance` skill into ~/.claude/skills/enhance
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/skills/enhance"
DEST="${HOME}/.claude/skills/enhance"

if [ ! -d "$SRC" ]; then
  echo "error: source skill not found at $SRC" >&2
  exit 1
fi

mkdir -p "${HOME}/.claude/skills"
rm -rf "$DEST"
cp -R "$SRC" "$DEST"

echo "✓ Installed 'enhance' to $DEST"
echo "  Open Claude Code and type /enhance to use it."
