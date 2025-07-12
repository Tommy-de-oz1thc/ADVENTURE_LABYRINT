global Attic
global attic_entry

extern choose, have_key, retur_value, map_found
extern _printf, _scanf, _getch, _system
extern Hallway, Show_map, SaveGame, Reverse, exit_game
extern choose
extern ret_to_hallway, current_room
extern show_keys_and_try_unlock, have_key_attic

section .data
	text_attic db "You are now in the dusty attic. There's not much here... yet.", 10, 0
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
	some_missing_text db "The door to the attic is locked. You don't have the key! Press any key to go back.", 10, 0
	name_format db "%s", 0
	greeting_format db "Hello %s %s", 10, 0
	prompt_attic1 db "Go back to the hallway(1), Backwards(2), Jump out of a window(3), Ask Name(4), Take Map(5): ", 0
	prompt_attic2 db "Go back to the hallway(1), Backwards(2), Jump out of a window(3), Ask Name(4): ", 0
	frontname db "What is your first name? ", 0
	lastname db "What is your last name? ", 0
    no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0
	map_text_found db "You pick up the old map:", 10, "Press any key to continue", 0
    say_cmd db "txt\\say.exe You pick up a old map.", 0
	
section .bss

section .text

Attic: 	
    call TjeckKey_OK

attic_entry:
	push cls_cmd            ; clear screan
    call _system
	
    push text_attic
    call _printf
    add esp, 4	
		
	mov eax, [map_found]
    cmp eax, 0
    je show_prompt1

    push prompt_attic2
    call _printf
    add esp, 4
    jmp scan_choose

show_prompt1:
    push prompt_attic1
    call _printf
    add esp, 4

scan_choose:		
	push choose
    push choose_format
    call _scanf                
    add esp, 8
	
    mov eax, [choose]
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je Reverse
	cmp eax, 3
	mov dword [retur_value], 5 ; 5 = Attic
	je exit_game
	cmp eax, 4
	je Ask_Name
	cmp eax, 5
	je find_map
	cmp eax, 500
    je SaveAndContinue
	cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
    jmp attic_entry

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
    jmp attic_entry

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Attic

TjeckKey_OK:
    mov dword [retur_value], Hallway
    call show_keys_and_try_unlock
    cmp eax, 1
    je attic_entry   ; korrekt nøgle valgt
    jmp Hallway      ; forkert nøgle eller ingen nøgler

find_map:
  
    mov byte [map_found], 1
	push say_cmd     ; Tekst-til-tale: "Hello from Assembly"
    call _system 
    push map_text_found
    call _printf
	push cls_cmd
    call _system
    call _getch      
    jmp attic_entry

Ask_Name:   	
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
	
	call _getch
	jmp attic_entry