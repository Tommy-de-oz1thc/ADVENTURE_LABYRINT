; -------- CW_Code_Word.asm --------
global  CW_Code_Word
extern  _printf, _getch, _rand, _srand, _time, _system, _putchar
extern _scanf, choose, current_room, retur_value
extern _strcmp
extern Hallway, TV_Room, Show_map, SaveGame 
extern system
extern map_found

section .data
ord1 db "code",0
ord2 db "morse",0
ord3 db "signal",0
ord4 db "radio",0
ord5 db "antenna",0
ord6 db "listen",0
ord7 db "transmit",0
ord8 db "receive",0
ord9 db "sos",0
ord10 db "telegraph",0
ord11 db "freq",0
ord12 db "noise",0
ord13 db "rhythm",0
ord14 db "melody",0
ord15 db "wave",0
ord16 db "codex",0
ord17 db "electron",0
ord18 db "light",0
ord19 db "hertz",0
ord20 db "pulse",0
ord21 db "sender",0
ord22 db "receiver",0
ord23 db "beat",0
ord24 db "bit",0
ord25 db "symbol",0

word_ptrs dd ord1, ord2, ord3, ord4, ord5, ord6, ord7, ord8, ord9, ord10
          dd ord11, ord12, ord13, ord14, ord15, ord16, ord17, ord18, ord19, ord20
          dd ord21, ord22, ord23, ord24, ord25
		  
		  
wav_a_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\a.wav").PlaySync()', 0
wav_b_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\b.wav").PlaySync()', 0
wav_c_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\c.wav").PlaySync()', 0
wav_d_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\d.wav").PlaySync()', 0
wav_e_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\e.wav").PlaySync()', 0
wav_f_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\f.wav").PlaySync()', 0
wav_g_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\g.wav").PlaySync()', 0
wav_h_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\h.wav").PlaySync()', 0
wav_i_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\i.wav").PlaySync()', 0
wav_j_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\j.wav").PlaySync()', 0
wav_k_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\k.wav").PlaySync()', 0
wav_l_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\l.wav").PlaySync()', 0
wav_m_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\m.wav").PlaySync()', 0
wav_n_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\n.wav").PlaySync()', 0
wav_o_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\o.wav").PlaySync()', 0
wav_p_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\p.wav").PlaySync()', 0
wav_q_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\q.wav").PlaySync()', 0
wav_r_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\r.wav").PlaySync()', 0
wav_s_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\s.wav").PlaySync()', 0
wav_t_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\t.wav").PlaySync()', 0
wav_u_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\u.wav").PlaySync()', 0
wav_v_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\v.wav").PlaySync()', 0
wav_w_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\w.wav").PlaySync()', 0
wav_x_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\x.wav").PlaySync()', 0
wav_y_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\y.wav").PlaySync()', 0
wav_z_cmd db 'powershell -c (New-Object Media.SoundPlayer "cw\\z.wav").PlaySync()', 0

wav_cmd_ptrs:
    dd wav_a_cmd, wav_b_cmd, wav_c_cmd, wav_d_cmd, wav_e_cmd
    dd wav_f_cmd, wav_g_cmd, wav_h_cmd, wav_i_cmd, wav_j_cmd
    dd wav_k_cmd, wav_l_cmd, wav_m_cmd, wav_n_cmd, wav_o_cmd
    dd wav_p_cmd, wav_q_cmd, wav_r_cmd, wav_s_cmd, wav_t_cmd
    dd wav_u_cmd, wav_v_cmd, wav_w_cmd, wav_x_cmd, wav_y_cmd, wav_z_cmd


	
play_cmd   db "play cwplay wait", 0
close_cmd  db "close cwplay", 0

info_txt   db "CW Code Word Room",10,0
go_to_txt db "Go to Hallway(1), Hear CW(2): ", 0
cw_txt     db "I sent you 10 words to answer: ", 10, 0
fmt_word   db "%s ",10, 0
cls_cmd    db "cls",0
input_format  db "%s", 0
input_prompt  db "Type your answer: ", 0
correct_txt   db "Well done!", 10, 0
wrong_txt     db "Oops! That's not it.", 10, 0
keypress      db "Press any key to continue", 0
choose_format db "%d", 0
result_txt db "You have %d correct!", 10, 0
not_enough_txt db "You Failed, you need 6 to Pass!", 10, 0
pass_txt db "PASS, Congratulation you passed!", 10, "And you can open the door to the TV Room", 10, 0
no_map_msg db "You don't have the map, press any key to go back.", 0
map_tip db 'Press "1000" to view the map', 10, 0

