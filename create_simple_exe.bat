@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer - 간단한 EXE 생성

echo.
echo ==========================================
echo   Android Log Analyzer - 간단한 EXE 생성
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

echo [1/3] Maven으로 JAR 파일 빌드 중...
call mvn clean package -q

if %ERRORLEVEL% neq 0 (
    echo [오류] 빌드 실패!
    pause
    exit /b 1
)

echo [2/3] JAR 파일 빌드 완료!

echo [3/3] 간단한 EXE 래퍼 생성 중...

REM 간단한 EXE 래퍼 배치 파일 생성
echo @echo off > AndroidLogAnalyzer.bat
echo setlocal enabledelayedexpansion >> AndroidLogAnalyzer.bat
echo chcp 65001 ^>nul 2^>^&1 >> AndroidLogAnalyzer.bat
echo title Android Log Analyzer >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo echo. >> AndroidLogAnalyzer.bat
echo echo ========================================== >> AndroidLogAnalyzer.bat
echo echo   Android Log Analyzer >> AndroidLogAnalyzer.bat
echo echo ========================================== >> AndroidLogAnalyzer.bat
echo echo. >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo REM Java 설치 확인 >> AndroidLogAnalyzer.bat
echo java -version ^>nul 2^>^&1 >> AndroidLogAnalyzer.bat
echo if %%ERRORLEVEL%% neq 0 ^( >> AndroidLogAnalyzer.bat
echo     echo [오류] Java가 설치되어 있지 않습니다. >> AndroidLogAnalyzer.bat
echo     echo Java 11 이상을 설치해주세요: https://adoptium.net/ >> AndroidLogAnalyzer.bat
echo     pause >> AndroidLogAnalyzer.bat
echo     exit /b 1 >> AndroidLogAnalyzer.bat
echo ^) >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo REM 로그 파일 경로 확인 >> AndroidLogAnalyzer.bat
echo if "%%1"=="" ^( >> AndroidLogAnalyzer.bat
echo     echo. >> AndroidLogAnalyzer.bat
echo     echo 사용법: AndroidLogAnalyzer.bat ^<로그파일경로^> >> AndroidLogAnalyzer.bat
echo     echo 예시: AndroidLogAnalyzer.bat dumpstate.txt >> AndroidLogAnalyzer.bat
echo     echo. >> AndroidLogAnalyzer.bat
echo     echo 로그 파일 경로를 입력하세요: >> AndroidLogAnalyzer.bat
echo     set /p logfile= >> AndroidLogAnalyzer.bat
echo     if "!logfile!"=="" ^( >> AndroidLogAnalyzer.bat
echo         echo [오류] 파일 경로가 입력되지 않았습니다. >> AndroidLogAnalyzer.bat
echo         pause >> AndroidLogAnalyzer.bat
echo         exit /b 1 >> AndroidLogAnalyzer.bat
echo     ^) >> AndroidLogAnalyzer.bat
echo ^) else ^( >> AndroidLogAnalyzer.bat
echo     set logfile=%%1 >> AndroidLogAnalyzer.bat
echo ^) >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo REM 파일 존재 확인 >> AndroidLogAnalyzer.bat
echo if not exist "!logfile!" ^( >> AndroidLogAnalyzer.bat
echo     echo [오류] 파일을 찾을 수 없습니다: !logfile! >> AndroidLogAnalyzer.bat
echo     pause >> AndroidLogAnalyzer.bat
echo     exit /b 1 >> AndroidLogAnalyzer.bat
echo ^) >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo echo. >> AndroidLogAnalyzer.bat
echo echo 로그 분석 실행 중... >> AndroidLogAnalyzer.bat
echo echo 분석 대상: !logfile! >> AndroidLogAnalyzer.bat
echo echo. >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo java -Dfile.encoding=UTF-8 -jar target\log-analyzer-1.0.0.jar "!logfile!" >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo if %%ERRORLEVEL%% neq 0 ^( >> AndroidLogAnalyzer.bat
echo     echo [오류] 분석 중 오류가 발생했습니다. >> AndroidLogAnalyzer.bat
echo     pause >> AndroidLogAnalyzer.bat
echo     exit /b 1 >> AndroidLogAnalyzer.bat
echo ^) >> AndroidLogAnalyzer.bat
echo. >> AndroidLogAnalyzer.bat
echo echo. >> AndroidLogAnalyzer.bat
echo echo [완료] 분석이 성공적으로 완료되었습니다! >> AndroidLogAnalyzer.bat
echo echo. >> AndroidLogAnalyzer.bat
echo pause >> AndroidLogAnalyzer.bat

echo [완료] AndroidLogAnalyzer.bat가 생성되었습니다!

REM Bat to Exe Converter 다운로드 (선택사항)
echo.
echo 추가로 .bat 파일을 .exe로 변환하려면:
echo 1. https://bat2exe.net/ 에서 Bat to Exe Converter 다운로드
echo 2. AndroidLogAnalyzer.bat를 선택
echo 3. EXE 파일로 변환

echo.
echo 생성된 파일:
echo - AndroidLogAnalyzer.bat (실행 파일)
echo - target\log-analyzer-1.0.0.jar (JAR 파일)

echo.
echo 사용법:
echo 1. AndroidLogAnalyzer.bat를 더블클릭하여 실행
echo 2. 로그 파일 경로를 입력하거나 명령행에서 실행
echo    AndroidLogAnalyzer.bat dumpstate.txt
echo.
pause

