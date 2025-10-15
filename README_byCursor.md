# Android Log Analyzer 📱

[![Java](https://img.shields.io/badge/Java-11+-orange.svg)](https://www.oracle.com/java/)
[![Maven](https://img.shields.io/badge/Maven-3.6+-blue.svg)](https://maven.apache.org/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

갤럭시 핸드폰의 덤프로그에서 ANR(Application Not Responding)과 Exception을 분석하는 Java 프로그램입니다.

## 🌟 특징

- 🔍 **자동 패턴 인식**: ANR과 Exception을 자동으로 감지
- 📊 **상세 통계**: 타입별 발생 횟수와 비율 제공
- 🚀 **고성능**: 대용량 로그 파일도 메모리 효율적으로 처리
- 🎯 **사용자 친화적**: 간단한 명령어로 실행 가능
- 🌐 **다국어 지원**: UTF-8 인코딩으로 한글 완벽 지원

## 🚀 기능

- **ANR 검출**: Application Not Responding 관련 로그 분석
- **Exception 검출**: 다양한 Exception 타입 분석 및 카운팅
- **상세 통계**: 타입별 발생 횟수 및 비율 제공
- **대용량 파일 지원**: 메모리 효율적인 스트리밍 방식으로 처리
- **진행 상황 표시**: 분석 진행률 실시간 표시

## 📋 요구사항

- Java 11 이상
- Maven 3.6 이상

## 🛠️ 설치 및 실행

### 🪟 Windows 10 사용자 (권장)

Windows 10에서 배치 파일 실행 문제가 있는 경우:

#### 1. 호환성 수정 도구 실행
```cmd
fix_windows10.bat
```

#### 2. Windows 10 전용 실행 파일 사용
```cmd
# Maven이 설치된 경우
run_windows10.bat dumpstate.txt

# Maven이 없는 경우
compile_and_run_windows10.bat dumpstate.txt
```

### 방법 1: Maven 사용 (권장)

#### 1. 요구사항
- Java 11 이상
- Maven 3.6 이상

#### 2. 프로젝트 빌드
```bash
mvn clean package
```

#### 3. 실행
```bash
# 일반 실행
java -jar target/log-analyzer-1.0.0.jar <로그파일경로>

# Windows 배치 파일
run.bat dumpstate.txt
```

### 방법 2: Maven 없이 실행

#### 1. 요구사항
- Java 11 이상만 필요

#### 2. 자동 실행 (Windows)
```bash
# 일반 버전
compile_and_run.bat dumpstate.txt

# Windows 10 호환 버전
compile_and_run_windows10.bat dumpstate.txt
```

#### 3. 수동 실행
```bash
# 라이브러리 다운로드 (한 번만)
mkdir lib
# Apache Commons IO와 Lang 라이브러리를 lib 폴더에 다운로드

# 컴파일
javac -cp "lib/*" -d target/classes src/main/java/com/android/loganalyzer/LogAnalyzer.java

# 실행
java -cp "target/classes;lib/*" com.android.loganalyzer.LogAnalyzer dumpstate.txt
```

### 예시
```bash
# Maven 사용
java -jar target/log-analyzer-1.0.0.jar dumpstate.txt

# Maven 없이 (Windows)
compile_and_run.bat dumpstate.txt

# Windows 10 호환 버전
run_windows10.bat dumpstate.txt
```

## 🎯 EXE 파일 생성

### 자동 EXE 생성 (권장)

모든 실행 파일을 한 번에 생성:
```cmd
create_all_exe.bat
```

### 개별 EXE 생성

#### 1. 콘솔 버전 EXE
```cmd
create_simple_exe.bat
```
- `AndroidLogAnalyzer.bat` 생성
- 명령행에서 실행
- 빠른 분석에 적합

#### 2. GUI 버전 EXE
```cmd
create_gui_exe.bat
```
- `AndroidLogAnalyzerGUI.bat` 생성
- 그래픽 사용자 인터페이스
- 파일 선택 대화상자
- 실시간 진행률 표시

#### 3. 고급 EXE (Launch4j 사용)
```cmd
create_exe.bat
```
- Launch4j를 사용한 네이티브 .exe 생성
- 더 작은 파일 크기
- Windows 탐색기에서 더블클릭 실행

### EXE 파일 사용법

#### 콘솔 버전
```cmd
# 더블클릭으로 실행 후 파일 경로 입력
AndroidLogAnalyzer.bat

# 명령행에서 직접 실행
AndroidLogAnalyzer.bat dumpstate.txt
```

#### GUI 버전
```cmd
# 더블클릭으로 실행
AndroidLogAnalyzerGUI.bat

# GUI에서 파일 선택 → 분석 시작
```

### .bat를 .exe로 변환

생성된 .bat 파일을 .exe로 변환하려면:

1. **Bat to Exe Converter** (무료)
   - https://bat2exe.net/ 에서 다운로드
   - .bat 파일을 .exe로 변환
   - 아이콘 설정 가능

2. **Launch4j** (고급)
   - https://launch4j.sourceforge.net/ 에서 다운로드
   - 더 많은 옵션 제공
   - 네이티브 .exe 생성

## 📊 출력 예시

```
📊 로그 분석 결과
============================================================

🚨 ANR (Application Not Responding) 분석:
----------------------------------------
총 ANR 발생 횟수: 5회

ANR 타입별 상세:
  • ANR: 3회
  • Application Not Responding: 2회

💥 Exception 분석:
----------------------------------------
총 Exception 발생 횟수: 12회

Exception 타입별 상세:
  • NullPointerException: 4회
  • OutOfMemoryError: 3회
  • IllegalStateException: 2회
  • Unknown Exception: 3회

📈 요약:
----------------------------------------
총 문제 발생 횟수: 17회
  - ANR: 5회
  - Exception: 12회
ANR 비율: 29.4%
Exception 비율: 70.6%
```

## 🔍 분석 패턴

### ANR 패턴
- `anr` (대소문자 구분 없음)
- `application not responding`
- `not responding`

### Exception 패턴
- `exception`
- `error`
- `fatal`
- `crash`
- `outofmemory`
- `stackoverflow`

## 📁 프로젝트 구조

```
src/
├── main/
│   └── java/
│       └── com/
│           └── android/
│               └── loganalyzer/
│                   └── LogAnalyzer.java
└── pom.xml
```

## 🎯 사용 사례

1. **개발자**: 앱의 안정성 문제 분석
2. **QA 엔지니어**: 테스트 중 발생한 문제 요약
3. **디버깅**: 프로덕션 환경의 문제 패턴 파악

## ⚡ 성능

- 대용량 로그 파일도 메모리 효율적으로 처리
- 스트리밍 방식으로 파일을 한 줄씩 읽어 처리
- 정규표현식 최적화로 빠른 패턴 매칭

## 🤝 기여하기

1. 이 저장소를 포크하세요
2. 새로운 기능 브랜치를 생성하세요 (`git checkout -b feature/amazing-feature`)
3. 변경사항을 커밋하세요 (`git commit -m 'Add some amazing feature'`)
4. 브랜치에 푸시하세요 (`git push origin feature/amazing-feature`)
5. Pull Request를 생성하세요

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

## 🐛 버그 리포트

버그를 발견하셨나요? [Issues](https://github.com/yourusername/android-log-analyzer/issues) 페이지에서 리포트해주세요.

## 🔧 커스터마이징

`LogAnalyzer.java` 파일에서 다음 패턴들을 수정하여 분석 기준을 조정할 수 있습니다:

- `ANR_PATTERN`: ANR 검출 패턴
- `EXCEPTION_PATTERN`: Exception 검출 패턴
- `EXCEPTION_TYPE_PATTERN`: Exception 타입 추출 패턴

## 🛠️ Windows 10 문제 해결

### 문제: "~~는 배치 파일이 아닙니다" 오류

이 문제는 Windows 10에서 배치 파일 연결이 잘못 설정되었을 때 발생합니다.

#### 해결 방법 1: 호환성 수정 도구 사용
```cmd
fix_windows10.bat
```

#### 해결 방법 2: 수동으로 파일 연결 수정
```cmd
assoc .bat=batfile
ftype batfile="%1" "%*"
```

#### 해결 방법 3: Windows 10 전용 파일 사용
- `run_windows10.bat` (Maven 필요)
- `compile_and_run_windows10.bat` (Maven 불필요)

### 문제: PowerShell 실행 정책 오류

PowerShell에서 스크립트 실행이 차단된 경우:

#### 해결 방법
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

또는 Windows 10 전용 파일을 사용하세요 (PowerShell 대신 curl 사용).

### 문제: Java 파일이 텍스트 에디터로 열림

#### 해결 방법
1. 파일 탐색기에서 `.java` 파일을 우클릭
2. "연결 프로그램" → "기본 프로그램 선택"
3. 텍스트 에디터 대신 명령 프롬프트에서 실행

## 📞 지원

질문이나 제안사항이 있으시면 [Issues](https://github.com/yourusername/android-log-analyzer/issues)를 통해 연락해주세요.

---

⭐ 이 프로젝트가 도움이 되었다면 스타를 눌러주세요!
