section .data
	name dd 'Pete'
	name_length equ $ - name
	nl db 0xa,0
	fmt db 10,'Der Byte-Wert in der Speicherzelle = %c', 10, 10, 0 ; ugh ._. 10 => \n in ASCII so '\nDer Byte...\n\n' with null-terminated

section .text
global main
extern printf

main:
	mov ecx, name
	call print_with_nl
	mov ecx, name + 1
	call print_with_nl
	mov ecx, name + 2
	call print_with_nl
	mov ecx, name + 3
	call print_with_nl

	xor esi, esi ; init loop at 0 --> faster than zeroing esi any other way (most of the time)
	call printf_loop

	mov eax, 1
	mov ebx, 0
	int 80h

print_with_nl:
	call print_char
	; write expects an address in ecx and not the val... so writing `mov ecx, 0xa` does not work
	mov ecx, nl
	call print_char
	ret

print_char:
	mov eax, 4
	mov ebx, 1
	mov edx, 1
	int 80h
	ret

printf_loop:
	movzx eax, byte[name + esi]; move zero extend (byte loaded from mem to dword register eax
	push eax
	push fmt
	call printf
	add esp, 8
	inc esi
	; http://unixwiz.net/techtips/x86-jumps.html
	; https://stackoverflow.com/questions/9617877/assembly-jg-jnle-jl-jnge-after-cmp
	; https://www.cs.virginia.edu/~evans/cs216/guides/x86.html "Control Flow Instructions"
	cmp esi, name_length
	jl printf_loop
	ret