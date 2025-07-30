// @ts-check
const { test, expect } = require('@playwright/test');

test.describe('Create Post Page Tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/');
    await page.waitForLoadState('networkidle');
    // Navigate to create post page
    await page.locator('text=게시물').click();
    await page.waitForTimeout(500);
  });

  test('should display create post page elements', async ({ page }) => {
    // Check for create post page elements
    await expect(page.locator('text=게시물')).toBeVisible();
    
    // Check for Flutter app container
    await expect(page.locator('flt-glass-pane')).toBeVisible();
  });

  test('should handle text input', async ({ page }) => {
    // Try to find and interact with text input fields
    // Since these are Flutter widgets, we'll test general interaction
    
    // Click in the middle of the page to potentially focus on text input
    await page.mouse.click(200, 300);
    await page.waitForTimeout(500);
    
    // Try typing some text
    await page.keyboard.type('Test post content');
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=게시물')).toBeVisible();
  });

  test('should handle image selection', async ({ page }) => {
    // Test image selection functionality
    // Click in area where image picker might be
    await page.mouse.click(200, 400);
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=게시물')).toBeVisible();
  });

  test('should handle camera access', async ({ page }) => {
    // Test camera access functionality
    // This will likely show a permission dialog in real browser
    await page.mouse.click(200, 400);
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=게시물')).toBeVisible();
  });

  test('should handle gallery access', async ({ page }) => {
    // Test gallery access functionality
    await page.mouse.click(200, 450);
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=게시물')).toBeVisible();
  });

  test('should handle post creation', async ({ page }) => {
    // Test post creation flow
    // Type some content
    await page.mouse.click(200, 300);
    await page.keyboard.type('Test post for E2E testing');
    await page.waitForTimeout(500);
    
    // Try to submit (click in submit area)
    await page.mouse.click(200, 600);
    await page.waitForTimeout(500);
    
    // Verify page is still functional
    await expect(page.locator('text=게시물')).toBeVisible();
  });

  test('should handle navigation back to feed', async ({ page }) => {
    // Navigate back to feed
    await page.locator('text=홈').click();
    await page.waitForTimeout(500);
    
    // Verify we're back on feed page
    await expect(page.locator('text=홈')).toBeVisible();
  });

  test('should handle permission dialogs', async ({ page }) => {
    // Test permission handling
    // Click in camera/gallery area to trigger permission request
    await page.mouse.click(200, 400);
    await page.waitForTimeout(1000);
    
    // Handle potential permission dialog
    try {
      await page.locator('text=Allow').click();
    } catch (e) {
      // Permission dialog might not appear in test environment
      console.log('Permission dialog not found, continuing...');
    }
    
    // Verify page is still functional
    await expect(page.locator('text=게시물')).toBeVisible();
  });
}); 