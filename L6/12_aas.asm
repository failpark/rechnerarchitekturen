section .data
	msg db 'The result is: ', 0xa
	len equ $ - msg
	num1 db '85'
	num2 db '56'
	res db '  '

section .text
global main
main:
	mov esi, 1 ; esi used for string ops "source index"
	; point to the right most digit (or string index 1)
	mov ecx, 2
	
	clc ; clear carry flag
	
	sub_loop:
		jnc no_carry ; jump not carry (imagine this as if(!no_carry) or if(carry))
			add byte[num2 + esi], 1 ; carry flag as carry in (CF can be either 0/1 and since we know that jnc didn't match we add 1
		no_carry:
		; explanation in the script is really good... refer to it
		mov al, [num1 + esi]
		sub al, [num2 + esi]
		aas
		pushf
		or al, 30h
		popf
		mov [res + esi], al
		dec esi
	loop sub_loop

	or al, 30h
	mov [res], al
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, res
	mov edx, 2
	int 80h
	ret