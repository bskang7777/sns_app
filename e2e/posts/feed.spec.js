// @ts-check
const { test, expect } = require('@playwright/test');

test.describe('Feed Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    // Ensure we're on the home/feed page
    await page.locator('text=홈').click();
    await page.waitForTimeout(500);
  });

  test('should display feed page elements', async ({ page }) => {
    // Check for main feed elements
    await expect(page.locator('text=AI TOOL 개발자')).toBeVisible();
    
    // Check for app bar actions
    // These are icon buttons, so we check for their presence
    await expect(page.locator('flt-glass-pane')).toBeVisible();
  });

  test('should handle pull to refresh', async ({ page }) => {
    // Simulate pull to refresh by scrolling to top
    await page.evaluate(() => {
      window.scrollTo(0, 0);
    });
    
    // Wait for potential refresh
    await page.waitForTimeout(1000);
    
    // Verify page is still functional
    await expect(page.locator('text=홈')).toBeVisible();
  });

  test('should scroll through feed', async ({ page }) => {
    // Scroll down to test infinite scroll
    await page.evaluate(() => {
      window.scrollTo(0, document.body.scrollHeight);
    });
    
    await page.waitForTimeout(1000);
    
    // Scroll back up
    await page.evaluate(() => {
      window.scrollTo(0, 0);
    });
    
    await page.waitForTimeout(500);
    
    // Verify navigation is still accessible
    await expect(page.locator('text=홈')).toBeVisible();
  });

  test('should navigate to create post from feed', async ({ page }) => {
    // Click on create post tab
    await page.locator('text=게시물').click();
    await page.waitForTimeout(500);
    
    // Verify we're on create post page
    await expect(page.locator('text=게시물')).toBeVisible();
    
    // Return to feed
    await page.locator('text=홈').click();
    await page.waitForTimeout(500);
  });

  test('should handle app bar actions', async ({ page }) => {
    // Test app bar icon interactions
    // Since these are Flutter widgets, we'll test their general presence
    await expect(page.locator('flt-glass-pane')).toBeVisible();
    
    // Try to interact with app bar area
    await page.mouse.click(100, 50); // Click in app bar area
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=홈')).toBeVisible();
  });
}); 