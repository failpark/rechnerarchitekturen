global main ;must be declared for using gcc

; define constants
SYS_EXIT    equ 1
SYS_READ    equ 3
SYS_WRITE   equ 4
STDIN       equ 0
STDOUT      equ 1

segment .data
    msg1 db "Enter a digit ", 0xA,0xD
    len1 equ $- msg1

    msg2 db "Please enter a second digit", 0xA,0xD
    len2 equ $- msg2
    
    msg3 db "The sum is: "
    len3 equ $- msg3

segment .bss
    number1 resb 2
    number2 resb 2
    res resb 1
    
section .text
    main: ;tell linker entry point
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, msg1           ; msg1 db "Enter a digit ", 0xA,0xD
        mov edx, len1
        int 0x80
        
        mov eax, SYS_READ
        mov ebx, STDIN
        mov ecx, number1       ; num1 eingeben per STDIN == Tastatur
        mov edx, 2              ; 2 Zeichen lesen (eine Zahl und "Return" : nur ein digit!)
        int 0x80
        
        mov eax, SYS_WRITE
        mov ebx, STDOUT 
        mov ecx, msg2           ; msg2 db "Please enter a second digit", 0xA,0xD
        mov edx, len2
        int 0x80
        
        mov eax, SYS_READ
        mov ebx, STDIN
        mov ecx, number2        ; num2 eingeben per STDIN == Tastatur
        mov edx, 2              ; 2 Zeichen lesen (eine Zahl und "Return" : nur ein digit!)
        int 0x80
        
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, msg3           ; msg3 db "The sum is: "
        mov edx, len3
        int 0x80
        
        ; moving the first number to eax register and second number to ebx
        ; and subtracting ascii '0' to convert it into a decimal number
        mov eax, [number1]
        sub eax, '0'
        
        mov ebx, [number2]
        sub ebx, '0'
        
        
        add eax, ebx        ; add eax and ebx => eax = eax + ebx
        
        
        ; add '0' to to convert the sum from decimal to ASCII
        add eax, '0'
        
        ; storing the sum in memory location res
        mov [res], eax
        
        ; print the sum
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, res
        mov edx, 1
        int 0x80
        
    exit:
        mov eax, SYS_EXIT
        xor ebx, ebx
        int 0x80




