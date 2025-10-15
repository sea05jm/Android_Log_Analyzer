@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer

echo.
echo ==========================================
echo   Android Log Analyzer (Windows 10 호환)
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

REM Maven 설치 확인
mvn -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Maven이 설치되어 있지 않습니다.
    echo Maven을 설치하거나 compile_and_run_windows10.bat를 사용하세요.
    echo Maven 설치: https://maven.apache.org/download.cgi
    echo.
    pause
    exit /b 1
)

echo [1/3] Maven으로 프로젝트 빌드 중...
call mvn clean package -q

if %ERRORLEVEL% neq 0 (
    echo [오류] 빌드 실패! Maven 설정을 확인하세요.
    pause
    exit /b 1
)

echo [2/3] 빌드 완료!

REM 로그 파일 경로 확인
if "%1"=="" (
    echo.
    echo 사용법: run_windows10.bat ^<로그파일경로^>
    echo 예시: run_windows10.bat dumpstate.txt
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
echo [3/3] 로그 분석 실행 중...
echo 분석 대상: !logfile!
echo.

java -Dfile.encoding=UTF-8 -jar target\log-analyzer-1.0.0.jar "!logfile!"

if %ERRORLEVEL% neq 0 (
    echo [오류] 분석 중 오류가 발생했습니다.
    pause
    exit /b 1
)

echo.
echo [완료] 분석이 성공적으로 완료되었습니다!
echo.
pause
