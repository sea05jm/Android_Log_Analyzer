# GitHub에 프로젝트 올리기 가이드

## 🚀 단계별 가이드

### 1단계: Git 설치
Git이 설치되어 있지 않다면 먼저 설치하세요:

**Windows:**
1. https://git-scm.com/download/win 에서 다운로드
2. 설치 후 Git Bash 또는 명령 프롬프트에서 사용 가능

**또는 Chocolatey로 설치:**
```bash
choco install git
```

### 2단계: GitHub 저장소 생성
1. https://github.com 에서 로그인
2. "New repository" 클릭
3. 저장소 이름: `android-log-analyzer`
4. 설명: `Android dump log analyzer for ANR and Exception detection`
5. Public 선택
6. "Create repository" 클릭

### 3단계: 로컬 Git 설정
```bash
# Git 사용자 정보 설정 (처음 한 번만)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# 저장소 초기화
git init

# 원격 저장소 추가 (GitHub에서 생성한 저장소 URL 사용)
git remote add origin https://github.com/YOUR_USERNAME/android-log-analyzer.git
```

### 4단계: 파일 추가 및 커밋
```bash
# 모든 파일 추가
git add .

# 첫 번째 커밋
git commit -m "Initial commit: Android Log Analyzer"

# 메인 브랜치로 푸시
git branch -M main
git push -u origin main
```

### 5단계: GitHub Actions 설정 확인
- `.github/workflows/build.yml` 파일이 자동으로 GitHub Actions를 설정합니다
- 저장소의 "Actions" 탭에서 빌드 상태를 확인할 수 있습니다

## 📁 업로드될 파일들

```
android-log-analyzer/
├── .github/
│   └── workflows/
│       └── build.yml          # GitHub Actions 설정
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── android/
│                   └── loganalyzer/
│                       └── LogAnalyzer.java
├── .gitignore                 # Git 무시 파일 목록
├── CONTRIBUTING.md           # 기여 가이드
├── LICENSE                   # MIT 라이선스
├── README.md                 # 프로젝트 설명서
├── compile_and_run.bat       # Maven 없이 실행하는 스크립트
├── install_java.bat          # Java 설치 도우미
├── pom.xml                   # Maven 설정
└── setup_github.md           # 이 파일
```

## 🎯 GitHub 저장소 설정

### 1. 저장소 설명 업데이트
- GitHub 저장소 페이지에서 "About" 섹션 편집
- 설명: `🔍 Android dump log analyzer for ANR and Exception detection`
- 웹사이트: (선택사항)
- 토픽: `android`, `log-analysis`, `anr`, `exception`, `java`, `maven`

### 2. README.md 미리보기
- GitHub에서 README.md가 제대로 표시되는지 확인
- 배지(badges)가 올바르게 표시되는지 확인

### 3. Issues 및 Discussions 활성화
- Settings → Features에서 Issues와 Discussions 활성화

## 🔧 추가 설정 (선택사항)

### 1. GitHub Pages 설정
```bash
# docs 폴더 생성
mkdir docs

# 간단한 웹사이트 생성
echo "# Android Log Analyzer" > docs/index.md
echo "갤럭시 핸드폰의 덤프로그를 분석하는 도구입니다." >> docs/index.md
```

### 2. Release 생성
1. GitHub 저장소에서 "Releases" 클릭
2. "Create a new release" 클릭
3. Tag: `v1.0.0`
4. Title: `Android Log Analyzer v1.0.0`
5. Description: 릴리스 노트 작성
6. "Publish release" 클릭

## 🎉 완료!

이제 다른 사람들이 다음과 같이 프로젝트를 사용할 수 있습니다:

```bash
# 저장소 클론
git clone https://github.com/YOUR_USERNAME/android-log-analyzer.git

# 프로젝트 디렉토리로 이동
cd android-log-analyzer

# Maven으로 빌드
mvn clean package

# 실행
java -jar target/log-analyzer-1.0.0.jar dumpstate.txt
```

## 📞 도움이 필요하시면

- GitHub Issues를 통해 문의해주세요
- 한국어로 질문하셔도 됩니다

