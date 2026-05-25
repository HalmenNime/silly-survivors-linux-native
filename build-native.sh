#!/bin/bash

# Title:       Silly Survivors - Universal Native Linux Patcher
# Author:      Halmen
# License:     MIT
# Requirements: Legally owned game files, installed 'npm' and 'electron' in your system.

BUILD_DIR="./native_linux_build"
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

echo "[1/3] Preparing build directories and unpacking dependencies..."
# Clean old builds if they exist
rm -rf "$START_DIR/Silly_Survivors_Linux" "$BUILD_DIR"

mkdir -p "$BUILD_DIR/game_code"
cp "app.asar" "$BUILD_DIR/"

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

# Run the build process for unpacked directory
../node_modules/.bin/electron-builder --linux dir -c.electronVersion=$ELECTRON_VER -c.artifactName="Silly_Survivors.\${ext}"

# Inject Steam ID
echo "4077800" > "./dist/linux-unpacked/steam_appid.txt"

# Move results back to resources folder and clean up build trash
mv "./dist/linux-unpacked" "$START_DIR/Silly_Survivors_Linux"

cd "$START_DIR"
rm -rf "$BUILD_DIR"

echo "=== BUILD COMPLETE ==="
echo "Your clean native game folder is ready right here: $START_DIR/Silly_Survivors_Linux/"
echo "Note: This folder is completely standalone. You can manually move it anywhere you like (e.g., into your Games folder)."
echo "To play, just go inside that folder and launch in terminal: ./silly_32survivors"