global main
extern printf

section .text
    print_eax:                      ; set up for calling printf to print EAX's value 
        push eax                    ; pushes the value of EAX onto the stack
        push formatString           ; Pushes the string address onto the stack
        call printf                 ; Calls the printf function from the C library 
        add ESP, 8                  ; Cleans up the stack after the call to printf
    ret
 
    main:
 
        MOV EAX, 0xFFFFFFFF         ; Initiates EAX with a full byte of 1s: 11111111 11111111 11111111 11111111

        AND EAX, 0x0000000F         ; Targeting the lowest four bits with the AND operation:  Masks EAX, resulting in: 00..00001111
 
        CALL print_eax              ; Prints the value of EAX : Calls the procedure to print EAX's value 
    ret                             ; Returns from _main

section .data
    formatString db '0xFFFFFFFF AND 0x0000000F is %d.', 10, 0   ; Format string for _printf
