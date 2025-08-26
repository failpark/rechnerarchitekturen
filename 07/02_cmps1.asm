global main ;must be declared for using gcc

section .data
    s1 db 'Hello, world!',0         ;our first string
    lens1 equ $-s1
    
;    s2 db 'Hello, there!', 0        ;our second string
    s2 db 'Hello, world!', 0        ;our second string
    lens2 equ $-s2

    msg_eq db 'Strings are equal!', 0xa     
    len_eq equ $-msg_eq
    
    msg_neq db 'Strings are not equal!'
    len_neq equ $-msg_neq

section .text

    main: ;tell linker entry point

        mov esi, s1
        mov edi, s2
        mov ecx, lens2

        cld

        repe cmpsb                      ; cmpsb compare byte at address ESI with byte at address EDI: The status flags are set accordingly.
                                        ; repe 

        jecxz equal                     ;jump when ecx is zero - dann sind die strings gleich. Wenn ecx nicht 0 dann ungleich

        ;If not equal then the following code
        mov eax, 4
        mov ebx, 1
        mov ecx, msg_neq
        mov edx, len_neq
        int 80h
        jmp exit

        equal:
            mov eax, 4
            mov ebx, 1
            mov ecx, msg_eq
            mov edx, len_eq
            int 80h
        
        exit:
            mov eax, 1                  ; return value set to 1
            mov ebx, 0
            int 80h
    






