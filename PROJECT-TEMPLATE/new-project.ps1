# new-project.ps1 — dung project moi tu PROJECT-TEMPLATE, chay 1 LAN khi tao project
# Nguon duy nhat cho 4 file agent la Vince-Group/.claude + .opencode — script nay COPY TUOI
# tai thoi diem tao, khong co ban tinh nam san trong PROJECT-TEMPLATE (tranh 2 ban lech nhau).
#   pwsh -File PROJECT-TEMPLATE\new-project.ps1 -TargetPath "C:\Users\Windows\DevSwarmProjects\Project-B" -Name "Project B"
param(
    [Parameter(Mandatory=$true)][string]$TargetPath,
    [Parameter(Mandatory=$true)][string]$Name
)
$ErrorActionPreference = 'Stop'
$vinceGroup = Split-Path -Parent $PSScriptRoot   # thu muc chua PROJECT-TEMPLATE = goc Vince-Group
$template   = $PSScriptRoot

if (-not (Test-Path $TargetPath)) {
    Write-Error "TargetPath '$TargetPath' chua ton tai. Tao + git init repo do truoc, roi chay lai script nay."
    exit 1
}
if (-not (Test-Path (Join-Path $TargetPath '.git'))) {
    Write-Error "TargetPath '$TargetPath' chua phai git repo. git init truoc."
    exit 1
}

# 1) Scaffold rieng cua project, doc tu templates/*.template (KHONG trung ten voi file that
#    o goc Vince-Group, tranh agent doc nham ban mau la luat/bo nho that)
Copy-Item (Join-Path $template 'templates\CLAUDE.md.template')          (Join-Path $TargetPath 'CLAUDE.md') -Force
Copy-Item (Join-Path $template 'templates\opencode.json.template')      (Join-Path $TargetPath 'opencode.json') -Force
New-Item -ItemType Directory -Force -Path (Join-Path $TargetPath 'obsidian') | Out-Null
Copy-Item (Join-Path $template 'templates\obsidian-index.md.template')  (Join-Path $TargetPath 'obsidian\index.md') -Force
Copy-Item (Join-Path $template 'templates\obsidian-log.md.template')    (Join-Path $TargetPath 'obsidian\log.md') -Force
Copy-Item (Join-Path $template 'templates\obsidian-bai-hoc.md.template') (Join-Path $TargetPath 'obsidian\BAI-HOC.md') -Force

# 2) Dien <PROJECT_NAME> (placeholder co tinh ASCII - dat ten co dau tieng Viet lam
# literal trong chinh file .ps1 nay khong an toan: Windows PowerShell 5.1 doc file
# .ps1 KHONG CO BOM bang codepage he thong, khong phai UTF-8, nen literal co dau trong
# script se bi doc sai va -replace se khong khop du file .template doc dung UTF-8)
# QUAN TRONG: Get-Content/Set-Content mac dinh cung doc/ghi SAI encoding voi file UTF-8
# khong BOM - phai dung System.IO.File truc tiep de doc/ghi dung UTF-8.
$today = Get-Date -Format 'yyyy-MM-dd'
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
foreach ($f in @('CLAUDE.md', 'obsidian\index.md', 'obsidian\log.md', 'obsidian\BAI-HOC.md')) {
    $p = Join-Path $TargetPath $f
    $content = [System.IO.File]::ReadAllText($p, [System.Text.Encoding]::UTF8)
    $content = $content -replace '<PROJECT_NAME>', $Name -replace '<YYYY-MM-DD>', $today
    [System.IO.File]::WriteAllText($p, $content, $utf8NoBom)
}

# 3) COPY TUOI 4 file agent tu nguon duy nhat (Vince-Group), khong lay ban cu trong template
New-Item -ItemType Directory -Force -Path (Join-Path $TargetPath '.claude\agents') | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $TargetPath '.opencode\agents') | Out-Null
Copy-Item (Join-Path $vinceGroup '.claude\agents\Bum.md') (Join-Path $TargetPath '.claude\agents\Bum.md') -Force
Copy-Item (Join-Path $vinceGroup '.claude\agents\LU.md')  (Join-Path $TargetPath '.claude\agents\LU.md') -Force
Copy-Item (Join-Path $vinceGroup '.opencode\agents\Vincep.md') (Join-Path $TargetPath '.opencode\agents\Vincep.md') -Force
Copy-Item (Join-Path $vinceGroup '.opencode\agents\Vincef.md') (Join-Path $TargetPath '.opencode\agents\Vincef.md') -Force

# 4) Session CHINH (Primary Workspace) cua project moi = LU DIEU PHOI mac dinh, khong ai go tay.
# LU dieu phoi doc Plan/GIAO-VIEC moi nhat roi TU DONG (khong hoi lai) tao du 4 workspace
# con: agent/vincep, agent/vincef, agent/bum, VA agent/lu (LU PIPELINE - khac LU dieu phoi,
# lam vai test+push gate cho slice). Chi session dung o dung repo do moi hivecontrol
# workspace create duoc cho repo do - xem README.md muc 4-5, CLAUDE.md Vince-Group muc 4.
'{"agent":"LU"}' | Out-File -FilePath (Join-Path $TargetPath '.claude\settings.json') -Encoding utf8 -NoNewline

# 5) Junction .claude/skills -> skills-library CUA VINCE-GROUP (nguon duy nhat, khong copy).
# Day la thu Bum/LU (Claude Code) doc de co skill - khong co junction nay thi 2 dua do
# khong thay skill nao het, chi Vincep/Vincef (OpenCode, qua opencode.json skills.paths)
# moi co. Junction NTFS tro duoc toi repo khac bang duong dan tuyet doi, khong can admin.
$skillsLink = Join-Path $TargetPath '.claude\skills'
if (Test-Path $skillsLink) {
    $item = Get-Item -Force $skillsLink
    if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        [IO.Directory]::Delete($skillsLink)
    } else {
        Write-Warning "'$skillsLink' da ton tai va KHONG phai junction - khong dong, tu kiem tra tay."
    }
}
if (-not (Test-Path $skillsLink)) {
    New-Item -ItemType Junction -Path $skillsLink -Target (Join-Path $vinceGroup 'skills-library') | Out-Null
}

$gitignorePath = Join-Path $TargetPath '.gitignore'
if (Test-Path $gitignorePath) {
    $gi = [System.IO.File]::ReadAllText($gitignorePath, [System.Text.Encoding]::UTF8)
    if ($gi -notmatch [regex]::Escape('.claude/settings.json')) {
        $gi = $gi.TrimEnd() + "`n`n# agent mac dinh per-worktree - khong commit`n.claude/settings.json`n# junction cross-repo - khong commit`n.claude/skills`n"
        [System.IO.File]::WriteAllText($gitignorePath, $gi, $utf8NoBom)
    }
}

Write-Host "OK: da dung project '$Name' tai $TargetPath"
Write-Host "  Session chinh (Primary Workspace) khi mo project nay trong DevSwarm = LU dieu phoi mac dinh."
Write-Host "  LU doc Plan/GIAO-VIEC moi nhat, TU DONG tao 4 workspace con (vincep/vincef/bum/lu) - khong hoi lai."
Write-Host "  Skill: da junction .claude/skills -> skills-library cua Vince-Group (Bum/LU dung duoc); opencode.json da tro san cho Vincep/Vincef."
Write-Host "  Con thieu: dien <dien> con lai trong CLAUDE.md (muc tieu, rang buoc rieng)"
Write-Host "  Neu agent file o Vince-Group doi sau nay, chay lai script nay de dong bo (Force ghi de)."
