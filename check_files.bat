@echo off
chcp 65001 >nul
echo Git에 올라갈 파일들 확인
echo ========================

echo.
echo 📁 현재 디렉토리의 모든 파일들:
echo ================================
dir /b

echo.
echo.
echo ✅ Git에 올라갈 파일들 (.gitignore 제외):
echo ==========================================

echo.
echo 📄 소스 코드:
if exist "src\" (
    echo ✅ src/ 폴더 (Java 소스 코드)
) else (
    echo ❌ src/ 폴더 없음
)

echo.
echo 📄 프로젝트 설정:
if exist "pom.xml" (
    echo ✅ pom.xml (Maven 설정)
) else (
    echo ❌ pom.xml 없음
)

if exist ".gitignore" (
    echo ✅ .gitignore (Git 무시 파일 목록)
) else (
    echo ❌ .gitignore 없음
)

echo.
echo 📄 문서:
if exist "README.md" (
    echo ✅ README.md (프로젝트 설명서)
) else (
    echo ❌ README.md 없음
)

if exist "LICENSE" (
    echo ✅ LICENSE (라이선스)
) else (
    echo ❌ LICENSE 없음
)

if exist "CONTRIBUTING.md" (
    echo ✅ CONTRIBUTING.md (기여 가이드)
) else (
    echo ❌ CONTRIBUTING.md 없음
)

echo.
echo 📄 스크립트:
if exist "run.bat" (
    echo ✅ run.bat (Maven 실행 스크립트)
) else (
    echo ❌ run.bat 없음
)

if exist "compile_and_run.bat" (
    echo ✅ compile_and_run.bat (Maven 없이 실행)
) else (
    echo ❌ compile_and_run.bat 없음
)

if exist "install_java.bat" (
    echo ✅ install_java.bat (Java 설치 도우미)
) else (
    echo ❌ install_java.bat 없음
)

if exist "setup_github.md" (
    echo ✅ setup_github.md (GitHub 업로드 가이드)
) else (
    echo ❌ setup_github.md 없음
)

echo.
echo.
echo ❌ Git에 올라가지 않는 파일들 (.gitignore에 의해 제외):
echo ======================================================

if exist "dumpstate.txt" (
    echo ❌ dumpstate.txt (덤프로그 파일 - 대용량)
) else (
    echo ✅ dumpstate.txt 없음 (정상)
)

if exist "test_*.zip" (
    echo ❌ test_*.zip (테스트 파일들)
) else (
    echo ✅ test_*.zip 없음 (정상)
)

if exist "target\" (
    echo ❌ target/ (Maven 빌드 결과)
) else (
    echo ✅ target/ 없음 (정상)
)

if exist "lib\" (
    echo ❌ lib/ (다운로드된 라이브러리)
) else (
    echo ✅ lib/ 없음 (정상)
)

echo.
echo 📊 요약:
echo ========
echo ✅ Git에 올라갈 파일들: 소스 코드, 설정 파일, 문서, 스크립트
echo ❌ Git에 올라가지 않는 파일들: 로그 파일, 빌드 결과, 라이브러리
echo.
echo 이제 git_commit.bat을 실행하여 커밋할 수 있습니다!
echo.

pause

