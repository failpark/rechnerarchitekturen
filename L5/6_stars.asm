section .data
	stars times 9 db '*'
	len equ $ - stars

section .text
global main
main:
	mov eax, 4
	mov ebx, 1
	mov ecx, stars
	mov edx, len
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h