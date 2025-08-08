param(
  [Parameter(Mandatory=$true)][string]$Owner,
  [Parameter(Mandatory=$true)][string]$Repo,
  [Parameter(Mandatory=$false)][ValidateSet("public","private")]$Visibility = "public"
)

$ErrorActionPreference = "Stop"

function Require-Command($cmd) {
  if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
    Write-Error "Required command '$cmd' not found. Install from https://cli.github.com/ and https://git-scm.com/"
    exit 1
  }
}

Require-Command git
Require-Command gh

if (!(Test-Path -Path ".\package.json") -or !(Test-Path -Path ".\next.config.js")) {
  Write-Error "Run this from your project root (where package.json & next.config.js live)."
  exit 1
}

$DefaultBranch = "main"

Write-Host ">> Initializing local git repo"
git init | Out-Null
git add .
git commit -m "chore: initial commit" | Out-Null
git branch -M $DefaultBranch

Write-Host ">> Creating GitHub repo $Owner/$Repo ($Visibility) and pushing $DefaultBranch"
gh repo create "$Owner/$Repo" --source=. --remote=origin --$Visibility --push

Write-Host ">> Creating a CI PR branch and committing a small change"
git checkout -b "chore/enable-ci"

if (Test-Path .\README.md) {
  $badge = "`n`n![CI](https://github.com/$Owner/$Repo/actions/workflows/ci.yml/badge.svg)`n"
  $readmeContent = Get-Content .\README.md -Raw
  if ($readmeContent -notmatch [regex]::Escape("github.com/$Owner/$Repo/actions")) {
    Add-Content -Path .\README.md -Value $badge
    git add README.md
    git commit -m "docs: add CI badge" | Out-Null
  }
}

git push -u origin "chore/enable-ci"

Write-Host ">> Opening PR"
gh pr create --title "Enable CI & repo config" --body "Adds CI badge to README and opens initial PR to activate checks." --base $DefaultBranch

Write-Host ">> Setting basic branch protection on '$DefaultBranch' (requires admin perms)"
gh api -X PUT "repos/$Owner/$Repo/branches/$DefaultBranch/protection" `
  -H "Accept: application/vnd.github+json" `
  -F required_pull_request_reviews.dismiss_stale_reviews=true `
  -F required_pull_request_reviews.required_approving_review_count=1 `
  -F enforce_admins=true `
  -F restrictions= `
  -F required_linear_history=true `
  -F allow_deletions=false `
  -F allow_force_pushes=false `
  -F block_creations=false `
  -F required_conversation_resolution=true `
  -F lock_branch=false `
  -F required_status_checks.strict=true `
  -F required_status_checks.contexts[]="build-test"

Write-Host ">> Done."
