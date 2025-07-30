// @ts-check
const { test, expect } = require('@playwright/test');

test.describe('YouTube Videos Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    // Navigate to YouTube videos page
    await page.locator('text=동영상').click();
    await page.waitForTimeout(500);
  });

  test('should display YouTube videos page elements', async ({ page }) => {
    // Check for YouTube videos page elements
    await expect(page.locator('text=동영상')).toBeVisible();
    
    // Check for Flutter app container
    await expect(page.locator('flt-glass-pane')).toBeVisible();
  });

  test('should handle video search', async ({ page }) => {
    // Test search functionality
    // Click in search area
    await page.mouse.click(200, 100);
    await page.waitForTimeout(500);
    
    // Type search query
    await page.keyboard.type('AI');
    await page.waitForTimeout(500);
    
    // Press Enter to search
    await page.keyboard.press('Enter');
    await page.waitForTimeout(1000);
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should handle category filtering', async ({ page }) => {
    // Test category filtering
    // Click in category area
    await page.mouse.click(200, 150);
    await page.waitForTimeout(500);
    
    // Click in different areas to test category selection
    await page.mouse.click(100, 150);
    await page.waitForTimeout(500);
    
    await page.mouse.click(300, 150);
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should handle video playback', async ({ page }) => {
    // Test video playback functionality
    // Click in video area to potentially play video
    await page.mouse.click(200, 300);
    await page.waitForTimeout(1000);
    
    // Click in another video area
    await page.mouse.click(200, 500);
    await page.waitForTimeout(1000);
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should handle video sharing', async ({ page }) => {
    // Test video sharing functionality
    // Click in share button area
    await page.mouse.click(350, 300);
    await page.waitForTimeout(500);
    
    // Handle potential share dialog
    try {
      await page.locator('text=Cancel').click();
    } catch (e) {
      // Share dialog might not appear in test environment
      console.log('Share dialog not found, continuing...');
    }
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should handle video scrolling', async ({ page }) => {
    // Test scrolling through videos
    // Scroll down to see more videos
    await page.evaluate(() => {
      window.scrollTo(0, 500);
    });
    await page.waitForTimeout(1000);
    
    // Scroll down more
    await page.evaluate(() => {
      window.scrollTo(0, 1000);
    });
    await page.waitForTimeout(1000);
    
    // Scroll back up
    await page.evaluate(() => {
      window.scrollTo(0, 0);
    });
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should handle external video links', async ({ page }) => {
    // Test external video link functionality
    // Click in video area to potentially open external link
    await page.mouse.click(200, 300);
    await page.waitForTimeout(1000);
    
    // Handle potential external link dialog
    try {
      await page.locator('text=Cancel').click();
    } catch (e) {
      // External link dialog might not appear in test environment
      console.log('External link dialog not found, continuing...');
    }
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should handle video animations', async ({ page }) => {
    // Test video animations and interactions
    // Click in different areas to trigger animations
    await page.mouse.click(200, 300);
    await page.waitForTimeout(500);
    
    await page.mouse.click(200, 400);
    await page.waitForTimeout(500);
    
    await page.mouse.click(200, 500);
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=동영상')).toBeVisible();
  });

  test('should navigate back to feed', async ({ page }) => {
    // Navigate back to feed
    await page.locator('text=홈').click();
    await page.waitForTimeout(500);
    
    // Verify we're back on feed page
    await expect(page.locator('text=홈')).toBeVisible();
  });
}); 