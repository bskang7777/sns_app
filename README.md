# AI TOOL 개발자 모임 SNS App

AI TOOL 개발자들을 위한 Instagram 스타일 소셜 네트워킹 서비스 앱입니다. Flutter와 Clean Architecture를 사용하여 개발되었습니다.

## 🌐 라이브 데모

**GitHub Pages에서 실행 중**: [https://bskang7777.github.io/sns_app/](https://bskang7777.github.io/sns_app/)

## 🤖 AI TOOL 개발자들을 위한 특별한 기능

### ✅ 구현된 기능
- **Feed Page**: AI TOOL 프로젝트 공유, 기술 토론, 스토리
- **Explore Page**: AI TOOL 기술 검색, 프로젝트 발견, 트렌드 탐색
- **Create Post Page**: AI TOOL 프로젝트 업로드, 코드 스니펫 공유
- **Activity Page**: AI TOOL 개발자 팔로우, 프로젝트 좋아요 알림
- **Profile Page**: AI TOOL 개발자 프로필, 포트폴리오, 기술 스택

### 🎨 AI TOOL 개발자 친화적 UI/UX
- **다크 모드 지원**: 개발자들이 선호하는 다크 테마
- **코드 하이라이팅**: 코드 스니펫 표시 최적화
- **기술 태그**: AI TOOL 기술 스택 태그 시스템
- **프로젝트 갤러리**: AI TOOL 프로젝트 포트폴리오 전시
- **실시간 협업**: AI TOOL 개발자들 간 실시간 소통

### 🛠️ 지원하는 AI TOOL
- **MCP (Model Context Protocol)**: AI 모델 통합 및 확장
- **LLM (Large Language Models)**: GPT-4, Claude 등 대형 언어 모델
- **Cursor**: AI 기반 코드 에디터
- **n8n**: AI 워크플로우 자동화 플랫폼
- **Claude**: AI 어시스턴트 및 튜토리얼

### 📍 서울 지역 기반 커뮤니티
- **송파구**: AI TOOL 연구소, AI TOOL 아카데미
- **강남구**: AI TOOL 컨퍼런스, AI TOOL 연구센터
- **강동구**: AI TOOL 엔지니어링팀
- **마천동**: AI TOOL 사이언스팀

## 🏗️ 아키텍처

### Clean Architecture
```
lib/
├── core/constants/          # 앱 상수 (색상, 타이포그래피)
├── domain/entities/         # 비즈니스 엔티티
├── domain/repositories/     # 리포지토리 인터페이스
├── domain/usecases/         # 비즈니스 로직
├── data/models/            # 데이터 모델
├── data/datasources/       # 데이터 소스
├── data/repositories/      # 리포지토리 구현
└── presentation/           # UI 레이어
    ├── pages/             # 페이지 위젯
    ├── widgets/           # 재사용 가능한 위젯
    └── providers/         # Riverpod 프로바이더
```

### SOLID 원칙 적용
- **SRP**: 단일 책임 원칙
- **OCP**: 개방-폐쇄 원칙
- **LSP**: 리스코프 치환 원칙
- **ISP**: 인터페이스 분리 원칙
- **DIP**: 의존성 역전 원칙

## 🚀 설치 및 실행

### 요구사항
- Flutter SDK 3.22.0 이상
- Dart 3.4.0 이상
- Git

### 설치 방법

1. **저장소 클론**
```bash
git clone https://github.com/bskang7777/sns_app.git
cd sns_app
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **코드 생성**
```bash
flutter packages pub run build_runner build
```

### 실행 방법

#### 웹 브라우저
```bash
flutter run -d chrome
```

#### Android 에뮬레이터
```bash
flutter run -d android
```

#### iOS 시뮬레이터 (macOS만)
```bash
flutter run -d ios
```

## 📦 빌드

### 웹 빌드
```bash
flutter build web --release
```

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

## 🧪 테스트

### 단위 테스트
```bash
flutter test
```

### 위젯 테스트
```bash
flutter test test/widget_test.dart
```

## 🚀 배포

### GitHub Pages 자동 배포
이 프로젝트는 GitHub Actions를 사용하여 자동으로 GitHub Pages에 배포됩니다.

1. **main 브랜치에 푸시**하면 자동으로 빌드 및 배포
2. **배포 URL**: https://bskang7777.github.io/sns_app/

### 수동 배포
```bash
# 웹 빌드
flutter build web --release --base-href="/sns_app/"

# gh-pages 브랜치 생성 및 배포
git checkout --orphan gh-pages
rm -rf *
cp -r build/web/* .
git add .
git commit -m "Deploy web"
git push -u origin gh-pages --force
```

## 📁 프로젝트 구조

```
sns_app/
├── lib/
│   ├── core/constants/          # 앱 상수
│   │   ├── app_colors.dart      # 색상 정의
│   │   └── app_typography.dart  # 타이포그래피
│   ├── domain/                  # 도메인 레이어
│   │   ├── entities/           # 엔티티
│   │   ├── repositories/       # 리포지토리 인터페이스
│   │   └── usecases/          # 유스케이스
│   ├── data/                   # 데이터 레이어
│   │   ├── models/            # 데이터 모델
│   │   ├── datasources/       # 데이터 소스
│   │   └── repositories/      # 리포지토리 구현
│   └── presentation/          # 프레젠테이션 레이어
│       ├── pages/            # 페이지
│       ├── widgets/          # 위젯
│       └── providers/        # 프로바이더
├── assets/
│   └── images/               # 이미지 에셋
├── test/                     # 테스트 파일
├── .github/workflows/        # GitHub Actions
└── docs/                     # 문서
```

## 🛠️ 기술 스택

### Frontend
- **Flutter**: 3.22.0
- **Dart**: 3.4.0
- **Riverpod**: 상태 관리
- **GoRouter**: 네비게이션

### Backend (계획)
- **Node.js**: 서버 런타임
- **Express.js**: 웹 프레임워크
- **PostgreSQL**: 데이터베이스
- **Redis**: 캐싱
- **JWT**: 인증

### DevOps
- **GitHub Actions**: CI/CD
- **GitHub Pages**: 정적 호스팅
- **Docker**: 컨테이너화

## 📈 개발 로드맵

### Phase 1: 기본 UI ✅
- [x] Clean Architecture 설정
- [x] 기본 페이지 구현
- [x] Instagram 스타일 UI
- [x] GitHub Pages 배포

### Phase 2: AI TOOL 개발자 기능
- [ ] AI TOOL 프로젝트 공유 기능
- [ ] 코드 스니펫 하이라이팅
- [ ] 기술 스택 태그 시스템
- [ ] AI TOOL 데모 공유

### Phase 3: 고급 기능
- [ ] 실시간 코드 리뷰
- [ ] AI TOOL 성능 비교
- [ ] 협업 프로젝트 관리
- [ ] AI TOOL 컨퍼런스 정보 공유

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 연락처

- **GitHub**: [@bskang7777](https://github.com/bskang7777)
- **프로젝트 링크**: [https://github.com/bskang7777/sns_app](https://github.com/bskang7777/sns_app)
- **라이브 데모**: [https://bskang7777.github.io/sns_app/](https://bskang7777.github.io/sns_app/)

---

⭐ 이 프로젝트가 도움이 되었다면 스타를 꼭 눌러주세요!
