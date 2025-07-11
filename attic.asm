global Attic

extern choose, have_key, retur_value, map_found
extern _printf, _scanf, _getch, _system
extern Hallway, Show_map, SaveGame
extern choose
extern ret_to_hallway, current_room

section .data
	text_attic db "You are now in the dusty attic. There's not much here... yet.", 10, 0
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
	some_missing_text db "The door to the attic is locked. You don't have the key! Press any key to go back.", 10, 0
	name_format db "%s", 0
	greeting_format db "Hello %s %s", 10, 0
	prompt_attic db "Go back to the hallway(1), Backwards Text(2): ", 0
	frontname db "What is your first name? ", 0
	lastname db "What is your last name? ", 0
    no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0
	
section .bss

section .text

Attic: 

    call TjeckKey
	
	push cls_cmd            ; clear screan
    call _system
    	   
    push text_attic
    call _printf
    add esp, 4	
	
   ; Spørg om fornavn
    push frontname
    call _printf
    add esp, 4
    
    push frontname
    push name_format
    call _scanf
    add esp, 8
    
    ; Spørg om efternavn
    push lastname
    call _printf
    add esp, 4
    
    push lastname
    push name_format
    call _scanf
    add esp, 8
    
    ; Udskriv Goddag fornavn efternavn
    push lastname
    push frontname
    push greeting_format
    call _printf
    add esp, 12
		
	push prompt_attic
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
    ;je Reverse
	cmp eax, 500
    je SaveAndContinue
	cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
    jmp Attic

SaveAndContinue:
    mov dword [current_room], 5   ; 5 = Attic
    call SaveGame
    jmp Attic

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map

    mov eax, Attic
    mov dword [retur_value], 5 ; 5 = Attic
    call Show_map
    jmp Attic

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Attic
	
TjeckKey:
    mov eax, [have_key]
    cmp eax, 1
    je key_ok         ; hvis man HAR nøglen, så spring videre

    ; ellers vis fejlen og gå tilbage
    push cls_cmd
    call _system
    push some_missing_text
    call _printf
    add esp, 4
    call _getch
    jmp Hallway       ; send spilleren tilbage

key_ok:
    ret
