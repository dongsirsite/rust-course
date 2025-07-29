const CACHE_NAME = 'v1';
const CACHE_ASSETS = [
  '/rust-course',
  '/rust-course/index.html',
  '/rust-course/theme/style.css',
  '/rust-course/css/variables.css',
  '/rust-course/css/general.css',
  '/rust-course/css/chrome.css',
  '/rust-course/FontAwesome/css/font-awesome.css',
  '/rust-course/fonts/fonts.css',
  '/rust-course/rust-course/highlight.css',
  '/rust-course/tomorrow-night.css',
  '/rust-course/ayu-highlight.css',
  '/rust-course/css/print.css',
  '/rust-course/toc.js',
  '/rust-course/ace.js',
  '/rust-course/mode-rust.js',
  '/rust-course/editor.js',
  '/rust-course/theme-dawn.js',
  '/rust-course/theme-tomorrow_night.js',
  '/rust-course/elasticlunr.min.js',
  '/rust-course/mark.min.js',
  '/rust-course/searcher.js',
  '/rust-course/highlight.js',
  '/rust-course/book.js',
  '/rust-course/custom.js',
  '/rust-course/bigPicture.js',
  '/rust-course/clipboard.min.js',
  '/rust-course/manifest.json',
  '/rust-course/icon-192.png',
  '/rust-course/icon-512.png'
];

self.addEventListener('install', e => {
  e.waitUntil(
    caches.open(CACHE_NAME).then(cache => {
      return cache.addAll(CACHE_ASSETS);
    })
  );
});

self.addEventListener('fetch', e => {
  e.respondWith(
    caches.match(e.request).then(res => {
      return res || fetch(e.request);
    })
  );
});
