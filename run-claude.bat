@echo off
setlocal enabledelayedexpansion

REM -- Config
set "ImageName=claude-cli"

REM -- Get current working directory
set "CurrentDir=%cd%"

REM -- Runs container commands to sync and persist Claude CLI configuration
set CONTAINER_COMMAND=mkdir -p /app/.claude ^&^& touch /app/.claude.json ^&^& touch /app/.claude.json.backup ^&^& chmod 755 /app/.claude ^&^& chmod 644 /app/.claude.json /app/.claude.json.backup ^&^& ln -sf /app/.claude ~/.claude ^&^& ln -sf /app/.claude.json ~/.claude.json ^&^& ln -sf /app/.claude.json.backup ~/.claude.json.backup ^&^& exec bash

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

REM -- Run the container with volume mount and forward arguments
docker run --rm -it ^
  -v "%CD%:/app" ^
  %ImageName% bash -c "%CONTAINER_COMMAND%"

endlocal
