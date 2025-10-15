@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
echo Android Log Analyzer 빌드 및 실행 스크립트
echo ==========================================

echo.
echo 1. Maven으로 프로젝트 빌드 중...
call mvn clean package -q

if %ERRORLEVEL% neq 0 (
    echo 빌드 실패! Maven이 설치되어 있는지 확인하세요.
    echo Maven 설치: https://maven.apache.org/download.cgi
    pause
    exit /b 1
)

echo 빌드 완료!
echo.

if "%1"=="" (
    echo 사용법: run.bat ^<로그파일경로^>
    echo 예시: run.bat dumpstate.txt
    echo.
    echo 사용할 로그 파일 경로를 입력하세요:
    set /p logfile=
    if "!logfile!"=="" (
        echo 파일 경로가 입력되지 않았습니다.
        pause
        exit /b 1
    )
) else (
    set logfile=%1
)

echo.
echo 2. 로그 분석 실행 중...
echo 분석 대상: %logfile%
echo.

java -Dfile.encoding=UTF-8 -jar target\log-analyzer-1.0.0.jar "%logfile%"

echo.
echo 분석 완료!
pause
