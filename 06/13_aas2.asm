global main             ;must be declared for using gcc

section .data
    msg db 'The Result is:',0xa
    len equ $ - msg
    num1    db '85'             ; 2 ASCII Zeichen
    num2    db '56'             ; 2 ASCII Zeichen
    sum     db '  '             ; 2 Leerzeichen

section .bss
    res resb 1

section .text

    main:               ; tell linker entry point
        mov esi, 1      ; Initiatisation: pointing to the rightmost digit ; (ESI used for String Operations "source index")
        mov ecx, 2      ; Initiatisation: num of digits

        clc             ; Clear CF flag in the EFLAGS register

        sub_loop:       ; Label

            jnc keinCarry           ; wenn CF = 0 dann wird gesprungen
                add byte[num2 + esi], 1  ; Carry Flag zu addieren als carry in.
            keinCarry:

            mov al, [num1 + esi]    ; num1 zeigt auf Speicherzelle: Inhalt '8' ASCII
                                    ; num1 + 1 zeigt auf Speicherzelle: Inhalt '5' ASCII
                                    ; al enthaelt '5' ASCII = 0x35 = 0011 0101

            sub al, [num2 + esi]    ; al         = 0011 0101
                                    ; [num2 + 1] = '6' = 0x36 = 0011 0110
                                    ; Das Ergebnis ist -1
                                    ; Dargestellt im 2er Komplement:
                                    ; -1(2erK) = 1111 1111
           
            aas             ; AX = 0000 0000 1111 1111
                            ; fuehrt folgenden Schritte aus:
                            ; AX = AX - 6 
                            ; AX = 0000 0000 1111 1001
                            ;   AH = 0000 0000 
                            ;   AH = AH - 1
                            ;   AH = 1111 1111 (2er K von 1)
                            ; AF = 1
                            ; CF = 1
                            ;   AL = 1111 1001 
                            ;   AL = AL AND 0x0F
                            ;   AL = 0000 1001 = 9
        
            pushf                   ; push eflags register (32 bit) on stack

            or al, 30h              ; al    0000 1001
                                    ; 0x30  0011 0000
                                    ; OR    0011 1001 = 0x39 = '9' ASCII Code
                                    ; al enthaelt dann '1' ASCII Code
            
            popf                    ; dword aus dem stack in eflags register (32 bit) schreiben

            mov [res + esi], al 	; an die hinterste Stelle von res das Ergebnis '9' schreiben.
                                    ; res zeigt dann auf folgenden String: ' 9' => 1 Leerzeichen und eine 9 (in ASCII)

            dec esi                 ; Jetzt kuemmern wir uns dann um '8' aus num1 und '5' aus num1
                                    ; Besonderheit: AF und CF ist auf 1 gesetzt, dies bleibt so bis zum sub Aufruf 

        loop sub_loop               ; loop decrementiert ecx automatisch um 1. Dann wird ueberprueft: ecx noch > 0 ? wenn ja dann loop ausfuehren.



        or al, 30h      ; AL enthaelt 0000 0110 als BCD-Ergebnis.
                        ; bityweises OR von AL mit 0011 0000 ergibt:
                        ; AL = 0011 0110 => 0x36 = '6' in ASCII Tabelle

        mov [res], al   ; al wird nach [res] geschrieben.

        mov ecx,msg     ; message to write : The Result is:
        mov edx,len     ; message length
        mov ebx,1       ; file descriptor (stdout)
        mov eax,4       ; system call number (sys_write)
        int 0x80        ; call kernel

        mov ecx,res     ; message to write = '29'
        mov edx,2       ; message length
        mov ebx,1       ; file descriptor (stdout)
        mov eax,4       ; system call number (sys_write)
        int 0x80        ; call kernel

    mov eax,1           ; system call number (sys_exit)
    int 0x80            ; call kernel

