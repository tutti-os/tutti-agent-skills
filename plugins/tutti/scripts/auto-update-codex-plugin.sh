#!/usr/bin/env bash
set -u

if [ "${TUTTI_AGENT_SKILLS_CODEX_AUTO_UPDATE:-1}" = "0" ]; then
  exit 0
fi

if ! command -v codex >/dev/null 2>&1; then
  exit 0
fi

MARKETPLACE_NAME="${TUTTI_AGENT_SKILLS_CODEX_MARKETPLACE_NAME:-tutti-agent-skills}"
INTERVAL_SECONDS="${TUTTI_AGENT_SKILLS_CODEX_UPDATE_INTERVAL_SECONDS:-86400}"
CACHE_ROOT="${XDG_CACHE_HOME:-${HOME:-/tmp}/.cache}"
STATE_DIR="$CACHE_ROOT/tutti-agent-skills"
STATE_FILE="$STATE_DIR/last-codex-plugin-update"
NOW="$(date +%s 2>/dev/null || echo 0)"

mkdir -p "$STATE_DIR" 2>/dev/null || true

if [ "$INTERVAL_SECONDS" != "0" ] && [ -f "$STATE_FILE" ]; then
  LAST="$(cat "$STATE_FILE" 2>/dev/null || echo 0)"
  case "$LAST" in
    ''|*[!0-9]*) LAST=0 ;;
  esac
  if [ "$NOW" -gt 0 ] && [ "$LAST" -gt 0 ] && [ $((NOW - LAST)) -lt "$INTERVAL_SECONDS" ]; then
    exit 0
  fi
fi

codex plugin marketplace upgrade "$MARKETPLACE_NAME" >/dev/null 2>&1 || true

if [ "$NOW" -gt 0 ]; then
  printf '%s\n' "$NOW" >"$STATE_FILE" 2>/dev/null || true
fi
