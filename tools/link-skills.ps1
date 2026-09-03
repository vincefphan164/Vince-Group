# link-skills.ps1 — nhat skills-library/ vao Claude Code qua Junction (Windows, khong can admin)
#
# Why junction: git + Windows + symlink = bay. Junction (reparse point the dir)
# tao bang New-Item -ItemType Junction tren NTFS khong yeu quyen admin,
# va Claude Code doc xuyen qua no nhu thu muc thuong.
#
# Chay 1 lan moi may, o GOC repo:   pwsh -File tools\link-skills.ps1
# Kiem tra trang thai:              pwsh -File tools\link-skills.ps1 -Check
#
# AN TOAN: script chi dong tac .claude\skills. Khong bao gio cham
# .claude\agents, .claude\settings*.json, hay bat ky file nao khac.

[CmdletBinding()]
param(
    [switch]$Check
)

$ErrorActionPreference = 'Stop'

# Nghi o goc repo = thu muc me cua tools\
$RepoRoot = Split-Path -Parent $PSScriptRoot
$Target   = Join-Path $RepoRoot 'skills-library'          # NGUON duy nhat (khong phai vendor-skills)
$Link     = Join-Path $RepoRoot '.claude\skills'          # JUNCTION

function Get-LinkState {
    if (-not (Test-Path $Link)) { return 'missing' }
    $item = Get-Item -Force $Link
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) { return 'junction' }
    if ($item.PSIsContainer) { return 'real-dir' }   # co the la thu muc skill that -> KHONG pha
    return 'file'
}

if ($Check) {
    $state = Get-LinkState
    Write-Host "repo  : $RepoRoot"
    Write-Host "target: $Target  $(if (Test-Path $Target) {'[OK]'} else {'[MISSING — skills-library/ phai nam canh tools/]'})"
    Write-Host "link  : $Link -> $state"
    if ($state -eq 'junction') {
        $resolved = (Get-Item -Force $Link).Target
        Write-Host "junction tro toi: $resolved"
        if ("$resolved" -like '*vendor-skills*') { Write-Host 'LOI: junction dang tro vendor-skills!'; exit 1 }
        exit 0
    } elseif ($state -eq 'missing') { exit 2 } else { exit 3 }
}

if (-not (Test-Path $Target)) {
    Write-Error "Khong thay '$Target'. Chay script tu goc repo (Vince-Group\)."
}

$state = Get-LinkState
switch ($state) {
    'junction' {
        # idempotent: xoa junction cu, tao lai
        [IO.Directory]::Delete($Link)   # chi xoa reparse point, khong xoa noi dung nguon
        Write-Host "Da xoa junction cu."
    }
    'missing' {
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Link) | Out-Null
    }
    default {
        Write-Error "'.claude\skills' hien la $state that (khong phai junction) - de tay khong pha. Tu xoa/doi ten roi chay lai."
    }
}

New-Item -ItemType Junction -Path $Link -Target $Target | Out-Null
Write-Host "OK: .claude\skills => skills-library (junction). Chay '-Check' de do."
