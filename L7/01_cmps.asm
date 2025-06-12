section .data
	s1 db 'Hello, world!', 0
	len1 equ $ - s1
	
	s2 db 'Hello, there!', 0
	len2 equ $ - s2
	
	msg_eq db 'Strings are equal!', 0xa
	len_eq equ $ - msg_eq
	
	msg_ne db 'Strings are not equal!', 0xa
	len_ne equ $ - msg_ne

section .text
global main
print_ecx:
	mov eax, 4
	mov ebx, 1
	int 80h
	ret

main:
	mov esi, s1
	mov edi, s2
	mov ecx, len2
	cld
	repe cmpsb
	jecxz equal

not_equal:
	mov ecx, msg_ne
	mov edx, len_ne
	call print_ecx
	jmp exit

equal:
	mov ecx, msg_eq
	mov edx, len_eq
	call print_ecx
	jmp exit

exit:
	mov eax, 1
	mov ebx, 0
	int 80h