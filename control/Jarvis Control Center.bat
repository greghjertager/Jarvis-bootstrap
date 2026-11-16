@echo off
rem Double-click to open the Jarvis Control Center. To put it on your desktop, right-click this file and choose Send to > Desktop (create shortcut).
start "" powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0Jarvis-Control-Center.ps1"
