global main ;must be declared for using gcc

section .data
    msg db 'The Result is:',0xa
    len equ $ - msg
    
section .bss
    res resb 1

section .text 

    main: ;tell linker entry point
    
        sub ah, ah                      ; Initialisierung : AH = 0000 0000

        mov al, '9'                     ; '9' = 0x39 = 0011 1001; AL wird auf 0011 1001 gesetzt
        sub al, '3'                     ; '3' = 0x33 = 0011 0011; AL wird auf 0000 0110 gesetzt

        aas                             ; fuehrt folgende Schritte aus











        or al, 30h                      ; al = 0000 0110 (keine Änderung durch aas notwendig)
                                        ; btweises OR von AL mit 0011 0000 ergibt:
                                        ; al = 0011 0110 => 0x36 = '6' in ASCII Tabelle
        
        mov [res], ax                   ; als wird nach [res] geschrieben

        mov ecx,msg                     ; message to write _ The Result is:
        mov edx,len                     ; message length
        mov ebx,1                       ; file descriptor (stdout)
        mov eax,4                       ; system call number (sys_write)
        int 0x80                        ; call kernel

        mov ecx,res                     ; message to write
        mov edx,1                       ; message length
        mov ebx,1                       ; file descriptor (stdout)
        mov eax,4                       ; system call number (sys_write)
        int 0x80                        ; call kernel

    mov eax,1                           ; system call number (sys_exit)
    int 0x80                            ; call kernel

