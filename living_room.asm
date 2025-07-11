global Living_Room
extern ret_to_living_room, current_room

extern choose, have_key, retur_value, map_found

section .data
	text_living_room db "You are now in the living room", 10, 0  
    cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0
	no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0
	prompt_living_room db "Hallway(1), Bedroom(2), Kitchen(3), Write down names(4): ", 0
	filenamename db "names.txt", 0
	write_mode db "a", 0                     ; Append mode
	name_format db "%99s", 0                ; scanf: reads one name (max 99 chars, stops at space)
	fprintf_format db "%s", 10, 0           ; fprintf: writes name + newline
	name_prompt db "Enter your name: ", 0	 
	map_text_found db "You pick up the old map:", 10, "Press any key to continue", 0

section .bss
	file resd 1
	
section .text
    extern _printf, _scanf, _getch, _system     ; <-- underscore!
    extern _fopen, _fprintf, _fclose
    extern Hallway, Bedroom, Kitchen, Write, Show_map, SaveGame 
    extern retur_value, map_found
	
global Living_Room

Living_Room:
    push cls_cmd
    call _system

    mov eax, [map_found]
    cmp eax, 0
    je .skip_map_tip

    push map_tip
    call _printf
    add esp, 4

.skip_map_tip:
    push text_living_room
    call _printf
    add esp, 4

    push prompt_living_room
    call _printf
    add esp, 4

    push choose
    push choose_format
    call _scanf
    add esp, 8


    mov eax, [choose]
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je Bedroom
    cmp eax, 3
    je Kitchen
    cmp eax, 4
    je Write
	cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
	jmp Living_Room
    
SaveAndContinue:
    mov dword [current_room], 4   ; 4 = Living Room
    call SaveGame
    jmp Living_Room
	
Write:
    push cls_cmd
    call _system
    ; vis prompt
    push name_prompt
    call _printf
    add esp, 4
    
    ; read name (one word)
    push name_prompt
    push name_format          ; scanf-format (%99s)
    call _scanf
    add esp, 8

   
    push write_mode
    push filenamename
    call _fopen
    add esp, 8
    mov [file], eax

    ; wrtie name + new line
    push name_prompt
    push fprintf_format       ; fprintf-format (%s\n)
    push dword [file]
    call _fprintf
    add esp, 12

    push dword [file]
    call _fclose
    add esp, 4

    jmp Living_Room




find_map:
    push cls_cmd
    call _system
    mov byte [map_found], 1
    push map_text_found
    call _printf
    call _getch      

   
    push cls_cmd
    call _system
    jmp Living_Room

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map       ;
    push Living_Room
    mov dword [retur_value], 4 ; 4 = Living_Room
    call Show_map
    jmp Living_Room

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Living_Room
