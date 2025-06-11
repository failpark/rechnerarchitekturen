section .data
	msg db 'The Sum is: ', 0xa
	len equ $ - msg
	num1 db '12345'
	num2 db '23456'
	sum db  '     '

section .text
global main
main:
	mov esi, 4
	mov ecx, 5
	clc

	add_loop:
		mov al, [num1 + esi]
		adc al, [num2 + esi]
		aaa
		pushf
		or al, 30h
		popf
		mov [sum  + esi], al
		dec esi
		loop add_loop

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, sum
	mov edx, 5
	int 80h

	ret