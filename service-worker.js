const CACHE_NAME = 'v1';
const CACHE_ASSETS = [
  '/',
  '/index.html',
  '/style.css',
  '/toc.js',
  '/ace.js',
  '/mode-rust.js',
  '/editor.js',
  '/theme-dawn.js',
  '/theme-tomorrow_night.js',
  '/elasticlunr.min.js',
  '/mark.min.js',
  '/searcher.js',
  '/highlight.js',
  '/book.js',
  '/custom.js',
  '/bigPicture.js',
  '/clipboard.min.js',
  '/manifest.json',
  '/icon-192.png',
  '/icon-512.png'
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
