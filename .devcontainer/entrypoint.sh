#!/bin/bash

source .devcontainer/.env

# Wait for observability stack to be ready
echo "Waiting for observability stack to be ready..."
timeout=120
while ! wget -q --spider http://otel-collector:8889/metrics 2>/dev/null; do
    sleep 2
    timeout=$((timeout-2))
    if [ $timeout -le 0 ]; then
        echo "Warning: Observability stack not ready after 2 minutes, continuing without it"
        break
    fi
done

if wget -q --spider http://otel-collector:8889/metrics 2>/dev/null; then
    echo "✅ Observability stack is ready"
    echo "📊 Grafana Dashboard: http://localhost:3000 (admin/admin)"
    echo "🔍 Prometheus: http://localhost:9090"
else
    echo "⚠️  Observability stack not accessible, Claude Code will work without telemetry"
fi

# Install MCP servers if not already configured
MCP_OUTPUT=$(claude mcp list 2>/dev/null || echo "No MCP servers configured")

if echo "$MCP_OUTPUT" | grep -q "No MCP servers configured"; then
  echo "Installing MCP servers..."
  
  claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project /workspace
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

echo "Entrypoint setup complete."
