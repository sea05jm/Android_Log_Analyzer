@echo off
chcp 65001 >nul
echo Git 설치 및 Sublime Text 설정 도우미
echo =====================================

echo.
echo 1. Git 설치 방법:
echo.
echo 방법 A: 공식 웹사이트에서 다운로드 (권장)
echo ----------------------------------------
echo 1. https://git-scm.com/download/win 접속
echo 2. "Download for Windows" 클릭
echo 3. 다운로드한 .exe 파일 실행하여 설치
echo 4. 설치 중 "Use Git from the command line and also from 3rd-party software" 선택
echo.
echo 방법 B: Chocolatey로 설치 (관리자 권한 필요)
echo -------------------------------------------
echo 1. PowerShell을 관리자 권한으로 실행
echo 2. 다음 명령어 실행:
echo    choco install git
echo.
echo 방법 C: Winget으로 설치
echo ------------------------
echo 1. 명령 프롬프트에서 다음 명령어 실행:
echo    winget install --id Git.Git -e --source winget
echo.

echo 2. Git 설치 후 Sublime Text 설정:
echo ----------------------------------
echo Git이 설치되면 다음 명령어를 실행하세요:
echo.
echo git config --global core.editor "\"C:\Program Files\Sublime Text\sublime_text.exe\" -w"
echo.
echo 또는 다음 명령어로 설정할 수 있습니다:
echo.
echo git config --global core.editor "subl -w"
echo (subl 명령어가 PATH에 등록되어 있는 경우)
echo.

echo 3. 설정 확인:
echo --------------
echo git config --global core.editor
echo.

echo 4. Git 사용자 정보 설정 (처음 한 번만):
echo ----------------------------------------
echo git config --global user.name "Your Name"
echo git config --global user.email "your.email@example.com"
echo.

echo 5. 현재 프로젝트를 Git 저장소로 설정:
echo --------------------------------------
echo git init
echo git add .
echo git commit -m "Initial commit: Android Log Analyzer"
echo.

pause

