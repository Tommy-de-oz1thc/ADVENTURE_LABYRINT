global Attic

extern ret_to_attic
extern choose, have_key, retur_value, map_found
extern _printf, _scanf, _getch, _system
extern Hallway
extern choose


section .data
	text_attic db "You are now in the dusty attic. There's not much here... yet.", 10, 0
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
	
section .bss

section .text

Attic: 
	push cls_cmd            ; clear screan
    call _system

    push text_attic
    call _printf
    add esp, 4
		
	push choose
    push choose_format
    call _scanf                
    add esp, 8
	
	call _getch
	call Hallway