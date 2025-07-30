/**
 * Page Object Model for SNS App
 * 각 페이지의 요소들과 액션을 캡슐화합니다.
 */

class BasePage {
  constructor(page) {
    this.page = page;
  }

  async waitForPageLoad() {
    await this.page.waitForLoadState('networkidle');
  }

  async takeScreenshot(name) {
    await this.page.screenshot({ path: `test-results/${name}.png` });
  }
}

class LoginPage extends BasePage {
  constructor(page) {
    super(page);
    this.emailInput = page.locator('[data-testid="email-input"]');
    this.passwordInput = page.locator('[data-testid="password-input"]');
    this.loginButton = page.locator('[data-testid="login-button"]');
    this.forgotPasswordLink = page.locator('[data-testid="forgot-password-link"]');
    this.signupLink = page.locator('[data-testid="signup-link"]');
  }

  async login(email, password) {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.loginButton.click();
  }

  async navigateToSignup() {
    await this.signupLink.click();
  }

  async navigateToForgotPassword() {
    await this.forgotPasswordLink.click();
  }
}

class HomePage extends BasePage {
  constructor(page) {
    super(page);
    this.feedContainer = page.locator('[data-testid="feed-container"]');
    this.createPostButton = page.locator('[data-testid="create-post-button"]');
    this.searchInput = page.locator('[data-testid="search-input"]');
    this.profileButton = page.locator('[data-testid="profile-button"]');
    this.notificationsButton = page.locator('[data-testid="notifications-button"]');
  }

  async createPost(content) {
    await this.createPostButton.click();
    // Post creation modal/page logic
  }

  async searchPosts(query) {
    await this.searchInput.fill(query);
    await this.page.keyboard.press('Enter');
  }

  async navigateToProfile() {
    await this.profileButton.click();
  }
}

class ProfilePage extends BasePage {
  constructor(page) {
    super(page);
    this.profileInfo = page.locator('[data-testid="profile-info"]');
    this.editProfileButton = page.locator('[data-testid="edit-profile-button"]');
    this.userPosts = page.locator('[data-testid="user-posts"]');
    this.followersCount = page.locator('[data-testid="followers-count"]');
    this.followingCount = page.locator('[data-testid="following-count"]');
  }

  async editProfile(newData) {
    await this.editProfileButton.click();
    // Profile editing logic
  }

  async getFollowersCount() {
    return await this.followersCount.textContent();
  }
}

class PostPage extends BasePage {
  constructor(page) {
    super(page);
    this.postContent = page.locator('[data-testid="post-content"]');
    this.likeButton = page.locator('[data-testid="like-button"]');
    this.commentInput = page.locator('[data-testid="comment-input"]');
    this.shareButton = page.locator('[data-testid="share-button"]');
    this.commentsList = page.locator('[data-testid="comments-list"]');
  }

  async likePost() {
    await this.likeButton.click();
  }

  async addComment(comment) {
    await this.commentInput.fill(comment);
    await this.page.keyboard.press('Enter');
  }

  async sharePost() {
    await this.shareButton.click();
  }
}

module.exports = {
  BasePage,
  LoginPage,
  HomePage,
  ProfilePage,
  PostPage
}; 