global main
extern printf

section .text
    main:

        mov EAX, 9                  ; Initializes EAX with the value 9

        cmp EAX, 0                  ; Compare EAX with 0
        
        je zero                     ; If EAX is 0, jump to 'zero' label

        jg positive                 ; If EAX is greater than 0, jump to 'positive' label

        jl negative                 ; If EAX is less than 0, jump to 'negative' label
 
        zero:                       ; Executes if EAX is exactly 0 ; Pushes the address of the zero message onto the stack
            push formatZero         ; Calls the '_printf' function to print the zero message
            call printf
            add esp, 4              ; Cleans up the stack by removing the pushed address
        jmp end                     ; Jumps to 'end' to avoid executing other blocks

        positive:                   ; Executes if EAX is greater than 0  ; Pushes the address of the positive message onto the stack
            push formatPositive     ; Calls the '_printf' function to print the positive message
            call printf
            add esp, 4              ; Cleans up the stack by removing the pushed address
        jmp end                     ; Jumps to 'end' to exit the program cleanly

        negative:                   ; Executes if EAX is less than 0.  ; Pushes the address of the negative message onto the stack
            push formatNegative     ; Calls the '_printf' function to print the negative message
            call printf
            add esp, 4              ; Cleans up the stack by removing the pushed address

    end:
    ret                             ; Returns from _main

 section .data
    ; Defines format strings for printing messages based on the value of EAX
    formatZero      db 'EAX holds ZERO.', 10, 0
    formatPositive  db 'EAX holds a POSITIVE value.', 10, 0
    formatNegative  db 'EAX holds a NEGATIVE value.', 10, 0





