global main
section .data
	msg db 'The Result is:',0xa
	len equ $ - msg

section .bss
	res resb 1

section .text 
main:

	sub ah, ah ; ah = 0x00
	mov al, '9'; al = '9' = 0x39 = 0011 1001
	;                 '3' = 0x33 = 0011 0011
	sub al, '3' ; al = 0x39 - 0x33 0000 0110
	aas ; ASCII Adjust AL after sub

	or al, 30h ; 30h => '0'
	; al = 0000 0110 (keine Änderung durch aas notwendig)
	; bitweises OR von AL mit 0011 0000 ergibt:
	; al = 0011 0110 => 0x36 = '6' in ASCII Tabelle

	mov [res], ax

	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,len
	int 0x80

	mov eax,4
	mov ebx,1
	mov ecx,res
	mov edx,1
	int 0x80
	
	mov eax, 1
	xor ebx, ebx
	int 0x80