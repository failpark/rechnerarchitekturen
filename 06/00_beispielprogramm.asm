global main                         ;must be declared for using gcc
extern printf

section .data
    A dw 1                          ; 16 bit unsigned int: 1
    B dw 2                          ; 16 bit unsigned int: 2

section .text

    print_ALLES:                    ; Set up for calling _printf to print myVar's value
        push EAX                    ; save EAX away on stack
        push EBX                    ; save EBX away on stack
        push ECX                    ; save EBX away on stack
        push EDX                    ; save EBX away on stack
        INC  ESI                    ; Increase ESI
        push ESI                    ; save ESI away on stack

        mov ecx, 0                  ; Initialisierung: ECX (32 bit)= alle bit sind 0.
        mov edx, 0                  ; Initialisierung: EDX (32 bit)= alle bit sind 0.
        mov  CX, [A]
        mov  DX, [B]

        push EDX                    ; Pushes the value of [B]
        push ECX                    ; Pushes the value of [A]
        push EBX                    ; Pushes the value of EBX onto the stack
        push EAX                    ; Pushes the value of EAX onto the stack
        push ESI                    ; Pushes the value of ESI (counter) onto the stack
        push formatString           ; Pushes the string address onto the stack
        call printf                 ; Calls the _printf function from the C library
        add ESP, 24                 ; Cleans up the stack after the call to printf

        pop ESI                    ; get saved away value from stack: restore ESI
        pop EDX                    ; get saved away value from stack: restore ECX
        pop ECX                    ; get saved away value from stack: restore ECX
        pop EBX                    ; get saved away value from stack: restore EBX
        pop EAX                    ; get saved away value from stack: restore EAX
    ret

    main:                           ; tell linker entry point
        
        mov esi, 0                  ; Initialisierung counter 

        mov eax, 0                  ; Initialisierung: EAX (32 bit)= alle bit sind 0.
        mov ebx, 0                  ; Initialisierung: EBX (32 bit)= alle bit sind 0.

        CALL print_ALLES            ; (1) Prints all of interest

        mov ax, [B]                 ; Lade Inhalt von B nach AX. In AX ist dann 2

        CALL print_ALLES            ; (2) Prints all of interest
        
        mov bx, ax                  ; Lade Inhalt von AX nach BX. In BX ist dann auch 2.

        CALL print_ALLES            ; (3) Prints all of interest

        shl	ax,	3                   ; Left-Shift von AX entpricht: 2*2*2*2 = 16. In AX steht dann: 16

        CALL print_ALLES            ; (4) Prints all of interest

        add	ax, bx                  ; Addiere BX (=2) auf AX (=16), entspricht: 16+2 = 18, In AX steht dann 18

        CALL print_ALLES            ; (5) Prints all of interest

        dec	ax                      ; Decrementiere AX um 1, entspricht 18-1 = 17. In AX steht dann 17.

        CALL print_ALLES            ; (6) Prints all of interest

        mov [B], ax                 ; Lade AX an die Adresse auf die B zeigt in den Speicher.
                                    ; Die Speicherzelle mit der Adresse B enthält dann 17.

        CALL print_ALLES            ; (7) Prints all of interest

        dec word[B]                 ; Decrementiere den Wert in Speicherzelle B um 1, entspricht 17-1 = 16.
                                    ; In Speicherzelle mit Adresse B steht dann der Wert 16

        CALL print_ALLES            ; (8) Prints all of interest

        mov bx, [B]                 ; Lade Inhalt von B nach BX. In BX ist dann 16

        CALL print_ALLES            ; (9) Prints all of interest



    ret                             ; Return from _main

section .data
    formatString db '%u) EAX = %u | EBX = %u | A = %u | B = %u ', 10, 0     ; Format string for _printf
    ;formatString db 'EAX = %d | EBX = %d', 10, 0     ; Format string for _printf
