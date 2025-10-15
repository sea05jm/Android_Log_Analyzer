@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer (Maven 없이)

echo.
echo ==========================================
echo   Android Log Analyzer (Maven 없이 실행)
echo   Windows 10 호환 버전
echo ==========================================
echo.

REM Java 설치 확인
java -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Java가 설치되어 있지 않습니다.
    echo Java 11 이상을 설치해주세요: https://adoptium.net/
    echo.
    pause
    exit /b 1
)

echo [1/4] 필요한 라이브러리 다운로드 중...

REM lib 폴더 생성
if not exist "lib" mkdir lib

REM 라이브러리 다운로드 (PowerShell 대신 curl 사용)
echo Apache Commons IO 다운로드 중...
curl -L -o "lib\commons-io-2.11.0.jar" "https://repo1.maven.org/maven2/commons-io/commons-io/2.11.0/commons-io-2.11.0.jar" 2>nul
if not exist "lib\commons-io-2.11.0.jar" (
    echo [경고] Commons IO 다운로드 실패. PowerShell로 재시도...
    powershell -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/commons-io/commons-io/2.11.0/commons-io-2.11.0.jar' -OutFile 'lib\commons-io-2.11.0.jar' -UseBasicParsing } catch { Write-Host '다운로드 실패' }"
)

echo Apache Commons Lang 다운로드 중...
curl -L -o "lib\commons-lang3-3.12.0.jar" "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar" 2>nul
if not exist "lib\commons-lang3-3.12.0.jar" (
    echo [경고] Commons Lang 다운로드 실패. PowerShell로 재시도...
    powershell -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar' -OutFile 'lib\commons-lang3-3.12.0.jar' -UseBasicParsing } catch { Write-Host '다운로드 실패' }"
)

REM 라이브러리 존재 확인
if not exist "lib\commons-io-2.11.0.jar" (
    echo [오류] Commons IO 라이브러리를 다운로드할 수 없습니다.
    echo 인터넷 연결을 확인하거나 수동으로 다운로드하세요.
    pause
    exit /b 1
)

if not exist "lib\commons-lang3-3.12.0.jar" (
    echo [오류] Commons Lang 라이브러리를 다운로드할 수 없습니다.
    echo 인터넷 연결을 확인하거나 수동으로 다운로드하세요.
    pause
    exit /b 1
)

echo [2/4] 라이브러리 다운로드 완료!

echo [3/4] Java 소스 컴파일 중...

REM target/classes 폴더 생성
if not exist "target\classes" mkdir target\classes

REM Java 컴파일
javac -cp "lib\*" -d target\classes src\main\java\com\android\loganalyzer\LogAnalyzer.java

if %ERRORLEVEL% neq 0 (
    echo [오류] 컴파일 실패! Java 소스 코드를 확인하세요.
    pause
    exit /b 1
)

echo 컴파일 완료!

REM 로그 파일 경로 확인
if "%1"=="" (
    echo.
    echo 사용법: compile_and_run_windows10.bat ^<로그파일경로^>
    echo 예시: compile_and_run_windows10.bat dumpstate.txt
    echo.
    echo 로그 파일 경로를 입력하세요:
    set /p logfile=
    if "!logfile!"=="" (
        echo [오류] 파일 경로가 입력되지 않았습니다.
        pause
        exit /b 1
    )
) else (
    set logfile=%1
)

REM 파일 존재 확인
if not exist "!logfile!" (
    echo [오류] 파일을 찾을 수 없습니다: !logfile!
    pause
    exit /b 1
)

echo.
echo [4/4] 로그 분석 실행 중...
echo 분석 대상: !logfile!
echo.

java -Dfile.encoding=UTF-8 -cp "target\classes;lib\*" com.android.loganalyzer.LogAnalyzer "!logfile!"

if %ERRORLEVEL% neq 0 (
    echo [오류] 분석 중 오류가 발생했습니다.
    pause
    exit /b 1
)

echo.
echo [완료] 분석이 성공적으로 완료되었습니다!
echo.
pause
