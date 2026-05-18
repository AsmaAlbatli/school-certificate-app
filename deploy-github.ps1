# Run after: gh-login.bat  (or close and reopen PowerShell, then gh auth login)
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$env:Path = "$env:ProgramFiles\GitHub CLI;" + $env:Path
$gh = "${env:ProgramFiles}\GitHub CLI\gh.exe"
if (-not (Test-Path $gh)) { $gh = "gh" }

if (-not (Get-Command $gh -ErrorAction SilentlyContinue) -and -not (Test-Path "${env:ProgramFiles}\GitHub CLI\gh.exe")) {
  Write-Host "Install GitHub CLI first: winget install GitHub.cli"
  exit 1
}
function Invoke-Gh { & $gh @args }

Invoke-Gh auth status 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Log in first: double-click gh-login.bat"
  exit 1
}

$repoName = "school-certificate-app"
Write-Host "Creating public repo '$repoName' and pushing..."
Invoke-Gh repo create $repoName --public --source=. --remote=origin --push
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Enabling GitHub Pages..."
Invoke-Gh api "repos/{owner}/$repoName/pages" -X POST -f "build_type=legacy" -f "source[branch]=main" -f "source[path]=/" 2>$null
if ($LASTEXITCODE -ne 0) {
  Invoke-Gh repo edit --enable-pages --pages-branch main
}

Start-Sleep -Seconds 3
$url = Invoke-Gh api "repos/{owner}/$repoName/pages" --jq ".html_url" 2>$null
if ($url) {
  Write-Host ""
  Write-Host "Live site (may take 1-2 minutes):"
  Write-Host $url
} else {
  Write-Host ""
  Write-Host "Open GitHub repo Settings -> Pages -> Branch main / root"
  Invoke-Gh repo view --web
}
