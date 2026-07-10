# Tutti Agent Skills

<p>
  <img src="./assets/icon.png" alt="Tutti" width="96" height="96" />
</p>

[English](./README.md) | 简体中文

用于 [Tutti](https://tutti.sh/) 的 skills 与插件元数据，帮助创建、转换、本地化、修复、校验并暴露可通过 CLI 调用的 Tutti workspace app package，以及构建带 agent 能力的 Tutti 应用仓库。

这个仓库同时是 Codex 插件市场、Claude Code 插件市场，以及兼容 `npx skills add` 的 skills 仓库。需要 Codex 或 Claude Code 的插件体验时，优先按插件市场安装；只需要命令行 skill 发现能力时，可以直接安装 `skills/`。

## 包含内容

- Codex 插件市场定义：`.agents/plugins/marketplace.json`
- Claude Code 插件市场定义：`.claude-plugin/marketplace.json`
- `plugins/tutti/` 下的 `tutti` 插件
- 用于直接插件发现的根插件清单：`.codex-plugin/plugin.json`
- 可直接安装的 skills：`skills/`
- 面向 `tutti.cli.json` 与 `/tutti/cli/*` app command 的 Tutti CLI surface 指引
- 从 Tutti 主仓库同步 skill 内容的辅助脚本

## 快速开始

### 添加 Codex 插件市场

命令行安装：

```bash
codex plugin marketplace add git@github.com:tutti-os/tutti-agent-skills.git
```

在 Codex App 中，打开 **Add Plugin Marketplace**，填写：

```text
git@github.com:tutti-os/tutti-agent-skills.git
```

稀疏路径保持为空。Codex 会从仓库根目录发现插件市场清单：

```text
.agents/plugins/marketplace.json
```

添加 marketplace 后，在 Codex 插件市场 UI 中安装 `tutti` 插件。

### 更新 Codex 插件市场

Codex 会在本地缓存 marketplace。GitHub 仓库更新后，如需拉取最新版本，运行：

```bash
codex plugin marketplace upgrade tutti-agent-skills
```

Codex 插件也内置了一个 `SessionStart` hook：

```text
plugins/tutti/hooks/codex-hooks.json
```

安装或启用插件后，可以打开 `/hooks`，检查并信任 Tutti hook。信任后，Codex 可以在新会话之间自动检查 marketplace 更新。默认 24 小时最多检查一次，避免每次启动都访问网络。

调整 Codex hook 检查间隔：

```bash
TUTTI_AGENT_SKILLS_CODEX_UPDATE_INTERVAL_SECONDS=0
```

关闭 Codex hook 自动更新：

```bash
TUTTI_AGENT_SKILLS_CODEX_AUTO_UPDATE=0
```

如果团队希望用 `cron`、`launchd` 或其他本地自动化来更新 Codex marketplace，也可以调用：

```bash
./scripts/upgrade-codex-marketplace.sh
```

### 添加 Claude Code 插件市场

首次安装时，必须先添加 marketplace，再安装 `tutti` 插件。

在 Claude Code 内执行：

```text
/plugin marketplace add tutti-os/tutti-agent-skills
/plugin install tutti@tutti-agent-skills
```

或使用命令行：

```bash
claude plugin marketplace add tutti-os/tutti-agent-skills
claude plugin install tutti@tutti-agent-skills
```

Claude Code 会从仓库根目录发现 marketplace 清单：

```text
.claude-plugin/marketplace.json
```

### 更新 Claude Code 插件市场

只有已经执行过 `marketplace add` 后，才能执行 `marketplace update`。如果 `claude plugin marketplace list` 里只有 `claude-plugins-official`，需要先添加这个 marketplace。

仓库更新后，刷新 Claude Code 本地 marketplace 缓存：

```bash
claude plugin marketplace update tutti-agent-skills
```

Claude Code 插件也包含一个静默的 `SessionStart` hook，路径是 `plugins/tutti/hooks/claude-hooks.json`，会在后台执行同样的 marketplace update。默认 24 小时最多执行一次。

调整 Claude Code hook 检查间隔：

```bash
TUTTI_AGENT_SKILLS_UPDATE_INTERVAL_SECONDS=0
```

关闭 Claude Code hook 自动更新：

```bash
TUTTI_AGENT_SKILLS_AUTO_UPDATE=0
```

### 直接安装 skills

安装仓库发布的所有 skills：

```bash
npx --yes skills add tutti-os/tutti-agent-skills
```

安装前查看可用 skills：

```bash
npx --yes skills add tutti-os/tutti-agent-skills --list
```

只安装 workspace app factory skill：

```bash
npx --yes skills add tutti-os/tutti-agent-skills --skill tutti-workspace-app-factory
```

只安装 agent workspace app 架构 skill：

```bash
npx --yes skills add tutti-os/tutti-agent-skills --skill tutti-agent-workspace-app
```

开发时从本地 checkout 安装：

```bash
npx --yes skills add ./skills/tutti-workspace-app-factory --skill tutti-workspace-app-factory
npx --yes skills add ./skills/tutti-agent-workspace-app --skill tutti-agent-workspace-app
```

## Skills

### `tutti-workspace-app-factory`

用于创建、转换或修复 Tutti workspace app package。生成的 package 应该是自包含的，并且可以被 Tutti custom app runtime 运行。

这个 skill 覆盖：

- `tutti.app.json` 和可选的 `tutti.cli.json` manifest
- 通过 `tutti.cli.json` 与 `/tutti/cli/*` handler 暴露可被 CLI 调用的 app 能力
- 将已有仓库转换成 `package/` 作用域内的 Tutti package
- manifest 元数据和应用内文案的 i18n harness 建议
- `bootstrap.sh` runtime 入口
- package 内部的 `AGENTS.md` 指导
- 本地 HTTP app runtime 规则
- Tutti 托管的 runtime 环境变量
- 生成 app package 的静态校验脚本和检查清单

### `tutti-agent-workspace-app`

用于构建或演进完整的、带 agent 能力的 Tutti app 仓库。当任务不是只生成一个 package 目录，而是需要可维护的应用架构时，使用这个 skill。

这个 skill 覆盖：

- `apps/web`、`apps/server` 和 `packages/shared` 的 monorepo 边界
- Tutti 应用级动态 provider catalog 与 `@tutti-os/agent-acp-kit` runtime 集成
- run-scoped MCP/tool gateway 模式
- 面向外部 agent 和其他 app 的 Tutti CLI/reference surface
- 应用自带的 `scripts/package-tutti-app.mjs` package builder
- 通过显式 `min_tutti_version` 声明实现按版本分发的 App Center 发布
- web-first debugging、i18n 约束和 package smoke validation
- 最终 package contract 回到 `tutti-workspace-app-factory` 做收口

## 仓库结构

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

仓库中有两份 skill copy，这是有意设计：

- `skills/*/` 支持从仓库根目录直接执行 `npx skills add`
- `plugins/tutti/skills/*/` 会被打包进 Claude Code 和 Codex 的 `tutti` 插件

## 同步模型

当前阶段，skill 内容的源头仍然在 Tutti 主仓库：

```text
services/tuttid/service/workspace/app_factory_reference/
services/tuttid/service/workspace/agent_workspace_app_reference/
```

这个仓库会把上述目录镜像到两个公开 skill 位置。除非这个仓库已经明确成为新的 source of truth，否则不要直接修改镜像后的 skill 内容。

从本地 Tutti 主仓库刷新当前仓库：

```bash
./scripts/pull-from-tutti-main.sh /path/to/tutti-main
```

检查当前仓库是否仍然与 Tutti 主仓库同步：

```bash
./scripts/check-tutti-main-sync.sh /path/to/tutti-main
```

## 校验

提交 PR 前建议运行：

```bash
npx --yes skills add . --list
npx --yes skills add ./skills/tutti-workspace-app-factory --list
npx --yes skills add ./skills/tutti-agent-workspace-app --list
claude plugin validate .
claude plugin validate ./plugins/tutti
codex plugin marketplace add .
```

GitHub Actions 会在 PR 和 push 到 `main` 时校验 skill discovery、plugin manifests、marketplace layout、Claude Code marketplace metadata、icon 路径、website metadata 和 skill frontmatter。

## 状态

当前仓库发布两个 Tutti skills 和一个用于 Claude Code / Codex 的 `tutti` 插件。后续可以继续在 `skills/` 和 `plugins/tutti/skills/` 下添加更多 Tutti skills，不需要改变安装流程。

## 许可证

Apache License 2.0。详见 [LICENSE](./LICENSE)。
