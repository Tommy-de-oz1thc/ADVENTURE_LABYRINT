global SaveGame

extern _fopen, _fprintf, _fclose, _printf, _getch
extern current_room
extern have_key, map_found
extern Hallway, Bedroom, Kitchen, Attic, Living_Room

section .data
save_filename db "savegame.txt", 0
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
    push dword [have_key]
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
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je Bedroom
    cmp eax, 3
    je Kitchen
    cmp eax, 4
    je Attic
    cmp eax, 5
    je Living_Room
    ; fallback
    jmp Hallway

