section .data
	name dd 'Pete'
	name_length equ $ - name
	nl db 0xa,0
	fmt db 'Der Byte-Wert in der Speicherzelle = %c', 10, 10, 0 ; ugh ._. 10 => \n in ASCII so '\nDer Byte...\n\n' with null-terminated

section .text
global main
extern printf

main:
	xor esi, esi ; init loop at 0 --> faster than zeroing esi any other way (most of the time)
	call char_loop

	xor esi, esi
	call printf_loop

	mov eax, 1
	mov ebx, 0
	int 80h

char_loop:
	mov ecx, name
	; works because we increment the pointer
	add ecx, esi
	call print_char
	; write expects an address in ecx and not the val... so writing `mov ecx, 0xa` does not work
	mov ecx, nl
	call print_char

	inc esi
	cmp esi, name_length
	jl char_loop
	ret

print_with_nl_padding:
	; Get the byte to print
	movzx eax, byte[ecx]  ; Zero-extend byte to eax
	push 0x0a00            ; Push newline + padding
	mov [esp+1], al        ; Overwrite padding with character

	; Print both bytes at once
	mov ecx, esp

print_with_nl_shift:
	movzx eax, byte[ecx]  ; Get character
	shl eax, 8             ; Shift left by 8 bits
	or eax, 0x0a           ; Add newline
	push eax               ; Push to stack
	mov ecx, esp

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