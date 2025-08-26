section .text
    global main                 ;must be declared for linker (ld)
    
main:                           ;tell linker entry point


    ;writing the name 'Zara Ali':
    mov edx, len                ;message length
    mov ecx, name               ;message to write
    mov ebx, 1                  ;file descriptor (stdout)
    mov eax, 4                  ;system call number (sys_write)
    int 0x80                    ;call kernel
    
    mov dword[name], dword 'Alex' ; Changed name to Alex Ali
;    mov dword[name+7], dword 'Alex' ; Changed name to Alex Ali


    ;writing the name 'Alex Ali'
    mov edx, len                 ;message length
    mov ecx, name                ;message to write
    mov ebx, 1                   ;file descriptor (stdout)
    mov eax,4                    ;system call number (sys_write)
    int 0x80                     ;call kernel

    ;Exit code
     mov eax, 1
     mov ebx, 0
     int 80h

section .data
    name db 'Zara Ali ',0xa         ;name
    len equ $ - name                ;length of name

