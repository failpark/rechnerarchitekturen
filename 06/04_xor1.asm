global main
extern printf

section .text

    print_eax:                  ; Set up for calling _printf to print EAX's value
        push EAX                ; Pushes the value of EAX onto the stack
        push formatString       ; Pushes the string address onto the stack
        call printf            ; Calls the _printf function from the C library  ; Cleans up the stack after the call to _printf
        add ESP, 8              ; Corrects the stack pointer
    ret

    main:
        MOV EAX, 0x000000FF     ; Using XOR to toggle and reset bits, EAX starts as: 00..00 11111111
        XOR EAX, 0x000000FF     ; Toggling all bits off results in: 00000000
 
        CALL print_eax          ; Prints the value of EAX, Calls the procedure to print EAX's value
    ret                         ; Returns from _main

section .data
    formatString db '0x000000FF XOR 0x000000FF is %d.', 10, 0   ; Format string for printf


