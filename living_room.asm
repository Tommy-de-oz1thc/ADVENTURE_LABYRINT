global Living_Room
extern ret_to_living_room

extern choose, have_key, retur_value, map_found

section .data
	text_living_room db "You are now in the living room", 10, 0  
    cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0
	
section .bss
    
   
section .text
    extern _printf, _scanf, _getch, _system    
    extern Hallway

Living_Room:
    push cls_cmd             ; clear screan
    call _system

    push text_living_room
    call _printf
    add esp, 4
		
	push choose
    push choose_format
    call _scanf                
    add esp, 8
	
	call _getch
	call Hallway