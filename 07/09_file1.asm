global main ;must be declared for using gcc
extern printf

section .data
    file_name db 'myfile.txt',  0       ; Filenname: 0-terminated

    achar     db '           ',  0               ; Array im Hauptspeicher, in den die eingelesenen Bytes
                                        ; aus dem File geschrieben werden
    charX     db 'XX',0                                    

    msg db 'Die Pruefung naht', 0       ; Text der ins File geschrieben werden soll: 0-terminated
    len equ $-msg
    msg_done db 'File erstellt, geoeffnet, ins File geschrieben, und File wieder geschlossen!', 0xa
    len_done equ $-msg_done

    positionOfFilePointer dd 0
    FPstring  db 10,10,'File Pointer :  %d', 10, 0      ; Define a string to be printed

    
section .bss
    fd_out  resd 1      ; file descriptor fuer das File in das geschrieben wird
    fd_in   resd 1      ; file descriptor fuer das File aus dem gelesen wird
    info    resb 26     ; Array im Hauptspeicher, in den die eingelesenen Bytes
                        ; aus dem File geschrieben werden
   

section .text

    main: ;tell linker entry point

        ;create a new file
        mov eax, 8              ; sys_creat : Erstellt und oeffnet ein vollkommen neues (leeres) File.
        mov ebx, file_name      ; Zeiger auf den String mit Filenamen : 'myfile.txt'
        mov ecx, 0664o          ; Octal Basis: 0 : Linux-Rechte: read (4), write (2) and execute (1) by all priviliges
                                ; rwxrwxrwx : 664 = rw r r => Nur der Besitzer darf schreiben, alle koennen lesen.
                                ; kein mov to edx notwendig !
        int 0x80                ; call kernel

        ; Ergebnis: in eax ist der File-Descriptor enthalten

        mov [fd_out], eax       ; File-Descriptor wird nach [fd_out] geschrieben.

        ; write to the new file
        mov eax,4               ; system call number (sys_write)
        mov ebx, dword [fd_out]       ; file descriptor
                                ; Hinweis: Standard File Descriptors:
                                ; stdin			0
                                ; stdout		1
                                ; stderr 		2
                                ; in Linux file-descriptor 0-1023 (10 bit) pro Prozess.
        mov ecx, msg            ; message to write: 'Die Pruefung naht' wird in das neue File geschrieben
        mov edx, len            ; number of bytes
        int 0x80                ; call kernel

        ; close the file
        mov eax, 6              ; system call number (sys_close)
        mov ebx, dword [fd_out] ; file descriptor
                                ; kein mov to ecx notwendig !
                                ; kein mov to edx notwendig !
        int 0x80                ; call kernel
        
        ; write the message indicating end of file write
        mov eax, 4              ; system call number (sys_write)
        mov ebx, 1              ; stdout		1  (Wird im Terminal ausgegeben)
        mov ecx, msg_done       ; message to write: 'File erstellt, geoeff...'
        mov edx, len_done       ; number of bytes
        int 0x80                ; call kernel

        ; open the now already existing file for reading
        mov eax, 5              ; system call number (sys_open)
        mov ebx, file_name      ; Zeiger auf den String mit Filenamen : 'myfile.txt'
        mov ecx, 0              ; ecx=access mode (0=read only, 1=write only, 2=read and write)
        mov edx, 0644o          ; read, write by owner, read by all
        int 0x80                ; call kernel

        ; Ergebnis: in eax ist der File-Descriptor enthalten
        mov [fd_in], eax        ;read from file

        mov eax, 3              ; system call number (sys_read)
        mov ebx, dword [fd_in]  ; file descriptor
        mov ecx, info           ; Zeiger auf einen leeren Array (26 bytes) in den die Info aus dem File geschrieben wird
        mov edx, 26             ; Anzahl der Bytes die aus dem File gelesen werden.
        int 0x80                ; call kernel

        ; close the file again
        mov eax, 6              ; system call number (sys_close)
        mov ebx, dword [fd_in]  ; file descriptor
                                ; kein mov to ecx notwendig !
                                ; kein mov to edx notwendig !
        int 0x80                ; call kernel

        ; Das aus dem File gelesene auf stdout ausgeben.
        mov eax, 4              ; system call number (sys_write)
        mov ebx, 1              ; stdout		1  (Wird im Terminal ausgegeben)
        mov ecx, info           ; message to write: aus dem File ausgelesen.
        mov edx, 26             ; Anzahl der Zeichen.
        int 0x80                ; call kernel

        ; und hier noch ein Special-Feature:
        ; File Pointer Beispiel
        ; es werden 3 Zeichen im File gelesen, und an die 4. Stelle in X geschrieben:

        ; open the now already existing file for reading
        mov eax, 5              ; system call number (sys_open)
        mov ebx, file_name      ; Zeiger auf den String mit Filenamen : 'myfile.txt'
        mov ecx, 2              ; ecx=access mode (0=read only, 1=write only, 2=read and write)
        mov edx, 0644o           ; read, write by owner, read by all
        int 0x80                ; call kernel

        ; Ergebnis: in eax ist der File-Descriptor enthalten
        mov [fd_in], eax        ;read from file


        ;READ 3 CHAR FROM start of file
        mov eax, 3              ; system call number (sys_read)
        mov ebx, dword [fd_in]  ; file descriptor
        mov ecx, achar          ; Zeiger auf einen leeren Array (2 bytes) in den die Info aus dem File geschrieben wird
        mov edx, 3              ; Anzahl der Bytes die aus dem File gelesen werden.
        int 0x80                ; call kernel

        ; der File Pointer steht jetzt auf das 4. Zeichen im String:
        ; dh: edx = 3 (erstes Zeichen: edx = 0)
        mov  [positionOfFilePointer], edx   ;edx enthält den File Pointer (offset)

        ; An die gegenwaertige Stelle im File ein 'XX' schreiben:
        mov eax, 4               ; system call number (sys_write)
        mov ebx, dword [fd_in] ; file descriptor
        mov ecx, charX          ; message to write: 'X' wird in das neue File geschrieben
        mov edx, 2              ; number of bytes
        int 0x80                ; call kernel

        ; close the file again
        mov eax, 6              ; system call number (sys_close)
        mov ebx, dword [fd_in]        ; file descriptor
                                ; kein mov to ecx notwendig !
                                ; kein mov to edx notwendig !
        int 0x80                ; call kernel
        
        push dword [positionOfFilePointer] 
        push FPstring           ; Push the string address
        call printf             ; Call _printf to print the string
        add esp, 8 

    mov eax,1                   ; system call number (sys_exit)
    int 0x80                    ; call kernel

