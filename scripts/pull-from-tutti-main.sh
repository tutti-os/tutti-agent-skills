#!/usr/bin/env bash
set -euo pipefail

SOURCE_REPO="${1:?usage: $0 /path/to/tutti-main}"
SRC_DIR="$SOURCE_REPO/services/tuttid/service/workspace/app_factory_reference/"
DST_DIR="skills/tutti-workspace-app-factory/"
PLUGIN_DST_DIR="plugins/tutti/skills/tutti-workspace-app-factory/"

rsync -a --delete "$SRC_DIR" "$DST_DIR"
rsync -a --delete "$SRC_DIR" "$PLUGIN_DST_DIR"
