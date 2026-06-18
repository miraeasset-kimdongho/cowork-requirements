# cowork-requirements

협업 도구들의 **요구사항(PRD)** 과 **이슈/변경사항**을 누적·관리하는 레포지토리입니다.
이미 개발/운영 중인 내부 협업 도구에 대해 발생하는 변경 요구를 문서로 쌓아 추적합니다.

## 📁 구조

```
cowork-requirements/
├── README.md          # 본 문서
├── MILESTONE.md       # 일정·마일스톤
├── PRD/               # 제품 요구사항 문서
│   └── _template.md
└── issue/             # 이슈/변경사항(버그·개선·UI변경·신규요청)
    └── _template.md
```

- 제품 구분은 **폴더로 나누지 않고** 각 문서 상단 메타의 `제품` 필드로 표기합니다.
- 변경 이력은 **Git/GitHub 히스토리**로 관리합니다(별도 changelog 미운영).

## 🧭 사용법

1. `_template.md`를 복사해 `PRD/` 또는 `issue/` 에 새 문서를 만든다.
2. 파일명: `PRD-{번호}_{기능명}.md`, `ISSUE-{번호}_{제목}.md` (번호는 종류별 연속 채번).
3. 문서 상단 메타의 `상태`로 진행을 추적한다.
   - PRD: `Draft` → `In Review` → `Approved` → `Done`
   - issue: `Open` → `In Progress` → `Done`
4. 큰 일정은 `MILESTONE.md`에 반영한다.
5. 각 이슈별 / 요구사항별 이력관리는 한 md 내에서 관리한다.


> PRD 작성 시 핵심 3원칙: ① 하나에 집중 · ② 안 할 것 먼저 정의 · ③ 측정 가능한 성공 기준

## 🔗 연관 레포지토리

| 대상 | 저장소 |
|------|--------|
| Mattermost 데스크탑 앱 | https://github.com/wign21dmove/mm-webapp |
| Mattermost 모바일 앱 | https://github.com/wign21dmove/mm-mobile |
| Mattermost 사이크로스(Sycross) 플러그인 | https://github.com/wign21dmove/mm-plugins-Sycros |
| Mattermost 캘린더 플러그인 | https://github.com/wign21dmove/mm-plugins-calendar |
| Jira / Confluence 커스텀 플러그인 | _링크 추가_ |
| Mattermost 파일 블로커 | https://github.com/wign21dmove/mm-plugins-file-blocker |
| Mattermost 로긴 | https://github.com/wign21dmove/mm-plugins-api |

> 필요 시 행 추가
