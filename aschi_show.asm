global Aschii_Show

extern Bedroom, TV_Room, SaveGame, Show_map
extern _scanf, _printf, _system, _getch
extern choose, current_room, retur_value 
extern map_found, have_key_creative

section .data
utf8_cmd db "chcp 65001 > nul", 0
no_map_msg db "You don't have the map, press any key to go back.", 0
map_tip db 'Press "1000" to view the map', 10, 0
found_text db "You find a golden key on the table.", 10, 0
say_cmd db "txt\\say.exe You find a golden key on the table. Can you figure out where it belongs to?", 0
	
Thumbs_Up db "   ┈┈┈┈▕▔╲", 10
          db "┈┈┈▏▕ⓈⓊⓅⒺⓇ", 10
          db "┈┈▏▕▂▂▂┈┈", 10
          db "▂▂▂▂╱▕▂▂▏", 10
          db "▉▉▉▉▉▕▂▂▏", 10
          db "▉▉▉▉▉▕▂▂▏", 10
          db "▔▔▔▔╲▕▂▂▏", 10
          db "Thumbs Up", 10, 0
		  

Teddy	db "───▄▀▀▀▄▄▄▄▄▄▄▀▀▀▄───", 10
		db "───█▒▒░░░░░░░░░▒▒█───", 10     
		db "────█░░█░░░░░█░░█────", 10
		db "─▄▄──█░░░▀█▀░░░█──▄▄─", 10
		db "█░░█─▀▄░░░░░░░▄▀─█░░█", 10
		db "Teddy", 10, 0
		
		
		
		

Like db "████████████████████████████████████████", 10
     db "████████████████████████████████████████", 10
     db "██████▀░░░░░░░░▀████████▀▀░░░░░░░▀██████", 10
     db "████▀░░░░░░░░░░░░▀████▀░░░░░░░░░░░░▀████", 10
     db "██▀░░░░░░░░░░░░░░░░▀▀░░░░░░░░░░░░░░░░▀██", 10
     db "██░░░░░░░░░░░░░░░░░░░▄▄░░░░░░░░░░░░░░░██", 10
     db "██░░░░░░░░░░░░░░░░░░█░█░░░░░░░░░░░░░░░██", 10
     db "██░░░░░░░░░░░░░░░░░▄▀░█░░░░░░░░░░░░░░░██", 10
     db "██░░░░░░░░░░████▄▄▄▀░░▀▀▀▀▄░░░░░░░░░░░██", 10
     db "██▄░░░░░░░░░████░░░░░░░░░░█░░░░░░░░░░▄██", 10
     db "████▄░░░░░░░████░░░░░░░░░░█░░░░░░░░▄████", 10
     db "██████▄░░░░░████▄▄▄░░░░░░░█░░░░░░▄██████", 10
     db "████████▄░░░▀▀▀▀░░░▀▀▀▀▀▀▀░░░░░▄████████", 10
     db "██████████▄░░░░░░░░░░░░░░░░░░▄██████████", 10
     db "████████████▄░░░░░░░░░░░░░░▄████████████", 10
     db "██████████████▄░░░░░░░░░░▄██████████████", 10
     db "████████████████▄░░░░░░▄████████████████", 10
     db "██████████████████▄▄▄▄██████████████████", 10
     db "████████████████████████████████████████", 10
     db "████████████████████████████████████████", 10, 0

Aschii_info db "You are in the Aschii Room.", 10, 0
Aschii_link db "Go to Bedroom(1), Show Thumbs Up(2), Show Teddy(3), Show Like(4), TV Room(5), Take Key(6) : ", 0
cls_cmd db "cls", 0       ; define the clear screan
choose_format db "%d", 0
exit_txt db "Press any Key", 0	
	
section .bss


section .text

Aschii_Show:
    push cls_cmd
    call _system

    mov eax, [map_found]    ;check up map is found
    cmp eax, 0
    je .spring_map_tip

    push map_tip
    call _printf
    add esp, 4
	
.spring_map_tip:
    push Aschii_info
	call _printf
	add esp, 4
	
	push Aschii_link
	call _printf
	add esp,4

    push choose
    push choose_format
    call _scanf
    add esp, 8


    mov eax, [choose]
    cmp eax, 1
    je Bedroom
    cmp eax, 2
    je Show_Thumbs_Up
    cmp eax, 3
    je Show_Teddy
    cmp eax, 4
	je Show_Like
	cmp eax, 5
	je TV_Room
	cmp eax, 6
	je Pick_key
	cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
    jne Aschii_Show

SaveAndContinue:
    mov dword [current_room], 9   ; 9 = Aschii
    call SaveGame
    jmp Aschii_Show
	
tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map

    mov eax, Aschii_Show
    mov dword [retur_value], 9 ; 9 = Aschi_Show
    call Show_map
    jmp Aschii_Show

Pick_key:
    push cls_cmd
    call _system
   
    movzx eax, byte [have_key_creative]
    cmp eax, 0
    je TakeIt

AlreadyHaveKey:
    push found_text
    call _printf
    add esp, 4
    call _getch
    jmp Aschii_Show

TakeIt:
	mov byte [have_key_creative], 1

    push found_text
    call _printf
    add esp, 4
	push say_cmd     ; Tekst-til-tale: "Hello from Assembly"
    call _system 
    call _getch
    jmp Aschii_Show


SkipKey:
    cmp eax, 0
    jne AlreadyHaveKey

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Aschii_Show
	
Show_Thumbs_Up:
    push utf8_cmd
    call _system
	push Thumbs_Up
	jmp ret_Print
	
Show_Teddy:
    push utf8_cmd
    call _system
	push Teddy
	jmp ret_Print
	
Show_Like:
    push utf8_cmd
    call _system
	push Like
	jmp ret_Print
	
ret_Print:
    call _printf
	add esp, 4
	
	push exit_txt
	call _printf
	add esp, 4
	
	call _getch
	jmp Aschii_Show
	
	