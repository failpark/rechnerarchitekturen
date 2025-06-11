section .data
	s1 db 'password', 0
	len1 equ $ - s1

	; we don't need to write 0x00000000
	len1pwd dd 0

	s2 db 'password', 0
	len2 equ $ - s2
	
	; we don't need to calc ... we can just use this lol
	len2pwd dd len2 - 1

	key db 0x00
	general_info db "Caesar-Chiffre, Key                             = %d", 10, 0
	ausgabeInfo  db "Das Password lautet                             : %s, Laenge des Strings : %d, Laenge des passworts : %d", 10, 0
	substitution db "Wir substitutionieren monografisch & symetrisch : ||||||||, Anzahl der Zeichen : %d", 10, 0
	ausgabeInfo2 db "Das verschluesselte Passwort                    : %s, Laenge des Strings : %d, Laenge des passworts : %d", 10, 0
	
section .text
global main
extern printf
main:
	mov [key], byte 0x02
	xor eax, eax
	mov al, [key]
	push eax
	push general_info
	call printf
	add esp, 8

	mov eax, len1
	dec eax
	mov [len1pwd], eax

	push dword[len1pwd]
	push len1
	push s1
	push ausgabeInfo
	call printf
	add esp, 16

	push dword[len1pwd]
	push substitution
	call printf
	add esp, 8

	mov ecx, [len1pwd]
	mov esi, s1
	mov edi, s2
	cld ; clear direction flag

	loop_here:
		lodsb
		add al, [key]
		stosb
		loop loop_here

	push dword[len2pwd]
	push len2
	push s2
	push ausgabeInfo2
	call printf
	add esp,16

	mov eax, 1
	int 80h