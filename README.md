# SNS App (Instagram Style)

Instagram 스타일의 소셜 네트워킹 서비스 앱입니다. Flutter와 Clean Architecture를 사용하여 개발되었습니다.

## 🌐 라이브 데모

**GitHub Pages에서 실행 중**: [https://bskang7777.github.io/sns_app/](https://bskang7777.github.io/sns_app/)

## 📱 주요 기능

### ✅ 구현된 기능
- **Feed Page**: 게시물 피드, 스토리, 좋아요/댓글 기능
- **Explore Page**: 검색, 발견, 게시물 그리드 뷰
- **Create Post Page**: 이미지 선택, 문구 입력, 위치 추가
- **Activity Page**: 팔로우/좋아요 알림, 실시간 활동
- **Profile Page**: 사용자 프로필, 게시물/저장됨/태그됨 탭

### 🎨 UI/UX 특징
- **Instagram 스타일 디자인**: Material Design 3 기반
- **반응형 레이아웃**: 다양한 화면 크기 지원
- **그라데이션 효과**: 스토리 테두리
- **탭 네비게이션**: 하단 탭 + 내부 탭
- **무한 스크롤**: 페이지네이션 지원

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

### Phase 2: 실제 기능
- [ ] API 연동
- [ ] 인증 시스템
- [ ] 이미지 업로드
- [ ] 실시간 기능

### Phase 3: 고급 기능
- [ ] 이미지 필터
- [ ] 스토리 기능
- [ ] DM 시스템
- [ ] 푸시 알림

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

⭐ 이 프로젝트가 도움이 되었다면 스타를 눌러주세요!
