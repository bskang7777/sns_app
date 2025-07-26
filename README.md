# 📱 SNS App

Flutter로 개발된 현대적인 SNS 애플리케이션입니다. Clean Architecture와 SOLID 원칙을 적용하여 개발되었습니다.

## 🚀 주요 기능

- **Clean Architecture**: 도메인, 데이터, 프레젠테이션 레이어 분리
- **SOLID 원칙**: 확장 가능하고 유지보수하기 쉬운 코드 구조
- **크로스 플랫폼**: iOS, Android, Web 지원
- **모던 UI**: Material Design 3 기반의 아름다운 사용자 인터페이스

## 📋 요구사항

- Flutter SDK 3.8.1 이상
- Dart SDK 3.8.1 이상
- Android Studio (Android 개발용)
- Xcode (iOS 개발용, macOS 필요)

## 🛠️ 설치 방법

### 1. 저장소 클론
```bash
git clone https://github.com/bskang7777/sns_app.git
cd sns_app
```

### 2. 의존성 설치
```bash
flutter pub get
```

### 3. 개발 환경 확인
```bash
flutter doctor
```

## 🚀 실행 방법

### Android 에뮬레이터에서 실행
```bash
# Android 에뮬레이터 시작
flutter emulators --launch android_emulator

# 앱 실행
flutter run -d android
```

### iOS 시뮬레이터에서 실행 (macOS 필요)
```bash
# iOS 시뮬레이터 시작
flutter emulators --launch apple_ios_simulator

# 앱 실행
flutter run -d ios
```

### 웹 브라우저에서 실행
```bash
flutter run -d chrome
```

### Windows 데스크톱에서 실행
```bash
flutter run -d windows
```

## 🏗️ 프로젝트 구조

```
lib/
├── main.dart                 # 앱 진입점
├── core/                     # 핵심 유틸리티
├── data/                     # 데이터 레이어
│   ├── datasources/         # 데이터 소스
│   ├── models/              # 데이터 모델
│   └── repositories/        # 리포지토리 구현
├── domain/                   # 도메인 레이어
│   ├── entities/            # 엔티티
│   ├── repositories/        # 리포지토리 인터페이스
│   └── usecases/            # 유스케이스
└── presentation/             # 프레젠테이션 레이어
    ├── pages/               # 페이지
    ├── widgets/             # 위젯
    └── providers/           # 상태 관리
```

## 🧪 테스트

### 단위 테스트 실행
```bash
flutter test
```

### 통합 테스트 실행
```bash
flutter test integration_test/
```

## 📦 빌드

### Android APK 빌드
```bash
flutter build apk
```

### Android App Bundle 빌드
```bash
flutter build appbundle
```

### iOS 빌드 (macOS 필요)
```bash
flutter build ios
```

### 웹 빌드
```bash
flutter build web
```

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 연락처

프로젝트 링크: [https://github.com/bskang7777/sns_app](https://github.com/bskang7777/sns_app)

---

⭐ 이 프로젝트가 도움이 되었다면 스타를 눌러주세요!
