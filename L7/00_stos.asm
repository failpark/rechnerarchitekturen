section .data
	; can't NULL-Terminate here since we would process garbage (0x20 is space so it's fine here but still...)
	; or handle it seperatly
	s1 db 'HELLO, WORLD', 10, 0
	len equ $ - s1

section .bss
	s2 resb len

section .text
global main

print_ecx:
	mov eax, 4
	mov ebx, 1
	mov edx, len
	int 80h
	ret

main:
	; we don't want to touch the \n and NULL at the end
	mov ecx, len - 2
	mov esi, s1
	mov edi, s2
	cld
	loop_here:
		lodsb
		or al, 20h
		stosb
	loop loop_here

	; add \n to s2
	mov byte[edi], 0xa
	inc edi
	mov byte[edi], 0x0

	mov ecx, s1
	call print_ecx

	mov ecx, s2
	call print_ecx
	
	mov eax, 1
	xor ebx, ebx
	int 80h