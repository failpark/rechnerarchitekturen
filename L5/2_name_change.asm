section .data
	name db 'Daniel Borgs', 0xa
	len equ $ - name
	new db 'Tester'

section .text
	global main
main:
	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, len
	int 80h ; 80 hex, could also write 128 or 0x80

	; byte = 8 bits
	; word = 16 bits = 2 bytes
	; doubleword = 32 bits = 4 bytes
	; quadword = 64 bits = 8 bytes
	mov eax, dword[new]
	mov dword[name], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, len
	int 128 ; same as int 80h

	mov eax, 1
	mov ebx, 0
	int 0x80 ; same as int 80h