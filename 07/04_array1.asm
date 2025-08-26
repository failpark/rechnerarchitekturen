global  main             ;must be declared for linker (ld)
extern  printf

section .data 

    my_string           db      '2 + 4 + 3 ergibt :%d', 10,'Und jetzt einzeln das Character : ', 10 , 0
    len                 equ     $-my_string

x:                      ; Array x : 32 bit unsigned int Zahlen: 2,4,3
    dd 2
    dd 4
    dd 3

;x   dd 2, 4, 3         ; ist das Gleiche wie oben!
    
sumInt:
    dd 0

;sumInt   dd 0           ; ist das Gleiche wie oben!

sumByte:
    db 0

;sumByte     db 0        ; ist das Gleiche wie oben!

section .text

main:
    mov eax, 3              ; number bytes to be summed (acts as counter)
    mov ebx, 0              ; Initialisierung: EBX will store the sum
    mov ecx, x              ; x ist ein Pointer auf das erste Element des Arrays.
                            ; ECX zeigt auch auf das erste Element des Arrays.

top:
    add ebx, dword [ecx]    ; Erster Schleifendurchlauf:
                            ; ecx zeigt auf das erste Element des arrays x
                            ; [ecx] ist der Wert des ersten Element des Arrays.
                            ; dieses wird zu ebx addiert.
                            ; ebx = 2 + 4 + 3 = 9
    add ecx,4               ; move pointer to next element: ecx zeigt zum zweiten element.
                            ; 4 byte weiter => die nächste 32 bit unsigned int Zahl
    dec eax                 ; decrement eax,
                            ; if eax = 0 => eflags are set
    jnz top                 ; if counter not 0 (ZF = 0), then loop again

    ; Diese Zeile wird erreicht: wenn eax = 0 => nach 3 Durchlaeufen
    ; in ebx enthalten: 9 (= 32 bit unsigned int)

    mov [sumInt], dword ebx ; Ergebnis wegschreiben: 32 bit unsigned int

displayPrintfUnsignedInt:
    push ebx                ; 9 als unsigned INT 32 bit Wert auf den Stack gelegt.
    push my_string          ; der 32 bit Zeiger auf  ('2 + 4 + 3 ergibt :%d', 0 ) wird auf den Stack gelegt
    call printf             ; Ausgabe
    add esp, 8              ; Cleans up the stack by removing the pushed addresses

conversion:
                            ; ebx ist jetzt durch printf überschrieben!
    mov ebx, dword [sumInt] ; Ergebnis holen: 32 bit unsigned int : 9
    add ebx, '0'            ; insigned int 9 wird zu ASCII character '9' : Aber mit 24 führenden 0-bits.
                            ; nur das niederwertige Byte von ebx enthaelt '9' als ASCII Code
    mov [sumByte], bl       ; Speichert ein byte ( '9') in [sum]
                            

displayEinASCIIzeichen:
    mov eax, 4              ; syswrite
    mov ebx, 1              ; stdout
    mov ecx, sumByte        ; Zeiger auf das Zeichen '9'
    mov edx, 1              ; nur 1 Zeichen ausgeben.
    int 80h

mov eax, 1 ;            system call number (sys_exit)
int 0x80                ;call kernel section






