@echo off
chcp 65001 >nul
echo Git PATH 문제 해결 도우미
echo ========================

echo.
echo 현재 Git 설치 확인 중...

if exist "C:\Program Files\Git\bin\git.exe" (
    echo ✅ Git이 설치되어 있습니다: C:\Program Files\Git\bin\git.exe
    set "GIT_PATH=C:\Program Files\Git\bin"
) else if exist "C:\Program Files (x86)\Git\bin\git.exe" (
    echo ✅ Git이 설치되어 있습니다: C:\Program Files (x86)\Git\bin\git.exe
    set "GIT_PATH=C:\Program Files (x86)\Git\bin"
) else (
    echo ❌ Git을 찾을 수 없습니다.
    echo Git을 먼저 설치하세요: https://git-scm.com/download/win
    pause
    exit /b 1
)

echo.
echo 1. 현재 PATH에 Git이 등록되어 있는지 확인...
echo %PATH% | findstr /i "git" >nul
if %ERRORLEVEL% equ 0 (
    echo ✅ Git이 PATH에 등록되어 있습니다.
) else (
    echo ❌ Git이 PATH에 등록되어 있지 않습니다.
)

echo.
echo 2. 시스템 PATH에 Git 추가 (관리자 권한 필요)...
echo ================================================
echo 이 작업은 관리자 권한이 필요합니다.
echo 계속하시겠습니까? (y/n):
set /p continue_choice=

if /i not "%continue_choice%"=="y" (
    echo 작업을 취소합니다.
    pause
    exit /b 0
)

echo.
echo 시스템 PATH에 Git을 추가하는 중...

REM 현재 사용자 PATH에 Git 추가
for /f "usebackq tokens=2*" %%A in (`reg query "HKCU\Environment" /v PATH 2^>nul`) do set "USER_PATH=%%B"
if not defined USER_PATH (
    set "USER_PATH=%GIT_PATH%"
) else (
    echo %USER_PATH% | findstr /i "%GIT_PATH%" >nul
    if %ERRORLEVEL% neq 0 (
        set "USER_PATH=%USER_PATH%;%GIT_PATH%"
    )
)

reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%USER_PATH%" /f >nul 2>&1

if %ERRORLEVEL% equ 0 (
    echo ✅ 사용자 PATH에 Git이 추가되었습니다.
) else (
    echo ❌ 사용자 PATH 추가에 실패했습니다.
)

echo.
echo 3. 현재 터미널 세션에 Git PATH 추가...
set "PATH=%PATH%;%GIT_PATH%"

echo.
echo 4. Git 작동 확인...
"%GIT_PATH%\git.exe" --version
if %ERRORLEVEL% equ 0 (
    echo ✅ Git이 정상적으로 작동합니다!
) else (
    echo ❌ Git 작동에 문제가 있습니다.
)

echo.
echo 5. Sublime Text를 Git 에디터로 설정...
if exist "C:\Program Files\Sublime Text\sublime_text.exe" (
    "%GIT_PATH%\git.exe" config --global core.editor "\"C:\Program Files\Sublime Text\sublime_text.exe\" -w"
    echo ✅ Sublime Text가 Git 에디터로 설정되었습니다.
) else if exist "C:\Program Files (x86)\Sublime Text\sublime_text.exe" (
    "%GIT_PATH%\git.exe" config --global core.editor "\"C:\Program Files (x86)\Sublime Text\sublime_text.exe\" -w"
    echo ✅ Sublime Text가 Git 에디터로 설정되었습니다.
) else (
    echo ⚠️ Sublime Text를 찾을 수 없습니다. 수동으로 설정하세요.
)

echo.
echo 6. Git 사용자 정보 설정 확인...
"%GIT_PATH%\git.exe" config --global user.name >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Git 사용자 정보가 설정되지 않았습니다.
    echo 사용자 이름을 입력하세요:
    set /p username=
    echo 이메일 주소를 입력하세요:
    set /p email=
    "%GIT_PATH%\git.exe" config --global user.name "%username%"
    "%GIT_PATH%\git.exe" config --global user.email "%email%"
    echo ✅ Git 사용자 정보가 설정되었습니다.
) else (
    echo ✅ Git 사용자 정보가 이미 설정되어 있습니다.
)

echo.
echo 🎉 Git PATH 문제가 해결되었습니다!
echo.
echo ⚠️ 주의사항:
echo - 새로운 터미널 창을 열어야 PATH 변경사항이 적용됩니다.
echo - Cursor를 재시작하는 것을 권장합니다.
echo.

pause
