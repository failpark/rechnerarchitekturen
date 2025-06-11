section .data
	s1 db 'Hello, world', 0
	len1 equ $ - s1
	s2 db '01234567890123456789', 10, 0
	len2 equ $ - s2
	out_info db 'Die Laenge von s1 : %d, die Laenge von s2: %d', 10, 0

section .text
global main
extern printf
main:
	push len2
	push len1
	push out_info
	call printf
	add esp, 12 ; 3 * 4 bits (size of pointer I'd guess)

	mov esi, s1
	mov edi, s2
	inc edi
	inc edi ; pointer now points to 3rd byte in s2
	cld ; clear direction flag
	
	; https://stackoverflow.com/questions/27804852/assembly-rep-movs-mechanism
	; https://www.felixcloutier.com/x86/rep:repe:repz:repne:repnz
	mov ecx, len1
	; repeats the string operation the number of times specified in the count register (ecx)
	; mov string byte
	; https://www.felixcloutier.com/x86/movs:movsb:movsw:movsd:movsq
	; mov byte from esi to edi for the length
	; repeat this ecx times
	rep movsb

	mov eax, 4
	mov ebx, 1
	mov ecx, s2
	mov edx, len2
	int 80h

	mov eax, 1
	xor ebx, ebx
	int 80h