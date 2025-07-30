# E2E Tests with Playwright

이 디렉토리는 Playwright를 사용한 End-to-End 테스트를 포함합니다.

## 테스트 구조

```
e2e/
├── README.md           # 이 파일
├── example.spec.js     # 기본 테스트 예제
├── auth/               # 인증 관련 테스트
├── navigation/         # 네비게이션 테스트
├── posts/              # 게시물 관련 테스트
├── profile/            # 프로필 관련 테스트
└── utils/              # 테스트 유틸리티
```

## 테스트 실행 방법

### 모든 테스트 실행
```bash
npm run test:e2e
```

### 특정 브라우저에서 실행
```bash
npx playwright test --project=chromium
```

### UI 모드로 실행
```bash
npx playwright test --ui
```

### 디버그 모드로 실행
```bash
npx playwright test --debug
```

### 특정 테스트 파일 실행
```bash
npx playwright test example.spec.js
```

## 테스트 작성 가이드라인

### 1. 테스트 파일 명명 규칙
- `*.spec.js` 또는 `*.test.js` 확장자 사용
- 기능별로 디렉토리 분리

### 2. 테스트 구조
```javascript
const { test, expect } = require('@playwright/test');

test.describe('Feature Name', () => {
  test.beforeEach(async ({ page }) => {
    // 각 테스트 전 실행될 코드
  });

  test('should do something', async ({ page }) => {
    // 테스트 로직
  });
});
```

### 3. 페이지 객체 패턴 사용
```javascript
// e2e/utils/PageObjects.js
class LoginPage {
  constructor(page) {
    this.page = page;
    this.emailInput = page.locator('[data-testid="email-input"]');
    this.passwordInput = page.locator('[data-testid="password-input"]');
    this.loginButton = page.locator('[data-testid="login-button"]');
  }

  async login(email, password) {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.loginButton.click();
  }
}
```

### 4. 데이터 테스트 ID 사용
HTML 요소에 `data-testid` 속성을 추가하여 안정적인 선택자 사용:

```html
<button data-testid="login-button">로그인</button>
```

```javascript
await page.locator('[data-testid="login-button"]').click();
```

## CI/CD 설정

GitHub Actions에서 자동으로 테스트가 실행됩니다. 설정은 `.github/workflows/e2e-tests.yml`에서 확인할 수 있습니다.

## 테스트 결과

테스트 실행 후 다음 위치에서 결과를 확인할 수 있습니다:

- HTML 리포트: `playwright-report/`
- 스크린샷: `test-results/`
- 비디오: `test-results/`
- 트레이스: `test-results/` 