section .data
	; TODO: why does '..is: %d.' break? whats so special about :
	fmt db 'The counter is %d.', 10, 0
	counter db 0

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
	counter_loop:
		inc byte[counter]
		mov eax, dword[counter]
		call print_eax
		cmp byte[counter], 10
		jge end
		jmp counter_loop
	end:
		ret