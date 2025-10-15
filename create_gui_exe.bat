@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer - GUI EXE 생성

echo.
echo ==========================================
echo   Android Log Analyzer - GUI EXE 생성
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

echo [1/4] Maven으로 JAR 파일 빌드 중...
call mvn clean package -q

if %ERRORLEVEL% neq 0 (
    echo [오류] 빌드 실패!
    pause
    exit /b 1
)

echo [2/4] JAR 파일 빌드 완료!

echo [3/4] GUI EXE 래퍼 생성 중...

REM GUI EXE 래퍼 배치 파일 생성
echo @echo off > AndroidLogAnalyzerGUI.bat
echo setlocal enabledelayedexpansion >> AndroidLogAnalyzerGUI.bat
echo chcp 65001 ^>nul 2^>^&1 >> AndroidLogAnalyzerGUI.bat
echo title Android Log Analyzer GUI >> AndroidLogAnalyzerGUI.bat
echo. >> AndroidLogAnalyzerGUI.bat
echo REM Java 설치 확인 >> AndroidLogAnalyzerGUI.bat
echo java -version ^>nul 2^>^&1 >> AndroidLogAnalyzerGUI.bat
echo if %%ERRORLEVEL%% neq 0 ^( >> AndroidLogAnalyzerGUI.bat
echo     echo [오류] Java가 설치되어 있지 않습니다. >> AndroidLogAnalyzerGUI.bat
echo     echo Java 11 이상을 설치해주세요: https://adoptium.net/ >> AndroidLogAnalyzerGUI.bat
echo     pause >> AndroidLogAnalyzerGUI.bat
echo     exit /b 1 >> AndroidLogAnalyzerGUI.bat
echo ^) >> AndroidLogAnalyzerGUI.bat
echo. >> AndroidLogAnalyzerGUI.bat
echo echo Android Log Analyzer GUI 시작 중... >> AndroidLogAnalyzerGUI.bat
echo java -Dfile.encoding=UTF-8 -cp target\log-analyzer-1.0.0.jar com.android.loganalyzer.LogAnalyzerGUI >> AndroidLogAnalyzerGUI.bat

echo [4/4] GUI EXE 래퍼 생성 완료!

echo [완료] AndroidLogAnalyzerGUI.bat가 생성되었습니다!

echo.
echo 생성된 파일:
echo - AndroidLogAnalyzerGUI.bat (GUI 실행 파일)
echo - target\log-analyzer-1.0.0.jar (JAR 파일)

echo.
echo 사용법:
echo 1. AndroidLogAnalyzerGUI.bat를 더블클릭하여 실행
echo 2. GUI 창에서 "파일 선택" 버튼을 클릭하여 로그 파일 선택
echo 3. "분석 시작" 버튼을 클릭하여 분석 실행
echo.
echo 특징:
echo - 그래픽 사용자 인터페이스
echo - 파일 선택 대화상자
echo - 실시간 진행률 표시
echo - 분석 결과를 창에서 바로 확인
echo.
pause

