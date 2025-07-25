@echo off
setlocal enabledelayedexpansion

REM -- Configuration
set "ImageName=claude-cli"
set "CurrentDir=%cd%"

REM -- Container commands to sync and persist Claude CLI configuration
set CONTAINER_COMMAND=^
mkdir -p /app ^&^& ^
chown claude:claude /app ^&^& ^
mkdir -p /app/.claude ^&^& ^
chmod 755 /app/.claude ^&^& ^
ln -sf /app/.claude ~/.claude ^&^& ^
ln -sf /app/.claude/root/.claude.json ~/.claude.json ^&^& ^
ln -sf /app/.claude/root/.claude.json.backup ~/.claude.json.backup ^&^& ^
echo 'alias claude=\"claude --model sonnet --dangerously-skip-permissions \"' ^>^> ~/.bashrc ^&^& ^
exec bash

REM -- Check if docker is available
where docker >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not installed or not in PATH.
    exit /b 1
)

REM -- Check if image exists
docker image inspect %ImageName% >nul 2>&1
if errorlevel 1 (
    echo 🐳 Docker image '%ImageName%' not found. Building it now...
    docker build -t %ImageName% .
    if errorlevel 1 (
        echo ❌ Failed to build Docker image.
        exit /b 1
    )
)

REM -- Run the container with volume mount
docker run --rm -it ^
    -v "%CD%:/app" ^
    -e "CLAUDE_CONFIG_DIR=.claude" ^
    %ImageName% bash -c "%CONTAINER_COMMAND%"

REM -- claude --dangerously-skip-permissions --model sonnet --strict-mcp-config(WHEN COMPLETE)

endlocal
