section .data
	fmt db '0x0000000F OR 0x000000F0 is %d.', 10, 0

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
	mov eax, 0x0000000F
	or eax, 0x000000F0
	call print_eax
	ret