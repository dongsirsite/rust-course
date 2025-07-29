#!/usr/bin/env bash

cp ./assets/CNAME ./book/
cp ./assets/*.html ./book/ || true
cp ./assets/sitemap.xml ./book/

cp ./icons/* ./book/
cp service-worker.js ./book/
cp manifest.json ./book/


# 插入 PWA HTML 片段
injection=$(cat <<'EOF'
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
)

# 用 awk 注入 PWA 内容到 <head> 后面
awk -v block="$injection" '
/<head>/ {
  print;
  print block;
  next
}
{ print }
' ./book/index.html
