section .data
	prompt db 'Please enter a number: '
	prompt_len equ $ - prompt
	answer db 'You have entered: '
	answer_len equ $ - answer
	; equ tells nasm that this is a compile-time constant
	read_len equ 5

; https://en.wikipedia.org/wiki/.bss
; block starting symbol
section .bss
	; https://www.nasm.us/doc/nasmdoc3.html#section-3.2.2
	; probably stands for res(erve) b(yte) --> equivalents for word, doubleword resw, resd exist
	read resb read_len ; declare 5 byte uninit data
	; 5 bytes. 4 chars + 1 \n
	
section .text
	global main

; stdin -> 0
; stdout -> 1
; stderr -> 2
main:
	mov eax, 4 ; write
	mov ebx, 1 ; stdout
	mov ecx, prompt
	mov edx, prompt_len
	int 80h

	mov eax, 3 ; read
	mov ebx, 0
	mov ecx, read
	mov edx, read_len
	int 80h

	; write to stdout string and stored var
	mov eax, 4
	mov ebx, 1
	mov ecx, answer
	mov edx, answer_len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, read ; num now contains the read value
	mov edx, read_len
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h