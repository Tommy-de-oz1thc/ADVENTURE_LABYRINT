global main ;Starter file
global current_room
global have_key
global map_found
global choose
global exit_game
extern _exit
extern _fopen, _fgets, _printf
extern Hallway, Bedroom, Kitchen, Living_Room, Attic   ;link to room
extern _printf, _scanf, _getch, _system  
extern LoadGame

section .data
    cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0  ; define the choose value
	intro_line1 db "+------------------------------------------+", 10, 0
	intro_line2 db "|  WELCOME TO ADVENTURE LABYRINT           |", 10, 0
	intro_line3 db "|  Made by Tommy Clemmensen *OZ1THC* 2025  |", 10, 0
	intro_line4 db "|  coded in NASM Assembly - Version 0.3a   |", 10, 0
	intro_line5 db "+------------------------------------------+", 10, 0
	press_key_txt db "Start(1), Load Game (501) ", 0
    sluttext db "Press any key to exit.", 10, 0
   

section .bss
	choose resd 1
	current_room resd 1
    have_map     resd 1
    have_key     resd 1
	map_found resb 1
	 
section .text   
    
show_intro_box:
    push intro_line1
    call _printf
    add esp, 4

    push intro_line2
    call _printf
    add esp, 4

    push intro_line3
    call _printf
    add esp, 4

    push intro_line4
    call _printf
    add esp, 4

    push intro_line5
    call _printf
    add esp, 4

    push press_key_txt
    call _printf
    add esp, 4

    ret

main:
    push cls_cmd   ; clear screan
    call _system

    call show_intro_box	
     
    push choose                 ;choose room to jump to
    push choose_format
    call _scanf                
    add esp, 8

    mov eax, [choose]
    cmp eax, 1
	je Hallway
    cmp eax, 501
    je LoadAndStart
    cmp eax, 2
	jmp main;
	
LoadAndStart:
    call LoadGame
    mov eax, [current_room]
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je Bedroom
    cmp eax, 3
    je Kitchen
    cmp eax, 4
    je Attic
    cmp eax, 5
    je Living_Room
    jmp Hallway  ; fallback
	
exit_game:
    push cls_cmd   ; clear screan
    call _system
	
    push sluttext
    call _printf
    add esp, 4
    call _getch
   
    mov eax, 1      
    push eax
    call _exit    

