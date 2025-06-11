section .bss
	num resb 1

section .text
global main

main:
	mov ecx, 10 ; loop assumes that our counter is here (e c <- like counter)
	mov eax, '0' ; start with this char
	
	l1:
		push ecx
		mov [num], eax
		mov eax, 4
		mov ebx, 1
		mov ecx, num
		mov edx, 1
		int 80h

		mov eax, [num]
		; sub and add are for illustration. But totaly redundant here since in ascii '0' 0x30 and '1' 0x31 so we don't need to convert to 0x00 add 1 0x01 and convert back to 0x31 by adding 0x30 ('0')
		;sub eax, '0' ; from ascii char to int
		inc eax
		;add eax, '0' ; from int to ascii
		
		pop ecx
		loop l1

	mov eax, 1
	xor ebx, ebx
	int 80h