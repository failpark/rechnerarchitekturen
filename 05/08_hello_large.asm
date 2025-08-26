    SYS_EXIT equ 1
    SYS_WRITE equ 4
    STDIN equ 0
    STDOUT equ 1 

section .text
    global main             ;must be declared for using gcc
    main:                   ;tell linker entry point
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg1
    mov edx, len1
    int 0x80
    
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg2
    mov edx, len2
    int 0x80 
    
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg3
    mov edx, len3
    int 0x80 
    
    mov eax,SYS_EXIT        ;system call number (sys_exit)
    int 0x80                ;call kernel
    
section .data
;msg1 db 'Hello, programmers!',0xA       ; 0xA line feed. 0x0A (line feed, LF, \n, ^J), moves the print head down one line, or to the left edge and down. Used as the end of line marker in Unix-like systems.
;msg1 db 'Hello, programmers!',0xD       ; 0xD carriage return. 0x0D (carriage return, CR, \r, ^M), moves the printing position to the start of the line, allowing overprinting.
msg1 db 'Hello, programmers!',0xA,0xD
;msg1 db 'Hello, programmers!', 0x47
len1 equ $ - msg1

msg2 db 'Welcome to the world of,', 0xA,0xD
len2 equ $ - msg2

msg3 db 'Linux assembly programming! '
len3 equ $- msg3