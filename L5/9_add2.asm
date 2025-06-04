SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1
KERNEL equ 80h
num_size equ 2

section .data
	prompt db 'Please enter a number:' , 10, 0
	prompt_len equ $ - prompt
	sol db 'The sum is: '
	sol_len equ $ - sol

section .bss
	num1 resb num_size ; byte since \n is also part of the read
	num2 resb num_size
	res resb 1

section .text
global main
main:
	call write_prompt
	mov ecx, num1
	call read
	call write_prompt
	mov ecx, num2
	call read
	call write_sol

	mov eax, [num1]
	mov ebx, [num2]

	; WTH... that this isn't more explained in the script should be a crime
	; '0' is the start of the ASCII figures (0 ... 9)
	; since '0' in ASCII is 48 we simply subtract the start value of our range (figures here)
	; and get the value we want. Pretty neat one you wrap your head around this concept
	sub eax, '0'
	sub ebx, '0'

	add eax, ebx

	add eax, '0' ; get our num as an ASCII value

	mov [res], eax
	
	mov ecx, res
	mov edx, 1
	call write

	call exit

read:
	mov eax, SYS_READ
	mov ebx, STDIN
	mov edx, num_size
	int KERNEL
	ret

write_prompt:
	mov ecx, prompt
	mov edx, prompt_len
	call write
	ret

write_sol:
	mov ecx, sol
	mov edx, sol_len
	call write
	ret

write:
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	int KERNEL
	ret

exit:
	mov eax, SYS_EXIT
	mov ebx, 0
	int KERNEL