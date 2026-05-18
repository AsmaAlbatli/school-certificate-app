@echo off
title Certificate server
cd /d "%~dp0"
echo.
echo  Certificate app is running.
echo  On this PC:     http://localhost:8080/content.html
echo  On same Wi-Fi:  http://YOUR-PC-IP:8080/content.html
echo.
echo  Press Ctrl+C to stop.
echo.
python -m http.server 8080 --bind 0.0.0.0
