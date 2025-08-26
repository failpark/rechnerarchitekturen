global main
extern printf

section .text
    print_eax:               ; Set up for calling _printf to print myVar's value
        push EAX             ; Pushes the value of EAX onto the stack
        push formatString    ; Pushes the string address onto the stack
        call printf         ; Calls the _printf function from the C library
        add ESP, 8           ; Cleans up the stack after the call to printf
    ret

    main:      	            ; The main entry point of the program
 
        MOV EAX, 4          ; EAX = 4
        IMUL EAX, 2         ; Multiplying EAX by 2 => EAX = EAX *2 => EAX = 4 * 2 = 8
        CALL print_eax      ; Prints the value of EAX
    ret                     ; Return from _main

section .data
    formatString db 'The product of 4 and 2 is %d.', 10, 0     ; Format string for _printf
