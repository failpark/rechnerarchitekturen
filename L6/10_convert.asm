section .data
	msg db "The sum is :", 0xa
	len equ $ - msg

section .bss
	sum resd 1

section .text
global main
main:
	;see comment in L5/8_add2.asm
	mov eax, '3'
	sub eax, '0'
	
	mov ebx, '4'
	sub ebx, '0'

	add eax, ebx
	add eax, '0'

	mov [sum], eax

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, sum
	mov edx, len
	int 80h

	; print \n on the fly
	mov eax, 4
	mov ebx, 1
	mov ecx, 0xa
	push ecx
	mov ecx, esp
	mov edx, 1
	int 80h
	add esp, 4

	ret