global TV_Room

extern _getch, _printf, _scanf, _system
extern choose, current_room, retur_value
extern SaveGame, Show_map 
extern CW_Code_Word
extern map_found

section .data
TV_Room_txt db "You are in the TV Room", 10, 0
go_to_txt db "CW_Code_Room(1): ", 0
choose_format db "%d", 0
cls_cmd db "cls", 0       ; define the clear screan
no_map_msg db "You don't have the map, press any key to go back.", 0
map_tip db 'Press "1000" to view the map', 10, 0
	
section . text
TV_Room:
    push cls_cmd
    call _system
	
	mov eax, [map_found]     ;check up map is found
    cmp eax, 0
    je .spring_map_tip

	cmp eax, 0
    je .spring_map_tip

    push map_tip
	call _printf
	add esp, 4
	
.spring_map_tip:	
	push TV_Room_txt
	call _printf
	add esp, 4
	
	push go_to_txt
	call _printf
	add esp, 4
	
	push choose
    push choose_format
    call _scanf
    add esp, 8


    mov eax, [choose]
    cmp eax, 1
    je CW_Code_Word 
	cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing  
	jmp TV_Room



SaveAndContinue:
    mov dword [current_room], 3   ; 3 = Kitchen
    call SaveGame
    jmp TV_Room

show_map:
    ; placeholder for map funktion
    call _getch
    jmp TV_Room

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map      
    mov eax, TV_Room
    mov dword [retur_value], 1 ; 1 = Hallway
    call Show_map
    jmp TV_Room

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp TV_Room
