global main             ;must be declared for using gcc

section .data
    msg db "The sum is:", 0xA, 0xD ; 0xA Line Feed/ Zeilenvorschub  0xD Carriage Return / Wagen-Rücklauf (Schreibmaschinendenke!)
    len equ $- msg

section .bss
    res resb 1

section .text

    sum:                    ; ecx = 4; edx = 5
        mov eax, ecx        ; eax = 4
        add eax, edx        ; eax = 4 + 5 = 9
        add eax, '0'        ; eax = '9'
    ret

    main:                   ; tell linker entry point

        mov ecx,    '4'     ; ecx = '4'
        sub ecx,    '0'     ; ecx = 4 (unsigened int 32 bit)
        mov edx,    '5'     ; edx = '5'
        sub edx,    '0'     ; ecx = 5 (unsigened int 32 bit)

        call sum            ; call sum procedure
    
        mov [res],  eax     ; eax = '9' wird in [res] geschrieben
        mov ecx, msg        ; "The sum is:"
        mov edx, len        ;
        mov ebx,1           ;file descriptor (stdout)
        mov eax,4           ;system call number (sys_write)
        int 0x80            ;call kernel (Operating System)

        mov ecx, res        ; ecx zeigt auf die Speicherzelle auf die auch res zeigt
        mov edx, 1          ; 1 Byte davon soll ausgegeben werden
        mov ebx, 1          ; file descriptor (stdout)
        mov eax, 4          ; system call number (sys_write)
        int 0x80            ; call kernel

    mov eax,1               ; system call number (sys_exit)
    int 0x80                ; call kernel
    
    