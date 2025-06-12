section .data
	s1 db 'hello world', 0
	len equ $ - s1
	comp_str db 'e', 0
	comp_len equ $ - comp_str

	msg_found db 'found!', 0xa, 'Das %d-te Zeichen im String : "%s", lautet : "%s"', 0xa, 0
	found_len equ $ - msg_found

	msg_edi_pointer db 'Der Pointer edi zeigt jetzt auf diesen String : "%s"', 0xa, 0
	edi_len equ $ - msg_edi_pointer

	msg_notfound db 'not found!', 0xa, 0
	notfound_len equ $ - msg_notfound

	pos dd 0

section .text
global main
extern printf
main:
	mov ecx, len
	mov edi, s1
	mov al, byte[comp_str]

	cld

	repne scasb ; scan string
	pushf
	mov eax, edi
	sub eax, s1
	mov [pos], eax
	popf
	je found

not_found:
	push msg_notfound
	call printf
	add esp, 4
	jmp exit

found:
	push comp_str
	push s1
	push dword[pos]
	push msg_found
	call printf
	add esp, 16
	push edi
	push msg_edi_pointer
	call printf
	add esp, 4

exit:
	mov eax, 1
	xor ebx, ebx
	int 80h