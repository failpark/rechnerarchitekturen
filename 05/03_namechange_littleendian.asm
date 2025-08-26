global main                             ; must be declared for linker (ld)
extern printf                           ; Funktionsaufruf aus C library

section .text
main:                                   ;tell linker entry point

    ; Load effective address: Adress Berechnung des nächsten Char im String name
    ; Berechnung von ByteNr1 (Pointer auf das erste Byte von name)
    mov eax, name                       ; Adresse von name wird in eax geschrieben.
    lea edx, [eax]                      ; neue effektive Adresse wird berechnet und in edx geschrieben.
                                        ; vorsicht: bei lea bedeutet [] keine Dereferenzierung!
                                        ; bei lea bedeutet [] schlichtweg die Berechnung: z.B. [eax+1]...
                                        ; edx enthält danach den exakt gleichen Wert wie eax: die Adresse der Speicherzelle: Beginn von name
    mov dword[ByteNr1], edx             ; ByteNr1 zeigt auf das erste Byte im Speicher von [name]
    
    ; Berechnung von ByteNr2 (Pointer auf das zweite Byte von name)
    ; eax enthält im Moment die Adresse des ersten Byte von name
    inc eax                             ; eax wird um 1 erhöht: das ist Adresse des nächsten byte im String name
    lea edx, [eax]                      ; neue effektive Adresse wird berechnet und in edx geschrieben.
    mov dword[ByteNr2], edx             ; ByteNr2 zeigt auf das zweite Byte im Speicher von [name]
    
    ; Berechnung von ByteNr3 (Pointer auf das dritte Byte von name)
    inc eax                             ; eax wird um 1 erhöht: das ist Adresse des nächsten byte im String name
    lea edx, [eax]                      ; neue effektive Adresse wird berechnet und in edx geschrieben.
    mov dword[ByteNr3], edx             ; ByteNr3 zeigt auf das dritte Byte im Speicher von [name]

    ; Berechnung von ByteNr4 (Pointer auf das vierte Byte von name)
    inc eax                             ; eax wird um 1 erhöht: das ist Adresse des nächsten byte im String name
    lea edx, [eax]                      ; neue effektive Adresse wird berechnet und in edx geschrieben.
    mov dword[ByteNr4], edx             ; ByteNr4 zeigt auf das vierte Byte im Speicher von [name]



    mov edx, 1                   ;message length
    mov ecx, [ByteNr1]           ;address of the message to write (name is pointer)
    mov ebx, 1                   ;file descriptor (stdout)
    mov eax,4                    ;system call number (sys_write)
    int 0x80                     ;call kernel

    mov edx, 1                   ;message length
    mov ecx, [ByteNr2]           ;address of the message to write (name is pointer)
    mov ebx, 1                   ;file descriptor (stdout)
    mov eax,4                    ;system call number (sys_write)
    int 0x80                     ;call kernel
 
    mov edx, 1                   ;message length
    mov ecx, [ByteNr3]           ;address of the message to write (name is pointer)
    mov ebx, 1                   ;file descriptor (stdout)
    mov eax,4                    ;system call number (sys_write)
    int 0x80                     ;call kernel

    mov edx, 1                   ;message length
    mov ecx, [ByteNr4]           ;address of the message to write (name is pointer)
    mov ebx, 1                   ;file descriptor (stdout)
    mov eax,4                    ;system call number (sys_write)
    int 0x80                     ;call kernel


    ;write the first byte of the [name]
    mov eax, [ByteNr1]          ; der Inhalt von der Speicherzelle auf die ByteNR1 zeigt wird in eax geschrieben
                                ; jetzt steht die Adresse vom ersten Byte von name in eax  
    push dword[eax]             ; Der Inhalt der Speicherzelle auf die EAX zeigt, wird als ein dword auf den Stack gelegt.
    push formatString           ; Pushes the string address onto the stack
    call printf                 ; Calls the _printf function from the C library
    add esp, 8                  ; Cleans up the stack after the call to _printf
                                ; Adjusts the stack pointer by 8 bytes to clean up the pushed arguments

    ;write the second byte of the [name]
    mov eax, [ByteNr2]          ; der Inhalt von der Speicherzelle auf die ByteNR1 zeigt wird in eax geschrieben
                                ; jetzt steht die Adresse vom ersten Byte von name in eax  
    push dword[eax]             ; Der Inhalt der Speicherzelle auf die EAX zeigt, wird als ein dword auf den Stack gelegt.
    push formatString           ; Pushes the string address onto the stack
    call printf                 ; Calls the _printf function from the C library
    add esp, 8                  ; Cleans up the stack after the call to _printf
                                ; Adjusts the stack pointer by 8 bytes to clean up the pushed arguments

    ;write the first byte of the [name]
    mov eax, [ByteNr3]          ; der Inhalt von der Speicherzelle auf die ByteNR1 zeigt wird in eax geschrieben
                                ; jetzt steht die Adresse vom ersten Byte von name in eax  
    push dword[eax]             ; Der Inhalt der Speicherzelle auf die EAX zeigt, wird als ein dword auf den Stack gelegt.
    push formatString           ; Pushes the string address onto the stack
    call printf                 ; Calls the _printf function from the C library
    add esp, 8                  ; Cleans up the stack after the call to _printf
                                ; Adjusts the stack pointer by 8 bytes to clean up the pushed arguments

    ;write the first byte of the [name]
    mov eax, [ByteNr4]          ; der Inhalt von der Speicherzelle auf die ByteNR1 zeigt wird in eax geschrieben
                                ; jetzt steht die Adresse vom ersten Byte von name in eax  
    push dword[eax]             ; Der Inhalt der Speicherzelle auf die EAX zeigt, wird als ein dword auf den Stack gelegt.
    push formatString           ; Pushes the string address onto the stack
    call printf                 ; Calls the _printf function from the C library
    add esp, 8                  ; Cleans up the stack after the call to _printf
                                ; Adjusts the stack pointer by 8 bytes to clean up the pushed arguments

    ;Exit code
     mov eax, 1
     mov ebx, 0
     int 80h

section .data
    name dd 'Pete'                ; name is a pointer to an allocated doube word (4 byte) in memory with 'Pete'
    ByteNr1 db '0000'             ; is a pointer to an allocated 4 byte in memory with '0'
    ByteNr2 db '0000'             ; is a pointer to an allocated 4 byte in memory with '0'
    ByteNr3 db '0000'             ; is a pointer to an allocated 4 byte in memory with '0'
    ByteNr4 db '0000'             ; is a pointer to an allocated 4 byte in memory with '0'

    formatString  db             10,'Der Byte-Wert in Speicherzelle = %c', 10, 10, 0  ; Format string for _printf