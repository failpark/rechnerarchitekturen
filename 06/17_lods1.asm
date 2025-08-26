global main ;must be declared for using gcc
extern printf   
        


section .data
    s1 db 'password', 0 ; Klartext (source) 0x00 NULL
    len1 equ $-s1
    
    len1pwd dd 0x00000000

    s2 db 'password', 0 ; Platzhalter für Geheimtext (destination)
    len2 equ $-s2

    len2pwd dd 0x00000000

    generalInfo   db 'Cesar-Chiffre, Key                           = %d', 10, 0
    key db 0x00
    ausgabeInfo   db 'Das Password lautet                          : %s, Laenge des Strings : %d, Länge des passwords : %d', 10, 0
    substitution  db 'Wir substituieren monografisch & symmetrisch : ||||||||, Anzahl der Zeichen : %d', 10, 0
    ausgabeInfo2  db 'Das verschlüsselte Password                  : %s, Laenge des Strings : %d, Länge des passwords : %d', 10, 0
            
section .text
    
    main: ;tell linker entry point

        mov [key], byte 0x02               ; Wir wollen um 2 verschieben bei Cesar

        mov eax, 0x00000000                 ; set to 0
        mov al, [key]                       ; set key
        push eax                            ; Der Key (=2) wird auf den stack gelegt (4 byte)
        push generalInfo                    ; Zeiger auf formatierung 'Cesar-C... (32 bit)
        call printf
        add esp, 8                          ; Cleans up the stack by removing the pushed addresses

        mov eax, len1
        dec eax
        mov [len1pwd], eax                  ; Die tatsächliche Länge des passwords s1 (ohne 0-termination)

        mov eax, len2
        dec eax
        mov [len2pwd], eax                  ; Die tatsächliche Länge des password-Platzhalters s2 (ohne 0-termination)


        push dword[len1pwd]                 ; tatsächliche Länge des Passworts auf stack legen: 32 bit (= 8)
        push len1                           ; Konstante : Länge des String (0-terminiert : 9) (32 bit)
        push s1                             ; Zeiger auf string des Passwords (32 bit) 
        push ausgabeInfo                    ; Zeiger auf formatierung 'Das Password lautet... (32 bit)
        call printf
        add esp, 16                         ; Cleans up the stack by removing the pushed addresses

        push dword[len1pwd]                  ; tatsächliche Länge des Passworts auf stack legen: 32 bit (= 8)
        push substitution                    ; Zeiger auf formatierung 'Das Password lautet... (32 bit)
        call printf
        add esp, 8                            ; Cleans up the stack by removing the pushed addresses

        mov ecx, [len1pwd]                    ; Nur die tatsächlichen Zeichen des Passwords substituieren
                                            ; nicht das letzte Zeichen des Strings: 0x00 !! das ist die 0-termination
        mov esi, s1                         ; ESI — Pointer to data in the segment pointed to by the DS register; source pointer for string operations
                                            ; siehe Intel Dokumentation (Band 1 Architecture)
        mov edi, s2                         ; EDI — Pointer to data (or destination) in the segment pointed to by the ES register; destination pointer for string operations
                                            ; siehe Intel Dokumentation (Band 1 Architecture)

        cld                                 ; clear direction flag in eflags register => esi und edi werden incremented nach jeder lodsb bzw. stosb.

        loop_here:
        
            lodsb                           ; Load byte at address ESI into AL: Das ist das erste char von s1 (password)
                                            ; After the byte, word, or doubleword is transferred from the memory location into the AL, AX, or EAX register, the
                                            ; ESI register is incremented or decremented automatically according to the setting of the DF flag in the EFLAGS
                                            ; register.
                                            ; (If the DF flag is 0, the (E)SI register is incremented; if the DF flag is 1, the ESI register is decremented.)
                                            ; The (E)SI register is incremented or decremented by 1 for byte operations, by 2 for word operations, or by 4 for doubleword operations.
        
            add al, [key]                   ; Wir addieren auf jeden Buchstaben den key (=2) dazu
        
            stosb                           ; store AL at address EDI : Das ist das erste char von s2 (Geheimtext)
                                            ; After the byte, word, or doubleword is transferred from the register to the memory location, the
                                            ; EDI register is incremented or decremented according to the setting of the DF flag in the EFLAGS register.
                                            ; If the DF flag is 0, the register is incremented; if the DF flag is 1, the register is decremented
                                            ; (the register is incremented or decremented  by 1 for byte operations, by 2 for word operations, by 4 for doubleword operations).
    
        loop loop_here                      ; ecx wurde vor dem loop auf len1pwd gesetzt: Loop wird für alle Zeichen des pwd durchlaufen.
        

        push dword[len2pwd]                 ; tatsächliche Länge des Passworts auf stack legen: 32 bit (= 8)
        push len2                           ; Konstante: beinhaltet die Länge des Strings inkl.  String (0-terminiert : 9) (als 32 bit unsigned int dargestellt)
        push s2                             ; Zeiger auf das erste Byte im Hauptspeicher des strings s2
        push ausgabeInfo2                   ; printf format
        call printf
        add esp, 16                         ; Cleans up the stack by removing the pushed addresses


        mov eax,1 ;system call number (sys_exit)
        int 0x80 ;call kernel
