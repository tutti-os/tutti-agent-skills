#!/usr/bin/env bash
set -euo pipefail

SOURCE_REPO="${1:?usage: $0 /path/to/tutti-main}"
rsync -a --delete \
  "$SOURCE_REPO/services/tuttid/service/workspace/app_factory_reference/" \
  "skills/tutti-workspace-app-factory/"
rsync -a --delete \
  "$SOURCE_REPO/services/tuttid/service/workspace/app_factory_reference/" \
  "plugins/tutti/skills/tutti-workspace-app-factory/"
rsync -a --delete \
  "$SOURCE_REPO/services/tuttid/service/workspace/agent_workspace_app_reference/" \
  "skills/tutti-agent-workspace-app/"
rsync -a --delete \
  "$SOURCE_REPO/services/tuttid/service/workspace/agent_workspace_app_reference/" \
  "plugins/tutti/skills/tutti-agent-workspace-app/"
