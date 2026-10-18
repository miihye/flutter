# CONTEXT_PACKET.md — 5주차 작업 컨텍스트 패킷

- 학생 정보: 컴퓨터소프트웨어학과 / 2025136004 / 장미혜
- 대상 기능: Task 완료/취소 토글 및 달성률/완료 개수 실시간 계산 기능

## 1. 목표 및 상태 소유권 (State Ownership)
- 목표: 사용자의 체크박스 클릭 한 번으로 작업 완료/취소 토글 및 상단 통계(완료 개수, 달성률)가 동기화되는 Flutter 앱 구현.
- 상태 소유자: _TaskContextScreenState (StatefulWidget 내부에서 단일 원본 상태 소유).

## 2. 상태 계약 및 흐름도

### (1) 원본 상태 vs 계산값 구분
- 원본 상태 (Source of Truth): List<TaskItem> _tasks의 각 TaskItem.isDone (boolean 값).
- 계산값 (Derived Value): completedCount (_tasks.where((t) => t.isDone).length), 달성률 ((completedCount / total) * 100).
- AC4 충족: 계산 가능한 완료 개수 및 달성률을 별도의 원본 변수로 저장하지 않고 getter로 즉시 계산함.

### (2) 이벤트 ➔ 상태 ➔ UI 흐름도
- [사용자 행동] Checkbox 클릭 
- ➔ [이벤트 발생] _toggleTask(index) 호출
- ➔ [상태 변경] setState() 내에서 task.isDone = !task.isDone 반전
- ➔ [계산값 갱신] completedCount getter 자동 계산
- ➔ [UI 리렌더링] Checkbox, 취소선, 상단 Card 현황 즉시 반영

## 3. 프로젝트 컨텍스트 지도
- my_first_app/
  - lib/
    - week04/
    - week05/
      - main.dart (TaskScreen 및 상태 관리)
  - evidence/
    - 5주차_ac1_initial.PNG (초기 상태 화면)
    - 5주차_ac2_toggle.PNG (입력 후 상태 반영 화면)
    - 5주차_ac3_revert.PNG (역동작 원복 화면)
    - 5주차_analyze.PNG (flutter analyze 결과)
  - CONTEXT_PACKET.md (본 문서)
  - PROMPT_COMPARISON.md (A/B 프롬프트 비교 문서)

## 4. 제약 사항 및 인수 조건(AC) 검증

| 인수 조건 | 검증 내용 및 방법 | 검증 결과 |
| :--- | :--- | :--- |
| AC1 | 앱 실행 시 초기 목록과 0개 완료 현황 일치 확인 | ✅ 통과 |
| AC2 | 항목 클릭 시 체크박스 및 완료 개수 변경 확인 | ✅ 통과 |
| AC3 | 다시 클릭 시 원래 상태로 완벽히 원복 확인 | ✅ 통과 |
| AC4 | completedCount를 getter로 구현하여 중복 저장 방지 | ✅ 통과 |
| AC5 | 프로젝트 내 실제 경로와 문서 내용 일치 | ✅ 통과 |
| AC6 | A/B 프롬프트 응답 관찰 및 비교 작성 | ✅ 통과 |
| AC7 | 코드, 문서, 증거가 같은 기능을 가리킴 | ✅ 통과 |