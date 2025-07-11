global Reverse
extern  _printf, _scanf,  _getch, _system
extern  Hallway, Biblevers
extern map_found

section .data
	cls_cmd     db "cls", 0
	input_fmt   db "%255s", 0
	output_fmt  db "Backwards: %s", 10, 0
	inputText   db "Write a word and I will reverse it", 10, 0
	reverse_info  db "You are now standing in the Reverse room.", 10, 0
	reversetext db "Go back to Hallway(1), Reverse Text(2), Go to Biblevers(3): ", 0 
	map_tip    db 'Type "1000" to view the map', 10, 0
	key_press db "Press any key to go back.", 0
	no_map_msg db "You don't have the map, press any key to go back.", 0
	choose_format db "%d", 0
	
section .bss
    buffer      resb 256
    reversed    resb 256
    choose      resd 1	
	
section .text

Reverse:
    push cls_cmd
    call _system 

    mov eax, [map_found]
    cmp eax, 0
    je .spring_map_tip

    push map_tip
    call _printf
    add esp, 4

.spring_map_tip:
   	
	push reverse_info
    call _printf
    add esp, 4
	
	push reversetext
    call _printf
    add esp, 4
	
.read_choice:
    add esp, 4
    push choose               ;choose room to jump to
    push choose_format
    call _scanf
    add esp, 8

    mov eax, [choose]
    cmp eax, 1
    je Hallway
    cmp eax, 2
    je read_input
	cmp eax, 3
    je Biblevers
	jmp Reverse

read_input:
    push inputText
    call _printf
    add esp, 4

    push buffer
    push input_fmt
    call _scanf
    add esp, 8

    push buffer
    push reversed
    call reverse
    add esp, 8

    push    reversed
    push    output_fmt
    call    _printf
    add     esp, 8
	
	push    key_press
    call    _printf
    add     esp, 4
    
	call _getch
    jmp Reverse
	
; ----------------------------------------
; reverse: turn a string around
; ----------------------------------------
reverse:
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ecx
    push    eax

    mov     edi, [ebp+8]     
	mov     esi, [ebp+12]   

    xor     ecx, ecx
	
.find_len:
    cmp     byte [esi + ecx], 0
    je      .found_len
    inc     ecx
    jmp     .find_len

.found_len:
    mov     eax, ecx        
    mov     ebx, 0          

.reverse_loop:
    dec     ecx             
    mov     al, [esi + ecx]
    mov     [edi + ebx], al
    inc     ebx
    cmp     ecx, 0
    jne     .reverse_loop

    ; Null-terminator
    mov     byte [edi + ebx], 0

    pop     eax
    pop     ecx
    pop     edi
    pop     esi
    pop     ebp
	ret
	