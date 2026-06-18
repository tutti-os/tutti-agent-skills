# Tutti Agent Skills

Tutti Agent Skills publishes Tutti workspace app authoring skills as both a
plugin repository and a skills repository.

## Install All Tutti Skills

Install every skill published by this repository:

```bash
npx --yes skills add tutti-os/tutti-agent-skills
```

To inspect the available skills before installing:

```bash
npx --yes skills add tutti-os/tutti-agent-skills --list
```

To install only the workspace app factory skill:

```bash
npx --yes skills add tutti-os/tutti-agent-skills --skill tutti-workspace-app-factory
```

For local development, you can also install from a checked-out skill directory:

```bash
npx --yes skills add ./skills/tutti-workspace-app-factory --skill tutti-workspace-app-factory
```

## Contents

```text
.codex-plugin/plugin.json
skills/tutti-workspace-app-factory/
```

`skills/tutti-workspace-app-factory` is mirrored from the Tutti main built-in App
Factory skill:

```text
services/tuttid/service/workspace/app_factory_reference/
```

Do not edit the mirrored skill content directly unless this repository has
become the source of truth. During the initial rollout, update the Tutti main
source and sync it here.

## Local Validation

```bash
npx --yes skills add . --list
npx --yes skills add ./skills/tutti-workspace-app-factory --list
python3 /Users/wwcome/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py .
python3 /Users/wwcome/.codex/skills/.system/skill-creator/scripts/quick_validate.py ./skills/tutti-workspace-app-factory
```
