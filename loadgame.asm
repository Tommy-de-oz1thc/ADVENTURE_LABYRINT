; === loadgame.asm ===
global LoadGame
extern current_room, map_found, have_key
extern _fopen, _fscanf, _fclose
extern main, Hallway, Bedroom, Kitchen, Attic, Living_Room

section .data
filename db "savegame.txt", 0
mode_read db "r", 0
fmt_string db "%d %d %d", 0

section .text
LoadGame:
    ; Åbn filen i læsemodus
    push mode_read
    push filename
    call _fopen
    add esp, 8
    test eax, eax
    jz .done          ; Kun hvis filen findes
    mov ebx, eax      ; Filhåndtag

    ; fscanf(fp, "%d %d %d", &current_room, &have_map, &have_key)
    push current_room
    push map_found
    push have_key

    push fmt_string
    push ebx
    call _fscanf
    add esp, 20

    ; Luk filen
    push ebx
    call _fclose
    add esp, 4

.done:
    .done:
    ; Hop videre til rummet efter load
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
    je Attic
  
    ; fallback
    jmp main



