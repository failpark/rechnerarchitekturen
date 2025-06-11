section .data
	fmt db '0xFFFFFFFF AND 0x0000000F is %d.', 10, 0

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
	mov eax, 0xFFFFFFFF ; init eax with 4 bytes (a DWORD, 32bit)
	; zero everything exept the last 4 bits
	and eax, 0x0000000F
	call print_eax
	ret