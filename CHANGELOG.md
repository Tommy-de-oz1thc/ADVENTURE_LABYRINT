# ADVENTURE_LABYRINT – Changelog

This file documents the changes, improvements, and new features for each version of the game.

---

## Version 0.6a – 2025-07-11
🔹 **Save & Load System**
- Added `savegame.asm` and `loadgame.asm`
- The game can now be saved to `savegame.txt` and loaded correctly
- Player is returned to the correct room after loading

🔹 **Bug Fix**
- Fixed issue where saving would end the game instead of returning to gameplay

---

## Version 0.5a
🔹 **Key System**
- Added a key item that can be found and used to unlock the attic door
- The attic (`attic.asm`) can now only be accessed with the correct key found in the kitchen

---

## Version 0.4a
🔹 **Room Structure Expanded**
- Added more rooms and navigation between them: Hallway, Bedroom, Kitchen, etc.
- Each room has its own logic and menu choices

---

## Version 0.3a
🔹 **Core Room Logic**
- Player can move between rooms using simple menu input
- `map.asm` defines room connections
- `current_room` variable controls navigation logic

---

## Version 0.2a
🔹 **Startup Display**
- Added welcome screen with version and author credits
- Basic layout for the main menu in `adventure.asm`

---

## Version 0.1a
🔹 **Prototype**
- First working version with two test rooms
- Text output via DOS terminal using NASM Assembly
