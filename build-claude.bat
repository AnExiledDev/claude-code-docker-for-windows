@echo off
setlocal enabledelayedexpansion

REM -- Configuration
set "ImageName=claude-cli"

REM -- Load environment variables from .env file if it exists
if exist ".env" (
    echo INFO: Loading environment variables from .env file
    for /f "usebackq tokens=1,* delims==" %%A in (".env") do (
        set "line=%%A"
        if not "!line:~0,1!"=="#" if not "!line!"=="" (
            set "%%A=%%B"
            echo Loaded: %%A=%%B
        )
    )
    echo INFO: Environment variables loaded
    echo TAVILY_API_KEY=!TAVILY_API_KEY!
    echo REF_TOOLS_API_KEY=!REF_TOOLS_API_KEY!
) else (
    echo ERROR: .env file not found. Please create one with your API keys.
    exit /b 1
)

REM -- Check if docker is available
where docker >nul 2>&1
if errorlevel 1 (
    echo ERROR: Docker is not installed or not in PATH.
    exit /b 1
)


REM -- Force rebuild to ensure fresh image with correct API keys
echo INFO: Removing existing image and rebuilding with API keys...
docker rmi %ImageName% >nul 2>&1
docker build --no-cache -t %ImageName% --build-arg TAVILY_API_KEY=!TAVILY_API_KEY! --build-arg REF_TOOLS_API_KEY=!REF_TOOLS_API_KEY! .
if errorlevel 1 (
    echo ERROR: Failed to build Docker image.
    exit /b 1
)

echo SUCCESS: Docker image built with API keys baked in.
echo You can now run 'run-claude' from any directory.

endlocal