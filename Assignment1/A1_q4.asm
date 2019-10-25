section .data
	msg1: db 'Enter first number :'
        length1: equ $-msg1
	
	msg2: db 'Enter second number :'
        length2: equ $-msg2

	msg3 db 'Enter third number :'
        length3: equ $-msg3


section .bss
	a1: resb 1
	a2: resb 1
	b1: resb 1
	b2: resb 1
	c1: resb 1
	c2: resb 1
        num1: resb 1
        num2: resb 1
	num3: resb 1
 	junk: resb 1

section .text
global _start
_start:

;number1:

	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,length1
	int 80h


   	mov eax,3
	mov ebx,0
	mov ecx,a1
	mov edx,1
	int 80h
        
        sub byte[a1],30h
        

   	mov eax,3
	mov ebx,0
	mov ecx,a2
	mov edx,1
	int 80h
        
        sub byte[a2],30h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h

	mov al,byte[a1]
        mov bl,10
        mul bl
        add al,byte[a2]
        mov byte[num1],al

;number2:

	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,length2
	int 80h

   	mov eax,3
	mov ebx,0
	mov ecx,b1
	mov edx,1
	int 80h
        
        sub byte[b1],30h

	mov eax,3
	mov ebx,0
	mov ecx,b2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
        
        sub byte[b2],30h

 	mov al,byte[b1]
        mov bl,10
	mul bl
	add al,byte[b2]
        mov byte[num2],al

;number3:

	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,length3
	int 80h

   	mov eax,3
	mov ebx,0
	mov ecx,c1
	mov edx,1
	int 80h
        
        sub byte[c1],30h

	mov eax,3
	mov ebx,0
	mov ecx,c2
	mov edx,1
	int 80h
        
        sub byte[c2],30h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
        
   	mov al,byte[c1]
        mov bl,10
	mul bl
	add al,byte[c2]
        mov byte[num3],al

;condition for checking greater number:


	case1:
        mov al,byte[num1]
        cmp al,byte[num2]
	jae case3
 
        case2:
        mov al,byte[num2]
        cmp al,byte[num3]
        jae numtwo
   

        case3:
        mov al,byte[num1]
        cmp al,byte[num3]
        jae numone

        jmp numthree

	numone:

        mov bl,10
        mov al,[num1]
	div bl
        mov byte[a1],al
        mov byte[a2],ah
        add byte[a1],30h
        add byte[a2],30h
        mov eax,4
        mov ebx,1
	mov ecx,a1
	mov edx,1
        int 80h


        mov eax,4
        mov ebx,1
	mov ecx,a2
	mov edx,1
        int 80h
        jmp exit  


	numtwo:

        mov bl,10
        mov al,[num2]
	div bl
        mov byte[b1],al
        mov byte[b2],ah
 

        add byte[b1],30h
        add byte[b2],30h

        mov eax,4
        mov ebx,1
	mov ecx,b1
	mov edx,1
        int 80h


        mov eax,4
        mov ebx,1
	mov ecx,b2
	mov edx,1
        int 80h
        jmp exit  

	numthree:

        mov bl,10
        mov al,[num3]
	div bl
        mov byte[c1],al
        mov byte[c2],ah
 
        add byte[c1],30h
        add byte[c2],30h

        mov eax,4
        mov ebx,1
	mov ecx,c1
	mov edx,1
        int 80h


        mov eax,4
        mov ebx,1
	mov ecx,c2
	mov edx,1
        int 80h
        jmp exit          


	exit:

        mov eax,1
	mov ebx,0
	int 80h
