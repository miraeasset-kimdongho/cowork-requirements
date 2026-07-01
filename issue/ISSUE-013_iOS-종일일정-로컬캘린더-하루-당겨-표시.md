# ISSUE-013: iOS 종일 일정이 로컬 캘린더 보기에서 하루 당겨 표시

> **제품**: Mattermost Calendar (모바일, mm-mobile) — 디바이스(로컬) 캘린더 연동
> **유형**: `버그`
> **작성자**: 김동호 책임
> **작성일**: 2026-07-01
> **상태**: `Open`
> **관련 PRD**: [PRD-007](../PRD/PRD-007_캘린더-기능-부가-개발.md) (캘린더 부가/함께보기)
> **관련 이슈**: [ISSUE-009](ISSUE-009_타인-일정-내-기기-저장-버튼-노출.md) (iOS 디바이스 캘린더 연동)
>
> 📝 메모: 원인 유력. 디바이스 캘린더 경로가 종일 일정 타임존 보정을 안 함(서버/EWS 경로는 이미 처리 중).

---

## 1. 현상 / 요청 내용

- iOS **캘린더 앱**에서 **7월 16일 종일(all-day) 일정**을 생성한 뒤,
- Mattermost 캘린더의 **"내 로컬 캘린더 보기"** 로 조회하면 **7월 16일이 아니라 7월 15일**에 종일 일정이 표시됨(하루 당겨짐).
- iOS의 종일 일정 시간 표현(타임존) 처리 방식 차이로 추정.

---

## 2. 기대 결과 (To-Be)

- iOS에서 만든 7/16 종일 일정이 로컬 캘린더 보기에서도 **7/16**에 표시.
- 종일 일정은 **타임존과 무관하게 "날짜"만** 정확히 매칭.
- 여러 날(multi-day) 종일 일정도 시작/종료일이 정확히(종료일 exclusive 규칙 포함) 표시.

---

## 3. 재현 경로

1. iOS 캘린더 앱에서 **7/16 종일 일정** 생성
2. Mattermost 모바일 → 캘린더 → **내 로컬 캘린더 보기**
3. **(현상)** 해당 종일 일정이 **7/15**에 종일 블록으로 표시

- 환경: **iOS**, 기기 타임존 **KST(UTC+9)**
- 확인 필요: 시간이 있는(비종일) 일정은 정상인지 / Android 동일 재현 여부 / 음(-)·양(+) 오프셋 타임존 경계

---

## 4. 대상 화면 / 영향 범위

- 대상: 모바일 캘린더 **"내 로컬 캘린더 보기"**(디바이스 캘린더 표시 경로)
- 영향: iOS 사용자의 **종일 일정** 표시. (서버/EWS 일정 경로와 별개)

---

## 5. Before / After

**Before**
```
iOS 캘린더:  [7/16 종일] 회의
MM 로컬 보기: 7/15 ┃ [종일] 회의   ← 하루 당겨짐
```

**After**
```
iOS 캘린더:  [7/16 종일] 회의
MM 로컬 보기: 7/16 ┃ [종일] 회의   ← 날짜 일치
```

---

## 6. 구현 메모 (원인 · 수정 방향)

**원인 (유력)**
- 디바이스 캘린더 조회 경로 [`app/utils/calendar/events.ts`](../codes/mm-mobile/app/utils/calendar/events.ts) 의 `fetchEvents()` 는
  `RNCalendarEvents.fetchAllEvents()` 결과의 `event.startDate`/`event.endDate`(ISO 문자열)를 **그대로 통과**시키고 `allDay`만 매핑함(별도 타임존 보정 없음).
  ```ts
  return events.map((event: any) => ({
      startDate: event.startDate,   // ← iOS 종일: UTC(예 2026-07-15T15:00:00Z)로 올 수 있음
      endDate:   event.endDate,
      allDay:    event.allDay || false,
  }));
  ```
- iOS 종일 일정은 라이브러리가 **UTC 자정 기준**(KST 7/16 00:00 → `2026-07-15T15:00:00Z`)으로 반환할 수 있는데,
  다운스트림 렌더(날짜 셀 매핑)가 이 값을 **로컬 보정 없이** 날짜로 환산하면 **KST에서 하루 당겨짐**.

**대비 (이미 잘 된 경로)**
- 서버/EWS 경로 [`app/screens/home/calendar/api/calendar_events.ts`](../codes/mm-mobile/app/screens/home/calendar/api/calendar_events.ts) 의 `parseApiDate(dateStr, isAllDay, isEndDate)` 는
  이미 **"종일 일정은 UTC 날짜 기준으로 처리"**, **"종일 종료일은 exclusive이므로 하루 빼기"** 를 구현 → 정상.
- → **디바이스 경로에도 동일 원칙을 적용**하면 됨.

**수정 방향 (택1 + 검증)**
- ⓐ 종일 일정은 `startDate`의 **날짜 성분(Y-M-D)만** 취해 로컬 자정으로 정규화(시간/타임존 무시). ← 권장
- ⓑ `allDay === true` 인 경우 UTC 파싱하지 말고 **date-only**로 취급.
- ⓒ 렌더 단계([`hooks/use_calendar_state.ts`](../codes/mm-mobile/app/screens/home/calendar/hooks/use_calendar_state.ts) / big-calendar 매핑)에서 `allDay` 분기 추가.
- 다일 종일 일정은 **종료일 exclusive** 규칙(EWS 경로와 동일)을 맞출 것.

---

## 7. 체크리스트

- [ ] 디바이스 종일 일정 날짜를 날짜 성분 기준으로 정규화(타임존 무시)
- [ ] iOS 7/16 종일 → 로컬 보기 7/16 표시 확인
- [ ] 다일 종일 일정 시작/종료(exclusive) 정확 표시
- [ ] 비종일(시간 있는) 일정 회귀 없음 확인
- [ ] 타임존 경계(자정) 및 음/양 오프셋 테스트
- [ ] Android 동일 여부 확인 후 필요 시 동반 수정
- [ ] iOS/Android 디바이스 동작 확인
