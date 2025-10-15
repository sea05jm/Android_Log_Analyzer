# Android Log Analyzer 사용법

## 🚀 빠른 시작

### 1. GUI 버전 (추천)
```bash
AndroidLogAnalyzerGUI.bat
```
- 더블클릭으로 실행
- 파일 선택 다이얼로그 제공
- 실시간 진행률 표시

### 2. 콘솔 버전
```bash
AndroidLogAnalyzer.bat <로그파일경로>
```
예시:
```bash
AndroidLogAnalyzer.bat dumpstate.txt
```

## 📋 시스템 요구사항

- **Java 11 이상** (자동으로 확인됨)
- **Windows 10/11**
- **인터넷 연결** (첫 실행 시 라이브러리 다운로드용)

## 🔧 자동 설정

배치 파일을 실행하면 자동으로:
1. Java 설치 확인
2. 필요한 라이브러리 다운로드
3. Java 소스 컴파일
4. GUI/콘솔 실행

## 📁 프로젝트 구조

```
Android_Log_Analyzer/
├── AndroidLogAnalyzer.bat          # 콘솔 버전 실행
├── AndroidLogAnalyzerGUI.bat       # GUI 버전 실행
├── src/main/java/com/android/loganalyzer/
│   ├── LogAnalyzer.java            # 콘솔 분석기
│   └── LogAnalyzerGUI.java         # GUI 분석기
├── target/classes/                 # 컴파일된 클래스 파일
└── lib/                           # 외부 라이브러리
```

## 🎯 분석 기능

- **ANR (Application Not Responding)** 분석
- **Exception** 분석
- **통계적 요약** 제공
- **타입별 상세 분석**

## ❓ 문제 해결

### Java가 설치되지 않은 경우
- [Java 11 이상 다운로드](https://adoptium.net/)
- 설치 후 재시도

### 라이브러리 다운로드 실패
- 인터넷 연결 확인
- 방화벽 설정 확인
- PowerShell 실행 정책 확인

### 컴파일 실패
- Java 버전 확인 (11 이상)
- 소스 파일 경로 확인
- 권한 문제 확인

## 📞 지원

문제가 발생하면 다음을 확인하세요:
1. Java 설치 여부
2. 인터넷 연결 상태
3. 파일 권한
4. 오류 메시지 내용
