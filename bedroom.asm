global Bedroom

extern Hallway, Living_Room, Kitchen, Show_map, SaveGame, Aschii_Show
extern _printf, _scanf, _getch, _system
extern choose, map_found, map_tip
extern _fopen, _fprintf, _fclose, _fgets
extern retur_value, current_room

section .data
    text_bedroom db "You are now in the bedroom", 10, 0  
    cls_cmd db "cls", 0       ; define the clear screan
    choose_format db "%d", 0
	promptbedroom db "Hallway(1), Living room(2), Kitchen(3), Read(4), Aschii Room(5): ", 0
	filename db "txt\\names.txt", 0
	read_mode db "r", 0
	no_name db "No names yet", 10, 0
	nameheadline db "Names in the list:", 10, 0
	newline db 10, 0
	go_return db "Press any key to return.", 10, 0
	no_map_msg db "You don't have the map, press any key to go back.", 0
	map_tip db 'Press "1000" to view the map', 10, 0
	
section .bss
    file resd 1  
    read_buf resb 100	
    retur resd 1 
	
section .text
    
Bedroom:
    push cls_cmd            ; clear screan
    call _system


    mov eax, [map_found]    ;check up map is found
    cmp eax, 0
    je .spring_map_tip

    push map_tip
    call _printf
    add esp, 4
	
.spring_map_tip:   
    
	push text_bedroom       ; set text to print out  
    call _printf
    add esp, 4
	
	push promptbedroom
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
    je Living_Room
    cmp eax, 3
    je Kitchen
    cmp eax, 4
    je Read
	cmp eax, 5
    je Aschii_Show
	cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
	jmp Bedroom
	
SaveAndContinue:
    mov dword [current_room], 2   ; 2 = Bedroom
    call SaveGame
    jmp Bedroom
	
Read:
    ; opon file in  read-mode
    push read_mode
    push filename
    call _fopen
    add esp, 8
    mov [file], eax

    ; if file == 0, show "no names yet"
    cmp eax, 0
    je no_names

    ; læs første linje
    push dword [file]
    push 100
    push read_buf
    call _fgets

    call _fgets
    add esp, 12
    mov [retur], eax
    cmp dword [retur], 0
    je close_and_end
    push cls_cmd
    call _system
   
    push nameheadline
    call _printf
    add esp, 4

.show_line:
    push read_buf
    call _printf              ;write to txt file
    add esp, 4

    ; read next line
    push dword [file]
    push 100
    push read_buf
    call _fgets
    add esp, 12
    mov [retur], eax
    cmp dword [retur], 0
    jne .show_line

.finish_with_reading:
    ; close file and go return
    push dword [file]
    call _fclose
    add esp, 4
    push go_return
    call _printf
    add esp, 4
    call _getch      
	jmp Bedroom

no_names:
    push no_name               ;write a msg if no names in the txt file
    call _printf
    add esp, 4
    push go_return
    call _printf
    add esp, 4
    call _getch      
    jmp Bedroom

close_and_end:
    push dword [file]
    call _fclose
    add esp, 4
    jmp no_names

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map 

    mov eax, Bedroom
    mov dword [retur_value], 3 ; 3 = Bedroom
    call Show_map
    jmp Bedroom

not_any_map:
    push cls_cmd              ;clear the screan
    call _system
    push no_map_msg           ;tells that you do not have the map
    call _printf
    add esp, 4
    call _getch
    jmp Bedroom

