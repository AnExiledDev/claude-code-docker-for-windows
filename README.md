# 📦 Claude Code VS Code Dev Container

A complete VS Code development environment for [Claude Code CLI](https://www.anthropic.com/index/claude-code) with zero local setup required.

> ✅ **Zero setup** - Open in VS Code and start coding with Claude immediately in a fully isolated, reproducible development environment.

---

## 🚀 Features

- **Zero setup** - Open in VS Code and start coding immediately
- **Full IDE integration** - IntelliSense, debugging, extensions
- **Persistent configuration** - Claude login and settings preserved
- **Pre-configured tools** - ESLint, Prettier, GitLens extensions included
- **Shell integration** - Zsh with Powerlevel10k theme
- **Configuration persistence**: `.claude` and `.serena` folders are created in your project directory
- **MCP server integration** for extended functionality
- **Pre-configured `claude` command** with optimized defaults
- **API key support** for Tavily Search and Ref.Tools

---

## 🧱 Prerequisites

- [Visual Studio Code](https://code.visualstudio.com/) with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://docs.docker.com/desktop/) installed and running
- Git (for cloning the repository)

**For VS Code Dev Container (Recommended):**

- [VS Code](https://code.visualstudio.com/) with [Remote-Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://docs.docker.com/desktop/) installed and running

---

## 🔧 Installation

1. **Clone the repository**:

```bash
git clone https://github.com/AnExiledDev/claude-code-docker.git
cd claude-code-docker
```

2. **Configure API keys** (optional):

```bash
cp .env.example .env
# Edit .env file and add your API keys for Tavily Search and Ref.Tools
```

3. **Open in VS Code**:

```bash
code .
```

4. **Reopen in Container**:

   - VS Code will detect the dev container configuration
   - Click "Reopen in Container" when prompted, or
   - Use Command Palette (`Ctrl+Shift+P`) → "Dev Containers: Reopen in Container"

5. **Wait for setup to complete** - The container will automatically:
   - Build the environment with Claude CLI pre-installed
   - Install MCP servers
   - Configure shell with optimizations

---

## 🛠️ Getting Started

1. **First-time login** (after container starts):

```bash
claude login
```

2. **Start coding** - The environment is ready with:

   - Claude CLI accessible via `claude` command
   - Optimized shell aliases (`claude` uses `sonnet` model by default)
   - All MCP servers pre-configured
   - VS Code extensions ready for development

3. **Your workspace** is mounted at `/workspace` with full read/write access

> **📁 Configuration Persistence**: The `.claude` and `.serena` folders are created in your project directory, allowing project-specific configurations that persist across container restarts.

---

## 🧪 Example Usage

Open any project in VS Code, reopen in container, and start working:

```bash
# Analyze your current codebase
claude ask "What does this repo do?"

# Get contextual help
claude "Analyze this codebase and suggest improvements"

# Work with specific files
claude "Review the security of this authentication system"
```

> **⚡ Pre-configured Claude**: The `claude` command is aliased with `--dangerously-skip-permissions` and uses the `sonnet` model by default.

Claude will analyze your mounted code and answer contextually.

---

## 🔌 MCP Server Integration

This dev container includes **automatic setup** for MCP (Model Context Protocol) servers:

**Always Installed:**

- **Serena MCP**: Advanced code analysis and refactoring
- **Context7**: Up-to-date library documentation
- **DeepWiki**: GitHub repository documentation
- **Playwright**: Browser automation

**API Key Required** (configured via `.env` file):

- **Tavily Search**: Web search capabilities (requires `TAVILY_API_KEY`)
- **Ref.Tools**: Documentation search (requires `REF_TOOLS_API_KEY`)

> **✅ Automatic Setup**: MCP servers are automatically installed on first run. API-key dependent servers (Tavily Search, Ref.Tools) are only installed if the corresponding API keys are provided in the `.env` file during the Docker build process.

---

---

## 📁 Project Structure

```
claude-code-docker/
├── .devcontainer/           # VS Code Dev Container configuration
│   ├── devcontainer.json   # Container setup, extensions, settings
│   └── Dockerfile          # Development environment definition
├── .env.example            # Example environment file for API keys
├── .dockerignore           # Docker ignore patterns
├── .gitignore             # Git ignore patterns
├── entrypoint.sh          # Container startup script with MCP setup
├── init-firewall.sh       # Network security initialization
├── perms.sh               # Permission setup script
├── MCP.md                 # MCP server reference
└── README.md
```

---
