# SNS App - AI TOOL 개발자 모임

AI TOOL 개발자들의 소통 공간을 위한 Instagram Style SNS 앱입니다.

## 🚀 최신 업데이트 (v1.1.0)

### ✨ 새로운 기능
- **실제 카메라 기능**: 카메라 선택 시 실제 카메라가 켜집니다
- **갤러리 이미지 선택**: 실제 갤러리에서 이미지 선택 가능
- **권한 처리 시스템**: Android/iOS 권한 자동 요청 및 처리
- **UI/UX 개선**: 모던한 아이콘 디자인 및 레이아웃 개선
- **Overflow 에러 수정**: 스크롤 가능한 반응형 레이아웃

## 📱 주요 기능

### 🎯 이미지 관리
- **카메라 촬영**: 실제 카메라로 사진 촬영
- **갤러리 선택**: 갤러리에서 이미지 선택
- **이미지 미리보기**: 실시간 이미지 미리보기
- **이미지 삭제**: 선택한 이미지 쉽게 제거

### 🔐 권한 관리
- **카메라 권한**: 자동 권한 요청 및 처리
- **갤러리 권한**: 이미지 접근 권한 관리
- **권한 거부 처리**: 설정으로 이동하는 안내 다이얼로그

### 🎨 UI/UX
- **모던한 디자인**: 일관된 아이콘 시스템
- **반응형 레이아웃**: 다양한 화면 크기 지원
- **사용자 피드백**: 실시간 상태 알림 메시지

## 🛠 설치 및 실행

### 필수 요구사항
- Flutter SDK 3.4.0 이상
- Dart SDK 3.4.0 이상
- Android Studio / VS Code
- Android SDK (Android 개발용)
- Xcode (iOS 개발용)

### 설치 방법

1. **저장소 클론**
```bash
git clone https://github.com/your-username/sns_app.git
cd sns_app
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **앱 실행**
```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Windows
flutter run -d windows

# 웹
flutter run -d chrome
```

## 📦 배포

### Android APK 빌드
```bash
flutter build apk --release
```

### Android App Bundle (Google Play Store)
```bash
flutter build appbundle --release
```

### Windows 실행 파일
```bash
flutter build windows --release
```

### 웹 배포
```bash
flutter build web --release
```

## 🏗 프로젝트 구조

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   └── utils/
│       └── permission_utils.dart
├── presentation/
│   └── pages/
│       ├── create_post_page.dart
│       ├── feed_page.dart
│       ├── explore_page.dart
│       ├── activity_page.dart
│       └── profile_page.dart
└── main.dart
```

## 🔧 기술 스택

- **Framework**: Flutter 3.4.0+
- **Language**: Dart 3.4.0+
- **State Management**: Riverpod
- **Navigation**: Go Router
- **Image Picker**: image_picker
- **Permissions**: permission_handler
- **Storage**: Shared Preferences, Hive
- **Network**: Dio, Retrofit

## 📋 주요 패키지

```yaml
dependencies:
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.3
  image_picker: ^1.0.4
  permission_handler: ^11.1.0
  cached_network_image: ^3.3.0
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  dio: ^5.4.0
```

## 🎯 사용 방법

### 게시물 생성
1. 하단 네비게이션에서 **"+"** 버튼 클릭
2. **"이미지 선택"** 버튼 클릭
3. **"카메라로 촬영"** 또는 **"갤러리에서 선택"** 선택
4. 권한 허용 후 이미지 선택
5. 문구 입력 및 설정 후 **"공유"** 버튼 클릭

### 권한 관리
- 앱 첫 실행 시 필요한 권한 자동 요청
- 권한 거부 시 설정으로 이동하는 안내 다이얼로그 표시

## 🐛 문제 해결

### 일반적인 문제들

1. **권한 오류**
   - 설정에서 앱 권한 확인
   - 앱 재설치 후 권한 재요청

2. **카메라가 켜지지 않음**
   - 카메라 권한 확인
   - 다른 앱에서 카메라 사용 중인지 확인

3. **갤러리 접근 오류**
   - 갤러리 권한 확인
   - Android 13+ 에서는 READ_MEDIA_IMAGES 권한 필요

## 🤝 기여하기

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 배포됩니다. 자세한 내용은 `LICENSE` 파일을 참조하세요.

## 📞 연락처

프로젝트 링크: [https://github.com/your-username/sns_app](https://github.com/your-username/sns_app)

---

**AI TOOL 개발자 모임** - 함께 성장하는 개발자 커뮤니티 🚀
