; === loadgame.asm ===
global LoadGame
extern current_room, map_found, have_key
extern _fopen, _fscanf, _fclose

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
    push have_key
    push map_found
    push current_room
    push fmt_string
    push ebx
    call _fscanf
    add esp, 20

    ; Luk filen
    push ebx
    call _fclose
    add esp, 4

.done:
    ret


