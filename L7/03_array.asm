section .data
	s1 db '2 + 4 + 3 ergibt :%d', 10, 'Und jetzt einzeln das Char : ', 10, 0
	len equ $ - s1

x:
	dd 2
	dd 4
	dd 3
; x dd 2, 4, 3

	sumInt dd 0
	sumByte db 0

section .text
global main
extern printf
main:
	mov eax, 3
	mov ebx, 0
	mov ecx, x ; zeigt auf das erste elem in x

top:
	add ebx, dword[ecx]
	add ecx, 4
	dec eax
	jnz top
	mov [sumInt], dword ebx

print_int:
	push ebx
	push s1
	call printf
	add esp, 8

conversion:
	mov ebx, dword [sumInt]
	add ebx, '0'
	mov [sumByte], bl

print_byte:
	mov eax, 4
	mov ebx, 1
	mov ecx, sumByte
	mov edx, 1
	int 80h

mov eax, 1
xor ebx, ebx
int 0x80