#!/usr/bin/env bash
set -euo pipefail

NEXTOP="${1:?usage: $0 /path/to/nextop}"
SRC_DIR="$NEXTOP/services/tuttid/service/workspace/app_factory_reference/"
DST_DIR="skills/tutti-workspace-app-factory/"

rsync -a --delete "$SRC_DIR" "$DST_DIR"
