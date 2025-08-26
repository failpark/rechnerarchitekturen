global main
extern printf

section .data
;    number       dd 10               ; we want to calculate number! works
    number       dd 12               ; we want to calculate number! works
;    number       dd 13               ; we want to calculate number! doesnt work
    formatString db '%d! = %d.', 10, 0   ; Defines the format string for output, used by _printf

section .text
    
    factorial:                          ; Recursive factorial function
        cmp eax, 1                      ; Compare the current value in EAX (n) to 1
        jle .base_case                  ; Jump short if less or equal (ZF=1 or SF not equal OF)
                                        ; If n <= 1, jump to the base case handler

        ; Recursive case handling
        push eax                        ; Save the current value of n on the stack to preserve it
        dec eax                         ; Decrement n by 1, preparing for the recursive call  with n-1
        
        call factorial                  ; Recursively call the factorial function with n-1
        
        pop ebx                         ; After returning, restore the original n value from the stack into EBX
        
        imul eax, ebx                   ; Multiply the returned factorial result (in EAX) by n, stored in EBX
        
        jmp end                         ; Jump to the end to skip the base case once recursion completes

        .base_case:                     ; Set the result to 1 for the base case (factorial of 0 or 1)
        mov eax, 1
        
        end:
    ret                                 ; Return from the factorial function, with the result in EAX

    main:
        
        mov eax, dword [number]         ; Example: Calculate the factorial of 3
        
        call factorial                  ; Call the factorial function
        
        ; eax now contains the result of the recursion n!
        
        ; Prepare the stack for _printf call
        push eax                        ; Push the factorial result onto the stack as the second argument to _printf
        push dword [number]             ; number!
        push formatString               ; Push the format string address onto the stack ; as the first argument
        call printf                     ; Call the _printf function to print the result
        add  esp, 12                    ; Clean up the stack (two 4-byte values were pushed)

    ret                                 ; Return from _main, ending the program






