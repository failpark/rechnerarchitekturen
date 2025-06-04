section .text
global _start
extern main
_start:
	call main

	; call exit manually
	mov eax, 1
	xor ebx, ebx
	int 80h