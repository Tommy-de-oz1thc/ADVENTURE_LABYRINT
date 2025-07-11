global Show_map
global retur_value
global ret_to_hallway, ret_to_living_room, ret_to_bedroom, ret_to_kitchen, ret_to_attic

extern _printf, _getch, _system
extern _fopen, _fclose, _fgets
extern Hallway, Living_Room, Bedroom, Kitchen, attic_entry

section .data
	map_text     db "You look at the old map:", 10, "[map contents here]", 10, 0
	go_back        db "", 10, "Press a key to return.", 10, 0
	cls_cmd        db "cls", 0
	filenamekort   db "map.txt", 0
	read_modek     db "r", 0


section .bss
	choose resd 1
	file resd 1   
	read_buf resb 100 
	retur_ptr resd 1
	retur_value resd 1   ; <-- Tilføjet for at gøre retur_værdi tilgængelig


section .text

Show_map:
    push cls_cmd
    call _system

  
    push read_modek
    push filenamekort
    call _fopen
    add esp, 8
    mov [file], eax

   
    push dword [file]
    push 100
    push read_buf
    call _fgets

    
    push dword [file]
    push 100
    push read_buf
    call _fgets
    add esp, 12
    mov [retur_ptr], eax
    cmp dword [retur_ptr], 0
    je close_and_end

    push cls_cmd
    call _system

    ; vis overskrift
    push map_text
    call _printf
    add esp, 4

show_line_map:
    push read_buf
    call _printf
    add esp, 4

    ; læs næste linje
    push dword [file]
    push 100
    push read_buf
    call _fgets
    add esp, 12
    mov [retur_ptr], eax
    cmp dword [retur_ptr], 0
    jne show_line_map

finish_with_reading_map:
    push dword [file]
    call _fclose
    add esp, 4

    push go_back
    call _printf
    add esp, 4
    call _getch
   
    mov eax, [retur_value]
    cmp eax, 1
    je ret_to_hallway
    cmp eax, 2
    je ret_to_living_room
    cmp eax, 3
    je ret_to_bedroom
    cmp eax, 4
    je ret_to_kitchen
	cmp eax, 5
    je ret_to_attic
   
    jmp Show_map

ret_to_hallway:
    mov dword [retur_value], 0
    jmp Hallway

ret_to_living_room:
    mov dword [retur_value], 0
    jmp Living_Room

ret_to_bedroom:
    mov dword [retur_value], 0
    jmp Bedroom

ret_to_kitchen:
    mov dword [retur_value], 0
    jmp Kitchen
	
ret_to_attic:
    mov dword [retur_value], 0
    jmp attic_entry

close_and_end:
    push dword [file]
    call _fclose
    add esp, 4
    jmp finish_with_reading_map
