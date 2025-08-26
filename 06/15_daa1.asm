global main             ;must be declared for using gcc

section .data
    msg db 'The Result is:',0xa
    len equ $ - msg

section .bss
    numb1                           resb 1                ; 1 Byte : dort kommen 2 BCD rein => packed BCD
    numb2                           resb 1                ; 1 Byte : dort kommen 2 BCD rein => packed BCD
    falschesZwischenErgebnis        resb 1                ; 1 Byte 
    res                             resb 1                ; 1 Byte : dort kommen 2 BCD rein => packed BCD
    unpackedBCD1                    resb 1                ; 1 Byte : dort kommt nur eine BCD rein => unpacked BCD
    unpackedBCD2                    resb 1                ; 1 Byte : dort kommt nur eine BCD rein => unpacked BCD

section .text

    main:                   ; tell linker entry point
        mov al, 5           ; Initiatisation: al =      0000 0101
        shl al, 4           ; Initialisation: al =      0101 0000
        add al, 2           ; Initialistioan: al =      0101 0010 : zwei BCD Zahlen im packed format: 52
        mov byte[numb1], al ; Initialistaion: [numb1] = 0101 0010 : zwei BCD Zahlen im packed format: 52

        mov al, 2           ; Initiatisation: al =      0000 0010
        shl al, 4           ; Initialisation: al =      0010 0000
        add al, 9           ; Initialistioan: al =      0010 1001 : zwei BCD Zahlen im packed format: 29
        mov byte[numb2], al ; Initialistaion: [numb2] = 0010 1001 : zwei BCD Zahlen im packed format: 29

        add al, [numb1]     ; unsigend int addition:
                            ; al            0010 1001
                            ; [numb1]     + 0101 0010
                            ;                           Übertragszeile
                            ;               0111 1011   Ergebnis: 0x7B => B kein BCD !
        
        mov [falschesZwischenErgebnis], al

        daa                 ; Decimal Adjust AL After Addition

        mov [res], al       ; richtiges Ergebnis:   0x81 = 1000 0001 = 129

        ; 129 dargestellt gibt keinen Sinn.
        ; jetzt müssen wir die packed BCD in 2 ASCII Zeichen umwandeln

        mov [unpackedBCD2], al  ; al wegsichern

        and al, 0x0F            ; 0000 0001
        or  al, 0x30             ; 0011 0001
        mov [unpackedBCD1], al  ; 0011 0001

        mov al, [unpackedBCD2]  ; 1000 0001
        and al, 0xF0            ; 1000 0000
        shr al, 4               ; 0000 1000
        or  al, 0x30            ; 0011 1000
        mov [unpackedBCD2], al  ; 0011 1000

        mov ecx,msg     ; message to write : The Result is:
        mov edx,len     ; message length
        mov ebx,1       ; file descriptor (stdout)
        mov eax,4       ; system call number (sys_write)
        int 0x80        ; call kernel

        mov ecx,unpackedBCD2     ; message to write = 0011 1000 = 0x38 = '8'
        mov edx,1       ; message length
        mov ebx,1       ; file descriptor (stdout)
        mov eax,4       ; system call number (sys_write)
        int 0x80        ; call kernel

        mov ecx,unpackedBCD1     ; message to write = 0011 0001 = 0x31 = '1'
        mov edx,1       ; message length
        mov ebx,1       ; file descriptor (stdout)
        mov eax,4       ; system call number (sys_write)
        int 0x80        ; call kernel
 

    mov eax,1           ; system call number (sys_exit)
    int 0x80            ; call kernel

