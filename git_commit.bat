@echo off
chcp 65001 >nul
echo Git 커밋 도우미
echo ===============

echo.
echo Git이 설치되어 있는지 확인 중...

git --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Git이 설치되어 있지 않습니다.
    echo setup_git_after_install.bat 파일을 먼저 실행하세요.
    pause
    exit /b 1
)

echo ✅ Git이 설치되어 있습니다.
echo.

echo 1. 현재 Git 상태 확인...
echo ========================
git status

echo.
echo 2. .gitignore에 의해 무시되는 파일들 확인...
echo ============================================
echo 다음 파일들은 Git에 올라가지 않습니다:
echo - dumpstate.txt (덤프로그 파일)
echo - test_*.zip (테스트 파일들)
echo - *.log (로그 파일들)
echo - target/ (Maven 빌드 결과)
echo - lib/ (다운로드된 라이브러리)
echo - *.class (컴파일된 클래스)
echo.

echo 3. Git에 추가될 파일들 확인...
echo ==============================
git add --dry-run .

echo.
echo 4. 실제로 파일들을 Git에 추가...
echo ================================
git add .

echo.
echo 5. 추가된 파일들 확인...
echo ======================
git status

echo.
echo 6. 커밋 메시지 입력...
echo ====================
echo 커밋 메시지를 입력하세요 (예: "Initial commit: Android Log Analyzer"):
set /p commit_message=

if "%commit_message%"=="" (
    set commit_message=Update project files
)

echo.
echo 7. 커밋 실행...
echo ==============
git commit -m "%commit_message%"

echo.
echo ✅ 커밋이 완료되었습니다!
echo.

echo 8. 커밋 히스토리 확인...
echo ======================
git log --oneline -5

echo.
echo 9. GitHub에 올리기 (선택사항)...
echo ==============================
echo GitHub에 올리시겠습니까? (y/n):
set /p push_choice=

if /i "%push_choice%"=="y" (
    echo.
    echo GitHub 저장소 URL을 입력하세요:
    echo 예시: https://github.com/YOUR_USERNAME/android-log-analyzer.git
    set /p remote_url=
    
    if not "%remote_url%"=="" (
        git remote add origin "%remote_url%"
        git branch -M main
        git push -u origin main
        echo ✅ GitHub에 업로드가 완료되었습니다!
    ) else (
        echo ❌ URL이 입력되지 않았습니다.
    )
) else (
    echo GitHub 업로드를 건너뜁니다.
)

echo.
echo 🎉 모든 작업이 완료되었습니다!
pause