section .bss
used          resb 25        ; 0/1-flags for allerede valgte ord
selected_ptrs resd 10        ; plads til 10 pointere
cur_time      resd 1         ; buffer til time()
user_input    resb 32
correct_count  resd 1


section .text
CW_Code_Word:
    ; ryd skærmen (Windows 'cls')
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
    add  esp,4
    mov dword [correct_count], 0
    push info_txt      ; eller ny tekst fx: "CW færdig – tilbage til spillet"
    call _printf
    add  esp,4

    push go_to_txt
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
    je Start_CW
	cmp eax, 500
    je SaveAndContinue
    cmp eax, 1000
    je tjeck_map_showing  
    jmp CW_Code_Word
    ; nulstil 'used'
    
Start_CW:	
	mov ecx, 25
    xor eax, eax
	
	
clr_loop:
    mov [used + ecx - 1], al
    loop clr_loop

    ; seed rand()
    lea  eax,[cur_time]
    push eax
    call _time
    add  esp,4
    mov  eax,[cur_time]
    push eax
    call _srand
    add  esp,4

    push cls_cmd
    call _system
    add  esp,4

    push cw_txt      ; eller ny tekst fx: "CW færdig – tilbage til spillet"
    call _printf
    add  esp,4

   

    ; vælg 10 unikke ord
    xor ebx, ebx        ; valgt antal ord = 0
select_loop:
    call _rand
    xor edx, edx
    mov ecx, 25
    div ecx             ; edx = rand() % 25
    mov esi, edx

    cmp byte [used + esi], 1
    je select_loop

    mov byte [used + esi], 1
    mov eax, [word_ptrs + esi*4]
    mov [selected_ptrs + ebx*4], eax

    inc ebx
    cmp ebx, 10
    jne select_loop

        xor edi, edi

ask_loop:
        ; hent pointer til ord og find index
    mov eax, [selected_ptrs + edi*4]  ; pointer til ord
    mov ecx, 0

find_wav_index:
    cmp ecx, 25
    jge skip_play
    mov ebx, [word_ptrs + ecx*4]
    cmp eax, ebx
    je play_wav
    inc ecx
    jmp find_wav_index

play_wav:
    push esi
    push edi
    push ecx

    mov esi, eax        ; pointer til ordet
.next_letter:
    mov al, [esi]
    cmp al, 0
    je .done

    sub al, 'a'
    jl .skip
    cmp al, 25
    ja .skip

    movzx ecx, al
    mov eax, [wav_cmd_ptrs + ecx*4]
    push eax
    call _system        ; afspil med PowerShell
    add esp, 4

.skip:
    inc esi
    jmp .next_letter

.done:
    pop ecx
    pop edi
    pop esi
    jmp skip_play   ; <-- fortsæt til næste trin i ask_loop




skip_play:

    ; vis ét ord
    mov eax, [selected_ptrs + edi*4]
    push eax
   ; push fmt_word
   ; call _printf
   ; add esp, 8

    ; bed om gæt
    push input_prompt
    call _printf
    add esp, 4

    ; læs brugerens gæt
    lea eax, [user_input]
    push eax
    push input_format
    call _scanf
    add esp, 8

    ; sammenlign brugerens input med det rigtige ord
    mov eax, [selected_ptrs + edi*4]
    push eax
    lea ebx, [user_input]
    push ebx
    call _strcmp
    add esp, 8

    test eax, eax
    jne wrong_guess

    push correct_txt
    call _printf
    add esp, 4
	mov eax, [correct_count]
    inc eax
    mov [correct_count], eax
    jmp next_word

wrong_guess:
    push wrong_txt
    call _printf
    add esp, 4

next_word:
    inc edi
    cmp edi, 10
    jl ask_loop
	mov eax, [correct_count]
    push eax
    push result_txt
    call _printf
    add esp, 8
    ; Tjek om spilleren har mere end 6 rigtige
    mov eax, [correct_count]
    cmp eax, 6
    jl not_enough


pass:
    push pass_txt
    call _printf
    add esp, 4
	push keypress
	
	call _printf
	add esp, 4
	call _getch
    jmp TV_Room
    


 
not_enough:
    ; Udskriv besked hvis der ikke er nok rigtige
    push not_enough_txt
    call _printf
    add esp, 4

	push keypress
	call _printf
	add esp, 4
	
SaveAndContinue:
    mov dword [current_room], 3   ; 3 = Kitchen
    call SaveGame
    jmp Hallway

show_map:
    ; placeholder for map funktion
    call _getch
    jmp Hallway

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map      
    mov eax, CW_Code_Word
    mov dword [retur_value], 8 ; 8 = CW_Code_Word
    call Show_map
    jmp CW_Code_Word

not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp CW_Code_Word
	
	
call _getch
jmp CW_Code_Word