section .data
	fmt db 'The quotient of 13 and 5 is %d, remainder is %d.', 10, 0

section .text
global main
extern printf
main:
	mov eax, 13
	mov ebx, 5

	; convert doubleword to quadword
	; extend sign bit of eax into edx
	cdq

	idiv ebx
	push edx
	push eax
	push fmt
	call printf
	add esp, 12
	ret