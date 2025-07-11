global Hallway
extern Living_Room, Bedroom, Kitchen, Attic
extern _printf, _getch, _system, _scanf
extern retur_value, choose
extern show_keys_and_try_unlock

section .data
	hallway_txt db "You are now in the Hallway", 10, 0
	valg_txt db "Living Room(1), Bedroom(2), Kitchen(3), Attic(4), Exit the House(5): Take the Map(6) ", 0
	cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0

section .bss
input resb 10

section .text
Hallway:
    push cls_cmd
    call _system

    push hallway_txt
    call _printf
    add esp, 4

    push valg_txt
    call _printf
    add esp, 4

    push choose
    push choose_format
    call _scanf
    add esp, 8


    mov eax, [choose]
    cmp eax, 1
    je Living_Room
    cmp eax, 2
    je Bedroom
    cmp eax, 3
    je Kitchen
    cmp eax, 4
    jne .not_attic

    mov dword [retur_value], 1 ; 1 = Hallway
    call show_keys_and_try_unlock
    cmp eax, 1
    je .go_to_attic
    jmp Hallway

.go_to_attic:
    call Attic
    jmp Hallway

.not_attic:
    cmp eax, 5
    je end_game
    cmp eax, 6
    je show_map

    jmp Hallway

show_map:
    ; placeholder for map funktion
    call _getch
    jmp Hallway

end_game:
    ret
