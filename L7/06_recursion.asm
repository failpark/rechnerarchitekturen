section .data
	number dd 3
	fmt_str dd '%d! = %d.', 10, 0
	here db 'Here %d', 10

section .text
global main
extern printf
factorial:
	cmp eax, 1
	jle .base_case
	push eax
	dec eax

	call factorial

	pop ebx
	imul eax, ebx
	jmp end
	
	.base_case:
		mov eax, 1
	
	end:
		ret
		
main:
	mov eax, dword[number]
	call factorial

	push eax
	push dword[number]
	push fmt_str
	call printf
	add esp, 12
	ret