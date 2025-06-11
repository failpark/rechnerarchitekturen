section .data
	msg db 'The Result is: ', 0xa
	len equ $ - msg

section .bss
	numb1 resb 1
	numb2 resb 1
	faulty_intermediate resb 1
	res resb 1
	unpacked_bcd_1 resb 1
	unpacked_bcd_2 resb 1

section .text
global main
main:
	mov al, 5
	shl al, 4
	add al, 2
	mov byte[numb1], al
	
	mov al, 2
	shl al, 4
	add al, 9
	mov byte[numb2], al

	add al, [numb1]
	mov [faulty_intermediate], al

	daa

	mov [res], al
	mov [unpacked_bcd_2], al
	
	and al, 0x0f
	or al, 0x30
	mov [unpacked_bcd_1], al

	mov al, [unpacked_bcd_2]
	and al, 0xf0
	shr al, 4
	or al, 0x30
	mov [unpacked_bcd_2], al

	mov ecx, msg
	mov edx, len
	call print
	
	mov ecx, unpacked_bcd_1
	mov edx, 1
	call print
	
	mov ecx, unpacked_bcd_2
	mov edx, 1
	call print

	ret 

print:
	mov eax, 4
	mov ebx, 1
	int 80h
	ret