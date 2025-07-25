@echo off
setlocal enabledelayedexpansion

REM -- Configuration
set "ImageName=claude-cli"
set "CurrentDir=%cd%"

REM -- Container commands to sync and persist Claude CLI configuration
set CONTAINER_COMMAND=^
mkdir -p /app/.claude ^&^& ^
mkdir -p /app/.serena ^&^& ^
chmod 755 /app/.claude ^&^& ^
ln -sf /app/.claude ~/.claude ^&^& ^
ln -sf /app/.serena ~/.serena ^&^& ^
echo 'alias claude=\"claude --model sonnet --dangerously-skip-permissions \"' ^>^> ~/.bashrc ^&^& ^
exec bash

REM -- Check if docker is available
where docker >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not installed or not in PATH.
    exit /b 1
)

REM -- Check if image exists
docker image inspect %ImageName% >nul 2>&1
if errorlevel 1 (
    echo INFO: Docker image '%ImageName%' not found. Building it now...
    docker build -t %ImageName% .
    if errorlevel 1 (
        echo ERROR: Failed to build Docker image.
        exit /b 1
    )
)

REM -- Run the container with volume mount
docker run --rm -it ^
    --mount type=bind,source="%cd%",target=/app ^
    -w /app ^
    -e "CLAUDE_CONFIG_DIR=.claude" ^
    %ImageName% bash -c "%CONTAINER_COMMAND%"

REM -- claude --dangerously-skip-permissions --model sonnet --strict-mcp-config(WHEN COMPLETE)

endlocal
