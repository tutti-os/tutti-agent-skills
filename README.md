# Tutti Agent Skills

Tutti Agent Skills publishes Tutti workspace app authoring skills as both a
plugin repository and a skills repository.

## Add The Plugin Marketplace

From the command line, add this repository as a Codex plugin marketplace:

```bash
codex plugin marketplace add git@github.com:tutti-os/tutti-agent-skills.git
```

In the Codex app, use **Add Plugin Marketplace** with this source:

```text
git@github.com:tutti-os/tutti-agent-skills.git
```

Leave the sparse path empty so Codex can discover
`.agents/plugins/marketplace.json` from the repository root.

After adding the marketplace, install the `tutti` plugin from the Codex plugin
marketplace UI.

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
.agents/plugins/marketplace.json
.codex-plugin/plugin.json
assets/icon.png
plugins/tutti/
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
codex plugin marketplace add .
```
