#!/usr/bin/env bash

cp ./assets/CNAME ./book/
cp ./assets/*.html ./book/
cp ./assets/sitemap.xml ./book/

cp ./icons/* ./book/
cp service-worker.js ./book/
cp manifest.json ./book/
