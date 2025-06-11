section .data
	msg db "The largest digit is: ", 0xa, 0
	len equ $ - msg
	num1 dd '47'
	num2 dd '22'
	num3 dd '31'

section .bss
	largest resb 4

section .text
global main
main:
	mov ecx, [num1] ; ecx = 47
	cmp ecx, [num2] ; vergleich mit 22 => ecx ist größer
	
	jg check_third_num ; jump if greater --> jump
	
	mov ecx, [num3] ; unreachable

check_third_num:
	cmp ecx, [num3] ; vergleich mit 31 => ecx ist größer
	jg ergebnis
	mov ecx, [num3] ; unreachable

ergebnis:
	mov [largest], ecx
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, largest
	mov edx, 2
	int 80h
	
	mov eax, 1
	xor ebx, ebx
	int 80h