// Playwright MCP 테스트 스크립트
const { spawn } = require('child_process');
const path = require('path');

console.log('🚀 Playwright MCP 테스트 시작...');

// npx 경로 확인
const npxPath = path.join(process.env.APPDATA || process.env.HOME, 'npm', 'npx.cmd');
const npmPath = path.join(process.env.APPDATA || process.env.HOME, 'npm', 'npm.cmd');

console.log('📁 npx 경로:', npxPath);
console.log('📁 npm 경로:', npmPath);

// MCP 서버 시작 (npm을 통해 실행)
const mcpServer = spawn('npm', ['exec', '@playwright/mcp', '--', '--headless'], {
  stdio: ['pipe', 'pipe', 'pipe'],
  shell: true
});

console.log('✅ Playwright MCP 서버가 시작되었습니다.');
console.log('📋 사용 가능한 기능:');
console.log('   - browser_navigate: 웹페이지 탐색');
console.log('   - browser_snapshot: 페이지 스냅샷');
console.log('   - browser_take_screenshot: 스크린샷 촬영');
console.log('   - browser_type: 텍스트 입력');
console.log('   - browser_click: 요소 클릭');
console.log('   - browser_wait_for: 대기');
console.log('   - browser_network_requests: 네트워크 요청 모니터링');

// 서버 종료 처리
process.on('SIGINT', () => {
  console.log('\n🛑 MCP 서버를 종료합니다...');
  mcpServer.kill();
  process.exit(0);
});

// 에러 처리
mcpServer.stderr.on('data', (data) => {
  console.error('❌ MCP 서버 에러:', data.toString());
});

mcpServer.stdout.on('data', (data) => {
  console.log('📡 MCP 서버 출력:', data.toString());
});

// 프로세스 종료 처리
mcpServer.on('close', (code) => {
  console.log(`🔄 MCP 서버가 종료되었습니다. (코드: ${code})`);
});

mcpServer.on('error', (error) => {
  console.error('💥 MCP 서버 시작 실패:', error.message);
  console.log('💡 대안: 직접 명령어로 실행해보세요:');
  console.log('   npx @playwright/mcp --headless');
});

console.log('\n💡 MCP 클라이언트에서 다음 명령어로 테스트할 수 있습니다:');
console.log('   browser_navigate({url: "https://example.com"})');
console.log('   browser_snapshot()');
console.log('   browser_take_screenshot({filename: "test.png"})'); 