#!/usr/bin/env bash

cp ./assets/CNAME ./book/
cp ./assets/*.html ./book/
cp ./assets/sitemap.xml ./book/

cp ./icons/* ./book/
cp service-worker.js ./book/
cp manifest.json ./book/



# 注入 PWA 内容
cat > ./book/pwa-snippet.html <<'EOF'
  <link rel="manifest" href="manifest.json">
  <meta name="theme-color" content="#3e4eb8">
  <link rel="icon" href="icon-192.png">
  <link rel="apple-touch-icon" href="icon-512.png">
  <script>
    if ('serviceWorker' in navigator) {
      window.addEventListener('load', () => {
        navigator.serviceWorker.register('service-worker.js')
          .then(reg => console.log('SW registered', reg))
          .catch(err => console.error('SW registration failed:', err));
      });
    }
  </script>
EOF

# 插入 HTML 片段到 <head> 后
sed -i.bak '/<head>/a__PWA_INSERT__' ./book/index.html
sed -i.bak '/__PWA_INSERT__/ {
  r ./book/pwa-snippet.html
  d
}' ./book/index.html

# 清理
rm ./book/pwa-snippet.html
