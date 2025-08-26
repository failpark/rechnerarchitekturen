global main
extern printf

section .text

    print_eax:                                  ; Set up for calling _printf to print EAX's value
        push EAX                                ; Pushes the value of EAX onto the stack
        push formatString                       ; Pushes the string address onto the stack
        call printf                             ; Calls the _printf function from the C library
 
        add ESP, 8                              ; Cleans up the stack after the call to _printf:  Corrects the stack pointer
    ret
 
    main:
        counter_loop:                           ; This loop increments the counter and prints its value until it reaches 10

        inc byte [counter]                      ; Increment counter by 1
        
        mov eax, dword [counter]                ; Move the counter value into EAX for printing
 
        CALL print_eax                          ; Calls the procedure to print EAX's value

        cmp byte [counter], 10                  ; Compare counter with 10

        jge end                                 ; If counter is greater or equal to 10, jump to 'end'
                                                ; wird nur einmal ausgefuehrt: dann wenn counter = 10 ist,
                                                ; dann wird das Programm beeendet
 
        jmp counter_loop                        ; Unconditionally jump back to start of the loop
                                                ; wenn nicht uebersprungen durch jge,
                                                ; dann zurueckspringen zu counter_loop
        
        end:

    ret                                         ; Returns from _main
 
section .data
    formatString db 'Counter is %d.', 10, 0     ; Format string for _printf
    counter db 0                                ; Initialize counter to 0



