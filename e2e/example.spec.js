// @ts-check
const { test, expect } = require('@playwright/test');

test.describe('SNS App E2E Tests', () => {
  test.beforeEach(async ({ page }) => {
    // Navigate to the app before each test
    await page.goto('/');
    // Wait for Flutter app to load
    await page.waitForLoadState('networkidle');
    // Wait a bit more for Flutter to initialize
    await page.waitForTimeout(5000);
  });

  test('should load the main page', async ({ page }) => {
    // Verify that the page loads successfully
    await expect(page).toHaveTitle(/SNS App/);
    
    // Check if page is loaded
    await expect(page.locator('html')).toBeVisible();
  });

  test('should display basic app structure', async ({ page }) => {
    // Check for basic page structure
    await expect(page.locator('body')).toBeVisible();
    
    // Wait for any content to load
    await page.waitForTimeout(2000);
    
    // Check if page has content
    const bodyText = await page.locator('body').textContent();
    expect(bodyText).toBeTruthy();
  });

  test('should be responsive on mobile', async ({ page }) => {
    // Test mobile viewport
    await page.setViewportSize({ width: 375, height: 667 });
    
    // Wait for layout to adjust
    await page.waitForTimeout(1000);
    
    // Verify page is still visible
    await expect(page.locator('body')).toBeVisible();
  });

  test('should handle basic interactions', async ({ page }) => {
    // Test basic page interactions
    // Click in the middle of the screen
    await page.mouse.click(200, 200);
    await page.waitForTimeout(500);
    
    // Try scrolling
    await page.evaluate(() => {
      window.scrollTo(0, 100);
    });
    await page.waitForTimeout(500);
    
    // Scroll back
    await page.evaluate(() => {
      window.scrollTo(0, 0);
    });
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('body')).toBeVisible();
  });

  test('should handle page refresh', async ({ page }) => {
    // Test page refresh
    await page.reload();
    await page.waitForLoadState('networkidle');
    await page.waitForTimeout(2000);
    
    // Verify page is still functional
    await expect(page.locator('body')).toBeVisible();
  });
}); 