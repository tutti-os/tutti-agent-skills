#!/usr/bin/env bash
set -euo pipefail

SOURCE_REPO="${1:?usage: $0 /path/to/tutti-main}"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$TMP_DIR/skills/tutti-workspace-app-factory"
rsync -a --delete \
  "$SOURCE_REPO/services/tuttid/service/workspace/app_factory_reference/" \
  "$TMP_DIR/skills/tutti-workspace-app-factory/"

diff -ru "$TMP_DIR/skills/tutti-workspace-app-factory" \
  "skills/tutti-workspace-app-factory"

diff -ru "$TMP_DIR/skills/tutti-workspace-app-factory" \
  "plugins/tutti/skills/tutti-workspace-app-factory"
