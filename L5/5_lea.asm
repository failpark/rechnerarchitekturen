section .data
	fmt db 'The result is %d', 10, 0
	array dd 10, 20, 30, 40, 50
	result dd 0

section .text
global main
extern printf

main:
	mov eax, array
	mov ebx, 2

	; calculation breaks down as follows:
	; edx = eax + (4 * ebx) + 4
	; edx = array + (4 * 2) + 4
	; edx = array + 8 + 4
	; edx = array + 12
	; OK so the + 4 is redundant. The intent is not quite clear but it's probably to showcase
	; the flexability of index arithmetic operations
	;lea edx, [eax + 4 * ebx + 4]
	; since I find the usecase confusing I'll be sticking to the following pattern
	lea edx, [eax + 4 * ebx] ; edx points to idx 2 which is 30
	add dword[edx], 10 ; add 10 to edx -> 30 + 10
	mov eax, [edx] ; deref -> get val in edx and put that in eax
	mov [result], eax ; move 40 to the value at result

	; setup & call printf
	push dword[result]
	push fmt
	call printf
	add esp, 8 ; cleanup stack

	mov eax, 1
	mov ebx, 0
	int 80h