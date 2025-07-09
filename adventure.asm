global main ;Starter file
global choose
global exit_game
extern _exit

section .data
    cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0  ; define the choose value
	intro_line1 db "+------------------------------------------+", 10, 0
	intro_line2 db "|  WELCOME TO ADVENTURE LABYRINT           |", 10, 0
	intro_line3 db "|  Made by Tommy Clemmensen *OZ1THC* 2025  |", 10, 0
	intro_line4 db "|  coded in NASM Assembly - Version 0.1a   |", 10, 0
	intro_line5 db "+------------------------------------------+", 10, 0
	press_key_txt db "Press any key to start...", 10, 0
    sluttext db "press any key to exit.", 10, 0

section .bss
	choose resd 1

section .text
    extern _printf, _getch, _system    
    extern Hallway   ;link to room
    
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

    call _getch           ; wait for keypress

    call Hallway           ; jump to room
	
	
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