#!/usr/bin/env bash

cp ./assets/CNAME ./book/
cp ./assets/*.html ./book/
cp ./assets/sitemap.xml ./book/

cp ./icons/* ./book/
cp service-worker.js ./book/
cp manifest.json ./book/


# 自动向 book/index.html 的 <head> 中插入 PWA 相关内容
# 使用临时文件写入
injection=$(cat <<EOF
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

# 使用 sed 将内容插入到 <head> 标签后
sed -i.bak "/<head>/a\\
$injection
" ./book/index.html
