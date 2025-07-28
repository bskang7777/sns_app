# SNS App - Flutter Social Network Application

## 🎉 Latest Updates (v1.2.0)

### ✨ New Features
- **🌐 Chrome Web Support**: Full web browser compatibility
- **🎬 AI YouTube Videos**: 17 curated AI videos with interactive playback
- **✨ Enhanced Animations**: Pulse animations, smooth transitions, and interactive icons
- **🔍 Smart Search**: Video search and category filtering
- **📱 Multi-Platform**: Android, Windows, and Web support

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
