global  main     ;must be declared for using gcc
extern  printf

section .data

    my_string           db      'hello world', 0
    len                 equ     $-my_string
     
    compare_string      db      'e', 0
    lenCompareString    equ     $-compare_string

    msg_found           db      'found!', 0xa, 'Das %d-te Zeichen im String :"%s", lautet : "%s"', 0xa, 0
    len_found           equ     $-msg_found

    msg_edi_pointer     db      'Der Pointer edi zeigt jetzt auf diesen String : "%s"', 0xa, 0
    len_msg_edi_pointer equ     $-msg_edi_pointer


    msg_notfound        db      'not found!', 0xa, 0
    len_notfound        equ     $-msg_notfound

    position            dd      0x00000000

section .text

    main:                   ;tell linker entry point

    ; initialisierung der Parameter für repne scasb
    mov ecx,  len               ; ecx mit der Anzahl belegen von Zeichen im String my_string die verglichen werden sollen.
    mov edi,  my_string         ; edi zeigt auf den Beginn des Strings der verglichen werden soll.
    mov al ,  byte [compare_string]  ; in al ist das Zeichen enthalten dass im String gesucht werden soll.
    
    cld                     ; direction flag (DF) = 0 => "vorwärts" mit inc durch den string
    
    repne scasb             ; scasb
                            ; this instruction compares a byte (scasw : word, scasd : doubleword)
                            ; specified using a memory operand with the value in AL (AX, or EAX).
                            ; It then sets status flags in EFLAGS recording the results. 
                            ; The no-operands form of the instruction uses a short form of SCAS.
                            ; The memory operand address is read from EDI register and AL (AX, or EAX) is assumed to be the register operand.
                            ; The size of operands is selected by the mnemonic: 
                            ; SCASB (byte comparison), SCASW (word comparison), or SCASD (doubleword comparison).
                            ; After the comparison:
                            ; * the EDI register is incremented or decremented automatically according to the setting of the DF flag in the EFLAGS register.
                            ; If the DF flag is 0, the (E)DI register is incremented
                            ; if the DF flag is 1, the (E)DI register is decremented.
                            ; The register is incremented or decremented by 1 for byte operations, 
                            ; by 2 for word operations,
                            ; and by 4 for doubleword operations.
                            ; 
                            ; REPNE (repeat while not equal)
                            ; Repeat Prefix 		Termination Condition 1* 	Termination Condition 2
                            ; REPNE			        ECX = 0 			        ZF = 1
                            ; *Count register ECX
                            ; 
                            ; The REPNE prefixes also check the state of the ZF flag after each iteration and terminate
                            ; the repeat loop if the ZF flag is not in the specified state. When both termination conditions are tested, the cause
                            ; of a repeat termination can be determined either by testing the count register with a JECXZ instruction or by testing
                            ; the ZF flag (with a JZ, JNZ, or JNE instruction).
                            ; When the REPE/REPZ and REPNE/REPNZ prefixes are used, the ZF flag does not require initialization because both
                            ; the CMPS and SCAS instructions affect the ZF flag according to the results of the comparisons they make. 
    
    pushf                   ; eflags auf stack pushen
    mov eax, edi            ; Addresse auf die EDI zeigt: Ein Byte nach dem Treffer, oder auf das Byte nach dem String
    sub eax, my_string      ; Davon ziehen wir die Adresse des ersten Byte des Strings ab
    mov [position], eax     ; Position enthält die relative Position im STring des ersten Treffers des gesuchten characters.
    popf                    ; eflags vom stack holen
       
    je found                ; Jump near if equal (ZF=1).
                            ; EDI zeigt jetzt auf den Wert nach dem ersten Treffer von 'e' im Speicher zeigen.
    
    ; If not found, then the following code
    push msg_notfound       ; 'not found!' (ohne paramter)
    call printf             ; Ausgabe
    add esp, 4              ; Cleans up the stack by removing the pushed addresses

    jmp exit
    
    found:
    push compare_string 
    push my_string 
    push dword [position]   ; Last state of ecx after renpe scasb terminated
    push msg_found          ; 'found! An Position-Nr : %d, im string : %s, steht das character : %s', 0xa, 0
    call printf             ; Ausgabe
    add esp, 16              ; Cleans up the stack by removing the pushed addresses


    push edi                ;  'Der Pointer edi zeigt jetzt auf diesen String : %s', 0xa, 0  
    push msg_edi_pointer     ;  'Der Pointer edi zeigt jetzt auf diesen String : %s', 0xa, 0
    call printf              ; Ausgabe
    add esp, 4              ; Cleans up the stack by removing the pushed addresses


    exit:
    mov eax,1
    mov ebx,0
    int 80h
    

