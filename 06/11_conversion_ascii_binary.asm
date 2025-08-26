global main             ;must be declared for using gcc

section .data
    msg db "The sum is:", 0xA,0xD
    len equ $ - msg

section .bss
    sum resd 1          ; 4 byte allokiert

section .text

    main:               ;tell linker entry point
        mov eax, '3'     ; move char '3' (ASCII Code) to eax
        sub eax, '0'    ; conversion from '3' to 3 (unsigned int)

        mov ebx, '4'    ; move char '4' (ASCII Code) to eax
        sub ebx, '0'    ; conversion from '4' to 4 (unsigned int)

        add eax, ebx    ; eax = 3+4 = 7
        add eax, '0'    ; Conversion from 7 to '7' (ASCII)

        mov [sum], eax  ; Ergebnis 7 in [sum] schreiben im Hauptspeicher
                        ; im ersten byte von [sum] steht das Ergebnis (ASCII Code passt in ein Byte,
                        ; convertiertes digit passt auch in ein byte)

        mov ecx, msg     ; print "The sum is:"
        mov edx, len    ; length
        mov ebx, 1       ; file descriptor (stdout)
        mov eax, 4       ; system call number (sys_write)
        int 0x80        ; call kernel

        mov ecx, sum     ; print '7'
        mov edx, 1      ; length
        mov ebx, 1       ; file descriptor (stdout)
        mov eax, 4       ; system call number (sys_write)
        int 0x80        ; call kernel

    mov eax,1           ;system call number (sys_exit)
    int 0x80 ;          call kernel

