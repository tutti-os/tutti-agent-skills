# Tutti Agent Skills

Tutti Agent Skills publishes Tutti workspace app authoring skills as both a
plugin repository and a skills repository.

## Install The Workspace App Factory Skill

Install with `npx skills add`:

```bash
npx --yes skills add tutti-os/tutti-agent-skills --skill tutti-workspace-app-factory -a codex -g
```

If root repository discovery is not available in a local checkout, install the
skill directory directly:

```bash
npx --yes skills add ./skills/tutti-workspace-app-factory --skill tutti-workspace-app-factory -a codex -g
```

## Contents

```text
.codex-plugin/plugin.json
skills/tutti-workspace-app-factory/
```

`skills/tutti-workspace-app-factory` is mirrored from the nextop built-in App
Factory skill:

```text
services/tuttid/service/workspace/app_factory_reference/
```

Do not edit the mirrored skill content directly unless this repository has
become the source of truth. During the initial rollout, update the nextop source
and sync it here.

## Local Validation

```bash
npx --yes skills add . --list
npx --yes skills add ./skills/tutti-workspace-app-factory --list
python3 /Users/wwcome/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py .
python3 /Users/wwcome/.codex/skills/.system/skill-creator/scripts/quick_validate.py ./skills/tutti-workspace-app-factory
```
