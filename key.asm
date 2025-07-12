global have_key_attic, have_key_creative
global key_names, key_flags

section .data
	have_key_attic:     db 0
    have_key_creative    db 0

key_names:
    dd keyname_attic
    dd keyname_creative

key_flags:
    dd have_key_attic
    dd have_key_creative

keyname_attic:      db "Rusty Key found in Kitchen", 10, 0
keyname_creative:    db "Golden Key found in Aschii Show", 10, 0

