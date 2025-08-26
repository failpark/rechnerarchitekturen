global main ;must be declared for using gcc

section .data
    msg     db 'The Sum is:',0xa
    len equ $ - msg
    num1    db '12345'              ; 5 ASCII Zeichen
    num2    db '23456'              ; 5 ASCII Zeichen
    sum     db '     '              ; 5 Leerzeichen

section .text

    main:                           ; tell linker entry point
        mov esi, 4                  ; Initiatisation: pointing to the rightmost digit ; (ESI used for String Operations "source index")
        mov ecx, 5                  ; Initiatisation: num of digits

        clc                         ; Clear CF flag in the EFLAGS register

        add_loop:                   ; Label

            mov al, [num1 + esi]    ; num1 zeigt auf Speicherzelle: Inhalt '1' ASCII
                                    ; num1 + 4 zeigt auf Speicherzelle: Inhalt '5' ASCII
                                    ; al enthaelt '5' ASCII

            adc al, [num2 + esi]    ; add with carry;  num2 + 4 zeigt auf Speicherzelle: Inhalt '6' ASCII
                                    ; Es wird durchgefuehrt '5' (ASCII) + '6' (ASCII) + CF (=0) = 0x35 + 0x36 + 0
                                    ;   0011 0101   ASCII Code fuer '5'
                                    ; + 0011 0110   ASCII Code fuer '6'
                                    ; + 0000 0000   Carry Flag (Carry in)
                                    ;    11  1      Uebertragszeile
                                    ;   0110 1011   Ergebnis in al = 0x6B (Direkte Bedeutung in ASCII Code: 'k')
                                    ; 'k' als Ergebnis macht KEINEN SINN => Deshalb Anpassung NOTWENDIG (=> AAA)

            aaa                     ; ASCII Adjust After Addition













            pushf                   ; push eflags register (32 bit) on stack

            or al, 30h              ; al    0000 0001
                                    ; 0x30  0011 0000
                                    ; OR    0011 0001 = 0x31 = '1' ASCII Code
                                    ; al enthaelt dann '1' ASCII Code
            
            popf                    ; dword aus dem stack in eflags register (32 bit) schreiben

            mov [sum + esi], al 	; an die hinterste Stelle von sum das Ergebnis '1' schreiben.
                                    ; sum zeigt dann auf folgenden String: '    1' => 4 Leerzeichen und eine 1 (ASCII)

            dec esi                 ; Jetzt kuemmern wir uns dann um '4' aus num1 und '5' aus num1
                                    ; Besonderheit: AF und CF ist auf 1 gesetzt, dies bleibt so bis zum adc Aufruf 

        loop add_loop               ; loop decrementiert ecx automatisch um 1. Dann wird ueberprueft: ecx noch > 0 ? wenn ja dann loop ausfuehren.


        mov ecx,msg                 ; message to write : The sumis:
        mov edx,len                 ; message length
        mov ebx,1                   ; file descriptor (stdout)
        mov eax,4                   ; system call number (sys_write)
        int 0x80                    ; call kernel
        
        mov ecx,sum                 ; message to write  : sum zeigt auf String der Ergebnis enthaelt als ASCII characters
        mov edx,5                   ; message length
        mov ebx,1                   ; file descriptor (stdout)
        mov eax,4                   ; system call number (sys_write)
        int 0x80                    ; call kernel

    mov eax,1                       ; system call number (sys_exit)
    int 0x80                        ; call kernel


