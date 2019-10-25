section .data
	msg1: db 'Size of the array: '
	length1: equ $-msg1
	
	msg2: db 'Enter the value of a: '
	length2: equ $-msg2
	
	msg3: db 'Enter the value of b: '
	length3: equ $-msg3
	
	msg4: db 'Enter the element: '
	length4: equ $-msg4
	
	msg: db 'none of the numbers',0Ah
	l: equ $-msg
	
	space: db ' '
	le: equ $-space
	

section .bss
	a: resb 1
	b: resb 1
	n: resb 1
	t: resb 1
	ele: resb 1
	array: resb 100
	dig1: resb 1
	dig2: resb 1
	junk: resb 1
        temp: resb 1
	flg: resb 1
	remainder: resb 1

section .text
	global _start:
	_start:

;INPUTING SIZE OF ARRAY 
	mov byte[flg],0
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,length1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
       	sub byte[dig1],30h
       	sub byte[dig2],30h
   

	mov al,byte[dig1]
	mov bl,10
	mul bl
	add al,byte[dig2]
	mov byte[n],al
	mov byte[t],al
	mov byte[temp],0


;INTAKING A AND B



	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,length2
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
       	sub byte[dig1],30h
       	sub byte[dig2],30h
   

	mov al,byte[dig1]
	mov bl,10
	mul bl
	add al,byte[dig2]
	mov byte[a],al


	mov eax,4
	mov ebx,1
	mov ecx,msg3
	mov edx,length3
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
       	sub byte[dig1],30h
       	sub byte[dig2],30h
   

	mov al,byte[dig1]
	mov bl,10
	mul bl
	add al,byte[dig2]
	mov byte[b],al

;INPUTING ARRAY


	mov ebx,array
	
reading:

        push ebx

	mov eax,4
	mov ebx,1
	mov ecx,msg4
	mov edx,length4
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,dig1
	mov edx,1
	int 80h


	mov eax,3
	mov ebx,0
	mov ecx,dig2
	mov edx,1
	int 80h

	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
       	sub byte[dig1],30h
       	sub byte[dig2],30h
   

	mov al,byte[dig1]
	mov bl,10
	mul bl
	add al,byte[dig2]

        pop ebx
	mov byte[ebx],al
	add ebx,1
        dec byte[n]
        cmp byte[n],0
	jg reading
        

;ACCEPTING ARRAY DONE


	mov ebx,array

	loop1:
        
	movzx ax,byte[ebx]
	mov [ele],ax
	mov cl,byte[a]
	div cl
	cmp ah,0
	jne else
        	

	mov ax,[ele]
	mov dl,byte[b]
	div dl
	cmp ah,0
	jne else


	print:
        mov byte[flg],1
	push ebx

	mov al,byte[ele]
	mov bl,10
	div bl

	mov byte[dig1],al
	mov byte[dig2],ah

	add byte[dig1],30h
	add byte[dig2],30h

	mov eax,4
	mov ebx,1
	mov ecx,dig1
	mov edx,1
	int 80h

	mov eax,4
	mov ebx,1
	mov ecx,dig2
	mov edx,1
	int 80h

        mov eax,4
        mov ebx,1
	mov ecx,space
	mov edx,le
	int 80h

	pop ebx
	
	else:
	add ebx,1
	add byte[temp],1
        mov al,byte[temp]
	cmp al,byte[t]
	jb loop1
        
        
	cmp byte[flg],0
        jne exit

	mov eax,4
	mov ebx,1
	mov ecx,msg
	mov edx,l
	int 80h  
    
	    exit:
	mov eax,1
	mov ebx,0
	int 80h

