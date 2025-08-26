section .text
global main

main:
	mov eax, 4 		; system call number (sys_write)
	mov ebx, 1 		; file descriptor (stdout)
	mov ecx, mymsg 	; message to write
	mov edx, mylen 	; message length
	int 80h			; call kernel

	mov eax, 1 		; system call number (sys_exit)
	mov ebx, 0 		; exit with error code 0
	int 80h 		; call kernel

section .data
	mymsg db 'Hello World!', 0xa
	mylen equ $-mymsg