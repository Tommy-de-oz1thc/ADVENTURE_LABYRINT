global Kitchen


	 extern ret_to_kichten
	 extern Hallway, Bedroom, Living_Room, Show_map, SaveGame
	 extern _printf, _scanf, _getch, _system
     extern choose, have_key, retur_value, map_found, current_room	 
	 extern have_key_attic, have_key_kitchen
	 
section .data
    text_kitchen db "You are now in the slightly messy kitchen.", 10, 0
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
    prompt1_kitchen db "Hallway(1), Living room(2), Bedroom(3), Take key(4): ", 0
    prompt2_kitchen db "Hallway(1), Living room(2), Bedroom(3): ", 0
    found_text db "You find a rusty key on the table. Press any key to pick it up.", 10, 0
    no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0

    debug_format db "DEBUG: have_key_attic = %d", 10, 0
	
section .bss
	
	
section .text
    
Kitchen:
    push cls_cmd             ; clear screan
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
	
    push text_kitchen
    call _printf
    add esp, 4
	
    mov al, [have_key_attic]
    cmp al, 0
    je .show_prompt_with_key

    ; Har allerede nøglen – vis menu uden "Take key"
    push prompt2_kitchen
    call _printf
    add esp, 4
    jmp .read_choice

.show_prompt_with_key:
    ; Har IKKE nøglen – vis menu med "Take key"
    push prompt1_kitchen
    call _printf
    add esp, 4


.read_choice:
    add esp, 4
    push choose               ;choose room to jump to
    push choose_format
    call _scanf
    add esp, 8

    mov eax, [choose]
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je Living_Room
    cmp eax, 3
    je Bedroom
    cmp eax, 4
    je Pick_key
	cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing      ;show a txt with the map
    jmp Kitchen               ;jump back if no room was choosen  
	
SaveAndContinue:
    mov dword [current_room], 3   ; 3 = Kitchen
    call SaveGame
    jmp Kitchen
	
Pick_key:
    push cls_cmd
    call _system
   ; mov eax, [have_key]
    movzx eax, byte [have_key_attic]
    cmp eax, 0
    je TakeIt

AlreadyHaveKey:
    push found_text
    call _printf
    add esp, 4
    call _getch
    jmp Kitchen

TakeIt:
   ; mov dword [have_key], 1
	mov byte [have_key_attic], 1

    push found_text
    call _printf
    add esp, 4
    call _getch
    jmp Kitchen


SkipKey:
    cmp eax, 0
    jne AlreadyHaveKey


tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map      
    mov eax, Kitchen
    mov dword [retur_value], 3 ; 3 = Kitchen
    call Show_map
    jmp Kitchen

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Kitchen
