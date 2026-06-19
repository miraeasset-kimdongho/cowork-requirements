# 🗓️ 마일스톤 / 일정

> 요구사항(PRD)·이슈의 큰 일정을 한눈에 본다. 세부 추적은 GitHub Issues / PR 사용.

## 진행 현황

| 마일스톤 | 목표 | 기간 | 상태 | 관련 PRD/이슈 |
|----------|------|------|------|----------------|
| M1 | Setup and Hotfix | 2026-06-17~2026-06-26 | 🔄 In Progress | ISSUE-002 · 🔴신규 critical 3종(api·Sycros·file-blocker) |
| M2 | 요구사항 중 단기간 내 구현 가능 항목| 2026-06-29~2026-07-10 | ⏳ 예정 | ISSUE-001·004·005·006·007·008·009 |
| M3 | 요구사항 core 항목 I | 2026-07-13~2026-07-31| ⏳ 예정 | PRD-004·007·008 |
| M4 | 요구사항 core 항목 II | 2026-08-03~2026-08-14| ⏳ 예정 | PRD-001·002·003·005·006 |
| M5 | detail fix and stablize | 2026-08-03~2026-08-14| ⏳ 예정 | 잔여 fix·안정화 |

> 상태: `✅ Done` / `🔄 In Progress` / `⏳ 예정` / `⏸️ Hold`

---

## 📊 진행상황 요약 (PRD·이슈 통합)

> 2026-06-19 기준. 작업량(S/M/L/XL)·제안 마일스톤은 `review.md`(codes/ 6개 레포 정적분석) 근거. 상태는 각 문서 메타 기준.

| 구분 | ID | 제목 | 작업량 | 상태 | 제안 M |
|---|---|---|:---:|---|---|
| 이슈 | ISSUE-002 | '오늘로 이동' 버튼 (모바일) | S | 🟡 Open | **M1** |
| 이슈 | ISSUE-001 | 일정 '장소' 필드 (모바일) | S | 🟡 Open | M1~M2 |
| 이슈 | ISSUE-008 | 함께보기 토스트 문구/레이아웃 | S | 🟡 Open | M1~M2 |
| 이슈 | ISSUE-004 | 일정 알림 DM 누락 (버그) | L | 🟡 Open | M2 |
| 이슈 | ISSUE-005 | 캘린더봇 'message deleted' 문구 교체 | M | 🟡 Open | M2 |
| 이슈 | ISSUE-006 | FCM 푸시 조용한 실패 (버그) | L | 🟡 Open | M2 |
| 이슈 | ISSUE-007 | 안드로이드 보안키패드 검은화면 (버그) | M | 🟡 Open | M2 |
| 이슈 | ISSUE-009 | 타인 일정 '내 기기 저장' 버튼 노출 | M | 🟡 Open | M2 |
| PRD | PRD-008 | 웹뷰 칸반 스크롤 잠금 (View 모드) | M | ⚪ Draft | M3 |
| PRD | PRD-004 | 캘린더 Day/Month View 간편화 | L | ⚪ Draft | M3 |
| PRD | PRD-007 | 캘린더 부가(장소/함께보기/그루핑) | L | ⚪ Draft | M3 |
| PRD | PRD-002 | 파일 DRM 통합 뷰어 | L | ⚪ Draft | M3~M4 |
| PRD | PRD-003 | 모바일 접근성(Jira/Confluence 웹뷰) | L | ⚪ Draft | M3~M4 |
| PRD | PRD-006 | 유동적 사용자 관리 (Admin) | L | ⚪ Draft | M4 |
| PRD | PRD-005 | 사이크로스 관리/매핑 고도화 | XL | ⚪ Draft | M4 |
| PRD | PRD-001 | 마이스퀘어 회의실 예약 연계 | L | ⚪ Draft | M4* |
| 이슈 | ISSUE-003 | 월 달력 이동/원거리 일정 등록 | L | ⏸️ Hold | 보류 |

> `*` PRD-001은 마이스퀘어 자원예약 API 스펙 확보가 선결(미확보 시 블로킹·effort L→XL 가능).
> **합계**: PRD 8건(전부 Draft) · 이슈 9건(🟡 Open 8 / ⏸️ Hold 1)

### 🔴 분석 중 신규 발견 — 미등록 / M1 핫픽스 권고

> `review.md` §4 잠재버그(확정 45건) 중 즉시 조치 대상. **별도 이슈 등재 필요.**

- **mm-plugins-api** — 인증 토큰 위조(비밀키 없음)·SSRF·SMS 폭탄·TLS 검증 off(MITM)·**DB 비번/관리자 토큰 평문 하드코딩** (critical + high 다수)
- **mm-plugins-Sycros** — 최초 활성화 시 알림 DM 폴링 전면 미작동 (critical)
- **mm-plugins-file-blocker** — 서버 자신의 네트워크를 측정 → 외부망 업로드 차단 무력화 (critical)

---

## 일정 타임라인
- (예정) 6월 22일 앱 배포
- (완료) 6우221ㅁㅁㄱ
- (예정) 6월 19일 킥 오프 미팅
- 6월 16일 rax, dale 님 투입