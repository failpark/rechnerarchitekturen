global main
extern printf

section .text

    main:               ; The main entry point of the program

        mov eax, 13     ; load Dibidend in eax
        mov ebx, 5      ; load Divisor in ebx
   
        cdq             ; Sign-extends EAX into EDX:EAX to prepare for division 

        idiv ebx        ; signed division  (EDX:EAX) / EBX = EAX (Quotient) and EDX (Remainder/ Rest)

        push edx        ; Pushes the remainder (now in EDX) onto the stack, as the second integer argument for printf
        push eax        ; Pushes the quotient (now in EAX) onto the stack, as the first integer argument for printf
        push format     ; Pushes the address of the format string onto the stack, printf will format the output using this string
        call printf    ; Calls '_printf', printing the message with the quotient and remainder embedded
        add esp, 12     ; Cleans up the stack by adjusting ESP (edx : 4)+(eax : 4)+(format : a 4 byte pointer to [format]) = alltogether 12 byte on the stack
    ret

section .data
    format db 'The quotient of 13 and 5 is %d, Remainder is %d.', 10, 0  ; format is a pointer to a 32bit address in memory where a Byte-String starts
