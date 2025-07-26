# 📱 Instagram Style SNS App - 설계문서

## 📋 목차
1. [프로젝트 개요](#프로젝트-개요)
2. [아키텍처 설계](#아키텍처-설계)
3. [기술 스택](#기술-스택)
4. [데이터 모델](#데이터-모델)
5. [UI/UX 설계](#uiux-설계)
6. [기능 명세](#기능-명세)
7. [API 설계](#api-설계)
8. [보안 설계](#보안-설계)
9. [테스트 전략](#테스트-전략)
10. [배포 전략](#배포-전략)
11. [퍼블리싱 가이드](#퍼블리싱-가이드)

---

## 🎯 프로젝트 개요

### 프로젝트명
**Instagram Style SNS App** - Flutter 기반 크로스 플랫폼 소셜 네트워킹 서비스

### 목표
- 인스타그램과 유사한 사용자 경험 제공
- Clean Architecture 기반 확장 가능한 구조
- 크로스 플랫폼 지원 (iOS, Android, Web)
- 실시간 소셜 기능 구현
- **앱스토어 및 플레이스토어 퍼블리싱 완료**

### 핵심 가치
- **사용자 중심**: 직관적이고 아름다운 UI/UX
- **성능**: 빠른 로딩과 부드러운 애니메이션
- **확장성**: 모듈화된 구조로 기능 추가 용이
- **보안**: 사용자 데이터 보호 및 개인정보 보안
- **배포 준비**: 퍼블리싱을 위한 완전한 준비

---

## 🏗️ 아키텍처 설계

### Clean Architecture 적용

```
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │   Pages     │ │  Widgets    │ │  Providers  │           │
│  └─────────────┘ └─────────────┘ └─────────────┘           │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                     Domain Layer                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │  Entities   │ │Repositories │ │  Use Cases  │           │
│  └─────────────┘ └─────────────┘ └─────────────┘           │
└─────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────┐
│                      Data Layer                             │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐           │
│  │ DataSources │ │   Models    │ │Repositories │           │
│  └─────────────┘ └─────────────┘ └─────────────┘           │
└─────────────────────────────────────────────────────────────┘
```

### SOLID 원칙 적용

#### 1. Single Responsibility Principle (SRP)
- 각 클래스는 하나의 책임만 가짐
- UI 로직과 비즈니스 로직 분리

#### 2. Open/Closed Principle (OCP)
- 확장에는 열려있고 수정에는 닫혀있음
- 인터페이스 기반 설계

#### 3. Liskov Substitution Principle (LSP)
- 하위 타입은 상위 타입을 대체 가능
- Repository 패턴 적용

#### 4. Interface Segregation Principle (ISP)
- 클라이언트는 사용하지 않는 인터페이스에 의존하지 않음
- 세분화된 인터페이스 설계

#### 5. Dependency Inversion Principle (DIP)
- 고수준 모듈은 저수준 모듈에 의존하지 않음
- 의존성 주입 패턴 적용

---

## 🛠️ 기술 스택

### Frontend
- **Framework**: Flutter 3.32.8
- **Language**: Dart 3.8.1
- **State Management**: Riverpod 2.4.9
- **UI Components**: Material Design 3
- **Navigation**: GoRouter 12.1.3

### Backend
- **Framework**: Node.js + Express.js
- **Database**: PostgreSQL (메인), Redis (캐시)
- **Authentication**: JWT + OAuth 2.0
- **File Storage**: AWS S3
- **Real-time**: Socket.io

### DevOps
- **CI/CD**: GitHub Actions
- **Container**: Docker
- **Cloud**: AWS (EC2, RDS, S3, CloudFront)
- **Monitoring**: Sentry, Firebase Analytics

### Testing
- **Unit Testing**: Flutter Test
- **Integration Testing**: Flutter Integration Test
- **E2E Testing**: Flutter Driver
- **API Testing**: Postman, Jest

### Publishing
- **iOS**: App Store Connect
- **Android**: Google Play Console
- **Code Signing**: Apple Developer Program, Google Play App Signing
- **Distribution**: TestFlight, Internal Testing

---

## 📊 데이터 모델

### Core Entities

#### User Entity
```dart
class User {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final String? profileImageUrl;
  final String? website;
  final bool isPrivate;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Statistics
  final int postsCount;
  final int followersCount;
  final int followingCount;
}
```

#### Post Entity
```dart
class Post {
  final String id;
  final String userId;
  final String? caption;
  final List<String> imageUrls;
  final List<String> hashtags;
  final Location? location;
  final PostType type; // image, video, carousel
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

#### Comment Entity
```dart
class Comment {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final String? parentCommentId; // For replies
  final int likesCount;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

#### Story Entity
```dart
class Story {
  final String id;
  final String userId;
  final String mediaUrl;
  final StoryType type; // image, video
  final List<String>? mentions;
  final List<String>? hashtags;
  final DateTime createdAt;
  final DateTime expiresAt; // 24 hours after creation
}
```

### Database Schema

#### Users Table
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  username VARCHAR(30) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(100),
  bio TEXT,
  profile_image_url VARCHAR(500),
  website VARCHAR(255),
  is_private BOOLEAN DEFAULT FALSE,
  is_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Posts Table
```sql
CREATE TABLE posts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  caption TEXT,
  location_name VARCHAR(255),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  type VARCHAR(20) DEFAULT 'image',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

#### Post_Media Table
```sql
CREATE TABLE post_media (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  post_id UUID REFERENCES posts(id) ON DELETE CASCADE,
  media_url VARCHAR(500) NOT NULL,
  media_type VARCHAR(20) NOT NULL,
  order_index INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🎨 UI/UX 설계

### Design System

#### Color Palette
```dart
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF0095F6);
  static const Color primaryDark = Color(0xFF00376B);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF8E8E93);
  static const Color secondaryLight = Color(0xFFC7C7CC);
  
  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFFAFAFA);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF262626);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textTertiary = Color(0xFFC7C7CC);
  
  // Status Colors
  static const Color success = Color(0xFF34C759);
  static const Color error = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFF9500);
}
```

#### Typography
```dart
class AppTypography {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );
  
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  );
}
```

### Screen Designs

#### 1. Feed Screen
- **Layout**: Vertical scrolling feed
- **Components**: 
  - Story highlights at top
  - Post cards with image, caption, actions
  - Infinite scroll pagination
- **Interactions**: Like, comment, share, save

#### 2. Explore Screen
- **Layout**: Grid layout with search
- **Components**:
  - Search bar
  - Trending hashtags
  - Suggested accounts
  - Photo grid
- **Interactions**: Search, follow, like

#### 3. Create Post Screen
- **Layout**: Step-by-step wizard
- **Components**:
  - Image picker
  - Filter options
  - Caption editor
  - Location picker
- **Interactions**: Upload, edit, share

#### 4. Profile Screen
- **Layout**: Header + grid
- **Components**:
  - Profile header with stats
  - Bio and website
  - Posts grid
  - Settings menu
- **Interactions**: Edit profile, follow/unfollow

---

## ⚙️ 기능 명세

### Core Features

#### 1. Authentication
- **Sign Up**: Email, username, password
- **Sign In**: Username/email + password
- **OAuth**: Google, Apple, Facebook
- **Password Reset**: Email verification
- **Account Verification**: Email/SMS verification

#### 2. Feed
- **Post Display**: Image/video with caption
- **Like System**: Heart button with animation
- **Comment System**: Nested comments
- **Share**: Direct message, external apps
- **Save**: Bookmark posts
- **Infinite Scroll**: Pagination

#### 3. Stories
- **Create Story**: Photo/video upload
- **Story Highlights**: Permanent stories
- **Story Viewing**: Tap to advance
- **Story Interactions**: Reply, like, share
- **Story Expiration**: 24-hour auto-delete

#### 4. Explore
- **Search**: Users, hashtags, locations
- **Trending**: Popular posts and hashtags
- **Discover**: Suggested content
- **Categories**: Food, travel, fashion, etc.

#### 5. Create Post
- **Media Upload**: Multiple images/videos
- **Filters**: Instagram-style filters
- **Editing**: Crop, rotate, adjust
- **Caption**: Text with hashtags/mentions
- **Location**: Add location tag
- **Privacy**: Public/private posts

#### 6. Profile
- **Profile Info**: Bio, website, stats
- **Posts Grid**: User's posts display
- **Settings**: Privacy, notifications, security
- **Edit Profile**: Change info and avatar

### Advanced Features

#### 1. Direct Messages
- **Chat Interface**: Real-time messaging
- **Media Sharing**: Photos, videos, stories
- **Group Chats**: Multiple participants
- **Message Status**: Sent, delivered, read

#### 2. Live Streaming
- **Go Live**: Start live video
- **Viewer Count**: Real-time statistics
- **Comments**: Live chat
- **Reactions**: Heart, fire, etc.

#### 3. Shopping
- **Product Tags**: Tag products in posts
- **Shopping Bag**: Save items
- **Checkout**: In-app purchase
- **Order Tracking**: Purchase history

---

## 🔌 API 설계

### RESTful API Endpoints

#### Authentication
```
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/logout
POST   /api/auth/refresh
POST   /api/auth/forgot-password
POST   /api/auth/reset-password
```

#### Users
```
GET    /api/users/profile
PUT    /api/users/profile
GET    /api/users/:id
GET    /api/users/:id/posts
GET    /api/users/:id/followers
GET    /api/users/:id/following
POST   /api/users/:id/follow
DELETE /api/users/:id/follow
```

#### Posts
```
GET    /api/posts
POST   /api/posts
GET    /api/posts/:id
PUT    /api/posts/:id
DELETE /api/posts/:id
POST   /api/posts/:id/like
DELETE /api/posts/:id/like
GET    /api/posts/:id/comments
POST   /api/posts/:id/comments
```

#### Stories
```
GET    /api/stories
POST   /api/stories
GET    /api/stories/:id
DELETE /api/stories/:id
POST   /api/stories/:id/view
```

#### Search
```
GET    /api/search/users?q=:query
GET    /api/search/posts?q=:query
GET    /api/search/hashtags?q=:query
```

### WebSocket Events

#### Real-time Features
```javascript
// Connection
socket.emit('join', { userId: 'user_id' });

// Post interactions
socket.emit('like_post', { postId: 'post_id' });
socket.on('post_liked', (data) => {});

// Comments
socket.emit('comment_post', { postId: 'post_id', content: 'comment' });
socket.on('new_comment', (data) => {});

// Stories
socket.emit('view_story', { storyId: 'story_id' });
socket.on('story_viewed', (data) => {});

// Direct messages
socket.emit('send_message', { recipientId: 'user_id', content: 'message' });
socket.on('new_message', (data) => {});
```

---

## 🔒 보안 설계

### Authentication & Authorization

#### JWT Token Structure
```json
{
  "header": {
    "alg": "HS256",
    "typ": "JWT"
  },
  "payload": {
    "sub": "user_id",
    "username": "username",
    "iat": 1516239022,
    "exp": 1516242622,
    "refresh_token": "refresh_token_id"
  }
}
```

#### Security Measures
- **Password Hashing**: bcrypt with salt
- **Rate Limiting**: API 요청 제한
- **CORS**: Cross-origin resource sharing 설정
- **Input Validation**: 모든 입력 데이터 검증
- **SQL Injection Prevention**: Parameterized queries
- **XSS Protection**: Content Security Policy

### Data Protection

#### GDPR Compliance
- **Data Minimization**: 최소한의 데이터 수집
- **User Consent**: 명시적 동의
- **Right to Delete**: 데이터 삭제 권리
- **Data Portability**: 데이터 이전 권리

#### Privacy Features
- **Private Accounts**: 비공개 계정 설정
- **Block Users**: 사용자 차단
- **Report Content**: 부적절한 콘텐츠 신고
- **Data Encryption**: 저장 및 전송 데이터 암호화

---

## 🧪 테스트 전략

### Testing Pyramid

#### 1. Unit Tests (70%)
```dart
// Example: Post Entity Test
void main() {
  group('Post Entity', () {
    test('should create post with required fields', () {
      final post = Post(
        id: '1',
        userId: 'user1',
        caption: 'Test caption',
        imageUrls: ['image1.jpg'],
        createdAt: DateTime.now(),
      );
      
      expect(post.id, equals('1'));
      expect(post.userId, equals('user1'));
      expect(post.caption, equals('Test caption'));
    });
  });
}
```

#### 2. Integration Tests (20%)
```dart
// Example: Post Repository Test
void main() {
  group('PostRepository Integration Tests', () {
    late PostRepository repository;
    late MockPostDataSource dataSource;
    
    setUp(() {
      dataSource = MockPostDataSource();
      repository = PostRepositoryImpl(dataSource);
    });
    
    test('should return posts when data source is successful', () async {
      // Arrange
      when(dataSource.getPosts()).thenAnswer((_) async => mockPosts);
      
      // Act
      final result = await repository.getPosts();
      
      // Assert
      expect(result, equals(Right(mockPosts)));
    });
  });
}
```

#### 3. E2E Tests (10%)
```dart
// Example: Feed Screen E2E Test
void main() {
  group('Feed Screen E2E Tests', () {
    late FlutterDriver driver;
    
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDownAll(() async {
      await driver.close();
    });
    
    test('should display posts in feed', () async {
      // Navigate to feed
      await driver.tap(find.byValueKey('feed_tab'));
      
      // Verify posts are displayed
      expect(await driver.getText(find.byValueKey('post_1')), isNotEmpty);
    });
  });
}
```

### Test Coverage Goals
- **Unit Tests**: 90% 이상
- **Integration Tests**: 80% 이상
- **E2E Tests**: 주요 사용자 시나리오 100%

---

## 🚀 배포 전략

### CI/CD Pipeline

#### GitHub Actions Workflow
```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk

  build-android:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter build appbundle
      - uses: actions/upload-artifact@v3

  build-ios:
    needs: test
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter build ios --release --no-codesign
      - uses: actions/upload-artifact@v3

  deploy:
    needs: [build-android, build-ios]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      - run: echo "Deploy to production"
```

### Environment Strategy

#### Development
- **Database**: Local PostgreSQL
- **Storage**: Local file system
- **API**: Local development server
- **Features**: Debug mode, hot reload

#### Staging
- **Database**: AWS RDS (staging)
- **Storage**: AWS S3 (staging bucket)
- **API**: AWS EC2 (staging instance)
- **Features**: Production-like environment

#### Production
- **Database**: AWS RDS (production)
- **Storage**: AWS S3 (production bucket)
- **API**: AWS EC2 (production instances)
- **CDN**: AWS CloudFront
- **Monitoring**: Sentry, Firebase Analytics

### Release Strategy

#### Versioning
- **Semantic Versioning**: MAJOR.MINOR.PATCH
- **Example**: 1.0.0, 1.1.0, 1.1.1

#### Release Process
1. **Feature Development**: develop 브랜치
2. **Testing**: staging 환경에서 테스트
3. **Release Candidate**: main 브랜치로 merge
4. **Production Deployment**: 자동 배포
5. **Monitoring**: 성능 및 오류 모니터링

---

## 📱 퍼블리싱 가이드

### 앱 퍼블리싱 준비사항

#### 1. 앱 정보 설정

##### pubspec.yaml 설정
```yaml
name: sns_app
description: "Instagram Style SNS App - Share your moments with the world"
version: 1.0.0+1
publish_to: 'none'

environment:
  sdk: ^3.8.1

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  # 추가 의존성들...

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

##### 앱 아이콘 설정
```dart
// android/app/src/main/res/mipmap-*/ic_launcher.png
// ios/Runner/Assets.xcassets/AppIcon.appiconset/
// 다양한 해상도별 아이콘 파일 필요
```

#### 2. Android 퍼블리싱 (Google Play Store)

##### Android 설정 파일

###### android/app/build.gradle.kts
```kotlin
android {
    namespace = "com.example.sns_app"
    compileSdk = 34
    
    defaultConfig {
        applicationId = "com.example.sns_app"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
        
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }
    
    buildTypes {
        release {
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("release")
        }
    }
    
    signingConfigs {
        create("release") {
            keyAlias = System.getenv("KEY_ALIAS")
            keyPassword = System.getenv("KEY_PASSWORD")
            storeFile = file(System.getenv("KEYSTORE_PATH"))
            storePassword = System.getenv("STORE_PASSWORD")
        }
    }
}
```

###### android/app/src/main/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <application
        android:label="SNS App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:allowBackup="true"
        android:fullBackupContent="true"
        android:dataExtractionRules="@xml/data_extraction_rules">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
            
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    
    <!-- 권한 설정 -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
</manifest>
```

##### Google Play Console 설정

###### 앱 정보
- **앱 이름**: SNS App
- **간단한 설명**: Instagram 스타일 소셜 네트워킹 앱
- **상세 설명**: 
```
Instagram 스타일의 소셜 네트워킹 앱입니다.

주요 기능:
• 사진과 비디오 공유
• 스토리 기능
• 실시간 피드
• 사용자 검색 및 팔로우
• 댓글 및 좋아요
• 개인 메시징
• 위치 태그

Clean Architecture 기반으로 개발되어 안정적이고 확장 가능한 구조를 가지고 있습니다.
```

###### 앱 카테고리
- **주 카테고리**: 소셜
- **보조 카테고리**: 사진/비디오

###### 콘텐츠 등급
- **연령 등급**: 3세 이상
- **콘텐츠 설명**: 사용자 생성 콘텐츠 포함

###### 개인정보처리방침
```
개인정보처리방침

1. 수집하는 개인정보
- 계정 정보 (이메일, 사용자명)
- 프로필 정보 (이름, 생년월일, 프로필 사진)
- 게시물 및 댓글
- 위치 정보 (선택적)

2. 개인정보의 이용
- 서비스 제공 및 개선
- 사용자 경험 향상
- 보안 및 사기 방지

3. 개인정보의 보호
- 암호화 저장 및 전송
- 접근 권한 제한
- 정기적인 보안 점검

4. 사용자 권리
- 개인정보 조회, 수정, 삭제
- 동의 철회
- 데이터 이전

5. 문의처
- 이메일: privacy@snsapp.com
- 전화: 02-1234-5678
```

#### 3. iOS 퍼블리싱 (App Store)

##### iOS 설정 파일

###### ios/Runner/Info.plist
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleDisplayName</key>
    <string>SNS App</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>sns_app</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>$(FLUTTER_BUILD_NAME)</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleVersion</key>
    <string>$(FLUTTER_BUILD_NUMBER)</string>
    <key>LSRequiresIPhoneOS</key>
    <true/>
    <key>UILaunchStoryboardName</key>
    <string>LaunchScreen</string>
    <key>UIMainStoryboardFile</key>
    <string>Main</string>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>
    <key>UISupportedInterfaceOrientations~ipad</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationPortraitUpsideDown</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>
    <key>UIViewControllerBasedStatusBarAppearance</key>
    <false/>
    <key>CADisableMinimumFrameDurationOnPhone</key>
    <true/>
    <key>UIApplicationSupportsIndirectInputEvents</key>
    <true/>
    
    <!-- 권한 설명 -->
    <key>NSCameraUsageDescription</key>
    <string>사진과 비디오를 촬영하여 공유하기 위해 카메라 접근 권한이 필요합니다.</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>갤러리에서 사진을 선택하여 공유하기 위해 사진 라이브러리 접근 권한이 필요합니다.</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>게시물에 위치 정보를 추가하기 위해 위치 접근 권한이 필요합니다.</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>비디오 촬영 시 오디오를 녹음하기 위해 마이크 접근 권한이 필요합니다.</string>
</dict>
</plist>
```

###### ios/Runner.xcodeproj/project.pbxproj
```
// Bundle Identifier 설정
PRODUCT_BUNDLE_IDENTIFIER = com.example.snsApp;
```

##### App Store Connect 설정

###### 앱 정보
- **앱 이름**: SNS App
- **부제목**: Instagram 스타일 소셜 네트워킹
- **키워드**: 소셜, 사진, 비디오, 공유, 커뮤니티
- **설명**:
```
Instagram 스타일의 소셜 네트워킹 앱

📸 사진과 비디오 공유
• 고품질 이미지 및 비디오 업로드
• 다양한 필터와 편집 도구
• 멀티미디어 캐러셀 지원

📱 스토리 기능
• 24시간 임시 스토리
• 스토리 하이라이트
• 인터랙티브 스티커와 텍스트

🔍 탐색 및 검색
• 해시태그 기반 검색
• 사용자 및 위치 검색
• 트렌딩 콘텐츠 발견

💬 소셜 기능
• 댓글 및 답글
• 좋아요 및 북마크
• 실시간 알림
• 개인 메시징

👤 프로필 관리
• 커스터마이징 가능한 프로필
• 팔로워/팔로잉 관리
• 개인정보 설정

🔒 보안 및 개인정보
• 안전한 인증 시스템
• 개인정보 보호
• 콘텐츠 신고 기능

Clean Architecture 기반으로 개발되어 안정적이고 확장 가능한 구조를 가지고 있습니다.
```

###### 앱 카테고리
- **주 카테고리**: 소셜 네트워킹
- **보조 카테고리**: 사진 및 비디오

###### 연령 등급
- **연령 등급**: 4+
- **콘텐츠 설명**: 사용자 생성 콘텐츠, 소셜 네트워킹

#### 4. 빌드 및 서명

##### Android 빌드
```bash
# Release APK 빌드
flutter build apk --release

# App Bundle 빌드 (권장)
flutter build appbundle --release

# 서명된 APK 빌드
flutter build apk --release --split-per-abi
```

##### iOS 빌드
```bash
# Release 빌드
flutter build ios --release

# Archive 생성 (Xcode에서)
# Product > Archive
```

##### 코드 서명

###### Android 서명
```bash
# 키스토어 생성
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# 서명 설정
# android/key.properties 파일 생성
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=<location of the keystore file>
```

###### iOS 서명
- Apple Developer Program 가입
- App Store Connect에서 앱 등록
- Xcode에서 자동 서명 설정
- Provisioning Profile 설정

#### 5. 테스트 배포

##### Android 테스트
- **Internal Testing**: 개발팀 내부 테스트
- **Closed Testing**: 제한된 사용자 그룹
- **Open Testing**: 공개 베타 테스트

##### iOS 테스트
- **TestFlight**: Apple의 베타 테스트 플랫폼
- **Internal Testing**: 개발팀 내부
- **External Testing**: 외부 사용자

#### 6. 스토어 심사 준비

##### 필수 준비사항
- [x] 앱 아이콘 (다양한 해상도)
- [x] 스크린샷 (다양한 디바이스)
- [x] 앱 설명 및 키워드
- [x] 개인정보처리방침
- [x] 사용자 가이드
- [x] 연락처 정보
- [x] 콘텐츠 등급
- [x] 앱 권한 설명

##### 심사 체크리스트
- [ ] 앱이 정상적으로 실행됨
- [ ] 모든 기능이 작동함
- [ ] 크래시나 버그 없음
- [ ] 개인정보 보호 준수
- [ ] 적절한 콘텐츠 필터링
- [ ] 사용자 신고 기능
- [ ] 접근성 지원
- [ ] 성능 최적화

#### 7. 출시 후 관리

##### 모니터링
- **앱 성능**: Firebase Performance
- **오류 추적**: Sentry, Firebase Crashlytics
- **사용자 분석**: Firebase Analytics
- **스토어 리뷰**: Google Play Console, App Store Connect

##### 업데이트 전략
- **정기 업데이트**: 월 1-2회
- **핫픽스**: 긴급 버그 수정
- **기능 업데이트**: 새로운 기능 추가
- **성능 개선**: 최적화 및 안정성 향상

---

## 📈 성능 최적화

### Frontend Optimization
- **Image Optimization**: WebP format, lazy loading
- **Code Splitting**: 필요한 코드만 로드
- **Caching**: HTTP 캐시, 앱 캐시
- **Bundle Size**: Tree shaking, minification

### Backend Optimization
- **Database Indexing**: 쿼리 성능 최적화
- **Caching**: Redis 캐시 레이어
- **CDN**: 정적 자산 전송 최적화
- **Load Balancing**: 트래픽 분산

### Monitoring & Analytics
- **Performance Monitoring**: Firebase Performance
- **Error Tracking**: Sentry
- **User Analytics**: Firebase Analytics
- **Crash Reporting**: Firebase Crashlytics

---

## 🔮 향후 계획

### Phase 1 (MVP) - 3개월
- [x] 기본 인증 시스템
- [x] 피드 및 포스트 기능
- [x] 프로필 관리
- [ ] 기본 스토리 기능
- [x] **앱스토어/플레이스토어 퍼블리싱 준비**

### Phase 2 (Enhanced) - 6개월
- [ ] 실시간 메시징
- [ ] 라이브 스트리밍
- [ ] 고급 검색 기능
- [ ] 쇼핑 기능
- [ ] **스토어 최적화 및 마케팅**

### Phase 3 (Advanced) - 12개월
- [ ] AI 기반 콘텐츠 추천
- [ ] AR 필터 및 효과
- [ ] 크리에이터 도구
- [ ] 비즈니스 계정 기능
- [ ] **글로벌 확장**

---

## 📞 연락처

- **GitHub Repository**: [https://github.com/bskang7777/sns_app](https://github.com/bskang7777/sns_app)
- **Documentation**: [https://github.com/bskang7777/sns_app/docs](https://github.com/bskang7777/sns_app/docs)
- **Issues**: [https://github.com/bskang7777/sns_app/issues](https://github.com/bskang7777/sns_app/issues)
- **App Store**: [링크 예정]
- **Google Play**: [링크 예정]

---

*이 문서는 지속적으로 업데이트됩니다. 최신 버전은 GitHub 저장소에서 확인하세요.* 