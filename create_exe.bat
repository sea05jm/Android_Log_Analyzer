@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul 2>&1
title Android Log Analyzer - EXE 생성 도구

echo.
echo ==========================================
echo   Android Log Analyzer EXE 생성 도구
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

REM Launch4j 다운로드 확인
if not exist "launch4j" (
    echo [3/4] Launch4j 다운로드 중...
    mkdir launch4j
    curl -L -o "launch4j\launch4j-3.50.zip" "https://sourceforge.net/projects/launch4j/files/launch4j-3/3.50/launch4j-3.50-win32.zip/download" 2>nul
    if exist "launch4j\launch4j-3.50.zip" (
        powershell -Command "Expand-Archive -Path 'launch4j\launch4j-3.50.zip' -DestinationPath 'launch4j' -Force"
        echo Launch4j 다운로드 완료!
    ) else (
        echo [경고] Launch4j 자동 다운로드 실패. 수동으로 다운로드하세요.
        echo https://launch4j.sourceforge.net/
    )
)

echo [4/4] EXE 파일 생성 중...

REM Launch4j 설정 파일 생성
echo ^<?xml version="1.0" encoding="UTF-8"?^> > launch4j_config.xml
echo ^<launch4jConfig^> >> launch4j_config.xml
echo   ^<dontWrapJar^>false^</dontWrapJar^> >> launch4j_config.xml
echo   ^<headerType^>gui^</headerType^> >> launch4j_config.xml
echo   ^<jar^>target\log-analyzer-1.0.0.jar^</jar^> >> launch4j_config.xml
echo   ^<outfile^>AndroidLogAnalyzer.exe^</outfile^> >> launch4j_config.xml
echo   ^<errTitle^>Android Log Analyzer Error^</errTitle^> >> launch4j_config.xml
echo   ^<cmdLine^>^</cmdLine^> >> launch4j_config.xml
echo   ^<chdir^>^</chdir^> >> launch4j_config.xml
echo   ^<priority^>normal^</priority^> >> launch4j_config.xml
echo   ^<downloadUrl^>https://adoptium.net/^</downloadUrl^> >> launch4j_config.xml
echo   ^<supportUrl^>^</supportUrl^> >> launch4j_config.xml
echo   ^<stayAlive^>false^</stayAlive^> >> launch4j_config.xml
echo   ^<restartOnCrash^>false^</restartOnCrash^> >> launch4j_config.xml
echo   ^<manifest^>^</manifest^> >> launch4j_config.xml
echo   ^<icon^>^</icon^> >> launch4j_config.xml
echo   ^<jre^> >> launch4j_config.xml
echo     ^<path^>^</path^> >> launch4j_config.xml
echo     ^<bundledJre64Bit^>false^</bundledJre64Bit^> >> launch4j_config.xml
echo     ^<bundledJreAsFallback^>false^</bundledJreAsFallback^> >> launch4j_config.xml
echo     ^<minVersion^>11.0.0^</minVersion^> >> launch4j_config.xml
echo     ^<maxVersion^>^</maxVersion^> >> launch4j_config.xml
echo     ^<jdkPreference^>preferJre^</jdkPreference^> >> launch4j_config.xml
echo     ^<runtimeBits^>64/32^</runtimeBits^> >> launch4j_config.xml
echo     ^<opt^>-Dfile.encoding=UTF-8^</opt^> >> launch4j_config.xml
echo   ^</jre^> >> launch4j_config.xml
echo   ^<versionInfo^> >> launch4j_config.xml
echo     ^<fileVersion^>1.0.0.0^</fileVersion^> >> launch4j_config.xml
echo     ^<txtFileVersion^>1.0.0^</txtFileVersion^> >> launch4j_config.xml
echo     ^<fileDescription^>Android Log Analyzer^</fileDescription^> >> launch4j_config.xml
echo     ^<copyright^>MIT License^</copyright^> >> launch4j_config.xml
echo     ^<productVersion^>1.0.0.0^</productVersion^> >> launch4j_config.xml
echo     ^<txtProductVersion^>1.0.0^</txtProductVersion^> >> launch4j_config.xml
echo     ^<productName^>Android Log Analyzer^</productName^> >> launch4j_config.xml
echo     ^<companyName^>Android Log Analyzer^</companyName^> >> launch4j_config.xml
echo     ^<internalName^>AndroidLogAnalyzer^</internalName^> >> launch4j_config.xml
echo     ^<originalFilename^>AndroidLogAnalyzer.exe^</originalFilename^> >> launch4j_config.xml
echo   ^</versionInfo^> >> launch4j_config.xml
echo ^</launch4jConfig^> >> launch4j_config.xml

REM Launch4j로 EXE 생성
if exist "launch4j\launch4j.exe" (
    launch4j\launch4j.exe launch4j_config.xml
    if exist "AndroidLogAnalyzer.exe" (
        echo [완료] AndroidLogAnalyzer.exe가 생성되었습니다!
    ) else (
        echo [오류] EXE 파일 생성 실패!
    )
) else (
    echo [경고] Launch4j를 찾을 수 없습니다. 수동으로 설정하세요.
    echo 1. https://launch4j.sourceforge.net/ 에서 Launch4j 다운로드
    echo 2. launch4j_config.xml 파일을 Launch4j로 열기
    echo 3. Build Wrapper 버튼 클릭
)

echo.
echo 생성된 파일:
if exist "AndroidLogAnalyzer.exe" (
    echo - AndroidLogAnalyzer.exe (메인 실행 파일)
)
if exist "target\log-analyzer-1.0.0.jar" (
    echo - target\log-analyzer-1.0.0.jar (JAR 파일)
)

echo.
echo 사용법:
echo 1. AndroidLogAnalyzer.exe를 더블클릭하여 실행
echo 2. 로그 파일을 선택하거나 드래그 앤 드롭
echo.
pause

