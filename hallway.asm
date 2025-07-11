global Hallway
global map_found

extern _printf, _scanf, _getch, _system 
extern Living_Room, Kitchen, Bedroom, Attic, exit_game, Show_map
extern choose, have_key, retur_value
extern ret_to_hallway

section .data
    cls_cmd db "cls", 0       ; define the clear screan
	text_hallway db "You are now in the Hallway", 10, 0
    prompthallway1 db "Living Room(1), Bedroom(2), Kitchen(3), Attic(4), Exit the House(5): Take the Map(6)", 0
    prompthallway2 db "Living Room(1), Bedroom(2), Kitchen(3), Attic(4), Exit the House(5): ", 0
	choose_format db "%d", 0
	map_text_found db "You pick up the old map:", 10, "Press any key to continue", 0
    no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0

	  
    
section .bss
   map_found resb 1
   
section .text  	
Hallway:
    push cls_cmd        ; clear screan
    call _system
    
	push text_hallway   ; set text to print out
	call _printf        ; print out text
	add esp, 4
	
	mov eax, [map_found]    ;check up map is found
    cmp eax, 0
    je .spring_map_tip

    push map_tip
    call _printf
    add esp, 4

.spring_map_tip:   
    mov eax, [map_found]	;check up map is found
    cmp eax, 0
    je show_prompt1

    push prompthallway2
    call _printf
    add esp, 4
    jmp scan_choose

show_prompt1:
    push prompthallway1
    call _printf
    add esp, 4
	
scan_choose:
    push choose                 ;choose room to jump to
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
	mov dword [retur_value], 1 ; 1 = Hallway
    je Attic					;check up you the key to open the door to the attic
    cmp eax, 5
    je exit_game
    cmp eax, 6
    je find_map
    cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
	
    call _getch
    jmp Hallway                 ;jump back if no room was choosen  

find_map:
    push cls_cmd
    call _system
    mov byte [map_found], 1
    push map_text_found
    call _printf
    call _getch       
    push cls_cmd
    call _system
    jmp Hallway

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map       

    mov eax, Hallway
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
   


