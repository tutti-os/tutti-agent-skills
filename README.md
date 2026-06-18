# Tutti Agent Skills

<p>
  <img src="./assets/icon.png" alt="Tutti" width="96" height="96" />
</p>

[Tutti](https://tutti.sh/) skills and plugin metadata for creating, repairing,
and validating self-contained Tutti workspace app packages.

This repository is both a Codex plugin marketplace and a Vercel-compatible
skills repository. Install it as a plugin when you want the Codex app experience,
or install the skills directly when you want command-line skill discovery with
`npx skills add`.

## What Is Included

- A Codex marketplace definition at `.agents/plugins/marketplace.json`.
- A `tutti` Codex plugin under `plugins/tutti/`.
- A root plugin manifest at `.codex-plugin/plugin.json` for direct plugin
  discovery.
- The `tutti-workspace-app-factory` skill under
  `skills/tutti-workspace-app-factory/`.
- Sync helpers for mirroring the skill from the Tutti main repository.

## Quick Start

### Add the Codex plugin marketplace

From the command line:

```bash
codex plugin marketplace add git@github.com:tutti-os/tutti-agent-skills.git
```

From the Codex app, open **Add Plugin Marketplace** and use:

```text
git@github.com:tutti-os/tutti-agent-skills.git
```

Leave the sparse path empty. Codex discovers the marketplace manifest from the
repository root:

```text
.agents/plugins/marketplace.json
```

After the marketplace is added, install the `tutti` plugin from the Codex plugin
marketplace UI.

### Install the skills directly

Install every skill published by this repository:

```bash
npx --yes skills add tutti-os/tutti-agent-skills
```

Inspect available skills before installing:

```bash
npx --yes skills add tutti-os/tutti-agent-skills --list
```

Install only the workspace app factory skill:

```bash
npx --yes skills add tutti-os/tutti-agent-skills --skill tutti-workspace-app-factory
```

Install from a local checkout during development:

```bash
npx --yes skills add ./skills/tutti-workspace-app-factory --skill tutti-workspace-app-factory
```

## Skill

### `tutti-workspace-app-factory`

Creates or repairs a Tutti workspace app package. The generated package is meant
to be self-contained and runnable by the Tutti custom app runtime.

The skill covers:

- `tutti.app.json` and optional `tutti.cli.json` manifests.
- `bootstrap.sh` runtime entrypoints.
- Package-local `AGENTS.md` guidance.
- Local HTTP app runtime rules.
- Tutti-managed runtime environment variables.
- Validation checks for generated app packages.

## Repository Layout

```text
.
├── .agents/plugins/marketplace.json
├── .codex-plugin/plugin.json
├── assets/icon.png
├── plugins/tutti/
│   ├── .codex-plugin/plugin.json
│   ├── assets/icon.png
│   └── skills/tutti-workspace-app-factory/
├── scripts/
│   ├── check-tutti-main-sync.sh
│   └── pull-from-tutti-main.sh
└── skills/tutti-workspace-app-factory/
```

There are two skill copies by design:

- `skills/tutti-workspace-app-factory/` supports direct `npx skills add`
  installs from the repository root.
- `plugins/tutti/skills/tutti-workspace-app-factory/` is bundled with the Codex
  `tutti` plugin.

## Sync Model

During the current rollout, the source of truth is the Tutti main repository:

```text
services/tuttid/service/workspace/app_factory_reference/
```

This repository mirrors that directory into both public skill locations. Do not
edit mirrored skill content directly unless this repository has intentionally
become the source of truth.

To refresh this repository from a local Tutti main checkout:

```bash
./scripts/pull-from-tutti-main.sh /path/to/tutti-main
```

To check whether this repository is still in sync:

```bash
./scripts/check-tutti-main-sync.sh /path/to/tutti-main
```

## Validation

Run these checks before opening a pull request:

```bash
npx --yes skills add . --list
npx --yes skills add ./skills/tutti-workspace-app-factory --list
codex plugin marketplace add .
```

GitHub Actions also validates skill discovery, plugin manifests, marketplace
layout, icon paths, website metadata, and skill frontmatter on pull requests and
pushes to `main`.

## Status

This repository currently publishes one Tutti skill and one Codex plugin. The
layout is intentionally prepared for adding more Tutti skills later without
changing the install flow.

## License

MIT. See [LICENSE](./LICENSE).
