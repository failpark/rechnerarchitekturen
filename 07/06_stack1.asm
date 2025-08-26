global  main ;must be declared for using gcc
extern  printf

section .data
    achar           db '0'
    EndeGelaender   db 0x0A
    copyESPregister dd 0
    MalESPgechecked db 0

    my_string           db      10, 'Schleifen-Durchlauf-Nr (ecx) = %d, (ebx) = %d', 10, 0
    Zeichen             db      'Zeichen wird ausgegeben:       ', 0
    len                 equ     $-Zeichen

section .text

    display:
        mov ecx, 75                 ; unsigned int (32 bit) = Anzahl der Zeichen im ASCII Code von 0 bis z
        
        next:
            ;ecx wird als counter verwandt: 75 Schleifendurchlaeufe bzw. Ausgaben
            push ecx                                    ; 75 unsigned int (32 bit) liegt auf dem Stack

                mov ebx, 0x00000000                      ; ebx = 0
                
                ;mov ebx,  dword [esp]                  
                mov bl,  byte [esp]                     ; esp zeigt auf niederwertigste Byte des hoechsten Elements im Stack
                                                        ; byte [esp] enthaelt den Inhalt des least signficant byte des hoechsten elements auf dem stack
                                                        ; in ebx: 24 0en und im least significant byte: 75 als unsigned int
                                                        ; das entspricht: in ecx: 75 als unsigned int (32 bit)
                
                push ecx                                ; für die Ausgabe: Vergleich mit ecx (muss identisch sein)
                push ebx                                ; 32 bit: unsigned int - gleicher Wert steht auch in ecx.
                push my_string
                call printf                             ; Ausgabe von: 'Schleifen-Durchlauf-Nr (ecx) = %d, Zeichen = 
                add esp, 12                             ; Cleans up the stack by removing the pushed addresses
            
                mov ecx, Zeichen                        ; Ausgabe: 'Zeichen wird ausgegeben:       '
                mov edx, len                            ; Laenge des strings
                mov eax, 4                              ; system call number (sys_write)
                mov ebx, 1                              ; stdout
                int 80h                                 ; call kernel (Operating System)

                mov ecx, achar                          ; Ausgabe: Erster Durchlauf: '0' wird ausgegeben.
                mov edx, 1                              ; 1 byte soll ausgegeben werden
                mov eax, 4                              ; system call number (sys_write)
                mov ebx, 1                              ; stdout
                int 80h                                 ; call kernel (Operating System)

            pop ecx                                     ; in ecx ist wieder der Schleifencounter
        
            inc byte [achar]                            ; naechstes Zeichen im ASCII-Code
        loop next                                       ; ecx wird implizit decrementiert (ecx > = ? dann loop)

        mov ecx, EndeGelaender                          ; Ausgabe: Linefeed
        mov edx, 1                                      ; 1 byte soll ausgegeben werden
        mov eax, 4                                      ; system call number (sys_write)
        mov ebx, 1                                      ; stdout
        int 80h                                         ; call kernel (Operating System)

        mov ecx, EndeGelaender                          ; Ausgabe: Linefeed
        mov edx, 1                                      ; 1 byte soll ausgegeben werden
        mov eax, 4                                      ; system call number (sys_write)
        mov ebx, 1                                      ; stdout
        int 80h                                         ; call kernel (Operating System)

    ret

    main: ;tell linker entry point
        mov ecx, EndeGelaender                          ; Ausgabe: Linefeed
        mov edx, 1                                      ; 1 byte soll ausgegeben werden
        mov eax, 4                                      ; system call number (sys_write)
        mov ebx, 1                                      ; stdout
        int 80h                                         ; call kernel (Operating System)

        call display                                    ; sub routine display aufrufen.

        mov eax,1                                       ;system call number (sys_exit)
        xor ebx, ebx                                    ; ebx = 0
        int 0x80                                        ;call kernel
        
