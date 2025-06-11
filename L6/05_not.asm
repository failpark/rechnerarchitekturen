section .data
	fmt db 'NOT 0xFFFFFF00 is %d.', 10, 0

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
	mov eax, 0xffffff00
	not eax
	call print_eax
	ret