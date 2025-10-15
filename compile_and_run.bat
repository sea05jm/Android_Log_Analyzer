@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
echo Android Log Analyzer - Maven 없이 실행
echo ======================================

echo.
echo 1. 필요한 라이브러리 다운로드 중...

if not exist "lib" mkdir lib

echo Apache Commons IO 다운로드 중...
powershell -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/commons-io/commons-io/2.11.0/commons-io-2.11.0.jar' -OutFile 'lib\commons-io-2.11.0.jar' -UseBasicParsing } catch { Write-Host '다운로드 실패: ' $_.Exception.Message }"

echo Apache Commons Lang 다운로드 중...
powershell -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.12.0/commons-lang3-3.12.0.jar' -OutFile 'lib\commons-lang3-3.12.0.jar' -UseBasicParsing } catch { Write-Host '다운로드 실패: ' $_.Exception.Message }"

echo.
echo 2. Java 소스 컴파일 중...

if not exist "target\classes" mkdir target\classes

javac -cp "lib\*" -d target\classes src\main\java\com\android\loganalyzer\LogAnalyzer.java

if %ERRORLEVEL% neq 0 (
    echo 컴파일 실패! Java가 설치되어 있는지 확인하세요.
    echo Java 설치: https://adoptium.net/
    pause
    exit /b 1
)

echo 컴파일 완료!
echo.

if "%1"=="" (
    echo 사용법: compile_and_run.bat ^<로그파일경로^>
    echo 예시: compile_and_run.bat dumpstate.txt
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
echo 3. 로그 분석 실행 중...
echo 분석 대상: %logfile%
echo.

java -Dfile.encoding=UTF-8 -cp "target\classes;lib\*" com.android.loganalyzer.LogAnalyzer "%logfile%"

echo.
echo 분석 완료!
pause

