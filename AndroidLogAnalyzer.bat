@echo off 
setlocal enabledelayedexpansion 
chcp 65001 >nul 2>&1 
title Android Log Analyzer 
 
echo. 
echo ========================================== 
echo   Android Log Analyzer 
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
 
REM 로그 파일 경로 확인 
if "%1"=="" ( 
    echo. 
    echo 사용법: AndroidLogAnalyzer.bat <로그파일경로> 
    echo 예시: AndroidLogAnalyzer.bat dumpstate.txt 
    echo. 
    echo 로그 파일 경로를 입력하세요: 
    set /p logfile= 
    if ""=="" ( 
        echo [오류] 파일 경로가 입력되지 않았습니다. 
        pause 
        exit /b 1 
    ) 
) else ( 
    set logfile=%1 
) 
 
REM 파일 존재 확인 
if not exist "" ( 
    echo [오류] 파일을 찾을 수 없습니다:  
    pause 
    exit /b 1 
) 
 
echo. 
echo 로그 분석 실행 중... 
echo 분석 대상:  
echo. 
 
java -Dfile.encoding=UTF-8 -jar target\log-analyzer-1.0.0.jar "" 
 
if %ERRORLEVEL% neq 0 ( 
    echo [오류] 분석 중 오류가 발생했습니다. 
    pause 
    exit /b 1 
) 
 
echo. 
echo [완료] 분석이 성공적으로 완료되었습니다 
echo. 
pause 
