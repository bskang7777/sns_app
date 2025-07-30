# SNS App - Flutter Social Network Application

## 🎉 Latest Updates (v1.2.0)

### ✨ New Features
- **🌐 Chrome Web Support**: Full web browser compatibility
- **🎬 AI YouTube Videos**: 17 curated AI videos with interactive playback
- **✨ Enhanced Animations**: Pulse animations, smooth transitions, and interactive icons
- **🔍 Smart Search**: Video search and category filtering
- **📱 Multi-Platform**: Android, Windows, and Web support
- **🤖 Playwright MCP Integration**: Automated browser testing and web automation

### 🚀 Performance Improvements
- Web-optimized YouTube URL handling
- Enhanced error handling and user feedback
- Improved animation performance
- Responsive UI/UX design

## 🎯 Key Features

### 📸 Image Management
- **Camera Integration**: Direct camera access with permission handling
- **Gallery Access**: Browse and select images from device gallery
- **Real-time Preview**: Instant image preview with clear option
- **Permission Management**: Automatic permission requests with user guidance

### 🎬 YouTube Video Integration
- **17 AI Videos**: Curated collection of AI-related content
- **Interactive Playback**: Pulse animation play buttons
- **Category Filtering**: Filter videos by category
- **Smart Search**: Search through video titles and descriptions
- **External Launch**: Opens videos in YouTube app or browser

### 🎨 UI/UX Enhancements
- **Modern Icons**: Redesigned with background containers and animations
- **Smooth Animations**: Pulse, rotation, and scale effects
- **Responsive Design**: Adapts to different screen sizes
- **Interactive Feedback**: Visual feedback for all user actions

### 🔐 Permission Management
- **Camera Permissions**: Automatic camera access requests
- **Storage Permissions**: Gallery access with proper permissions
- **User Guidance**: Clear permission request dialogs
- **Fallback Handling**: Graceful handling of permission denials

## 📦 Installation & Execution

### Prerequisites
```bash
# Flutter SDK 설치
flutter --version

# 의존성 설치
flutter pub get
```

### Playwright MCP 설치 및 설정

#### 1. Playwright MCP 서버 설치
```bash
# Playwright MCP 서버 전역 설치
npm install -g @playwright/mcp

# Playwright 브라우저 설치
npx playwright install
```

#### 2. MCP 설정 파일 생성
프로젝트 루트에 `mcp_config.json` 파일을 생성하고 다음 내용을 추가:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp"],
      "env": {}
    }
  }
}
```

#### 3. MCP 서버 등록 확인
```bash
# MCP 서버 상태 확인
npx @playwright/mcp --help

# 브라우저 설치 확인
npx playwright install --dry-run
```

#### 4. MCP 클라이언트에서 사용
MCP 클라이언트에서 다음과 같은 기능들을 사용할 수 있습니다:

- **웹 자동화**: 브라우저 제어, 페이지 스크린샷, 요소 상호작용
- **테스트 자동화**: 웹 애플리케이션 자동 테스트
- **데이터 수집**: 웹 페이지에서 데이터 추출
- **UI 테스트**: 사용자 인터페이스 자동화 테스트

#### 5. 설치 확인 및 테스트
```bash
# 간단한 테스트 실행
node simple_test.js

# 직접 MCP 서버 테스트
npx @playwright/mcp --help
```

#### 6. 문제 해결
만약 `npx` 명령어 관련 오류가 발생하는 경우:
```bash
# Node.js 환경 확인
node --version
npm --version
npx --version

# 대안: npm을 통해 실행
npm exec @playwright/mcp -- --help
```

### Quick Start
```bash
# 개발 모드 실행
flutter run

# 웹 서버 모드 (Chrome 지원)
flutter run -d web-server --web-port 8080

# 특정 디바이스에서 실행
flutter run -d chrome    # Chrome 브라우저
flutter run -d edge      # Edge 브라우저
flutter run -d windows   # Windows 데스크톱
```

## 🚀 Deployment

### Android APK
```bash
# 릴리즈 APK 빌드
flutter build apk --release

# APK 위치: build/app/outputs/flutter-apk/app-release.apk
```

### Windows Executable
```bash
# Windows 실행파일 빌드
flutter build windows --release

# 실행파일 위치: build/windows/runner/Release/
```

### Web Deployment
```bash
# 웹 빌드
flutter build web --release

