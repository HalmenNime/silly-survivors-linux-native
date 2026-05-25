# Silly Survivors - Universal Native Linux Builder

An interactive, distro-independent build script to run **Silly Survivors** natively on Linux (Arch Linux, Steam Deck, Ubuntu, Fedora, etc.) with working game saves under the standard `~/.config` folder.

This completely bypasses the Proton black screen bug caused by Electron/ANGLE graphics driver conflicts.

## ⚠️ Disclaimer
**I am NOT the developer of Silly Survivors.** This is an unofficial, open-source community tool created solely to help players run their legitimately purchased game natively under Linux environments. No copyrighted game assets or binaries are distributed within this repository.

## 🎮 Steam Support
Since this script uses your legitimately owned game files, Steam will recognize this native version correctly. Your Steam overlay, play time tracking, and achievements will work normally out of the box.

## Requirements

Before running the script, make sure you have:
* **A legally purchased copy of Silly Survivors** installed via Steam.
* **Node.js / npm** installed via your distro's package manager.
* **Electron** installed via your distro's package manager.

### Quick dependency install commands:
* **Arch Linux / Steam Deck:** `sudo pacman -S npm electron`
* **Ubuntu / Debian / Mint:** `sudo apt install npm electron`
* **Fedora:** `sudo dnf install npm electron`

## How to use

### 1. Locate the game's resources folder
* Open your Steam Library, right-click **Silly Survivors** -> **Manage** -> **Browse local files**.
* Navigate inside the **`resources`** folder and open your terminal there.
* *Alternative terminal path:* `cd "$HOME/.local/share/Steam/steamapps/common/Silly Survivors/resources"`

### 2. Download and run the script
Drop the `build-native.sh` script into that `resources` folder, then execute:
```bash
chmod +x build-native.sh
./build-native.sh
```

### 3. Choose your build mode in the menu:
* **Option 1 (Unpacked Folder - Recommended):** Creates a standalone folder. It automatically injects `steam_appid.txt`, allowing you to play immediately with full Steam and achievements support.
* **Option 2 (AppImage):** Packages the entire game into a single portable `.AppImage` file. To keep Steam features working, you have two choices:
  * **Via Terminal:** Run the file with the Steam ID variable directly:
    ```bash
    SteamAppId=4077800 ./Silly_Survivors.AppImage
    ```
  * **Via Steam GUI:** Add the AppImage to Steam as a **"Non-Steam Game"** and set its **Launch Options** to:
    ```bash
    SteamAppId=4077800 %command%
    ```

## Tested on
* **OS:** Arch Linux (Kernel 6.18-lts) / Steam Deck
* **System Electron version:** v42.2.0

## License
MIT License - Copyright (c) 2026 Halmen
