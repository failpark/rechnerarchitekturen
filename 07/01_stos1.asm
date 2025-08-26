global main ;must be declared for using gcc
 
section .data
    s1 db 'HeLLO, WORLD', 10, 0 ;source
    len equ $-s1
        
section .bss
    s2 resb 20 ;destination

section .text

    main: ;tell linker entry point


        mov edx,20          ;message length
        mov ecx,s1          ;message to write
        mov ebx,1           ;file descriptor (stdout)
        mov eax,4           ;system call number (sys_write)
        int 0x80            ;call kernel
    
        mov ecx, len        ; Anzahl der Bytes in String s1, inkl. 0-Terminierung : 13 Byte (dargestellt als 32 bit unsigned int)
        mov esi, s1         ; ESI — Pointer to data in the segment pointed to by the DS register; source pointer for string operations
                            ; siehe Intel Dokumentation (Band 1 Architecture)
        mov edi, s2         ; EDI — Pointer to data (or destination) in the segment pointed to by the ES register; destination pointer for string operations
                            ; siehe Intel Dokumentation (Band 1 Architecture)

        cld                 ; clear direction flag in eflags register => esi und edi werden incremented nach jeder lodsb bzw. stosb.

        loop_here:
            
            lodsb           ; Load byte at address ESI into AL: Das ist das erste char von s1 (password)
                            ; After the byte, word, or doubleword is transferred from the memory location into the AL, AX, or EAX register, the
                            ; ESI register is incremented or decremented automatically according to the setting of the DF flag in the EFLAGS
                            ; register.
                            ; (If the DF flag is 0, the (E)SI register is incremented; if the DF flag is 1, the ESI register is decremented.)
                            ; The (E)SI register is incremented or decremented by 1 for byte operations, by 2 for word operations, or by 4 for doubleword operations.
            
            or al, 20h      ; Verschiebt das Zeichen in der Ascii Tabelle um 2 Zeilen, wenn das Zeichen nicht in Zeile 2, 3, 6, 7 ist.
                            ; dh:  Zeile 0: Die ersten 16 Steuerzeichen (NUL - SI) werden zu (SP-/)
                            ;      Zeile 1: Dei zweiten 16 Steuerzeichen (DLE - US) werden zu (0 -?)
                            ;      Zeile 4: (@ A B - O) werden zu (` a b - 0)
                            ;      Zeile 5: (P Q R - _) werden zu (p q r - DEL)
                            ; =>  Insbesondere werden alle uppercase Letters zu lower case letters

            stosb           ; store AL at address EDI : Das ist das erste char von s2 (Geheimtext)
                            ; After the byte (stosb), word (stosw), or doubleword (stosd) is transferred from the register to the memory location, the
                            ; EDI register is incremented or decremented according to the setting of the DF flag in the EFLAGS register.
                            ; If the DF flag is 0, the register is incremented; if the DF flag is 1, the register is decremented
                            ; (the register is incremented or decremented  by 1 for byte operations, by 2 for word operations, by 4 for doubleword operations).

        loop loop_here      ; dec ecx; wenn nicht 0 => loop_here:
        
        
        mov edx,20          ;message length
        mov ecx,s2          ;message to write
        mov ebx,1           ;file descriptor (stdout)
        mov eax,4           ;system call number (sys_write)
        int 0x80            ;call kernel
        
    mov eax,1 ;system call number (sys_exit)
    int 0x80 ;call kernel
