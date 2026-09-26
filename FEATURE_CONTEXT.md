# FEATURE_CONTEXT: Goal Lab (목표 관리 앱)

## 인수 조건 (Acceptance Criteria)

### AC1: 정상 입력 통과
- **설명**: 텍스트 입력창에 목표를 입력하고 추가 버튼을 누르면 목록에 정상적으로 등록된다.
- **증거**: `evidence/ac1-valid.png`

### AC2: 공백 입력 통과 (예외 처리)
- **설명**: 빈 문자열이나 공백만 입력한 경우 목록에 추가되지 않고 경고 또는 무시 처리된다.
- **증거**: `evidence/ac2-empty.png`

### AC3: 완료 전환 통과
- **설명**: 등록된 목표의 체크박스를 누르면 완료 상태(취소선 또는 체크 표시)로 변경된다.
- **증거**: `evidence/ac3-complete.png`