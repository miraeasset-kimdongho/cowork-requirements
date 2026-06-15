# cowork-requirements

협업 도구(Jira DC / Confluence DC / Mattermost)의 **요구사항(PRD)** 과 **UI 수정사항**을 누적·관리하는 레포지토리입니다.
이미 개발/운영 중인 제품에 대해 발생하는 변경 요구를 문서로 쌓아 추적합니다.

## 📁 디렉터리 구조

```
cowork-requirements/
├── README.md                  # 본 문서
├── PRD/                       # 제품 요구사항 문서
│   ├── _template.md           # PRD 작성 템플릿
│   ├── JIRA-DC/
│   ├── Confluence-DC/
│   └── Mattermost/
├── UI-Changes/                # UI 수정사항 누적 목록
│   ├── _template.md           # UI 변경 템플릿
│   ├── JIRA-DC/
│   ├── Confluence-DC/
│   └── Mattermost/
├── Changelog/
│   └── CHANGELOG.md           # 버전별 변경 이력
└── .github/
    └── ISSUE_TEMPLATE/        # 이슈 기반 요청 템플릿
        ├── prd_request.md
        └── ui_change_request.md
```

## 🧭 사용 규칙

### 네이밍

| 종류 | 형식 | 예시 |
|------|------|------|
| PRD | `PRD-{3자리}_{기능명}.md` | `PRD-001_워크플로우_개선.md` |
| UI 변경 | `UI-{3자리}_{화면명}.md` | `UI-001_보드_화면_개선.md` |

- 번호는 제품 구분 없이 종류별로 **전역 연속 채번**합니다.
- 새 문서는 해당 제품 폴더(`JIRA-DC` / `Confluence-DC` / `Mattermost`) 안에 둡니다.

### 작성 흐름

1. **이슈 생성** — GitHub Issues에서 `PRD 요청` 또는 `UI 변경 요청` 템플릿으로 등록
2. **문서 작성** — `_template.md`를 복사해 해당 제품 폴더에 문서 추가
3. **상태 관리** — 문서 상단 메타의 `상태` 필드로 진행 추적
   - PRD: `Draft` → `In Review` → `Approved` → `Done`
   - UI: `Requested` → `In Progress` → `Done`
4. **이력 기록** — 의미 있는 변경은 `Changelog/CHANGELOG.md`에 반영

### 브랜치 / PR (권장)

- `main` 직접 push 대신 `feat/PRD-00X-...`, `feat/UI-00X-...` 브랜치 → PR 리뷰 후 merge
- PR 본문에 관련 이슈/문서 링크 명시

## 🏷️ 제품 구분

| 폴더 | 제품 |
|------|------|
| `JIRA-DC` | Jira Data Center |
| `Confluence-DC` | Confluence Data Center |
| `Mattermost` | Mattermost |
