global main             ;must be declared for using gcc

section .text

main:                   ;tell linker entry point

    call next
    mov eax,1           ;system call number (sys_exit)
    int 0x80            ;call kernel
    
next:                   ; dort wird mit loop hingesprungen
    push ecx            ; Der Inhalt des ecx Registers wird zu Beginn der Schleife auf den Stack "weg-gesichert"

    inc byte [achar]    ; der Wert in der Speicherzelle auf die achar zeigt (ein Byte) wird um 1 erhoeht
    
    ; [achar] wird ausgegeben
    mov eax, 4      
    mov ebx, 1
    mov ecx, achar      ; achar ist ein Pointer auf eine Speicherzelle mit einem byte.
                        ; der momentane Wert in dieser Speicherzelle soll ausgegeben werden.
    mov edx, 1
    int 80h             ; der Wert wird auf dem Bildschirm ausgegeben.
    
                        ; Der Inhalt von ecx wurde mittlerweile ueberschrieben: zunaechst mit der Adresse von achar, dann schreibt int 80h auch einen Wert zurueck in ecx.
    pop ecx             ; Fuer einen eventuellen weiteren Gebrauch (hier im Beispiel nicht der Fall), kann der urspruengliche Wert von ecx aus dem Stack geholt werden.

    ; hier dann weitere Rechenoperationen mit dem urspruenglichen Wert von ecx
    ; ....
    ; ....

    cmp byte [achar], 0x7e  ; es wird verglichen ob der Inhalt der Speicherzelle auf die achar zeigt identisch ist mit odh (== Carriage Return)
    jne next                ; wenn der vorherige Vergleich negativ ausfaellt: dann wird zu next gesprungen.
    ret                     ; wenn der Wert [achar] gleich 0x7e (ASCII Code entspricht ~) dann wird abgebrochen und das Programm beendet

section .data
    achar db 0x20           ; ASCII Code 0x20 entspricht "Space", ein Leerzeichen.