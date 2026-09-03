# set-default-agent.ps1 — đặt agent MẶC ĐỊNH cho RIÊNG worktree này (Claude Code)
# Dùng khi DevSwarm cho chọn default agent per workspace: chạy 1 lần trong mỗi workspace Claude.
#   powershell -File tools\set-default-agent.ps1 Bum
#   powershell -File tools\set-default-agent.ps1 LU
#   powershell -File tools\set-default-agent.ps1 -Check
# Lý do cần file riêng từng worktree: .claude/settings.json là đường DUY NHẤT khai agent mặc định
# cho mọi session của project, và nó nằm trong thư mục làm việc → 2 workspace cùng repo
# phải có 2 bản khác nhau. Worktree DevSwarm là 2 thư mục khác nhau nên OK.
param(
    [Parameter(Position=0)][string]$Agent,
    [switch]$Check
)
$ErrorActionPreference = 'Stop'
$valid = @('Bum','LU')
$settingsDir = Join-Path (Get-Location) '.claude'
$settings    = Join-Path $settingsDir 'settings.json'

if ($Check -or -not $Agent) {
    if (Test-Path $settings) {
        $cur = (Get-Content $settings -Raw | ConvertFrom-Json)
        Write-Host "worktree : $(Get-Location)"
        Write-Host "agent    : $($cur.agent)"
        Write-Host "file     : $settings"
    } else {
        Write-Host "CHUA dat agent mac dinh cho worktree nay ($settings khong ton tai)."
    }
    if (-not $Agent) { exit 0 }
}

if ($Agent -notin $valid) {
    Write-Error "Agent '$Agent' khong hop le cho Claude Code. Choi: $($valid -join ', '). (Vincep/Vincep la cua OpenCode.)"
    exit 1
}
if (-not (Test-Path (Join-Path $settingsDir "agents\$Agent.md"))) {
    Write-Error "Thieu .claude/agents/$Agent.md — khong the dat lam mac dinh."
    exit 1
}

if (-not (Test-Path $settingsDir)) { New-Item -ItemType Directory -Path $settingsDir | Out-Null }

$obj = @{}
if (Test-Path $settings) {
    # giu nguyen cac khoi khac (permissions, hooks...) — chi doi moi truong 'agent'
    $obj = Get-Content $settings -Raw | ConvertFrom-Json
}
$obj | Add-Member -NotePropertyName agent -NotePropertyValue $Agent -Force

$obj | ConvertTo-Json -Depth 10 | Set-Content -Path $settings -Encoding utf8
Write-Host "OK: worktree nay mac dinh = $Agent"
Write-Host "  file: $settings"
Write-Host "  Mo workspace moi trong DevSwarm (hoac /clear) de no ap dung."
