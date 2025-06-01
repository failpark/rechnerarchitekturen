section .text
global printf

printf:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    
    mov esi, [ebp+8]    ; format string
    lea edi, [ebp+12]   ; first vararg
    
.loop:
    lodsb
    test al, al
    jz .done
    
    cmp al, '%'
    jne .print_char
    
    lodsb
    cmp al, 'd'
    je .print_int
    cmp al, 's'
    je .print_str
    cmp al, 'c'
    je .print_char_arg
    
.print_char:
    mov [char_buf], al
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, char_buf
    mov edx, 1
    int 0x80
    jmp .loop
    
.print_char_arg:
    mov eax, [edi]      ; get char argument
    add edi, 4
    mov [char_buf], al  ; only low byte
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, char_buf
    mov edx, 1
    int 0x80
    jmp .loop
    
.print_int:
    mov eax, [edi]
    add edi, 4
    call itoa
    mov eax, 4
    mov ebx, 1
    mov ecx, num_buf
    mov edx, 11
    int 0x80
    jmp .loop
    
.print_str:
    mov eax, [edi]
    add edi, 4
    push esi
    mov esi, eax
    call strlen
    mov edx, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    int 0x80
    pop esi
    jmp .loop
    
.done:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

itoa:
    push edi
    mov edi, num_buf + 10
    mov byte [edi], 0
    mov ecx, 10
    
.itoa_loop:
    xor edx, edx
    div ecx
    add dl, '0'
    dec edi
    mov [edi], dl
    test eax, eax
    jnz .itoa_loop
    
    mov ecx, num_buf + 10
    sub ecx, edi
    push esi
    mov esi, edi
    mov edi, num_buf
    rep movsb
    pop esi
    pop edi
    ret

strlen:
    push edi
    mov edi, esi
    xor eax, eax
    xor ecx, ecx
    dec ecx
    repne scasb
    not ecx
    dec ecx
    mov eax, ecx
    pop edi
    ret

section .bss
char_buf resb 1
num_buf resb 11