@echo off
cd /d "%~dp0"
echo.
echo  Deploy with Git only (no gh CLI)
echo  --------------------------------
echo  1. On https://github.com/new create a repo named: school-certificate-app
echo     (Public, do NOT add README)
echo  2. Replace YOUR_USERNAME below, then run this script again.
echo.
set /p GITHUB_USER=Your GitHub username: 
if "%GITHUB_USER%"=="" exit /b 1

git branch -M main 2>nul
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USER%/school-certificate-app.git
echo.
echo Pushing to GitHub (browser may open to sign in)...
git push -u origin main
if errorlevel 1 (
  echo Push failed. Sign in when prompted, or use a Personal Access Token as password.
  pause
  exit /b 1
)
echo.
echo Done. Enable Pages:
echo   https://github.com/%GITHUB_USER%/school-certificate-app/settings/pages
echo   Source: Deploy from branch ^| main ^| / (root)
echo   Save, then open: https://%GITHUB_USER%.github.io/school-certificate-app/content.html
echo.
pause
