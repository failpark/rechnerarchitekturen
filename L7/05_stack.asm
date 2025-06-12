section .data
	a_char db '0'
	new_line db 0xa
	esp_reg_copy dd 0
	esp_check_counter db 0

	msg db 10, 'Schleifen-Durchlauf-Nr (ecx) = %d, (ebx) = %d', 10, 0
	char_out db "Zeichen wird ausgegeben :                        ", 0
	len equ $ - char_out

section .text
global main
extern printf

print_ecx:
	mov eax, 4
	mov ebx, 1
	int 80h
	ret

print_newline:
	mov ecx, new_line
	mov edx, 1
	call print_ecx
	ret

display:
	mov ecx, 75
	next:
		push ecx
		xor ebx, ebx
		mov bl, byte[esp]

		push ecx
		push ebx
		push msg
		call printf
		add esp, 12

		mov ecx, char_out
		mov edx, len
		call print_ecx

		mov ecx, a_char
		mov edx, 1
		call print_ecx
		
		pop ecx
		inc byte[a_char]
	loop next

	call print_newline
	call print_newline
	ret

main:
	call print_newline

	call display

	mov eax, 1
	mov ebx, 0
	int 80h