section .text
	global main

main:
	mov edx, len
	mov ecx, msg
	mov ebx, 1
	mov eax, 4
	int 0x80
	; the above essentially boils down to:
	; write(stdout, msg, len)
	mov edx, starsAndNewLine
	mov ecx, stars 
	; TODO: can the following be deleted since we don't touch those registers again?
	mov ebx, 1
	mov eax, 4
	int 0x80
	; write(stout, s2, 9)

	mov eax, 1 ;exit
	mov ebx, 0 ; status code
	int 0x80

section .data
	msg db 'Displaying 9 Stars: ', 0xa ; essentially msg = 'Disp...\n'
	len equ $ - msg ; essentially look at start of mem and the next free space and do `free - start`
	stars times 9 db '*' ; https://www.nasm.us/doc/nasmdoc3.html#section-3.2.5
	newLine db 0xa ;empty string and \n ??? TODO: wouldn't \n suffice? --> yes it would
	starsAndNewLine equ $ - stars ; since we defined 0xa in between now and stars