section .data
	
	little: db 'LITTLE ENDIAN',0Ah
        length1: equ $-little
        bigI: db 'BIG ENDIAN',0Ah
	length2: equ $-bigI

section .bss
	var: resb 1

section .text
	global _start:
	       _start:

	
        mov ax,1234h
        
	cmp al,12
        je big

        mov eax,4
        mov ebx,1
	mov ecx,little
	mov edx,length1
        int 80h
        jmp exit

        big:

        mov eax,4
        mov ebx,1
	mov ecx,bigI
	mov edx,length2
        int 80h


        exit:
        

	mov eax,1
 	mov ebx,0
	int 80h
