@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer GUI

REM Java 설치 확인
java -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Java가 설치되어 있지 않습니다.
    echo Java 11 이상을 설치해주세요: https://adoptium.net/
    pause
    exit /b 1
)

echo Android Log Analyzer GUI 시작 중...
java -Dfile.encoding=UTF-8 -cp target\log-analyzer-1.0.0.jar com.android.loganalyzer.LogAnalyzerGUI
