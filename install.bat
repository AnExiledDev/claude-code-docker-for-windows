@echo off
setlocal enabledelayedexpansion

REM -- Configuration
echo [INFO] Installing Claude CLI wrapper...

REM -- Get user home directories
set "USER_HOME=%USERPROFILE%"
set "APP_DIR=%USER_HOME%\AppData\Local\Programs\ClaudeCLI"
set "WINDOWSAPPS=%USER_HOME%\AppData\Local\Microsoft\WindowsApps"
set "BASH_BIN=%USER_HOME%\bin"

REM -- Check if run-claude.bat exists
if not exist "run-claude.bat" (
    echo ERROR: run-claude.bat not found in current directory.
    exit /b 1
)

REM -- 1. Ensure ClaudeCLI directory exists
if not exist "%APP_DIR%" (
    mkdir "%APP_DIR%"
    if errorlevel 1 (
        echo ERROR: Failed to create directory: %APP_DIR%
        exit /b 1
    )
)

REM -- 2. Copy run-claude.bat to ClaudeCLI folder
copy /Y "run-claude.bat" "%APP_DIR%\run-claude.bat" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy run-claude.bat to %APP_DIR%
    exit /b 1
)

REM -- 3. Create .bat launcher in WindowsApps
echo @echo off > "%WINDOWSAPPS%\run-claude.bat"
echo "%APP_DIR%\run-claude.bat" %%* >> "%WINDOWSAPPS%\run-claude.bat"
if errorlevel 1 (
    echo ERROR: Failed to create launcher in WindowsApps
    exit /b 1
)

REM -- 4. Setup Git Bash support
if not exist "%BASH_BIN%" (
    mkdir "%BASH_BIN%"
    if errorlevel 1 (
        echo ERROR: Failed to create bash bin directory: %BASH_BIN%
        exit /b 1
    )
)

REM -- 5. Create bash wrapper for Git Bash
(
    echo #!/bin/bash
    echo cmd //c "%APP_DIR:\=\\%\\run-claude.bat" "\$@"
) > "%BASH_BIN%\run-claude"
if errorlevel 1 (
    echo ERROR: Failed to create bash wrapper
    exit /b 1
)

REM -- 6. Make it executable (Git Bash uses chmod)
where bash >nul 2>&1
if not errorlevel 1 (
    bash -c "chmod +x \"$BASH_BIN/run-claude\""
)

REM -- 7. Final message
echo [SUCCESS] Installed successfully!
echo [INFO] You can now run 'run-claude' from:
echo      • Windows CMD / PowerShell
echo      • Git Bash (after restart or PATH refresh)

endlocal
