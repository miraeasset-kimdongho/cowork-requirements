# ISSUE-001: 일정 '장소' 필드 추가

> **제품**: Mattermost Calendar 플러그인
> **유형**: `신규 요청`
> **작성자**: 김동호 책임
> **작성일**: 2026-06-17
> **상태**: `Open`
> **관련 PRD**: [PRD-007](../PRD/PRD-007_캘린더-기능-부가-개발.md)

---

## 1. 현상 / 요청 내용

- 일정에 **'장소' 필드**를 추가해달라.
- **로컬 캘린더 저장 시에도** 장소 정보를 포함하여 저장.

---

## 2. 기대 결과 (To-Be)

- 모바일, 데스크탑 일정 생성/편집 화면에 장소 입력 필드 노출
- 모바일, 데스크탑 일정 조회 시 장소 표시
- 로컬 저장(내보내기 포함) 시 장소 데이터 유지

---

## 3. 재현 경로 (버그일 경우)

- 해당 없음 (기능 추가)

---

## 4. 대상 화면 / 영향 범위

- 대상 화면: 캘린더 일정 생성/편집/상세, 로컬 저장
- 영향 범위: 캘린더 사용자 전체

---

## 5. Before / After (UI 변경일 경우)

**Before**
> 장소 입력 항목 없음

**After**
> 장소 입력/표시 항목 추가, 로컬 저장에도 반영

---

## 6. 구현 메모

- 일정 테이블에 이미 location 칼럼 존재

`## outlook_calendar

| 순번 | 물리명 | 논리명 | 타입 | NOT NULL |
|---:|---|---|---|:---:|
| 1 | id | ID | varchar(20) | ✅ |
| 2 | calendar_id | Outlook 일정 ID | varchar(512) | |
| 3 | user_id | 사용자 ID | varchar(255) | |2111
| 4 | subject | 일정제목 | varchar(500) | |
| 5 | body | 일정 본문설명 | text | |
| 6 | start_date | 시작일시 | timestamp | |
| 7 | end_date | 종료일시 | timestamp | |
| 8 | organizer | 주최자 이메일 | varchar(255) | |
| 9 | organizer_name | 주최자 표시 이름 | varchar(255) | |
| 10 | location | 일정 장소 | varchar(500) | |
| 11 | is_all_day | 종일일정여부 | bool | |
| 12 | is_recurring | 반복일정여부 | bool | |
| 13 | sensitivity | 공개범위민감도 | varchar(50) | |
| 14 | is_reminder_set | 알림설정여부 | bool | |
| 15 | reminder_minutes_before | 알림 시간 | int4(32,0) | |
| 16 | response_type | 참석응답상태 | varchar(50) | |
| 17 | is_cancelled | 일정 취소 여부 | bool | |
| 18 | attendees | 참석자 목록 | text | |
| 19 | created_at | 생성 일시 | timestamp | |
| 20 | updated_at | 수정 일시 | timestamp | |

---

## outlook_calendar_local_folder

| 순번 | 물리명 | 논리명 | 타입 | NOT NULL | 기본값 |
|---:|---|---|---|:---:|---|
| 1 | id | ID | varchar(20) | ✅ | |
| 2 | user_id | 사용자 아이디 | varchar(50) | ✅ | |
| 3 | provider | 계정공급자 | varchar(20) | ✅ | |
| 4 | email | 이메일주소 | varchar(255) | ✅ | |
| 5 | created_at | 생성시간 | timestamp | ✅ | |
| 6 | updated_at | 수정 일시 | timestamptz | ✅ | `now()` |

---

## outlook_calendar_reminders

| 순번 | 물리명 | 논리명 | 타입 | NOT NULL |
|---:|---|---|---|:---:|
| 1 | id | ID | varchar(20) | ✅ |
| 2 | useremail | 알림 대상 사용자 이메일 | varchar(255) | |
| 3 | itemid | 일정 관련 Outlook 일정 ID | varchar(255) | |
| 4 | subject | 일정 제목 | varchar(255) | |
| 5 | location | 일정 장소 | varchar(255) | |
| 6 | remindertime | 알림 발생 시간 | timestamp | |
| 7 | starttime | 일정 시작 시간 | timestamp | |
| 8 | endtime | 일정 종료 시각 | timestamp | |
| 9 | isalldayevent | 종일 일정 여부 | bool | |
| 10 | recurringmasteritemid | 반복 일정 마스터 ID | varchar(255) | |
| 11 | remindertype | 알림 종류 | varchar(20) | |
| 12 | status | 알림 처리 상태 | varchar(20) | |
| 13 | created_at | 생성 일시 | timestamp | |
| 14 | updated_at | 수정 일시 | timestamp | |
---

## 7. 체크리스트

- [x] 일정 생성/편집 시 장소 입력
- [x] 일정 상세에 장소 표시
- [x] 로컬 저장 시 장소 포함
