#!/usr/bin/env bash
set -euo pipefail

# Sync canonical skills/zig/ to all IDE skill directories.
# Usage:
#   bash scripts/sync-ide-folders.sh          # sync all
#   bash scripts/sync-ide-folders.sh --verify  # check if all dirs match

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CANONICAL="$REPO_ROOT/skills/zig"

# Standard IDE directories (each gets skills/zig/ with SKILL.md + references/)
IDE_DIRS=(
  .agent/skills/zig
  .cursor/skills/zig
  .opencode/skills/zig
  .codex/skills/zig
  .gemini/skills/zig
  .continue/skills/zig
  .kilocode/skills/zig
  .factory/skills/zig
  .adal/skills/zig
  .codebuddy/skills/zig
  .openclaw/skills/zig
  .pi/skills/zig
)

# Kiro uses steering format (just SKILL.md renamed)
KIRO_DIR=".kiro/steering"
KIRO_FILE="zig-skill.md"

verify() {
  local errors=0

  for dir in "${IDE_DIRS[@]}"; do
    target="$REPO_ROOT/$dir"
    if [ ! -d "$target" ]; then
      echo "MISSING: $dir"
      errors=$((errors + 1))
      continue
    fi
    if ! diff -rq "$CANONICAL" "$target" > /dev/null 2>&1; then
      echo "OUT OF SYNC: $dir"
      diff -rq "$CANONICAL" "$target" 2>/dev/null || true
      errors=$((errors + 1))
    else
      echo "OK: $dir"
    fi
  done

  # Check Kiro
  kiro_target="$REPO_ROOT/$KIRO_DIR/$KIRO_FILE"
  if [ ! -f "$kiro_target" ]; then
    echo "MISSING: $KIRO_DIR/$KIRO_FILE"
    errors=$((errors + 1))
  elif ! diff -q "$CANONICAL/SKILL.md" "$kiro_target" > /dev/null 2>&1; then
    echo "OUT OF SYNC: $KIRO_DIR/$KIRO_FILE"
    errors=$((errors + 1))
  else
    echo "OK: $KIRO_DIR/$KIRO_FILE"
  fi

  if [ "$errors" -gt 0 ]; then
    echo ""
    echo "$errors directory(ies) need syncing. Run: bash scripts/sync-ide-folders.sh"
    exit 1
  else
    echo ""
    echo "All IDE directories are in sync."
  fi
}

sync_all() {
  for dir in "${IDE_DIRS[@]}"; do
    target="$REPO_ROOT/$dir"
    rm -rf "$target"
    mkdir -p "$(dirname "$target")"
    cp -R "$CANONICAL" "$target"
    echo "Synced: $dir"
  done

  # Kiro
  mkdir -p "$REPO_ROOT/$KIRO_DIR"
  cp "$CANONICAL/SKILL.md" "$REPO_ROOT/$KIRO_DIR/$KIRO_FILE"
  echo "Synced: $KIRO_DIR/$KIRO_FILE"

  echo ""
  echo "All IDE directories synced from skills/zig/."
}

if [ "${1:-}" = "--verify" ]; then
  verify
else
  sync_all
fi
