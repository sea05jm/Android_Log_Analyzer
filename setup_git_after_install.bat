@echo off
chcp 65001 >nul
echo Git 설치 후 설정 스크립트
echo ========================

echo.
echo Git이 설치되었는지 확인 중...

git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Git이 설치되어 있지 않습니다.
    echo install_git_and_setup.bat 파일을 실행하여 Git을 먼저 설치하세요.
    pause
    exit /b 1
)

echo ✅ Git이 설치되어 있습니다.
echo.

echo 1. Git 사용자 정보 설정...
echo 사용자 이름을 입력하세요:
set /p username=
echo 이메일 주소를 입력하세요:
set /p email=

git config --global user.name "%username%"
git config --global user.email "%email%"

echo.
echo 2. Sublime Text를 Git 에디터로 설정...

REM Sublime Text 경로 확인
if exist "C:\Program Files\Sublime Text\sublime_text.exe" (
    echo ✅ Sublime Text를 찾았습니다.
    git config --global core.editor "\"C:\Program Files\Sublime Text\sublime_text.exe\" -w"
    echo ✅ Sublime Text가 Git 에디터로 설정되었습니다.
) else if exist "C:\Program Files (x86)\Sublime Text\sublime_text.exe" (
    echo ✅ Sublime Text를 찾았습니다 (x86 버전).
    git config --global core.editor "\"C:\Program Files (x86)\Sublime Text\sublime_text.exe\" -w"
    echo ✅ Sublime Text가 Git 에디터로 설정되었습니다.
) else (
    echo ❌ Sublime Text를 찾을 수 없습니다.
    echo 수동으로 설정하세요:
    echo git config --global core.editor "\"C:\Program Files\Sublime Text\sublime_text.exe\" -w"
)

echo.
echo 3. 설정 확인...
echo.
echo 현재 Git 설정:
echo --------------
echo 사용자 이름: 
git config --global user.name
echo 이메일: 
git config --global user.email
echo 에디터: 
git config --global core.editor

echo.
echo 4. 현재 프로젝트를 Git 저장소로 초기화...
git init

echo.
echo 5. 파일들을 Git에 추가...
git add .

echo.
echo 6. 첫 번째 커밋 생성...
git commit -m "Initial commit: Android Log Analyzer"

echo.
echo ✅ Git 설정이 완료되었습니다!
echo.
echo 이제 GitHub에 올리려면:
echo 1. GitHub에서 새 저장소 생성
echo 2. git remote add origin https://github.com/YOUR_USERNAME/android-log-analyzer.git
echo 3. git push -u origin main
echo.

pause

