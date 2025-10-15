@echo off
chcp 65001 >nul
echo Java 설치 도우미
echo ================

echo.
echo Java가 설치되어 있지 않습니다.
echo.
echo 다음 중 하나의 방법으로 Java를 설치하세요:
echo.
echo 방법 1: 웹사이트에서 직접 다운로드
echo ----------------------------------------
echo 1. https://adoptium.net/ 접속
echo 2. "Latest LTS Release" 다운로드
echo 3. Windows x64 .msi 파일 다운로드
echo 4. 다운로드한 파일 실행하여 설치
echo.
echo 방법 2: 관리자 권한으로 Chocolatey 사용
echo ----------------------------------------
echo 1. PowerShell을 관리자 권한으로 실행
echo 2. 다음 명령어 실행:
echo    choco install openjdk
echo.
echo 방법 3: 수동 설치 (권장)
echo -------------------------
echo 1. https://www.oracle.com/java/technologies/downloads/ 접속
echo 2. "Java 17" 또는 "Java 11" 다운로드
echo 3. Windows x64 Installer 다운로드
echo 4. 설치 후 환경변수 PATH에 Java bin 폴더 추가
echo.
echo 설치 완료 후 이 스크립트를 다시 실행하세요.
echo.

pause

