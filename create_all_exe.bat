@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer - 모든 EXE 생성

echo.
echo ==========================================
echo   Android Log Analyzer - 모든 EXE 생성
echo ==========================================
echo.

REM Java 설치 확인
java -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Java가 설치되어 있지 않습니다.
    echo Java 11 이상을 설치해주세요: https://adoptium.net/
    pause
    exit /b 1
)

REM Maven 설치 확인
mvn -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Maven이 설치되어 있지 않습니다.
    echo Maven을 설치해주세요: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

echo [1/5] Maven으로 JAR 파일 빌드 중...
call mvn clean package -q

if %ERRORLEVEL% neq 0 (
    echo [오류] 빌드 실패!
    pause
    exit /b 1
)

echo [2/5] JAR 파일 빌드 완료!

echo [3/5] 콘솔 버전 EXE 생성 중...
call create_simple_exe.bat

echo [4/5] GUI 버전 EXE 생성 중...
call create_gui_exe.bat

echo [5/5] 모든 EXE 파일 생성 완료!

echo.
echo ==========================================
echo   생성된 실행 파일들
echo ==========================================
echo.

if exist "AndroidLogAnalyzer.bat" (
    echo ✅ AndroidLogAnalyzer.bat (콘솔 버전)
)
if exist "AndroidLogAnalyzerGUI.bat" (
    echo ✅ AndroidLogAnalyzerGUI.bat (GUI 버전)
)
if exist "target\log-analyzer-1.0.0.jar" (
    echo ✅ target\log-analyzer-1.0.0.jar (JAR 파일)
)

echo.
echo ==========================================
echo   사용 방법
echo ==========================================
echo.

echo 📱 콘솔 버전 (AndroidLogAnalyzer.bat):
echo    - 명령행에서 실행
echo    - 빠른 분석에 적합
echo    - 배치 처리에 유용
echo.

echo 🖥️ GUI 버전 (AndroidLogAnalyzerGUI.bat):
echo    - 그래픽 인터페이스
echo    - 파일 선택 대화상자
echo    - 실시간 진행률 표시
echo    - 일반 사용자에게 적합
echo.

echo 📦 JAR 파일 (target\log-analyzer-1.0.0.jar):
echo    - java -jar target\log-analyzer-1.0.0.jar ^<파일경로^>
echo    - 다른 Java 프로그램에서 라이브러리로 사용 가능
echo.

echo ==========================================
echo   추가 변환 옵션
echo ==========================================
echo.

echo 💡 .bat 파일을 .exe로 변환하려면:
echo    1. https://bat2exe.net/ 에서 Bat to Exe Converter 다운로드
echo    2. .bat 파일을 선택하여 .exe로 변환
echo    3. 아이콘 설정 및 기타 옵션 조정
echo.

echo 💡 더 고급 .exe 생성 (Launch4j 사용):
echo    1. create_exe.bat 실행
echo    2. Launch4j를 사용한 네이티브 .exe 생성
echo.

echo 모든 실행 파일이 준비되었습니다! 🎉
echo.
pause

