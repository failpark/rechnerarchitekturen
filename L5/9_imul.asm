section .data
	fmt db 'The product of 4 and 2 is %d.', 10, 0

section .text
global main
extern printf

print_eax:
	push eax
	push fmt
	call printf
	add esp, 8 ; cleanup stack
	ret

main:
	mov eax, 4
	imul eax, 2
	call print_eax
	
	mov eax, 1
	xor ebx, ebx
	int 80h