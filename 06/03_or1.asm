global main
extern printf

section .text
    
    print_eax:                  ; Set up for calling _printf to print EAX's value
        push EAX                ; Pushes the value of EAX onto the stack
        push formatString       ; Pushes the string address onto the stack
        call printf             ; Calls the _printf function from the C library
        add ESP, 8              ; Cleans up the stack after the call to _printf
    ret

    main:
        MOV EAX, 0x0000000F     ; EAX is initially: 00..00 00001111
        OR EAX,  0x000000F0     ; Setting specific bits using OR, Combining with 0xF0 results in: 00..00 11111111
 
        CALL print_eax          ; Prints the value of EAX, calls the procedure to print EAX's value
    ret                         ; Returns from _main

section .data

    formatString db '0x0000000F OR 0x000000F0 is %d.', 10, 0     ; Format string for _printf



