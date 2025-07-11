# ADVENTURE_LABYRINT - Changelog

Her er en oversigt over ændringer og nye funktioner i hver version af spillet.

---

## Version 0.6a – 2025-07-09
🔹 **Save og Load**
- Tilføjet `savegame.asm` og `loadgame.asm`
- Spillet kan nu gemmes til `savegame.txt` og genindlæses korrekt
- Spillet vender tilbage til korrekt rum efter Load

🔹 **Bugfix**
- Rettet fejl hvor Save afsluttede spillet uden at vende tilbage

---

## Version 0.5a
🔹 **Nøglesystem**
- Tilføjet nøgle, som kan findes og bruges til at åbne dør til loftet
- Loftet (`attic.asm`) kan nu låses op med nøgle fundet i køkkenet

---

## Version 0.4a
🔹 **Rumstruktur**
- Flere rum tilføjet og koblet sammen: Hallway, Bedroom, Kitchen osv.
- Hvert rum har nu egne valg og returnering via menuvalg

---

## Version 0.3a
🔹 **Grundstruktur**
- Spilleren kan navigere mellem rum
- `map.asm` definerer sammenhængen mellem rummene
- Brug af `current_room` til logik og navigation

---

## Version 0.2a
🔹 **Opstart og skærmtekst**
- Velkomsttekst med version og forfatter
- Strukturering af hovedmenu i `adventure.asm`

---

## Version 0.1a
🔹 **Prototype**
- Første version med to test-rum og grundlæggende funktion
- Udskrift via DOS-terminal
