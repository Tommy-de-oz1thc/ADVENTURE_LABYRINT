global show_keys_and_try_unlock

extern _printf, _getch, _system
extern have_key_attic
extern key_names, key_flags
extern attic_entry, Kitchen, Hallway
extern retur_value 

section .data
	invalid_key_msg db "Wrong key!", 10, 0
	no_keys_msg db "The door is Locked and you have no keys! Press any key to go back.", 10, 0
	choose_key_msg db "Choose a key:", 10, 0
	success_msg db "The door is now open!", 10, 0
	cls_cmd db "cls", 0       ; define the clear screan
  
    key_format db "%d. %s", 10, 0
section .text

; Funktion: Viser spillerens nøgler og lader dem vælge
show_keys_and_try_unlock:
    push cls_cmd             ; clear screan
    call _system
	
    pushad

    ; check for keys
    mov esi, 0
    mov ecx, 0 ; tæller fundne nøgler
    mov edi, 1 ; tæller til visning af nummer

.check_keys:
    cmp esi, 1               ; vi har to nøgler (0 og 1)
    jge .no_keys_check

    mov ebx, [key_flags + esi*4]
    mov al, [ebx]
    test al, al
    jz .next_key

    push dword [key_names + esi*4]
    push edi
    push key_format
    call _printf
    add esp, 12

    inc ecx
    inc edi

.next_key:
    inc esi
    jmp .check_keys

.no_keys_check:
    cmp ecx, 0
    jne .get_choice

    push no_keys_msg
    call _printf
    add esp, 4
    call _getch
    mov eax, [retur_value]
    cmp eax, 1
    je Hallway
	ret

.get_choice:
    push choose_key_msg
    call _printf
    add esp, 4

    call _getch
    sub al, '0'

    cmp al, 1
    je .try_attic
   ; cmp al, 2
   ; je .try_kitchen
    jmp .wrong_key

.try_attic:
    mov al, [have_key_attic]
    cmp al, 1
    jne .wrong_key

    push success_msg
    call _printf
    add esp, 4
    call _getch
    popad
    jmp attic_entry

.try_kitchen:
   ; mov al, [have_key_kitchen]
    ;cmp al, 1
   ; jne .wrong_key

    push success_msg
    call _printf
    add esp, 4
    call _getch
    popad
    jmp Kitchen

.wrong_key:
    push invalid_key_msg
    call _printf
    add esp, 4
    call _getch
    mov eax, [retur_value]
    cmp eax, 1
    je Hallway
	ret

