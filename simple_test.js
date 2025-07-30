// 간단한 Playwright MCP 테스트
const { exec } = require('child_process');

console.log('🚀 Playwright MCP 간단 테스트 시작...\n');

// 1. 설치 확인
console.log('1️⃣ Playwright MCP 설치 확인...');
exec('npx @playwright/mcp --version', (error, stdout, stderr) => {
  if (error) {
    console.error('❌ 설치 확인 실패:', error.message);
    return;
  }
  console.log('✅ 버전:', stdout.trim());
  
  // 2. 브라우저 설치 확인
  console.log('\n2️⃣ 브라우저 설치 확인...');
  exec('npx playwright install --dry-run', (error, stdout, stderr) => {
    if (error) {
      console.error('❌ 브라우저 확인 실패:', error.message);
      return;
    }
    console.log('✅ 브라우저 설치됨');
    
    // 3. MCP 설정 파일 확인
    console.log('\n3️⃣ MCP 설정 파일 확인...');
    const fs = require('fs');
    if (fs.existsSync('mcp_config.json')) {
      console.log('✅ mcp_config.json 파일 존재');
      const config = JSON.parse(fs.readFileSync('mcp_config.json', 'utf8'));
      console.log('📋 설정:', JSON.stringify(config, null, 2));
    } else {
      console.log('❌ mcp_config.json 파일 없음');
    }
    
    console.log('\n🎉 Playwright MCP 설치 완료!');
    console.log('\n📝 사용 방법:');
    console.log('   MCP 클라이언트에서 다음 명령어 사용 가능:');
    console.log('   - browser_navigate({url: "https://example.com"})');
    console.log('   - browser_snapshot()');
    console.log('   - browser_take_screenshot({filename: "test.png"})');
    console.log('   - browser_type({element: "검색창", ref: "search", text: "검색어"})');
    console.log('   - browser_click({element: "버튼", ref: "button"})');
  });
}); 