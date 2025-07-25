# Installing MCP Servers

Use the below commands to add MCPServers to Claude Code CLI.

## Serena MCP
`claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project $(pwd)`

## Context7
`claude mcp add -t http context7 https://mcp.context7.com/mcp`

## DeepWiki
`claude mcp add -t http deepwiki https://mcp.deepwiki.com/mcp`

## Playwright
`claude mcp add playwright npx @playwright/mcp@latest`

## Tavily Search
`claude mcp add -t http tavily-search https://mcp.tavily.com/mcp/?tavilyApiKey=` (Add your API Key to the end of the string)

## Ref.Tools
`claude mcp add -t http ref-tools https://api.ref.tools/mcp?apiKey=` (Add your API Key to the end of the string)
