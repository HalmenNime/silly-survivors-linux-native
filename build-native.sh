#!/bin/bash

# Title:       Silly Survivors - Universal Native Linux Patcher (Dual Mode)
# Author:      Halmen
# License:     MIT
# Requirements: Legally owned game files, installed 'npm' and 'electron' in your system.

BUILD_DIR="./native_linux_build"

# FIX: Save the clean resources directory path right at the start
START_DIR=$(pwd)

echo "=== Silly Survivors Native Linux Builder ==="

# 1. Check for game files
if [ ! -f "app.asar" ]; then
    echo "Error: app.asar not found in the current folder!"
    echo "Please place this script inside the 'resources' folder of the game."
    exit 1
fi

# 2. Check for node/electron
if ! command -v npm &> /dev/null || ! command -v electron &> /dev/null; then
    echo "Error: 'npm' or 'electron' is missing in your system!"
    echo "Please install them via your distribution's package manager first."
    exit 1
fi

# 3. Interactive Menu for Build Mode
echo "Select your build mode:"
echo "1) Unpacked Folder (Recommended: native steam_appid.txt support, faster launch)"
echo "2) AppImage (Single portable file, requires manual SteamAppId variable)"
read -p "Enter choice [1 or 2]: " BUILD_CHOICE

if [ "$BUILD_CHOICE" == "1" ]; then
    BUILD_TARGET="dir"
    echo "Selected mode: Unpacked Folder"
elif [ "$BUILD_CHOICE" == "2" ]; then
    BUILD_TARGET="appimage"
    echo "Selected mode: AppImage"
else
    echo "Invalid choice! Exiting."
    exit 1
fi

echo "[1/3] Preparing build directories and unpacking dependencies..."
# Clean old builds if they exist at the start
rm -rf "$START_DIR/Silly_Survivors_Linux" "$START_DIR/Silly_Survivors.AppImage" "$BUILD_DIR"

mkdir -p "$BUILD_DIR/game_code"
cp "app.asar" "$BUILD_DIR/"

# CRITICAL FIX: Copy original unpacked folder so asar doesn't crash on Steam API binaries
if [ -d "app.asar.unpacked" ]; then
    cp -r "app.asar.unpacked" "$BUILD_DIR/"
fi

cd "$BUILD_DIR"

echo "[2/3] Extracting app.asar archive..."
npm install @electron/asar electron-builder
./node_modules/.bin/asar extract app.asar game_code
cd game_code

# Detect system electron version
ELECTRON_VER=$(electron -v | sed 's/v//')
echo "Detected system Electron version: $ELECTRON_VER"

echo "[3/3] Running electron-builder..."
npm install

# Run the build process
../node_modules/.bin/electron-builder --linux $BUILD_TARGET -c.electronVersion=$ELECTRON_VER -c.artifactName="Silly_Survivors.\${ext}"

# Move results back to resources folder and clean up build trash
if [ "$BUILD_TARGET" == "dir" ]; then
    echo "4077800" > "./dist/linux-unpacked/steam_appid.txt"

    # Move to the pre-saved START_DIR location
    mv "./dist/linux-unpacked" "$START_DIR/Silly_Survivors_Linux"

    cd "$START_DIR"
    rm -rf "$BUILD_DIR"

    echo "=== BUILD COMPLETE ==="
    echo "Your clean native game folder is ready right here: $START_DIR/Silly_Survivors_Linux/"
    echo "Note: This folder is completely standalone. You can manually move it anywhere you like (e.g., into your Games folder)."
    echo "To play, just go inside that folder and launch in terminal: ./silly_32survivors"
else
    mv "./dist/Silly_Survivors.AppImage" "$START_DIR/"

    cd "$START_DIR"
    rm -rf "$BUILD_DIR"

    echo "=== BUILD COMPLETE ==="
    echo "Your clean portable AppImage is ready right here: $START_DIR/Silly_Survivors.AppImage"
    echo "Note: This folder is completely standalone. You can manually move it anywhere you like (e.g., into your Games folder)."
    echo "To play, just go inside that folder and launch in terminal: SteamAppId=4077800 ./Silly_Survivors.AppImage"
fi
