global Biblevers

extern _printf, _scanf, _getch, _system 
extern Reverse, current_room
extern Show_map, SaveGame
extern retur_value, map_found

section .data
    choose_format db "%d", 0
	cls_cmd db "cls", 0
	textbiblevers db "You are now in the Bible verse room.", 10, 0
	prompt1_Biblevers db "Go back to Backwards(1), View Bible verse(2): ", 0

	vers1  db "In the beginning God created the heaven and the earth.", 10, 0                  ; Genesis 1:1  
	vers2  db "The Lord is my shepherd; I shall not want.", 10, 0                             ; Psalm 23:1  
	vers3  db "Your word is a lamp to my feet and a light to my path.", 10, 0                ; Psalm 119:105  
	vers4  db "Trust in the Lord with all your heart and lean not on your own understanding; in all your ways acknowledge him, and he will make your paths straight.", 10, 0 ; Proverbs 3:5-6  
	vers5  db "Fear not, for I am with you; be not dismayed, for I am your God. I will strengthen you and help you; I will uphold you with my righteous right hand.", 10, 0 ; Isaiah 41:10  
	vers6  db "For I know the plans I have for you, declares the Lord, plans to prosper you and not to harm you, plans to give you a future and a hope.", 10, 0 ; Jeremiah 29:11  
	vers7  db "But seek first the kingdom of God and his righteousness, and all these things will be added to you.", 10, 0 ; Matthew 6:33  
	vers8  db "Come to me, all you who labor and are heavy laden, and I will give you rest.", 10, 0 ; Matthew 11:28  
	vers9  db "In the beginning was the Word, and the Word was with God, and the Word was God.", 10, 0 ; John 1:1  
	vers10 db "For the wages of sin is death, but the gift of God is eternal life in Christ Jesus our Lord.", 10, 0 ; Romans 6:23  
	vers11 db "And we know that all things work together for good to those who love God, to those who are called according to his purpose.", 10, 0 ; Romans 8:28  
	vers12 db "No temptation has overtaken you except such as is common to man. But God is faithful, and he will not allow you to be tempted beyond what you can bear; but with the temptation he will also make the way of escape, that you may be able to bear it.", 10, 0 ; 1 Corinthians 10:13  
	vers13 db "I can do all things through Christ who strengthens me.", 10, 0 ; Philippians 4:13  
	vers14 db "For God has not given us a spirit of fear, but of power and of love and of a sound mind.", 10, 0 ; 2 Timothy 1:7  
	vers15 db "Now faith is the substance of things hoped for, the evidence of things not seen.", 10, 0 ; Hebrews 11:1  
	vers16 db "Cast all your care upon Him, for He cares for you.", 10, 0 ; 1 Peter 5:7  
	vers17 db "Behold, I stand at the door and knock. If anyone hears my voice and opens the door, I will come in to him and dine with him, and he with me.", 10, 0 ; Revelation 3:20  

	remarks db "(1) Genesis 1:1", 10, \
         "(2) Psalm 23:1", 10, \
         "(3) Psalm 119:105", 10, \
         "(4) Proverbs 3:5-6", 10, \
         "(5) Isaiah 41:10", 10, \
         "(6) Jeremiah 29:11", 10, \
         "(7) Matthew 6:33", 10, \
         "(8) Matthew 11:28", 10, \
         "(9) John 1:1", 10, \
         "(10) Romans 6:23", 10, \
         "(11) Romans 8:28", 10, \
         "(12) 1 Corinthians 10:13", 10, \
         "(13) Philippians 4:13", 10, \
         "(14) 2 Timothy 1:7", 10, \
         "(15) Hebrews 11:1", 10, \
         "(16) 1 Peter 5:7", 10, \
         "(17) Revelation 3:20", 10, 10, 0


	versinfo db "Choose a verse to view: Back(0)", 0
	moveontext db "", 10, "Press a key to return.", 0
	map_tip db 'Press "1000" to view the map', 10, 0
	no_map_msg db "You don't have the map, press any key to go back.", 0



section .bss
	choose resd 1

section .text

Biblevers:
    push cls_cmd
	call _system

	mov eax, [map_found]
	cmp eax, 0
	je .spring_map_tip

	push map_tip
	call _printf
	add esp, 4

.spring_map_tip:
    push textbiblevers
    call _printf
    add esp, 4

    push prompt1_Biblevers
    call _printf               ; <-- underscore!
    add esp, 4
    
    push choose
    push choose_format
    call _scanf                ; <-- underscore!
    add esp, 8

    mov eax, [choose]
    cmp eax, 1
    je Reverse
    
    cmp eax, 2
    je Vers
    cmp eax, 500
    je SaveAndContinue
	cmp eax, 1000
    je tjeck_map_showing        ;show a txt with the map
    jmp Biblevers

SaveAndContinue:
    mov dword [current_room], 5   ; 5 = Attic
    call SaveGame
    jmp Biblevers

tjeck_map_showing:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map

    mov eax, Biblevers
    mov dword [retur_value], 8 ; 8 = Biblevers
    call Show_map
    jmp Biblevers



    
Vers:
    push cls_cmd
    call _system
    
    push remarks
    call _printf               ; <-- underscore!
    add esp, 4
    
    push versinfo
    call _printf               ; <-- underscore!
    add esp, 4
   
    push choose
    push choose_format
    call _scanf                ; <-- underscore!
    add esp, 8
    
    mov eax, [choose]
    cmp eax, 0
    je Biblevers
        
    cmp eax, 1
    je v1
    
    cmp eax, 2
    je v2
    
    cmp eax, 3
    je v3
    
    cmp eax, 4
    je v4
    
    cmp eax, 5
    je v5
    
    cmp eax, 6
    je v6
    
    cmp eax, 7
    je v7
    
    cmp eax, 8
    je v8
    
    cmp eax, 9
    je v9
    
    cmp eax, 10
    je v10
    
    cmp eax, 11
    je v11
    
    cmp eax, 12
    je v12
    
    cmp eax, 13
    je v13
    
    cmp eax, 14
    je v14
    
    cmp eax, 15
    je v15
    
    cmp eax, 16
    je v16
    
    cmp eax, 17
    je v17
    
v1:
    push vers1
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v2:
  push vers2
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v3:
  push vers3
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v4:
  push vers4
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v5:
  push vers5
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v6:
  push vers6
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v7:
  push vers7
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v8:
  push vers8
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v9:
  push vers9
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v10:
  push vers10
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v11:
  push vers11
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v12:
  push vers12
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v13:
  push vers13
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v14:
  push vers14
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v15:
  push vers15
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v16:
  push vers16
    call _printf               ; <-- underscore!
    add esp, 4
    jmp _moveonText
v17:
push vers17
    call _printf               ; <-- underscore!
    add esp, 17
    jmp _moveonText
    
jmp Vers
    
_moveonText:
      push moveontext
   call _printf
   add esp, 4
   
    call _getch      ; vent på tastetryk
    jmp Vers
    
tjek_map_shoving:
    mov eax, [map_found]
    cmp eax, 1
    jne not_any_map      
	
    mov eax, Biblevers
    mov dword [retur_value], 7 ; 7 = Biblevers
    call Show_map
    jmp Biblevers




not_any_map:
    push cls_cmd
    call _system
    push no_map_msg
    call _printf
    add esp, 4
    call _getch
    jmp Biblevers
