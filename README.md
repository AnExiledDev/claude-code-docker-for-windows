# 📦 Claude Code Docker Wrapper for Windows

A lightweight, dependency-free way to run [Claude Code CLI](https://www.anthropic.com/index/claude-code) using Docker on Windows — no need for `node`, `npm`, or global installations.

> ✅ Ideal for Windows developers who prefer **not to pollute their local environment** with NodeJS-based dependencies.

---

## 🚀 Features

- **VS Code Dev Container Integration**: Full IDE experience with containerized development environment
- **Standard Docker Support**: Run Claude CLI in any project folder using `run-claude`
- Works on **Windows 10/11** with Docker Desktop or WSL2
- CLI login and API session are **persisted across runs** via `.claude` folder
- Mounts current directory into the container for context-aware use
- **Configuration persistence**: `.claude` and `.serena` folders are created in each project directory
- Works in both **Command Prompt/PowerShell** and **Git Bash**
- Includes MCP server configuration for extended functionality
- Pre-configured `claude` command with optimized defaults
- **Developer-friendly tools**: ZSH with Oh My Zsh, fzf, vim, and more

---

## 🧱 Prerequisites

**For Standard Docker Usage:**
- [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/) installed and running
- Windows 10/11 with WSL2 enabled (recommended)
- Git Bash (optional, for bash compatibility)

**For VS Code Dev Container (Recommended):**
- [VS Code](https://code.visualstudio.com/) with [Remote-Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker Desktop](https://docs.docker.com/desktop/) installed and running

---

## 🔧 Installation

### Option 1: VS Code Dev Container (Recommended)

1. **Clone the repository**:
```cmd
git clone https://github.com/AnExiledDev/claude-code-docker.git
cd claude-code-docker
```

2. **Configure API keys** (optional):
```cmd
copy .env.example .env
# Edit .env file and add your API keys for Tavily Search and Ref.Tools
```

3. **Open in VS Code**:
```cmd
code .
```

4. **Reopen in Container**:
   - VS Code will prompt to "Reopen in Container"
   - Or use Command Palette: `Remote-Containers: Reopen in Container`

5. **First-time setup** (in VS Code terminal):
```bash
claude login
```

### Option 2: Standard Docker Usage

1. **Clone and setup**:
```cmd
git clone https://github.com/AnExiledDev/claude-code-docker.git
cd claude-code-docker
```

2. **Configure API keys** (optional, for enhanced MCP servers):
```cmd
copy .env.example .env
# Edit .env file and add your API keys for Tavily Search and Ref.Tools
```

3. **Build the Docker image**:
```cmd
build-claude.bat
```

4. **Install globally** (optional):
```cmd
install.bat
```

The install script will:
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

This wrapper includes **automatic setup** for MCP (Model Context Protocol) servers:

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

## 🔁 Rebuilding the Docker image

If you need to rebuild the image (e.g., after updating API keys or modifying the Dockerfile):

```cmd
build-claude.bat
```

This will automatically rebuild the image with your current `.env` configuration.

---

## 📁 Folder Structure

```
claude-code-docker/
├── .env.example       # Example environment file for API keys
├── .dockerignore      # Docker ignore patterns
├── .gitignore         # Git ignore patterns
├── build-claude.bat   # Docker image builder with API key integration
├── Dockerfile         # Node.js environment with Claude CLI and Python support
├── entrypoint.sh      # Container startup script with MCP auto-setup
├── install.bat        # Windows installer script
├── run-claude.bat     # Main Windows script that launches Claude CLI container
├── MCP.md            # MCP server installation reference
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
