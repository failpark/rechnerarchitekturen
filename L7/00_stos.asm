section .data
	; can't NULL-Terminate here since we would process garbage (0x20 is space so it's fine here but still...)
	; or handle it seperatly
	s1 db 'HELLO, WORLD', 0
	len equ $ - s1 - 1

section .bss
	s2 resb len + 1

section .text
global main
main:
	mov ecx, len
	mov esi, s1
	mov edi, s2
	cld
	loop_here:
		lodsb
		or al, 20h
		stosb
	loop loop_here

	mov eax, 4
	mov ebx, 1
	mov ecx, s2
	mov edx, len
	int 80h
	
	mov eax, 1
	xor ebx, ebx
	int 80h