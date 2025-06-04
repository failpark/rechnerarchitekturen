section .data
	one_char db 0x20 ; we start with space since the first 32 are mostly control chars

section .text
global main
main:
	call next
	mov eax, 1 ; exit
	mov ebx, 0 ; ok
	int 80h

next:
	mov eax, 4
	mov ebx, 1
	mov ecx, one_char
	mov edx, 1
	int 80h
	
	inc byte[one_char]
	cmp byte[one_char], 0x7E ; we want to stop at the last printable ASCII (~)
	jle next
	ret