section .data
	name dd 'Pete' ; declare DWORD (double - 32 unsigned word)
	byte_nr_1 db '0000'
	byte_nr_2 db '0000'
	byte_nr_3 db '0000'
	byte_nr_4 db '0000'

	fmt db 10,'Der Byte-Wert in der Speicherzelle = %c', 10, 10, 0 ; ugh ._. 10 => \n in ASCII so '\nDer Byte...\n\n' with null-terminated

section .text
global main
extern printf

main:
	mov eax, name ; eax => address of name
	lea edx, [eax] ; load effective address (see lea https://www.cs.virginia.edu/~evans/cs216/guides/x86.html)
	mov dword[byte_nr_1], edx ; store whats stored in edx in byte_nr_1 and treat it as a dword 32 bit (4 byte) operation

	inc eax ; since eax was pointing at the first byte we now want the second byte
	lea edx, [eax]
	mov dword[byte_nr_2], edx

	inc eax
	lea edx, [eax]
	mov dword[byte_nr_3], edx

	inc eax
	lea edx, [eax]
	mov dword[byte_nr_4], edx

	; the following just prints each char of Pete seperatly ...
	mov eax, 4 ; write
	mov ebx, 1 ; stdout
	mov ecx, [byte_nr_1] ; dereference / load whats at address byte_nr_1
	mov edx, 1 ; length
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, [byte_nr_2]
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, [byte_nr_3]
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, [byte_nr_4]
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, 4
	int 80h

	mov eax, [byte_nr_1]
	push dword[eax] ; put address on the stack
	push fmt
	call printf
	; see push https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
	; push decrements esp (extended stack pointer) by 4
	add esp, 8

	mov eax, [byte_nr_2]
	push dword[eax]
	push fmt
	call printf
	add esp, 8

	mov eax, [byte_nr_3]
	push dword[eax]
	push fmt
	call printf
	add esp, 8

	mov eax, [byte_nr_4]
	push dword[eax]
	push fmt
	call printf
	add esp, 8

	mov eax, 1
	mov ebx, 0
	int 80h