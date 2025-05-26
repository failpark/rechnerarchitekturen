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
	mov edx, 9
	mov ecx, s2
	; TODO: can the following be deleted since we don't touch those registers again?
	mov ebx, 1
	mov eax, 4
	int 0x80
	; write(stout, s2, 9)
	
	mov edx, len1
	mov ecx, e1
	mov ebx, 1
	mov eax, 4
	int 0x80
	; write(stout, e1, len1)
	
	mov eax, 1 ;exit
	int 0x80

section .data
	msg db 'Displaying 9 Stars: ', 0xa ; essentially msg = 'Disp...\n'
	len equ $ - msg ; essentially look at start of mem and the next free space and do `free - start`
	s2 times 9 db '*' ; https://www.nasm.us/doc/nasmdoc3.html#section-3.2.5
	e1 db '',0xa ;empty string and \n ??? TODO: wouldn't \n suffice?
	len1 equ $ - e1