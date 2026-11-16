@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0list-voices.ps1"
echo.
echo Jarvis: voice list saved to voices.txt. You may close this window.
pause
