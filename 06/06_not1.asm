global main
extern printf

section .text

    print_eax:              ; Set up for calling _printf to print EAX's value
        push EAX            ; Pushes the value of EAX onto the stack
        push formatString   ; Pushes the string address onto the stack
        call printf         ; Calls the _printf function from the C library
        add ESP, 8          ; Cleans up the stack after the call to _printf
    ret
 
    main:
 
        MOV EAX, 0xFFFFFF00 ; Inverting bits with NOT EAX begins with: 00000000
        NOT EAX             ; After inversion, EAX is: 11111111 
        CALL print_eax      ; Calls the procedure to print EAX's value
    ret                     ; Returns from _main

 section .data 
    formatString db 'NOT 0xFFFFFF00 is %d.', 10, 0     ; Format string for printf

