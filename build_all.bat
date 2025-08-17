@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Building Flutter app for all platforms
echo ========================================

echo.
echo [1/7] Cleaning project...
call flutter clean
if !errorlevel! neq 0 (
    echo ERROR: Flutter clean failed
    pause
    exit /b 1
)

echo.
echo [2/7] Getting dependencies...
call flutter pub get
if !errorlevel! neq 0 (
    echo ERROR: Flutter pub get failed
    pause
    exit /b 1
)

echo.
echo [3/7] Building Android APK (Universal)...
call flutter build apk --release
if !errorlevel! neq 0 (
    echo ERROR: Android APK build failed
    pause
    exit /b 1
)

echo.
echo [4/7] Building Android APK (Split per ABI)...
call flutter build apk --release --split-per-abi
if !errorlevel! neq 0 (
    echo ERROR: Android APK split-per-abi build failed
    pause
    exit /b 1
)

echo.
echo [5/7] Building Android App Bundle...
call flutter build appbundle --release
if !errorlevel! neq 0 (
    echo ERROR: Android AAB build failed
    pause
    exit /b 1
)

echo.
echo [6/7] Building Windows...
call flutter build windows --release
if !errorlevel! neq 0 (
    echo ERROR: Windows build failed
    pause
    exit /b 1
)

echo.
echo [7/7] Building Web...
call flutter build web --release
if !errorlevel! neq 0 (
    echo ERROR: Web build failed
    pause
    exit /b 1
)

echo.
echo ========================================
echo BUILD COMPLETED SUCCESSFULLY!
echo ========================================
echo.
echo Files location:
echo - Android APK (Universal): build\app\outputs\flutter-apk\app-release.apk
echo - Android APK (ARM64): build\app\outputs\flutter-apk\app-arm64-v8a-release.apk
echo - Android APK (ARMv7): build\app\outputs\flutter-apk\app-armeabi-v7a-release.apk
echo - Android APK (x86_64): build\app\outputs\flutter-apk\app-x86_64-release.apk
echo - Android AAB: build\app\outputs\bundle\release\app-release.aab
echo - Web: build\web\
echo - Windows: build\windows\x64\runner\Release\
echo.

pause