@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Windows 10 호환성 수정 도구

echo.
echo ==========================================
echo   Windows 10 호환성 수정 도구
echo ==========================================
echo.

echo [1/3] 배치 파일 연결 확인 중...

REM 배치 파일 연결 확인
assoc .bat >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [경고] .bat 파일 연결이 설정되지 않았습니다.
    echo 배치 파일 연결을 수정합니다...
    assoc .bat=batfile
    ftype batfile="%%1" "%%*"
    echo 배치 파일 연결이 수정되었습니다.
) else (
    echo 배치 파일 연결이 정상입니다.
)

echo.
echo [2/3] PowerShell 실행 정책 확인 중...

REM PowerShell 실행 정책 확인
powershell -Command "Get-ExecutionPolicy" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [경고] PowerShell 실행 정책을 확인할 수 없습니다.
) else (
    echo PowerShell 실행 정책이 확인되었습니다.
)

echo.
echo [3/3] Java 및 Maven 설치 확인 중...

REM Java 확인
java -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [오류] Java가 설치되어 있지 않습니다.
    echo Java 11 이상을 설치해주세요: https://adoptium.net/
    set java_ok=0
) else (
    echo [OK] Java가 설치되어 있습니다.
    set java_ok=1
)

REM Maven 확인
mvn -version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [경고] Maven이 설치되어 있지 않습니다.
    echo Maven 없이 실행하려면 compile_and_run_windows10.bat를 사용하세요.
    set maven_ok=0
) else (
    echo [OK] Maven이 설치되어 있습니다.
    set maven_ok=1
)

echo.
echo ==========================================
echo   수정 완료!
echo ==========================================
echo.

if !java_ok!==1 (
    if !maven_ok!==1 (
        echo [권장] run_windows10.bat를 사용하세요.
    ) else (
        echo [권장] compile_and_run_windows10.bat를 사용하세요.
    )
) else (
    echo [필수] Java를 먼저 설치하세요.
)

echo.
echo 사용 가능한 실행 파일:
echo - run_windows10.bat (Maven 필요)
echo - compile_and_run_windows10.bat (Maven 불필요)
echo.
pause
