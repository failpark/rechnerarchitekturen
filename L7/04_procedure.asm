section .data
	msg db "The sum is: ", 0xa
	len equ $ - msg

section .bss
	res resb 1

section .text
global main
sum:
	mov eax, ecx
	add eax, edx
	add eax, '0' ; to ASCII
	ret

print_ecx:
	mov eax, 4
	mov ebx, 1
	int 80h
	ret

main:
	; the prof adds ASCII 4 and then subs '0' ... we just skip that and directly use the num
	mov ecx, 4
	mov edx, 5
	call sum

	mov [res], eax

	mov ecx, msg
	mov edx, len
	call print_ecx
	
	mov ecx, res
	mov edx, 1
	call print_ecx

	mov eax, 1
	mov ebx, 0
	int 80h