# 📦 Claude Code Docker Wrapper for Windows

A lightweight, dependency-free way to run [Claude Code CLI](https://www.anthropic.com/index/claude-code) using Docker on Windows — no need for `node`, `npm`, or global installations.

> ✅ Ideal for Windows developers who prefer **not to pollute their local environment** with NodeJS-based dependencies.

---

## 🚀 Features

- Run Claude CLI in **any project folder** using `run-claude`
- Works on **Windows 10/11** with Docker Desktop or WSL2
- CLI login and API session are **persisted across runs** via `.claude` folder
- Mounts current directory into the container for context-aware use
- **Configuration persistence**: `.claude` and `.serena` folders are created in each project directory
- Works in both **Command Prompt/PowerShell** and **Git Bash**
- Includes MCP server configuration for extended functionality
- Pre-configured `claude` command with optimized defaults

---

## 🧱 Prerequisites

- [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/) installed and running
- Windows 10/11 with WSL2 enabled (recommended)
- Git Bash (optional, for bash compatibility)

---

## 🔧 Installation

```cmd
git clone https://github.com/AnExiledDev/claude-code-docker.git
cd claude-code-docker
install.bat
```

This will:
- Install `run-claude.bat` to your local programs directory
- Create a launcher in WindowsApps for global access
- Set up Git Bash compatibility (if available)

---

## 🛠️ First-time setup

After installation, navigate to any project folder:

```cmd
cd C:\path\to\your\project
run-claude
```

Inside the container, log in to Claude:

```bash
claude login
```

Your login will be stored locally in the `.claude` folder within the current project directory and reused for future sessions.

> **📁 Local Configuration**: The wrapper creates `.claude` and `.serena` folders in each project directory where you run `run-claude`. This allows project-specific configurations and ensures persistence across container restarts.

---

## 🧪 Example usage

From any project folder:

```cmd
run-claude
```

The container will start with an interactive bash shell. You can then use:

```bash
claude ask "What does this repo do?"
claude "Analyze this codebase"
```

> **⚡ Pre-configured Claude**: The `claude` command is aliased with `--dangerously-skip-permissions` and enforces the `sonnet-4` model by default. A future version will include a configuration file for customizing these defaults.

Claude will analyze your mounted code and answer contextually.

---

## 🔌 MCP Server Integration

This wrapper includes support for MCP (Model Context Protocol) servers. See `MCP.md` for available servers:

- **Serena MCP**: Advanced code analysis and refactoring
- **Context7**: Up-to-date library documentation  
- **DeepWiki**: GitHub repository documentation
- **Playwright**: Browser automation
- **Tavily Search**: Web search capabilities
- **Ref.Tools**: Documentation search

> **⚠️ Current Limitation**: MCP server commands from `MCP.md` must be run inside the container **once per new project directory**. Each time you use `run-claude` in a different directory, you'll need to re-run the MCP setup commands. This will be automated in a future update.

---

## 🔁 Rebuilding the Docker image

If you need to rebuild the image (e.g., after modifying the Dockerfile):

```cmd
docker build -t claude-cli .
```

---

## 📁 Folder Structure

```
claude-code-docker/
├── Dockerfile         # Node.js environment with Claude CLI and Python support
├── install.bat        # Windows installer script
├── run-claude.bat     # Main Windows script that launches Claude CLI container
├── MCP.md            # MCP server installation commands
└── README.md
```

---

## 🧹 Uninstall (optional)

To remove everything:

```cmd
rmdir /s "%USERPROFILE%\AppData\Local\Programs\ClaudeCLI"
del "%USERPROFILE%\AppData\Local\Microsoft\WindowsApps\run-claude.bat"
rmdir /s "%USERPROFILE%\bin"
docker rmi claude-cli
```
