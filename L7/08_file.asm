section .data
	file_name db 'myfile.txt', 0
	buffer times 10 db ' '

	char_x db 'XX',0
	msg db 'Die Pruefung naht', 10, 0
	msg_len equ $ - msg
	msg_done db 'Create, Write and Close', 10, 0
	done_len equ $ - msg_done

	file_pos dd 0
	msg_fp db 10, 10, 'File pointer : %d', 10, 0

section .bss
	fd_out resd 1
	fd_in resd 1
	; I think the prof just used 26 as an arbitrary size
	info resb 26

section .text
global main
extern printf
main:
	; create new file
	mov eax, 8
	mov ebx, file_name
	; 6 = 110b = rw- ==> maps directly AND visually matches
	; 4 = 100b = r--
	mov ecx, 0664o
	int 0x80

	; eax contains file descriptor
	mov [fd_out], eax

	mov eax, 4
	mov ebx, dword[fd_out]
	mov ecx, msg
	mov edx, msg_len
	int 0x80

	mov eax, 6
	mov ebx, dword[fd_out]
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, msg_done
	mov edx, done_len
	int 80h

	mov eax, 5
	mov ebx, file_name
	mov ecx, 0 ; access mode 0=ro 1=wo 2=rw
	; only needed when creating files
	; create only exists for historical compat apperently
	mov edx, 0644o
	int 80h

	mov [fd_in], eax

	mov eax, 3 ; read
	mov ebx, dword[fd_in]
	mov ecx, info
	mov edx, 26 ; max bytes to read
	int 80h
	; eax contains now the actual number of read bytes
	push eax

	mov eax, 6 ; close
	mov ebx, dword[fd_in]
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, info
	pop edx ; use the actual size returned from read
	int 80h

write_in_place:
	mov eax, 5 ; open
	mov ebx, file_name
	mov ecx, 2 ; read and write
	;mov edx, 0644o ; redundant since the file was already written to
	int 80h
	mov [fd_in], eax

	; we use this to advance the file position
	; the buffer just there to use read
	; we could also use lseek (19) to advance the position
	; WITHOUT using a buffer
	;mov eax, 3
	;mov ebx, dword[fd_in]
	;mov ecx, buffer
	;mov edx, 3
	;int 80h

	; this is compleatly redundant since edx is unchanged from read
	; the kernel keeps track of our position in the file not us
	; this would just be the constant 3 from our ecx in read
	;mov [file_pos], edx

	
	mov eax, 19
	mov ebx, dword[fd_in]
	mov ecx, 3 ; bytes we want to advance to
	mov edx, 0 ; pos from where we advance
		; 0 = start
		; 1 = current pos
		; 2 from the end (we could use -3 in ecx for example)
	int 80h

	mov eax, 4
	mov ebx, dword[fd_in]
	mov ecx, char_x
	mov edx, 2
	int 80h

	mov eax, 6
	mov ebx, dword[fd_in]
	int 80h

	;push dword[3]
	;push msg_fp
	;call printf
	;add esp, 8

	mov eax, 1
	mov ebx, 0
	int 80h