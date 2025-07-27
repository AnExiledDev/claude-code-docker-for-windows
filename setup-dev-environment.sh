#!/bin/bash

# Optional full development environment setup
# Run this manually after the dev container starts for complete features
# This includes MCP server installation and shell customization

echo "Setting up full development environment..."

# Add claude alias to bashrc (only if not already present)
if ! grep -q "alias claude=" ~/.bashrc; then
    echo 'alias claude="claude --model sonnet --dangerously-skip-permissions"' >> ~/.bashrc
    echo "✓ Added claude alias to ~/.bashrc"
else
    echo "✓ Claude alias already exists in ~/.bashrc"
fi

# Check if MCP servers are already installed
MCP_OUTPUT=$(claude mcp list 2>/dev/null || echo "No MCP servers configured")

if echo "$MCP_OUTPUT" | grep -q "No MCP servers configured"; then
    echo "Installing MCP servers..."
    
    claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project /app
    claude mcp add -t http context7 https://mcp.context7.com/mcp
    claude mcp add -t http deepwiki https://mcp.deepwiki.com/mcp
    claude mcp add playwright npx @playwright/mcp@latest
    
    echo "✓ Core MCP servers installed"
else
    echo "✓ MCP servers already configured"
fi

# Install API-key dependent servers if keys are present
if [ -n "$TAVILY_API_KEY" ] && [ "$TAVILY_API_KEY" != "" ]; then
    if ! echo "$MCP_OUTPUT" | grep -q "tavily-search"; then
        echo "Installing Tavily Search MCP server..."
        claude mcp add -t http tavily-search https://mcp.tavily.com/mcp/?tavilyApiKey=$TAVILY_API_KEY
        echo "✓ Tavily Search MCP server installed"
    else
        echo "✓ Tavily Search MCP server already installed"
    fi
else
    echo "⚠ TAVILY_API_KEY not set or empty - skipping Tavily Search MCP server"
fi

if [ -n "$REF_TOOLS_API_KEY" ] && [ "$REF_TOOLS_API_KEY" != "" ]; then
    if ! echo "$MCP_OUTPUT" | grep -q "ref-tools"; then
        echo "Installing Ref.Tools MCP server..."
        claude mcp add -t http ref-tools https://api.ref.tools/mcp?apiKey=$REF_TOOLS_API_KEY
        echo "✓ Ref.Tools MCP server installed"
    else
        echo "✓ Ref.Tools MCP server already installed"
    fi
else
    echo "⚠ REF_TOOLS_API_KEY not set or empty - skipping Ref.Tools MCP server"
fi

echo ""
echo "🎉 Development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc"
echo "2. Run: claude login (if not already logged in)"
echo "3. Start coding with full MCP server support!"