global main ;Starter file
global current_room
global retur_value
global map_found
global choose
global exit_game
extern _exit
extern _fopen, _fgets, _printf
extern Hallway, Bedroom, Kitchen, Living_Room, Attic, SaveGame, LoadGame, Biblevers, Reverse   ;link to room
extern _printf, _scanf, _getch, _system, retur_value 
extern LoadGame

section .data
    cls_cmd db "cls", 0       ; define the clear screan
	choose_format db "%d", 0  ; define the choose value
	intro_line1 db "+------------------------------------------+", 10, 0
	intro_line2 db "|  WELCOME TO ADVENTURE LABYRINT           |", 10, 0
	intro_line3 db "|  Made by Tommy Clemmensen *OZ1THC* 2025  |", 10, 0
	intro_line4 db "|  coded in NASM Assembly - Version 3.0    |", 10, 0
	intro_line5 db "+------------------------------------------+", 10, 0
	press_key_txt db "Start(1), Save Game *works in all rooms*(500) Load Game *work only her*(501) ", 0
    slutHallway db "You walked out of the house", 10, 0
	sluttext db "Press any key to exit.", 0
	slutAttic db "Do not jump out off a window.", 10, 0
    say_cmd db "txt\\say.exe Welcome to Adventur Libyrint. Press 1 to start.", 0

    retur_value dd 0
    


section .bss
	choose resd 1
	current_room resd 1
  
  
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
    push cls_cmd            ; clear screan
    call _system

    call show_intro_box	
    push say_cmd     ; Tekst-til-tale: "Hello from Assembly"
    call _system 
    push choose
    push choose_format
    call _scanf                
    add esp, 8

    mov eax, [choose]
    cmp eax, 1
    je Hallway
    cmp eax, 500
    je SaveAndContinue
    cmp eax, 501
    je LoadGame

invalid_choice:
    push say_cmd     ; Tekst-til-tale: "Hello from Assembly"
    call _system

    push press_key_txt
    call _printf
    add esp, 4
    jmp main

	
SaveAndContinue:
    mov dword [current_room], 0   ; 0 = main
    call SaveGame
    jmp main
	
exit_game:
    push cls_cmd
    call _system

    mov eax, [retur_value]
    cmp eax, 5          ; 5 = Attic
    je attic_exit

hallway_exit:
    push slutHallway   ; Almindelig afslutning
    call _printf
    add esp, 4
    jmp done

attic_exit:
    push slutAttic     ; Alternativ afslutning fra loftet
    call _printf
    add esp, 4

done:
    push sluttext      ; Almindelig afslutning
    call _printf
    add esp, 4
    call _getch
    mov eax, 0
    ret

    

