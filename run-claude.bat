@echo off

REM -- Configuration
set "ImageName=claude-cli"

REM -- Check if docker is available
where docker >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not installed or not in PATH.
    exit /b 1
)

REM -- Check if image exists
docker image inspect %ImageName% >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker image '%ImageName%' not found.
    echo Please run 'build-claude.bat' first from the docker project directory.
    exit /b 1
)


REM -- Run the container with volume mount
docker run --rm -it ^
    --mount type=bind,source="%cd%",target=/app ^
    -e "CLAUDE_CONFIG_DIR=.claude" ^
    %ImageName% /entrypoint.sh
