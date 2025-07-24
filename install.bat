@echo off
setlocal

echo [🛠] Installing Claude CLI wrapper...

REM Get user home
set "USER_HOME=%USERPROFILE%"
set "APP_DIR=%USER_HOME%\AppData\Local\Programs\ClaudeCLI"
set "WINDOWSAPPS=%USER_HOME%\AppData\Local\Microsoft\WindowsApps"
set "BASH_BIN=%USER_HOME%\bin"

REM 1. Ensure ClaudeCLI directory exists
if not exist "%APP_DIR%" (
    mkdir "%APP_DIR%"
)

REM 2. Copy run-claude.bat to ClaudeCLI folder
copy /Y "run-claude.bat" "%APP_DIR%\run-claude.bat" >nul

REM 3. Create .bat launcher in WindowsApps
echo @echo off > "%WINDOWSAPPS%\run-claude.bat"
echo "%APP_DIR%\run-claude.bat" %%* >> "%WINDOWSAPPS%\run-claude.bat"

REM 4. Setup Git Bash support
if not exist "%BASH_BIN%" (
    mkdir "%BASH_BIN%"
)

REM 5. Create bash wrapper for Git Bash
(
    echo #!/bin/bash
    echo cmd //c "%APP_DIR:\=\\%\\run-claude.bat" "\$@"
) > "%BASH_BIN%\run-claude"

REM 6. Make it executable (Git Bash uses chmod)
bash -c "chmod +x \"$BASH_BIN/run-claude\""

REM 7. Final message
echo [✅] Installed successfully!
echo [ℹ] You can now run 'run-claude' from:
echo      • Windows CMD / PowerShell
echo      • Git Bash (after restart or PATH refresh)

endlocal
