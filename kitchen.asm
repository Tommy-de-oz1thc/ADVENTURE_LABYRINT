global Kitchen
global have_key

	 extern ret_to_kichten
	 extern Hallway
	 extern _printf, _scanf, _getch, _system
     extern choose, have_key, retur_value, map_found	 
	 
section .data
    text_kitchen db "You are now in the slightly messy kitchen.", 10, 0
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
   

section .bss
	have_key resd 1
	
section .text
    
Kitchen:
    push cls_cmd             ; clear screan
    call _system

    push text_kitchen
    call _printf
    add esp, 4
		
	push choose
    push choose_format
    call _scanf                
    add esp, 8
	
	call _getch
	call Hallway