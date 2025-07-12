global Hallway
extern Living_Room, Bedroom, Kitchen, Attic, SaveGame, Show_map
extern _printf, _getch, _system, _scanf
extern retur_value, choose, current_room
extern show_keys_and_try_unlock
extern map_found

section .data
	hallway_txt db "You are now in the Hallway", 10, 0
	valg_txt db "Living Room(1), Bedroom(2), Kitchen(3), Attic(4), Exit the House(5): ", 0
	cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0
	no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0

section .bss
input resb 10

section .text
Hallway:
    push cls_cmd
    call _system

    mov eax, [map_found]     ;check up map is found
    cmp eax, 0
    je .spring_map_tip

	cmp eax, 0
    je .spring_map_tip

    push map_tip
	call _printf
	add esp, 4

.spring_map_tip:

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
    cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing      ;show a txt with the map
    jmp Hallway               ;jump back if no room was choosen  
	
SaveAndContinue:
    mov dword [current_room], 3   ; 3 = Kitchen
    call SaveGame
    jmp Hallway

show_map:
    ; placeholder for map funktion
    call _getch
    jmp Hallway

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map      
    mov eax, Kitchen
    mov dword [retur_value], 1 ; 1 = Hallway
    call Show_map
    jmp Hallway

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Hallway


end_game:
    ret
