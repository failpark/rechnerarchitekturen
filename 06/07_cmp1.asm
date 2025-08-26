section .text
global main                 ;must be declared for using gcc

main:                       ;tell linker entry point

    mov ecx, [num1]         ; '47' wird in ecx geschrieben
    cmp ecx, [num2]         ; ecx ('47') wird mit '22' vergleichen
                            ; Ergebnis von cmp: ist groesser!
                            
    jg check_third_num      ; jump greater: (ecx > '22') ? jg | nicht springen
                            ; dh. wenn ecx ('47') groesser ist als '22', dann wird zu check_third_num gesprungen
                            ; => wir springen zu check_third_num

    mov ecx, [num3]         ; wird nicht ausgefuehrt, sondern uebersprungen

check_third_num: 
    cmp ecx, [num3]         ; in ecx ist noch der alte Wert: '47'
                            ; ecx ('47') wird mit '31' vergleichen
                            ; Ergebnis von cmp: ist groesser!

    jg ergebnis             ; jump greater: (ecx > '31') ? jg | nicht springen
                            ; dh. wenn ecx ('47') groesser ist als '31', dann wird zu ergebnis gesprungen
                            ; => wir springen zu ergebnis

    mov ecx, [num3]         ; wird nicht ausgefuehrt, sondern uebersprungen

ergebnis: 

    mov [largest], ecx      ; in ecx enthalten: '47' - unser Ergebnis

    mov ecx,msg             
    mov edx, len 
    mov ebx,1               ;file descriptor (stdout) 
    mov eax,4               ;system call number (sys_write) 
    int 0x80                ;call kernel

    mov ecx,largest         ; '47' 
    mov edx, 2 
    mov ebx,1               ;file descriptor (stdout)
    mov eax,4               ;system call number (sys_write)
    int 0x80                ;call kernel
    
    mov eax, 1
    int 80h                 ;programm exit

section .data
    msg db "The largest digit is: ", 0xA,0xD
    len equ $- msg
    num1 dd '47'
    num2 dd '22'
    num3 dd '31'

segment .bss
    largest resb 4


