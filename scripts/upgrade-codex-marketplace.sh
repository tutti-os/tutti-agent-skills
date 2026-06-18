#!/usr/bin/env bash
set -euo pipefail

MARKETPLACE_NAME="${1:-tutti-agent-skills}"

if ! command -v codex >/dev/null 2>&1; then
  echo "codex CLI is required to upgrade the marketplace." >&2
  exit 1
fi

codex plugin marketplace upgrade "$MARKETPLACE_NAME" ||
  codex -c 'service_tier="fast"' plugin marketplace upgrade "$MARKETPLACE_NAME"
