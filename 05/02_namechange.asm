section .text
    global main                 ;must be declared for linker (ld)
    
main:                           ;tell linker entry point


    ;writing the name 'Zara  Ali':
    mov edx, len                ;message length
    mov ecx, name               ;message to write
    mov ebx, 1                  ;file descriptor (stdout)
    mov eax, 4                  ;system call number (sys_write)
    int 0x80                    ;call kernel

    mov [newFIRSTname], dword 'ALEX'  ;change newFIRSTname from Alix to ALEX
    
    mov eax, dword[newFIRSTname]   ; der Inhalt von newFirstname (= Pete) )wird in EAX geschrieben,
    mov dword[name], eax         ; Pete wird um 1 byte verschoben in den byte-String name im Speicher überschrieben
   ;mov dword[name+1], eax         ; Pete wird um 1 byte verschoben in den byte-String name im Speicher überschrieben

   

    ;writing the name 'ALEX Ali'
    mov edx, len                 ;message length
    mov ecx, name                ;message to write
    mov ebx, 1                   ;file descriptor (stdout)
    mov eax,4                    ;system call number (sys_write)
    int 0x80                     ;call kernel

    ;Exit code
     mov eax, 1
     mov ebx, 0
     int 80h

section .data
    name db 'Zara Ali ',0xa        ;name
    len equ $ - name                ;length of name

    newFIRSTname db 'Alix'          ;name

