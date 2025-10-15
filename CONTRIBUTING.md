# 기여 가이드 (Contributing Guide)

Android Log Analyzer 프로젝트에 기여해주셔서 감사합니다! 🎉

## 🚀 시작하기

### 개발 환경 설정

1. **저장소 포크**
   ```bash
   # GitHub에서 이 저장소를 포크하세요
   ```

2. **로컬에 클론**
   ```bash
   git clone https://github.com/YOUR_USERNAME/android-log-analyzer.git
   cd android-log-analyzer
   ```

3. **개발 환경 준비**
   - Java 11 이상
   - Maven 3.6 이상
   - Git

## 📝 기여 방법

### 1. 이슈 생성
- 버그 리포트나 기능 제안을 위해 이슈를 생성해주세요
- 기존 이슈가 있는지 먼저 확인해주세요

### 2. 브랜치 생성
```bash
git checkout -b feature/your-feature-name
# 또는
git checkout -b bugfix/your-bugfix-name
```

### 3. 코드 작성
- 코드 스타일을 일관성 있게 유지해주세요
- 주석을 한국어로 작성해주세요
- 새로운 기능에는 테스트를 추가해주세요

### 4. 커밋
```bash
git add .
git commit -m "feat: 새로운 기능 추가"
# 또는
git commit -m "fix: 버그 수정"
```

### 5. 푸시 및 Pull Request
```bash
git push origin feature/your-feature-name
```

## 📋 커밋 메시지 규칙

- `feat:` 새로운 기능
- `fix:` 버그 수정
- `docs:` 문서 수정
- `style:` 코드 스타일 변경
- `refactor:` 코드 리팩토링
- `test:` 테스트 추가/수정
- `chore:` 빌드 과정 또는 보조 도구 변경

## 🧪 테스트

```bash
# 모든 테스트 실행
mvn test

# 특정 테스트 실행
mvn test -Dtest=LogAnalyzerTest
```

## 📚 코딩 스타일

- Java 코딩 컨벤션을 따릅니다
- 클래스명은 PascalCase
- 메서드명과 변수명은 camelCase
- 상수는 UPPER_SNAKE_CASE

## 🐛 버그 리포트

버그를 발견하셨다면 다음 정보를 포함해주세요:

1. **환경 정보**
   - OS 버전
   - Java 버전
   - Maven 버전

2. **재현 단계**
   - 명확한 단계별 설명
   - 예상 결과 vs 실제 결과

3. **로그 파일**
   - 가능하다면 문제가 발생한 로그 파일 샘플

## 💡 기능 제안

새로운 기능을 제안하실 때는:

1. **문제 설명**: 어떤 문제를 해결하고 싶은지
2. **해결 방안**: 어떻게 해결하고 싶은지
3. **사용 사례**: 어떤 상황에서 유용한지

## 📞 문의

질문이나 제안사항이 있으시면:
- GitHub Issues를 통해 문의해주세요
- 한국어로 작성해주세요

## 🙏 감사 인사

기여해주신 모든 분들께 감사드립니다! 여러분의 기여가 이 프로젝트를 더 좋게 만들어줍니다.

