section .data
	fmt db '0x000000FF xor itself is %d.', 10, 0

section .text
global main
extern printf
print_eax:
	push eax
	push fmt
	call printf
	add esp, 8
	ret

main:
	mov eax, 0x000000FF
	xor eax, eax
	call print_eax
	ret