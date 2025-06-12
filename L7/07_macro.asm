section .data
	string db 'Macros sind cool: Nr %d', 10, 0
	num dd 12345

section .text
global main
extern printf

%macro ausgabe 2
	push dword[%2]
	push %1
	call printf
	add esp, 8
%endmacro

main:
	ausgabe string, num
	ret