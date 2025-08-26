global main ;must be declared for using gcc

section .text 

    main: ;tell linker entry point
        mov ecx,    10      ; so viele Schleifendurchlaeufe wollen wir machen

        mov eax,    '1'     ; mit diesem char fangen wir an: das wollen wir als erster ausgeben.

        l1:
            push ecx        ; Iterationszaehler auf den stack weg-schreiben.
                            ; ecx wird fuer die Ausgabe benötigt

            mov [num], eax  ; eax in [num] weg-schreiben
                            ; eax wird fuer die Ausgabe benötigt

            ; Ausgabe eines digits
            mov ecx, num    ; num wird vorbereitet: soll ausgegeben werden
            mov edx, 1      ; Laenge: nur ein char! wir geben nur 1 digit aus           
            mov ebx, 1      ; file descriptor (stdout)
            mov eax, 4      ; system call number (sys_write)         
            int 0x80        ; [num] wird ausgegeben.


            mov eax, [num]  ; eax wieder zurückholen (gerade ausgegebenes digit)

            sub eax, '0'    ; umwandeln von char in int
            inc eax         ; das gerade ausgegebene digit (integer) um 1 erhoehen.
            add eax, '0'    ; umwandeln von int in char
    
            pop ecx         ; Iterationszaehler aus ecs zurück holen

        loop l1             ; decreases ecx; wenn ecx dann nicht 0 => Sprung zu label l1

        mov eax, 1  ;system call number (sys_exit)
        int 0x80    ;call kernel

section .bss
    num resb 1

    