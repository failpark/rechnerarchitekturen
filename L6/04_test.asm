section .data
	fmt db 'eax beinhaltet %d.', 10,0
	fmt_jz_str db 'and eax,  0x0000ff00 wuerde 0x00000000 liefern', 10, 0
	safe_eax dd 0x00000000

section .text
global main
extern printf
main:
	mov eax, 0x000000ff
	mov [safe_eax], eax
	call print_eax
	mov eax, [safe_eax]

	test eax, 0x0000ff00
	jz print_and_would_deliver_zero ; jump (if last result was) zero
	jmp NOT_ZERO ; <- never reached because:
	; 0x0000ff00
	; 0x000000ff
	; bitwise-and results in 0 (see fmt_jz_str)

	print_and_would_deliver_zero:
	call print_eax

	push fmt_jz_str
	call printf
	add esp, 4

	mov eax, [safe_eax]

	NOT_ZERO:
	call print_eax

	ret ; from main


print_eax:
	push eax
	push fmt
	call printf
	add esp, 8
	ret