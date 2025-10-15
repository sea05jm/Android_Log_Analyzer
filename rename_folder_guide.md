# 폴더명 변경 가이드

## 🔄 폴더명을 "Android_Log_Analyzer"로 변경하는 방법

### 방법 1: Windows 탐색기 사용 (권장)

1. **Windows 탐색기 열기**
   - `Win + E` 키를 누르거나
   - 작업 표시줄의 폴더 아이콘 클릭

2. **폴더 위치로 이동**
   - `C:\Users\mimma\` 경로로 이동

3. **폴더명 변경**
   - `안드로이드 로그분석기` 폴더를 찾기
   - 폴더를 우클릭 → "이름 바꾸기" 선택
   - `Android_Log_Analyzer`로 변경

### 방법 2: 명령 프롬프트 사용

1. **명령 프롬프트 열기**
   - `Win + R` → `cmd` 입력 → Enter

2. **폴더 위치로 이동**
   ```cmd
   cd C:\Users\mimma
   ```

3. **폴더명 변경**
   ```cmd
   ren "안드로이드 로그분석기" "Android_Log_Analyzer"
   ```

### 방법 3: PowerShell (관리자 권한)

1. **PowerShell을 관리자 권한으로 실행**
   - 시작 메뉴에서 "PowerShell" 검색
   - 우클릭 → "관리자 권한으로 실행"

2. **폴더명 변경**
   ```powershell
   Set-Location "C:\Users\mimma"
   Rename-Item -Path "안드로이드 로그분석기" -NewName "Android_Log_Analyzer"
   ```

## ✅ 변경 후 확인사항

폴더명 변경 후 다음을 확인하세요:

1. **새 경로로 이동**
   ```cmd
   cd C:\Users\mimma\Android_Log_Analyzer
   ```

2. **파일들이 모두 있는지 확인**
   ```cmd
   dir
   ```

3. **Git 초기화**
   ```cmd
   git init
   git add .
   git commit -m "Initial commit: Android Log Analyzer"
   ```

## 🎯 변경 후 장점

- ✅ **Git 호환성**: 영어 폴더명으로 Git 문제 해결
- ✅ **경로 문제 해결**: 한글 경로로 인한 오류 방지
- ✅ **GitHub 호환성**: GitHub 저장소명과 일치
- ✅ **국제적 호환성**: 다른 개발자들과 공유 시 문제 없음

## 📝 주의사항

- 폴더명 변경 전에 **모든 파일이 저장**되었는지 확인
- Cursor에서 **새 폴더를 열어야** 함
- 기존 터미널 세션은 **새로 시작**해야 함
