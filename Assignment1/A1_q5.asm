section .bss
	a: resb 1
	b: resb 1
        junk: resb 1

section .data
	message1: db 'Enter first number :',0Ah
        length1: equ $-message1
        message2: db 'Enter second number :',0Ah
        length2: equ $-message2
	message3: db 'Multiple',0Ah
        length3: equ $-message3
        message4: db 'Not a multiple',0Ah
        length4: equ $-message4


section .text
    	global _start:
               _start:

	mov eax,4
	mov ebx,1
	mov ecx,message1
        mov edx,length1
	int 80h
	

	mov eax,3
	mov ebx,0
	mov ecx,a
        mov edx,1
	int 80h
        

	mov eax,3
	mov ebx,0
	mov ecx,junk
        mov edx,1
	int 80h

        sub byte[a],30h

	mov eax,4
	mov ebx,1
	mov ecx,message2
        mov edx,length2
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,b
        mov edx,1
	int 80h

	
       	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
	
	sub byte[b],30h

	mov al,byte[a]
	mov bl,byte[b]
	div bl
	cmp ah,0

        jne notmul

	
	mov eax,4
	mov ebx,1
	mov ecx,message3
        mov edx,length3
	int 80h
               
        jmp exit

        notmul:

	mov eax,4
	mov ebx,1
	mov ecx,message4
        mov edx,length4
	int 80h
      
	exit:
 	mov eax,1
	mov ebx,0
 	int 80h
