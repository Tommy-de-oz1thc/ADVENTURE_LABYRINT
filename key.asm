global have_key_attic
global key_names, key_flags

section .data
	have_key_attic:     db 0


key_names:
    dd keyname_attic
    

key_flags:
    dd have_key_attic
    

keyname_attic:      db "Key found in Kitchen", 10, 0


