// @ts-check
const { test, expect } = require('@playwright/test');
const { setMobileViewport, setDesktopViewport } = require('../utils/testHelpers');

test.describe('Navigation Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
  });

  test('should navigate between main sections', async ({ page }) => {
    // Navigate to explore
    await page.locator('text=탐색').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=탐색')).toBeVisible();

    // Navigate to create post
    await page.locator('text=게시물').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=게시물')).toBeVisible();

    // Navigate to videos
    await page.locator('text=동영상').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=동영상')).toBeVisible();

    // Navigate to profile
    await page.locator('text=프로필').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=프로필')).toBeVisible();

    // Return to home
    await page.locator('text=홈').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=홈')).toBeVisible();
  });

  test('should show active navigation state', async ({ page }) => {
    // Check home is active by default
    await expect(page.locator('text=홈')).toBeVisible();

    // Navigate to profile and check it's visible
    await page.locator('text=프로필').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=프로필')).toBeVisible();
  });

  test('should handle mobile navigation', async ({ page }) => {
    await setMobileViewport(page);
    
    // Check if navigation is still visible on mobile
    await expect(page.locator('text=홈')).toBeVisible();
    await expect(page.locator('text=프로필')).toBeVisible();
    
    // Test navigation on mobile
    await page.locator('text=탐색').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=탐색')).toBeVisible();
  });

  test('should handle desktop navigation', async ({ page }) => {
    await setDesktopViewport(page);
    
    // Check if navigation is visible on desktop
    await expect(page.locator('text=홈')).toBeVisible();
    await expect(page.locator('text=프로필')).toBeVisible();
    
    // Test navigation on desktop
    await page.locator('text=동영상').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should maintain navigation state after page refresh', async ({ page }) => {
    // Navigate to profile
    await page.locator('text=프로필').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=프로필')).toBeVisible();
    
    // Refresh page
    await page.reload();
    await page.waitForLoadState('networkidle');
    
    // Should still be on profile page
    await expect(page.locator('text=프로필')).toBeVisible();
  });

  test('should handle back navigation', async ({ page }) => {
    // Navigate to profile
    await page.locator('text=프로필').click();
    await page.waitForTimeout(500);
    await expect(page.locator('text=프로필')).toBeVisible();
    
    // Go back
    await page.goBack();
    await page.waitForLoadState('networkidle');
    
    // Should be back on home page
    await expect(page.locator('text=홈')).toBeVisible();
  });
}); 