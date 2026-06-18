# Mattermost 알림 자동화

두 가지 알림을 설정한다.

1. **일정 D-2 / D-1 알림** — `MILESTONE.md`의 `(예정)` 일정 기준, 매일 오전 8시 점검 (로컬 PC)
2. **main 커밋 알림** — GitHub `main` push 시 Mattermost로 전송 (GitHub Actions)

---

## 1. 일정 알림 (로컬 / Windows 작업 스케줄러)

### 1) 설정 파일 작성
```powershell
Copy-Item scripts/mm-config.example.json scripts/mm-config.local.json
# mm-config.local.json 을 열어 baseUrl / channelId / token 입력
# (mm-config.local.json 은 .gitignore 로 커밋 제외됨)
```

- `channelId` 확인: Mattermost 웹에서 채널 진입 → 채널명 옆 ⋯ → "채널 정보 보기"에 ID 표시.
  또는 API로: `GET {baseUrl}/api/v4/teams/name/{team}/channels/name/{channel}` 의 `id`.

### 2) 수동 테스트
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/mm-notify-milestone.ps1
```

### 3) 매일 오전 8시 스케줄 등록
```powershell
$action  = New-ScheduledTaskAction -Execute 'powershell.exe' `
  -Argument '-NoProfile -ExecutionPolicy Bypass -File "D:\DEV\cowork-requirements\scripts\mm-notify-milestone.ps1"'
$trigger = New-ScheduledTaskTrigger -Daily -At 8:00am
Register-ScheduledTask -TaskName 'MM-Milestone-Reminder' -Action $action -Trigger $trigger `
  -Description 'MILESTONE (예정) 일정 D-2/D-1 알림'
```
> 해제: `Unregister-ScheduledTask -TaskName 'MM-Milestone-Reminder' -Confirm:$false`

---

## 2. main 커밋 알림 (GitHub Actions)

워크플로: `.github/workflows/notify-mattermost.yml` (PAT / REST API 방식)

- 서버 URL(`https://mattermost.dmove.co.kr`)과 채널 ID(`1upwm4rjz38oxppnjzx5bab8he`)는
  워크플로 파일에 직접 기재되어 있음(비밀 아님).

### 1) GitHub Secret 등록 (토큰만)
- GitHub repo → Settings → Secrets and variables → Actions → New repository secret
- 이름: `MATTERMOST_TOKEN` / 값: Mattermost Personal Access Token

### 2) 워크플로를 main에 반영
- push 트리거는 **main 브랜치에 있는 워크플로**로 동작하므로, 이 파일이 main에 머지되어야 발동함.
- 현재 작업 브랜치(dongho)에 커밋해두고, main 머지 시점에 활성화됨.

> 전제: GitHub 호스티드 러너 → `mattermost.dmove.co.kr`(퍼블릭)로 접근 가능. ✅ (공개 서버라 충족)

---

## 보안 메모
- Personal Access Token / Webhook URL 은 **절대 커밋 금지** (`.gitignore` 처리됨).
- 토큰 노출이 의심되면 Mattermost에서 즉시 폐기 후 재발급.
