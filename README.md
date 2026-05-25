# Silly Survivors - Universal Native Linux Builder

An interactive, distro-independent build script to run **[Silly Survivors](https://store.steampowered.com/app/4077800/)** natively on Linux (Arch Linux, Steam Deck, Ubuntu, Fedora, etc.) with working game saves under the standard `~/.config` folder.

This completely bypasses the Proton black screen bug caused by Electron/ANGLE graphics driver conflicts.

## ⚠️ Disclaimer
**I am NOT the developer of Silly Survivors.** This is an unofficial, open-source community tool created solely to help players run their legitimately purchased game natively under Linux environments. No copyrighted game assets or binaries are distributed within this repository.

## 💾 How to Transfer Your Saves (Windows / Proton to Native)

If you previously played the game on Windows or via Proton on Linux, you can easily migrate your progress. To restore your saves on the native Linux version, follow these steps:

1. Locate your old save folder depending on where you played:
   * **From Windows:**
     Press `Win + R`, type `%appdata%` and hit Enter. Then navigate to:
     ```bash
     Silly Survivors\Local Storage\leveldb\
     ```
   * **From Linux (Proton Prefix):**
     ```bash
     \$HOME/.local/share/Steam/steamapps/compatdata/4077800/pfx/drive_c/users/steamuser/AppData/Roaming/Silly Survivors/Local Storage/leveldb/
     ```

2. Locate your new **Native Linux** save folder (run the native game at least once to create it):
   ```bash
   \$HOME/.config/Silly Survivors/Local Storage/leveldb/
   ```

3. Copy all files (`*.log`, `CURRENT`, `MANIFEST`, etc.) from your old Windows/Proton `leveldb` folder and paste them into the new Native Linux `leveldb` folder, overwriting everything.

Your progress, unlocked characters, and points will now be fully restored on the native Linux build!


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
### 3. Launch the game
The script will generate a standalone `Silly_Survivors_Linux` folder inside your resources directory. To launch the game, navigate to the folder and run the executable file:
```bash
cd Silly_Survivors_Linux
./silly_32survivors
```

## Tested on
* **OS:** Arch Linux (Kernel 6.18-lts) / Steam Deck
* **System Electron version:** v42.2.0

## License
MIT License - Copyright (c) 2026 Halmen
