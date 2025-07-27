# Claude Code Development Container

This development container provides a complete Claude Code CLI environment with VS Code integration.

## Features

- **Claude Code CLI**: Pre-installed and ready to use
- **Development Tools**: Node.js 20, Python 3.11, Git, ZSH, and more
- **VS Code Integration**: Optimized extensions and settings
- **MCP Servers**: Pre-configured Serena, DeepWiki, Playwright, and optional Tavily/Ref.Tools
- **Persistent Configuration**: `.claude` and `.serena` folders mounted from host

## Getting Started

1. **Prerequisites**:
   - VS Code with Remote-Containers extension
   - Docker Desktop

2. **Open in Dev Container**:
   - Open this folder in VS Code
   - Click "Reopen in Container" when prompted
   - Or use Command Palette: `Remote-Containers: Reopen in Container`

3. **First-time Setup**:
   ```bash
   claude login
   ```

4. **Start Developing**:
   ```bash
   claude ask "What does this project do?"
   claude "Help me implement a new feature"
   ```

## API Keys (Optional)

For enhanced MCP server functionality, configure API keys:

1. Create `.env` file with:
   ```
   TAVILY_API_KEY=your_tavily_key
   REF_TOOLS_API_KEY=your_ref_tools_key
   ```

2. Rebuild the dev container

## Included Tools

- **Claude Code CLI**: AI-powered development assistant
- **MCP Servers**: Serena (code analysis), DeepWiki, Playwright, Tavily Search, Ref.Tools
- **Development**: Node.js, Python, Git, ZSH with Oh My Zsh
- **Editors**: Vim, Nano
- **Utilities**: curl, wget, fzf

## VS Code Extensions

Pre-configured extensions for optimal development experience:
- Python development tools
- TypeScript/JavaScript support
- Docker support
- GitHub Copilot integration
- Code formatting and linting

## Troubleshooting

If you encounter issues:
1. Rebuild the container: `Remote-Containers: Rebuild Container`
2. Check Docker Desktop is running
3. Verify API keys in `.env` file (if using optional features)