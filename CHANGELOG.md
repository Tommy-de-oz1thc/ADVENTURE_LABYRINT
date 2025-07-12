# ADVENTURE_LABYRINT – Changelog

This file documents the changes, improvements, and new features for each version of the game.

---

## Version 2.1 – 2025 July 12
🔹 **Bug fix*
- CW_Code_Word was not having a link to the room.
- txt files had been moved to /txt.

---

---

## Version 2.0 – 2025 July 12
🔹 **Second release*
- Now whit cw wav file a.wav, b.wav, c.wav etc.

---

## Version 1.0 – 2025 July 11
🔹 **First release*
- Biblevers and Reverse is added and the first exe file is released.
---

## Version 0.8 – 2025 July 11
🔹 **Key System**
- New key system so you can choose between the keys you find.
  
---

## Version 0.7 – 2025 July 11
🔹 **Exit Text**
- Different Exit Text Added from `Hallway.asm` and `Attic.asm`
- Added jump out of window from Attic
  
---

## Version 0.6 – 2025 July 11
🔹 **Save & Load System**
- Added `savegame.asm` and `loadgame.asm`
- The game can now be saved to `savegame.txt` and loaded correctly
- Player is returned to the correct room after loading

🔹 **Bug Fix**
- Fixed issue where saving would end the game instead of returning to gameplay

---

## Version 0.5 – 2025 July 10
🔹 **Key System**
- Added a key item that can be found and used to unlock the attic door
- The attic (`attic.asm`) can now only be accessed with the correct key found in the kitchen

---

## Version 0.4 – 2025 July 9
🔹 **Room Structure Expanded**
- Added more rooms and navigation between them: Hallway, Bedroom, Kitchen, etc.
- Each room has its own logic and menu choices

---

## Version 0.3 – 2025 July 8
🔹 **Core Room Logic**
- Player can move between rooms using simple menu input
- `map.asm` defines room connections
- `current_room` variable controls navigation logic

---

## Version 0.2 – 2025 July 7
🔹 **Startup Display**
- Added welcome screen with version and author credits
- Basic layout for the main menu in `adventure.asm`

---

## Version 0.1 – 2025 July 6
🔹 **Prototype**
- First working version with two test rooms
- Text output via DOS terminal using NASM Assembly
