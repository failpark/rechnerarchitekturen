global main
extern printf

section .text

    main:
        mov eax, 0x000000FF     ; EAX starts as: 00..00 11111111
        mov [sicherungEAX], eax ; eax weg-gesichert

        push eax                ; Pushes the value of EAX onto the stack
        push formatString1      ; Pushes the string address onto the stack
        call printf             ; Calls the _printf function from the C library  ; Cleans up the stack after the call to _printf
        add ESP, 8              ; Corrects the stack pointer
        
        ; wegen call printf ist eax jetzt ueberschrieben...
        ; deshalb wiederherstellung
        mov eax, [sicherungEAX] ; EAX starts as: 00..00 11111111

        test eax,   0x0000FF00  ; aehnlich bitweises and (aber kein Ergebnis), nur PF, ZF, und SF wird gesetzt.        
        ;and  eax,   0x0000FF00  ; aehnlich bitweises and (aber kein Ergebnis), nur PF, ZF, und SF wird gesetzt.        
        
        jz   print_and_would_deliver_zero

        jmp NOT_ZERO

        print_and_would_deliver_zero:   ; Set up for calling _printf to print EAX's value
        push eax                ; Pushes the value of EAX onto the stack
        push formatString2      ; Pushes the string address onto the stack
        call printf             ; Calls the _printf function from the C library  ; Cleans up the stack after the call to _printf
        add ESP, 8              ; Corrects the stack pointer

        push formatJZstring         ; Pushes the string address onto the stack
        call printf                 ; Calls the _printf function from the C library  ; Cleans up the stack after the call to _printf
        add ESP, 4                  ; Corrects the stack pointer

        ; jetzt ist eax wieder überschrieben wegen call printf
         ; deshalb wiederherstellung
        mov eax, [sicherungEAX] ; EAX starts as: 00..00 11111111

        NOT_ZERO:

        push EAX                ; Pushes the value of EAX onto the stack
        push formatString3      ; Pushes the string address onto the stack
        call printf             ; Calls the _printf function from the C library  ; Cleans up the stack after the call to _printf
        add ESP, 8              ; Corrects the stack pointer

        

    ret                         ; Returns from _main

section .data
    formatString1   db 'eax beinhaltet noch: %d.', 10, 0   ; Format string for printf
    formatString2   db 'eax beinhaltet immer noch: %d.', 10, 0   ; Format string for printf
    formatString3   db 'eax beinhaltet wirklich immer noch: %d.', 10, 0   ; Format string for printf
    formatJZstring  db 'and eax, 0x0000FF00 wuerde 0x00000000 liefern', 10, 0   ; Format string for printf
    sicherungEAX    dd  0x00000000


