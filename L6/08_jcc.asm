section .data
	fmt_zero db 'eax holds ZERO.', 10,0
	fmt_pos db 'eax holds a POSITIVE value.', 10, 0
	fmt_neg db 'eax holds a NEGATIVE value.', 10, 0

section .text
global main:
extern printf
main:
	mov eax, 9
	cmp eax, 0
	je zero
	jg pos
	jl neg

	zero:
		push fmt_zero
		jmp end
	pos:
		push fmt_pos
		jmp end
	neg:
		push fmt_neg
		jmp end
	
	end:
		call printf
		add esp, 4
		ret