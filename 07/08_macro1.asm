global main
extern printf

section .data
 
    string  db 'Macros sind cool: Nr : %d', 10, 0      ; Define a string to be printed
    zahl    dd 12345                                ; 32 bit unsigned int

section .text                   ; Define a macro named 'print' that takes one argument

    %macro ausgabe 2
        push dword [%2]         ; Push erstes Argument fuer printf (zahl): 
                                ; Derefenzierung von zahl : 32 bit unsigned int
        push %1                 ; Push the string address
        call printf             ; Call _printf to print the string
        add esp, 8              ; Clean up the stack (4 bytes)
    %endmacro                   ; End of the macro definition
 
    main:

        ausgabe string, zahl    ; Macro invocation to print the string

    ret                         ; Return from _main, ending the program
 
