global SaveGame

extern _fopen, _fprintf, _fclose, _printf, _getch
extern current_room
extern map_found, have_key_attic 
extern Hallway, Bedroom, Kitchen, attic_entry, Living_Room, Aschii_Show, Reverse,Biblevers, CW_Code_Word, main

section .data
save_filename db "txt\\savegame.txt", 0
save_mode     db "w", 0
save_format   db "%d %d %d", 0   ; fx have_key, have_map, current_room
save_ok       db "Game saved!", 10, 0
save_fp       dd 0

section .text

SaveGame:
    ; Åbn fil
    push save_mode
    push save_filename
    call _fopen
    mov [save_fp], eax

    ; Gem data (push dword bruges her)
    mov eax, [save_fp]
    push dword [current_room]
    push dword [map_found]
    push dword [have_key_attic]
    push save_format
    push eax
    call _fprintf
    add esp, 20

    ; Luk fil
    mov eax, [save_fp]
    push eax
    call _fclose

    ; Bekræft
    push save_ok
    call _printf
    add esp, 4
    call _getch
    mov eax, [current_room]
	cmp eax, 0
    je main
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je Bedroom
    cmp eax, 3
    je Kitchen
    cmp eax, 4
    je Living_Room
	cmp eax, 5
    je attic_entry
	cmp eax, 6
    je Reverse
	cmp eax, 7
    je Biblevers
	cmp eax, 8
	je CW_Code_Word
	cmp eax, 9
	je Aschii_Show
    ; fallback
    jmp main

