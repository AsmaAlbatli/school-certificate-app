@echo off
cd /d "%~dp0"
set "PATH=%ProgramFiles%\GitHub CLI;%PATH%"
where gh >nul 2>&1
if errorlevel 1 (
  echo GitHub CLI not found. Install with: winget install GitHub.cli
  pause
  exit /b 1
)
echo Starting GitHub login...
echo Choose: GitHub.com - HTTPS - Login with a web browser
echo.
gh auth login
echo.
gh auth status
pause
