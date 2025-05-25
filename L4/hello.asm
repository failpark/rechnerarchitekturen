segment .text
global main
main:
	; e for extended meaning 32 bit
	; r would mean 64 bit
	; ax without anything would mean 16 bit
	; ax accummulator register
	; bx base register
	; cx count reg
	; dx data reg
	; | 32-bit | 16-bit | 8-bit (high) | 8-bit (low) |
	; | eax    | ax     | ah           | al          |
	; https://stackoverflow.com/questions/2545192/what-does-x-mean-in-eax-ebx-ecx-in-assembly
	; lol ok so running theory is that: e and x both stand for extended. but from 8 -> 16 eXtended and from 16 -> 32 Extended
	mov edx, len
	mov ecx, msg
	mov ebx, 1 ; stdout (first arg)
	mov eax, 4 ; sys write (second arg)
	; https://stackoverflow.com/questions/12806584/what-is-better-int-0x80-or-syscall-in-32-bit-code-on-linux
	; Table for i386 32-bit x86
	; https://web.archive.org/web/20160213015253/http://docs.cs.up.ac.za/programming/asm/derick_tut/syscalls.html
	int 0x80 ; software interrupt aka syscall
	; int MEANS interrupt not integer
	; https://stackoverflow.com/questions/1817577/what-does-int-0x80-mean-in-assembly-code
	; 0x80 is the interrupt number of the kernel
	; eax should contain status code after call
	
	mov eax, 1 ; sys_exit
	int 0x80

segment .data
msg		db 'Hello, world!', 0xa
len		equ		$ - msg