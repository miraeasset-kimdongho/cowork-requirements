<#
  MILESTONE.md의 "(예정)" 일정을 읽어, 오늘이 일정일의 D-2 또는 D-1이면
  Mattermost 채널에 "미래에셋증권 내부 협업툴 업그레이드" 알림을 전송한다.

  - 매일 오전 8시 Windows 작업 스케줄러로 1회 실행하는 것을 전제로 함.
  - 설정(서버 URL/채널/토큰)은 scripts/mm-config.local.json 에서 읽음(커밋 제외).
  - 날짜 형식: "M월 D일" (연도 미표기 → 올해 기준). 예: "(예정) 6월 22일 앱 배포"
#>

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot          # repo 루트
$configPath = Join-Path $PSScriptRoot 'mm-config.local.json'
$milestonePath = Join-Path $root 'MILESTONE.md'

if (-not (Test-Path $configPath)) {
  Write-Error "설정 파일이 없습니다: $configPath  (mm-config.example.json을 복사해 채우세요)"
  exit 1
}
$cfg = Get-Content $configPath -Raw -Encoding UTF8 | ConvertFrom-Json
$headline = if ($cfg.headline) { $cfg.headline } else { '미래에셋증권 내부 협업툴 업그레이드' }

# 오늘 날짜(자정 기준)
$today = (Get-Date).Date

# MILESTONE.md에서 "(예정)" + "M월 D일" 패턴 추출
$lines = Get-Content $milestonePath -Encoding UTF8
$hits = @()
foreach ($line in $lines) {
  if ($line -notmatch '\(예정\)') { continue }
  if ($line -match '(\d{1,2})\s*월\s*(\d{1,2})\s*일') {
    $month = [int]$Matches[1]
    $day   = [int]$Matches[2]
    $year  = $today.Year
    try { $eventDate = Get-Date -Year $year -Month $month -Day $day -Hour 0 -Minute 0 -Second 0 } catch { continue }
    # 이미 지난 월이면 내년 일정으로 간주(연말연초 경계 보정)
    if ($eventDate -lt $today.AddDays(-30)) { $eventDate = $eventDate.AddYears(1) }

    $daysLeft = ($eventDate - $today).Days
    if ($daysLeft -eq 2 -or $daysLeft -eq 1) {
      # 일정 설명 텍스트 정리: 불릿/괄호표시 제거
      $desc = ($line -replace '^\s*[-*]\s*', '' -replace '\(예정\)', '').Trim()
      $hits += [pscustomobject]@{ Date = $eventDate; DaysLeft = $daysLeft; Desc = $desc }
    }
  }
}

if ($hits.Count -eq 0) {
  Write-Host "오늘($($today.ToString('yyyy-MM-dd'))) D-2/D-1에 해당하는 (예정) 일정 없음. 종료."
  exit 0
}

# 메시지 구성
$body = [System.Text.StringBuilder]::new()
[void]$body.AppendLine("📢 **$headline**")
foreach ($h in ($hits | Sort-Object Date)) {
  [void]$body.AppendLine("- (D-$($h.DaysLeft)) $($h.Desc) — $($h.Date.ToString('yyyy-MM-dd'))")
}
$message = $body.ToString().TrimEnd()

# Mattermost REST API로 전송
$uri = "$($cfg.baseUrl.TrimEnd('/'))/api/v4/posts"
$headers = @{ Authorization = "Bearer $($cfg.token)"; 'Content-Type' = 'application/json; charset=utf-8' }
$payload = @{ channel_id = $cfg.channelId; message = $message } | ConvertTo-Json -Compress
# PowerShell 5.1의 Invoke-RestMethod는 문자열 본문을 UTF-8로 보내지 않으므로 직접 바이트로 변환
$payloadBytes = [System.Text.Encoding]::UTF8.GetBytes($payload)

try {
  Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $payloadBytes | Out-Null
  Write-Host "전송 완료: $($hits.Count)건"
  Write-Host $message
} catch {
  Write-Error "Mattermost 전송 실패: $($_.Exception.Message)"
  exit 1
}
