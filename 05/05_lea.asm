global main
extern printf

section .text

    main:                               ; The main entry point of the program
        mov EAX, array                  ; Load the address of the start of 'array' into EAX
        mov EBX, 2                      ; Let's say we want to access the 3rd element, index 2
 
        lea EDX, [EAX + 4 * EBX + 4]    ; Calculates the address for 'array[2+1]' and stores it in EDX
                                        ; zur effektiven Adresse der ersten Speicherzelle (byte) des array wird addiert:
                                        ; 4 * 2 + 4 = 12.
                                        ; in edx wird diese neu berechnete Adresse geschrieben.
                                        ; deshalb zeigt edx auf das vierte Element des array:
                                        ; dh. die 4 byte in denen steht die Zahl 40 als 32 bit Integer

        ; Let's assume we want to perform an operation, like adding 10 
        ; to this element
        ; Adds 10 to the value at the address stored in EDX 
        ; ('array[3]')

        add dword [EDX], 10             ; edx zeigt auf die Speicherzelle (dword) mit dem Inhalt 40.
                                        ; Auf den Inhalt der Speicherzelle wird die Zahl 10 addiert.
                                        ; dh: [edx] = [edx] + 10
                                        ; dh  [edx] = 40 + 10 = 50 => an der Speicherstelle steht jetzt 50.
 
        mov EAX, [EDX]                  ; (Beispieloperation) Der Inhalt der Speicherzelle auf die edx zeigt, wird nach eax geschrieben

        mov [result], EAX               ; (Beispieloperation) eax (enthaelt die Zahl 50) wird an die Stelle im Speicher geschrieben auf die result zeigt.

        ; Set up for calling _printf to print result's value
        push dword [result]             ; Pushes the value of result onto the stack
        push dword [result]             ; Pushes the value of result onto the stack
        push formatString               ; Pushes the string address onto the stack
        call printf                    ; Calls the _printf function from the C library
 
        add esp, 12                      ; Cleans up the stack after the call to _printf
                                        ; Adjusts the stack pointer by 8 bytes to clean up the pushed arguments
        
        ret         ; Return from _main

 section .data
 
    formatString db 'The result is %d. so isses! es ist wirklich: %d', 10, 0  ; Format string for _printf
 
    array dd 10, 20, 30, 40, 50                 ; Array of 5 integers, jeweils dword (4 Byte): insgesamt 5*4 = 20 byte allokiert
    
    result dd 0                                 ; Speicher allokiert fuer Ergebnis, zunaechst mit 0 initialisiert. result ist der Pointer auf die 4 byte Speicher.

