SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
SYS_OPEN equ 5
SYS_CLOSE equ 6
STDIN equ 0
STDOUT equ 1
STDERR equ 2
KERNEL equ 80h

section .data
	; https://stackoverflow.com/questions/1552749/difference-between-cr-lf-lf-and-cr-line-break-types
	msg1 db 'Hello, programmers!',0xA
	;len1 equ $ - msg1
	
	msg2 db 'Welcome to the world of,', 0xA
	;len2 equ $ - msg2
	
	msg3 db 'Linux assembly programming!', 0xa
	;len3 equ $ - msg3
	len equ $ - msg1

section .text
global main

main:
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len
	int KERNEL
	
	mov eax, SYS_EXIT
	mov ebx, 0
	int KERNEL