#!/bin/bash

# Create directories and set permissions
mkdir -p /app/.claude
mkdir -p /app/.serena
chmod 755 /app/.claude

# Create symlinks for persistent configuration
ln -sf /app/.claude ~/.claude
ln -sf /app/.serena ~/.serena

# Add claude alias to bashrc
echo 'alias claude="claude --model sonnet --dangerously-skip-permissions"' >> ~/.bashrc

# Install MCP servers if not already configured
MCP_OUTPUT=$(claude mcp list 2>/dev/null || echo "No MCP servers configured")

if echo "$MCP_OUTPUT" | grep -q "No MCP servers configured"; then
  echo "Installing MCP servers..."
  
  claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project /app
  claude mcp add -t http context7 https://mcp.context7.com/mcp
  claude mcp add -t http deepwiki https://mcp.deepwiki.com/mcp
  claude mcp add playwright npx @playwright/mcp@latest
  
  echo "MCP servers installed successfully."
fi

# Always check and install API-key dependent servers if keys are present
if [ ! -z "$TAVILY_API_KEY" ]; then
  if ! echo "$MCP_OUTPUT" | grep -q "tavily-search"; then
    echo "Installing Tavily Search MCP server..."
    claude mcp add -t http tavily-search https://mcp.tavily.com/mcp/?tavilyApiKey=$TAVILY_API_KEY
  fi
fi

if [ ! -z "$REF_TOOLS_API_KEY" ]; then
  if ! echo "$MCP_OUTPUT" | grep -q "ref-tools"; then
    echo "Installing Ref.Tools MCP server..."
    claude mcp add -t http ref-tools https://api.ref.tools/mcp?apiKey=$REF_TOOLS_API_KEY
  fi
fi

# Start bash
exec bash
