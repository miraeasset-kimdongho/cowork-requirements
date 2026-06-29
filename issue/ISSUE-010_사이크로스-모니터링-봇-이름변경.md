# ISSUE-010: 사이크로스 모니터링 봇 이름 변경 (→ Sycros Event Monitoring)

> **제품**: Mattermost Sycros 플러그인 (mm-plugins-Sycros)
> **유형**: `개선` / `UI 변경`
> **작성자**: 김동호 책임
> **작성일**: 2026-06-29
> **상태**: `Open`
> **관련 PRD**: [PRD-005](../PRD/PRD-005_사이크로스-관리-매핑-고도화.md)

---

## 1. 현상 / 요청 내용

- 현재 사이크로스 DB 모니터링 봇의 이름(채널에 표시되는 발신자명 등)을 **싹 바꾸고 싶다.**
- 변경 후 이름: **`Sycros Event Monitoring`**
- 봇이 노출되는 **모든 지점**(표시 이름·유저네임·플러그인 메타·알림 메시지 발신자)에 일괄 적용.

---

## 2. 기대 결과 (To-Be)

- 채널/DM 알림의 **봇 표시 이름**이 `Sycros Event Monitoring` 으로 노출
- 봇 **유저네임**(@mention)도 가능한 범위에서 정합되게 변경 (예: `sycros-event-monitoring`)
- **plugin.json** 의 name/description 등 메타도 신규 명칭과 일치
- 봇 프로필/문구 등 잔여 노출부 일관 적용

---

## 3. 재현 경로 (버그일 경우)

- 해당 없음 (명칭 변경)

---

## 4. 대상 화면 / 영향 범위

- 대상: mm-plugins-Sycros 가 보내는 모니터링/이벤트 알림의 발신 봇
- 영향 범위: 사이크로스 알림 수신 채널·사용자 전체 (표시 이름만 변경, 기능 동작 동일)

---

## 5. Before / After (UI 변경일 경우)

**Before**
> 기존 사이크로스 모니터링 봇 이름

**After**
> `Sycros Event Monitoring`

---

## 6. 구현 메모

- 봇 생성/등록부(`EnsureBot` 등)에서 **Username** 과 **DisplayName** 을 구분 처리:
  - DisplayName = `Sycros Event Monitoring`
  - Username 은 소문자/공백·특수문자 제약이 있으므로 `sycros-event-monitoring` 류로 (기존 username 변경 시 기존 봇 계정/멘션 호환성 확인 필요)
- `plugin.json`(name/description), webapp 노출 문구/i18n, 알림 템플릿의 발신자명도 함께 점검.
- 단순 명칭 변경이라 기능 로직 영향 없음. 기존 봇 username 을 바꾸면 과거 멘션/링크 영향 여부만 확인.

---

## 7. 체크리스트

- [ ] 봇 DisplayName 을 `Sycros Event Monitoring` 으로 변경
- [ ] 봇 Username 정합 변경(+기존 계정/멘션 호환성 확인)
- [ ] plugin.json name/description 갱신
- [ ] webapp 노출 문구/i18n 갱신
- [ ] 알림 메시지 발신자명 확인
- [ ] 배포 후 채널 알림에서 신규 이름 노출 확인
