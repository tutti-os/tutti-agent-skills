# Tutti Agent Skills

<p>
  <img src="./assets/icon.png" alt="Tutti" width="96" height="96" />
</p>

English | [简体中文](./README.zh-CN.md)

[Tutti](https://tutti.sh/) skills and plugin metadata for creating, converting,
localizing, repairing, validating, and exposing CLI-callable Tutti workspace app
packages and agent-enabled app repositories.

This repository is a Codex plugin marketplace, a Claude Code plugin marketplace,
and a Vercel-compatible skills repository. Install it as a plugin when you want
the Codex or Claude Code app experience, or install the skills directly when you
want command-line skill discovery with `npx skills add`.

## What Is Included

- A Codex marketplace definition at `.agents/plugins/marketplace.json`.
- A Claude Code marketplace definition at `.claude-plugin/marketplace.json`.
- A `tutti` plugin under `plugins/tutti/`.
- A root plugin manifest at `.codex-plugin/plugin.json` for direct plugin
  discovery.
- Direct-install skills under `skills/`.
- Tutti CLI surface guidance for `tutti.cli.json` and `/tutti/cli/*` app
  commands.
- Sync helpers for mirroring the skills from the Tutti main repository.

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

### Update the Codex plugin marketplace

Codex marketplace entries are cached locally. To pull the latest version of this
marketplace after the GitHub repository changes, run:

```bash
codex plugin marketplace upgrade tutti-agent-skills
```

The Codex plugin also bundles a `SessionStart` hook at
`plugins/tutti/hooks/codex-hooks.json`. After installing or enabling the plugin,
open `/hooks`, review the Tutti hook, and trust it if you want Codex to check for
marketplace updates automatically between sessions. The hook is throttled to once
every 24 hours by default.

Tune the Codex hook interval with:

```bash
TUTTI_AGENT_SKILLS_CODEX_UPDATE_INTERVAL_SECONDS=0
```

Disable the Codex hook-driven update entirely with:

```bash
TUTTI_AGENT_SKILLS_CODEX_AUTO_UPDATE=0
```

This repository also includes a wrapper script for teams that want to call the
same update from `cron`, `launchd`, or another local automation:

```bash
./scripts/upgrade-codex-marketplace.sh
```

### Add the Claude Code plugin marketplace

For a first-time install, add the marketplace first, then install the `tutti`
plugin.

Inside Claude Code:

```text
/plugin marketplace add tutti-os/tutti-agent-skills
/plugin install tutti@tutti-agent-skills
```

From the command line:

```bash
claude plugin marketplace add tutti-os/tutti-agent-skills
claude plugin install tutti@tutti-agent-skills
```

Claude Code discovers the marketplace manifest from the repository root:

```text
.claude-plugin/marketplace.json
```

### Update the Claude Code plugin marketplace

Only run `marketplace update` after `tutti-agent-skills` has already been added
with `marketplace add`. If `claude plugin marketplace list` only shows
`claude-plugins-official`, add this marketplace first.

To refresh Claude Code's local marketplace cache after this repository changes:

```bash
claude plugin marketplace update tutti-agent-skills
```

The Claude Code plugin also includes a quiet `SessionStart` hook at
`plugins/tutti/hooks/claude-hooks.json` that runs the same marketplace update in
the background. It is throttled to once every 24 hours by default so new
sessions do not hit the network every time. You can tune it with:

```bash
TUTTI_AGENT_SKILLS_UPDATE_INTERVAL_SECONDS=0
```

To disable the hook-driven update entirely:

```bash
TUTTI_AGENT_SKILLS_AUTO_UPDATE=0
```

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

Install only the agent workspace app architecture skill:

```bash
npx --yes skills add tutti-os/tutti-agent-skills --skill tutti-agent-workspace-app
```

Install from a local checkout during development:

```bash
npx --yes skills add ./skills/tutti-workspace-app-factory --skill tutti-workspace-app-factory
npx --yes skills add ./skills/tutti-agent-workspace-app --skill tutti-agent-workspace-app
```

## Skills

### `tutti-workspace-app-factory`

Creates, converts, or repairs a Tutti workspace app package. The generated
package is meant to be self-contained and runnable by the Tutti custom app
runtime.

The skill covers:

- `tutti.app.json` and optional `tutti.cli.json` manifests.
- CLI-callable app capabilities through `tutti.cli.json` and `/tutti/cli/*`
  handlers.
- Existing repository conversion into `package/`-scoped Tutti packages.
- I18n harness guidance for manifest metadata and in-app copy parity.
- `bootstrap.sh` runtime entrypoints.
- Package-local `AGENTS.md` guidance.
- Local HTTP app runtime rules.
- Tutti-managed runtime environment variables.
- Static validation script and checklist for generated app packages.

### `tutti-agent-workspace-app`

Builds or evolves a full agent-enabled Tutti app repository. Use it when the
task needs a maintainable app architecture rather than only a package directory.

The skill covers:

- `apps/web`, `apps/server`, and `packages/shared` monorepo boundaries.
- `@tutti-os/agent-acp-kit` local Codex/Claude runtime integration.
- Run-scoped MCP/tool gateway patterns.
- Tutti CLI/reference surfaces for external agents and other apps.
- App-owned `scripts/package-tutti-app.mjs` package builders.
- Web-first debugging, i18n enforcement, and package smoke validation.
- Deferring final package contracts back to `tutti-workspace-app-factory`.

## Repository Layout

```text
.
├── .agents/plugins/marketplace.json
├── .claude-plugin/marketplace.json
├── .codex-plugin/plugin.json
├── assets/icon.png
├── plugins/tutti/
│   ├── .claude-plugin/plugin.json
│   ├── .codex-plugin/plugin.json
│   ├── assets/icon.png
│   ├── hooks/claude-hooks.json
│   ├── hooks/codex-hooks.json
│   ├── scripts/auto-update-codex-plugin.sh
│   ├── scripts/auto-update-claude-plugin.sh
│   └── skills/
│       ├── tutti-agent-workspace-app/
│       └── tutti-workspace-app-factory/
├── scripts/
│   ├── check-tutti-main-sync.sh
│   ├── pull-from-tutti-main.sh
│   └── upgrade-codex-marketplace.sh
└── skills/
    ├── tutti-agent-workspace-app/
    └── tutti-workspace-app-factory/
```

There are two skill copies by design:

- `skills/*/` supports direct `npx skills add`
  installs from the repository root.
- `plugins/tutti/skills/*/` is bundled with the Claude Code and Codex `tutti`
  plugin.

## Sync Model

During the current rollout, the source of truth is the Tutti main repository:

```text
services/tuttid/service/workspace/app_factory_reference/
services/tuttid/service/workspace/agent_workspace_app_reference/
```

This repository mirrors those directories into both public skill locations. Do not
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
npx --yes skills add ./skills/tutti-agent-workspace-app --list
claude plugin validate .
claude plugin validate ./plugins/tutti
codex plugin marketplace add .
```

GitHub Actions also validates skill discovery, plugin manifests, marketplace
layout, Claude Code marketplace metadata, icon paths, website metadata, and skill
frontmatter on pull requests and pushes to `main`.

## Status

This repository currently publishes two Tutti skills and one `tutti` plugin for
Claude Code and Codex. Additional Tutti skills can be added under `skills/` and
`plugins/tutti/skills/` without changing the install flow.

## License

Apache License 2.0. See [LICENSE](./LICENSE).
