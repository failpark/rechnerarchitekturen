global main                     ;must be declared for using gcc
extern printf   

section .data
    s1      db 'Hello, world!', 0               ; string s1
    len1     equ $-s1                           ; length s1
    s2      db '01234567890123456789',10, 0     ; destination-string s1
    len2     equ $-s2                           ; length s2
    ausgabeInfo  db 'Die Laenge von s1 : %d, die Laenge von s2 : %d', 10, 0

section .text

    main:                                   ;tell linker entry point
        push len2
        push len1
        push ausgabeInfo
        call printf
        add esp, 12                         ; Cleans up the stack by removing the pushed addresses

        mov ecx, 3
        ;mov ecx, len1                       ; ecx wird mit length s1 beschrieben
                                            ; rep movsb macht Block-moves von Anzahl Bytes
                                            ; in ecx muss die Anzahl der Bytes stehen damit rep movsb arbeiten kann

        mov esi, s1                         ; pointer aus string 1 wird in esi abgelegt 

        mov edi, s2                         ; pointer auf string 2 wird in edi abgelegt.
        inc edi                             ; pointer zeigt auf zweites Byte von string 2
        inc edi                             ; pointer zeigt auf drittes Byte von string 2
        inc edi
        inc edi
        inc edi
        inc edi

        cld                                 ; clear direction flag, clear DF-flag in eflags

        rep movsb                           ; rep (repeat string oeration)  movsb (Move byte from address ESI to EDI)
                                            ; kopiert Anzahl (= ecx) Bytes von esi (pointer auf String 1 ) nach edi (pointer auf String 2)

        mov edx,len2                        ;message length von 
        mov ecx,s2                          ;message to write
        mov ebx,1                           ;file descriptor (stdout)
        mov eax,4                           ;system call number (sys_write)
        int 0x80                            ;call kernel

    mov eax,1 ;system call number (sys_exit)
    int 0x80 ;call kernel

