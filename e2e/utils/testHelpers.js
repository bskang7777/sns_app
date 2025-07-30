/**
 * Test Helper Functions
 * 테스트에서 자주 사용되는 유틸리티 함수들
 */

const { expect } = require('@playwright/test');

/**
 * 사용자 로그인 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {string} email 
 * @param {string} password 
 */
async function loginUser(page, email, password) {
  await page.goto('/login');
  await page.locator('[data-testid="email-input"]').fill(email);
  await page.locator('[data-testid="password-input"]').fill(password);
  await page.locator('[data-testid="login-button"]').click();
  
  // 로그인 성공 확인
  await expect(page).toHaveURL(/.*\/home/);
}

/**
 * 테스트 데이터 생성 헬퍼
 * @param {string} prefix 
 * @returns {string}
 */
function generateTestData(prefix = 'test') {
  const timestamp = Date.now();
  const random = Math.random().toString(36).substring(7);
  return `${prefix}_${timestamp}_${random}`;
}

/**
 * 스크린샷 비교 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {string} name 
 * @param {Object} options 
 */
async function takeScreenshot(page, name, options = {}) {
  const defaultOptions = {
    fullPage: true,
    path: `test-results/${name}.png`
  };
  
  await page.screenshot({ ...defaultOptions, ...options });
}

/**
 * 네트워크 요청 대기 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {string} urlPattern 
 * @param {number} timeout 
 */
async function waitForNetworkRequest(page, urlPattern, timeout = 10000) {
  await page.waitForResponse(
    response => response.url().includes(urlPattern),
    { timeout }
  );
}

/**
 * 요소가 로드될 때까지 대기 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {string} selector 
 * @param {number} timeout 
 */
async function waitForElement(page, selector, timeout = 10000) {
  await page.waitForSelector(selector, { timeout });
}

/**
 * 모바일 뷰포트 설정 헬퍼
 * @param {import('@playwright/test').Page} page 
 */
async function setMobileViewport(page) {
  await page.setViewportSize({ width: 375, height: 667 });
}

/**
 * 데스크톱 뷰포트 설정 헬퍼
 * @param {import('@playwright/test').Page} page 
 */
async function setDesktopViewport(page) {
  await page.setViewportSize({ width: 1920, height: 1080 });
}

/**
 * 테스트 데이터 정리 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {Array} testData 
 */
async function cleanupTestData(page, testData) {
  // 테스트 데이터 정리 로직
  // 예: 생성된 게시물 삭제, 테스트 계정 정리 등
  console.log('Cleaning up test data:', testData);
}

/**
 * 성능 측정 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {string} metricName 
 */
async function measurePerformance(page, metricName) {
  const startTime = Date.now();
  
  return {
    start: () => startTime,
    end: () => {
      const endTime = Date.now();
      const duration = endTime - startTime;
      console.log(`${metricName} took ${duration}ms`);
      return duration;
    }
  };
}

/**
 * 에러 스크린샷 캡처 헬퍼
 * @param {import('@playwright/test').Page} page 
 * @param {string} testName 
 */
async function captureErrorScreenshot(page, testName) {
  try {
    await page.screenshot({ 
      path: `test-results/error_${testName}_${Date.now()}.png`,
      fullPage: true 
    });
  } catch (error) {
    console.error('Failed to capture error screenshot:', error);
  }
}

module.exports = {
  loginUser,
  generateTestData,
  takeScreenshot,
  waitForNetworkRequest,
  waitForElement,
  setMobileViewport,
  setDesktopViewport,
  cleanupTestData,
  measurePerformance,
  captureErrorScreenshot
}; 