# 웹 파일 위치: build/web/
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   ├── models/
│   │   └── youtube_video.dart
│   ├── services/
│   │   └── youtube_service.dart
│   └── utils/
│       └── permission_utils.dart
├── presentation/
│   ├── pages/
│   │   ├── create_post_page.dart
│   │   ├── feed_page.dart
│   │   ├── profile_page.dart
│   │   └── youtube_videos_page.dart
│   └── widgets/
└── main.dart
```

## 🛠 Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **UI Components**: Material Design 3
- **Image Handling**: image_picker, cached_network_image
- **Video Integration**: url_launcher
- **Permissions**: permission_handler
- **E2E Testing**: Playwright
- **CI/CD**: GitHub Actions

## 🧪 E2E Testing with Playwright

### 설치 및 설정
```bash
# Playwright 설치
npm install --save-dev @playwright/test

# 브라우저 설치
npx playwright install
```

### 테스트 실행
```bash
# 모든 E2E 테스트 실행
npm run test:e2e

# UI 모드로 테스트 실행
npm run test:e2e:ui

# 디버그 모드로 테스트 실행
npm run test:e2e:debug

# 특정 브라우저에서 테스트 실행
npm run test:e2e:chrome
npm run test:e2e:firefox
npm run test:e2e:safari
npm run test:e2e:mobile

# 테스트 리포트 확인
npm run test:e2e:report
```

### 테스트 구조
```
e2e/
├── README.md           # 테스트 가이드
├── example.spec.js     # 기본 테스트 예제
├── auth/               # 인증 관련 테스트
├── navigation/         # 네비게이션 테스트
├── posts/              # 게시물 관련 테스트
├── profile/            # 프로필 관련 테스트
└── utils/              # 테스트 유틸리티
    ├── PageObjects.js  # 페이지 객체 모델
    └── testHelpers.js  # 테스트 헬퍼 함수
```

### CI/CD Integration
- GitHub Actions에서 자동 테스트 실행
- 크로스 브라우저 테스트 (Chrome, Firefox, Safari, Mobile)
- 테스트 결과 리포트 자동 생성
- 실패 시 스크린샷 및 비디오 캡처

## 📦 Key Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.3
  image_picker: ^1.0.4
  permission_handler: ^11.1.0
  url_launcher: ^6.2.1
  cached_network_image: ^3.3.0
```

## 🎮 Usage

### 📱 Mobile Features
1. **Camera Access**: Tap camera icon to take photos
2. **Gallery Selection**: Tap gallery icon to browse images
3. **Post Creation**: Add images and text to create posts
4. **Video Playback**: Watch AI videos with interactive controls

### 🌐 Web Features
1. **Browser Compatibility**: Works on Chrome, Edge, and other browsers
2. **Responsive Design**: Adapts to different screen sizes
3. **External Links**: YouTube videos open in new tabs
4. **Smooth Animations**: All animations work perfectly in web

### 🖥️ Desktop Features
1. **Native Performance**: Full desktop application experience
2. **Window Management**: Proper window sizing and positioning
3. **Keyboard Navigation**: Full keyboard support
4. **System Integration**: Native desktop integration

## 🔧 Troubleshooting

### Common Issues

#### Permission Errors
```bash
# Android 권한 확인
flutter doctor --android-licenses

# iOS 권한 확인 (macOS에서만)
flutter doctor --ios-licenses
```

#### Build Errors
```bash
# 클린 빌드
flutter clean
flutter pub get
flutter build apk --release
```

#### Web Issues
```bash
# 웹 서버 모드로 실행
flutter run -d web-server --web-port 8080

# 브라우저에서 http://localhost:8080 접속
```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21
- Target SDK: 34
- Permissions: Camera, Storage

#### iOS
- Minimum iOS: 12.0
- Permissions: Camera, Photo Library

#### Windows
- Windows 10 SDK
- Visual Studio 2019 or later

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- **Developer**: AI Assistant
- **Project**: SNS App
- **Version**: v1.2.0
- **Last Updated**: December 2024

---

## 🎯 Development Roadmap

### ✅ Completed (v1.2.0)
- [x] Camera and gallery integration
- [x] YouTube video integration
- [x] Web browser support
- [x] Enhanced animations
- [x] Multi-platform deployment

### 🚧 Planned (v1.3.0)
- [ ] User authentication
- [ ] Real-time messaging
- [ ] Push notifications
- [ ] Advanced video features
- [ ] Social sharing

### 🔮 Future (v2.0.0)
- [ ] AI-powered content recommendations
- [ ] Advanced image editing
- [ ] Video creation tools
- [ ] Community features
- [ ] Monetization options
